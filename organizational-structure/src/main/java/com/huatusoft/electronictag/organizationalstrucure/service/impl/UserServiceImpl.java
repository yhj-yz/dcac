package com.huatusoft.electronictag.organizationalstrucure.service.impl;
import com.huatusoft.electronictag.base.service.BaseServiceImpl;
import com.huatusoft.electronictag.common.bo.Principal;
import com.huatusoft.electronictag.common.constant.DefaultNodeConstants;
import com.huatusoft.electronictag.common.constant.PlatformConstants;
import com.huatusoft.electronictag.organizationalstrucure.dao.UserDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import com.huatusoft.electronictag.organizationalstrucure.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 16:14
 */
@Service
public class UserServiceImpl extends BaseServiceImpl<UserEntity, UserDao> implements UserService {
    @Autowired
    private UserDao userDao;

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
}
