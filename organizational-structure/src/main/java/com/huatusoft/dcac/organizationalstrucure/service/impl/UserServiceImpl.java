package com.huatusoft.dcac.organizationalstrucure.service.impl;
import com.ht.base.util.HttpUtil;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.common.bo.Principal;
import com.huatusoft.dcac.common.constant.DefaultNodeConstants;
import com.huatusoft.dcac.common.constant.PlatformConstants;
import com.huatusoft.dcac.common.constant.SystemConstants;
import com.huatusoft.dcac.common.util.JsonUtils;
import com.huatusoft.dcac.organizationalstrucure.dao.DepartmentDao;
import com.huatusoft.dcac.organizationalstrucure.dao.RoleDao;
import com.huatusoft.dcac.organizationalstrucure.dao.SystemDao;
import com.huatusoft.dcac.organizationalstrucure.dao.UserDao;
import com.huatusoft.dcac.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.LoginParamEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.RoleEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.*;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 16:14
 */
@Service
public class UserServiceImpl extends BaseServiceImpl<UserEntity, UserDao> implements UserService {
    @Autowired
    private UserDao userDao;

    @Autowired
    private SystemDao systemParamDao;

    @Autowired
    private DepartmentDao departmentDao;

    @Autowired
    private RoleDao roleDao;

    @Override
    public UserEntity getUserByAccount(String account) {
        return dao.findByAccountEquals(account);
    }

    @Override
    public boolean isExistsByAccount(String account) {
        return dao.countByAccount(account) > 0;
}

    @Override
    public boolean isNotExistsByAccount(String account) {
        return !isExistsByAccount(account);
    }

    @Override
    public List<UserEntity> findAllAvailable() {
        return dao.findByStatusNotIn(PlatformConstants.USER_DISABLED, PlatformConstants.USER_DELETE);
    }

    @Override
    public Page<UserEntity> findUsersByDept(DepartmentEntity dept, Integer pageNumber, Integer pageSize, String account) {
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize);
        Specification<UserEntity> specification = new Specification<UserEntity>() {
            @Override
            public Predicate toPredicate(Root<UserEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                ArrayList<Predicate> predicates = new ArrayList<Predicate>();
                if (Objects.nonNull(dept) && !Objects.equals(dept.getId(), DefaultNodeConstants.EMPTY_DEPT_ID)) {
                    predicates.add(criteriaBuilder.equal(root.get("department").as(DepartmentEntity.class), dept));
                }
                if (StringUtils.isNotBlank(account)) {
                    predicates.add(criteriaBuilder.like(root.get("account").as(String.class), "%" + account +"%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public void saveOrUpdate(List<UserEntity> userEntities) {
        for (UserEntity userEntity : userEntities) {
            dao.save(userEntity);
        }
    }

    @Override
    public List<UserEntity> findByIsSystem(Integer isSystem) {
        return dao.findByIsSystem(isSystem);
    }

    @Override
    public UserEntity getCurrentUser() {
        Subject subject = SecurityUtils.getSubject();
        if(subject != null){
            Principal principal =(Principal)subject.getPrincipal();
            if(principal != null){
                return userDao.find(principal.getId());
            }
        }
        return null;
    }

    @Override
    public void updateLoginCount(String userId, Integer acount) {
        dao.updateLoginFailureCount(userId, acount);
    }

    @Override
    public UserEntity login(LoginParamEntity paramEntity) throws Exception {
        String userName = paramEntity.getLoginName();
        ByteSource credentialsSalt = ByteSource.Util.bytes(userName);
        String password = new SimpleHash("MD5",paramEntity.getPassword(),credentialsSalt,10).toString();
        UserEntity user = userDao.findByAccountAndPassword(userName,password);
        if (user == null) {
            throw new Exception("用户不存在");
        }
        if (user.getIsLocked() == 1) {
            throw new Exception("用户已被锁");
        }
        return user;
    }

    @Override
    public String visitByOut(String url, String userNo) {
        Map<String,String> paramMap = new HashMap<String, String>(1);
        paramMap.put("userNo",userNo);
        String appId = systemParamDao.findAll().get(0).getAppId();
        String productKey = systemParamDao.findAll().get(0).getProductKey();
        String result = HttpUtil.signPost("http://172.16.23.148:7073/api/token/getTokenByUserNo", appId, productKey, String.valueOf(System.currentTimeMillis()), paramMap);
        String code = JsonUtils.getJsonString(result, "code");
        //用户处在登陆状态
        if ("1".equals(code)) {
            String result1 = HttpUtil.signPost("http://172.16.23.148:7073/api/user/getUserByNo", appId, productKey, String.valueOf(System.currentTimeMillis()),paramMap);
            String data1 = JsonUtils.getJsonString(result1, "data");
            if(data1 != null) {
                String userName = JsonUtils.getJsonString(data1, "userAccount");
                UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(userName,userNo);
                SecurityUtils.getSubject().getSession().setAttribute("basicPlatformReturnCurLoginAccount",userNo);
                SecurityUtils.getSubject().login(usernamePasswordToken);
                return url;
            }else {
                return "";
            }
        } else {
            SecurityUtils.getSubject().logout();
        }
        return "";
    }

    @Override
    public Result addUser(String departmentId, String account, String name, String password) {
        if(isAccountOrNameRepeat(account,name)){
            return new Result("账号或姓名已存在,请重新输入!");
        }
        DepartmentEntity departmentEntity = departmentDao.find(departmentId);
        if(departmentEntity == null){
            return new Result("不存在相应的部门!");
        }
        try {
            UserEntity userEntity = new UserEntity();
            userEntity.setAccount(account);
            userEntity.setName(name);
            ByteSource source = ByteSource.Util.bytes(account);
            SimpleHash md5 = new SimpleHash("MD5", password, source, 10);
            userEntity.setPassword(md5.toString());
            userEntity.setDepartment(departmentEntity);
            userEntity.setRoleName("系统管理员");
            RoleEntity roleEntity = roleDao.findByName("系统管理员");
            userEntity.setRole(roleEntity);
            userDao.add(userEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("添加用户失败!");
        }
        return new Result("200","添加用户成功!",null);
    }

    @Override
    public Result updateUser(String userId, String account, String name, String password, String passwordSure) {
        UserEntity userEntity = this.find(userId);
        if(userEntity == null){
            return new Result("不存在相应的用户!");
        }
        if(isAccountOrNameRepeat(account,name) && !account.equals(userEntity.getAccount()) && !name.equals(userEntity.getName()) ){
            return new Result("账号或姓名重复,请重新输入!");
        }
        try {
            userEntity.setAccount(account);
            userEntity.setName(name);
            ByteSource source = ByteSource.Util.bytes(account);
            SimpleHash md5 = new SimpleHash("MD5", password, source, 10);
            userEntity.setPassword(md5.toString());
            this.update(userEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("更新用户失败!");
        }
        return new Result("200","更新用户成功!",null);
    }

    private boolean isAccountOrNameRepeat(String account,String name){
        List<UserEntity> list = findAll();
        for(UserEntity userEntity : list){
            if(userEntity.getAccount().equals(account) || userEntity.getName().equals(name)){
                return true;
            }
        }
        return false;
    }
}
