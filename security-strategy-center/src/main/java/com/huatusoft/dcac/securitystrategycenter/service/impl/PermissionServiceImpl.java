/**
 * @author yhj
 * @date 2019-10-15
 */
package com.huatusoft.dcac.securitystrategycenter.service.impl;

import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.organizationalstrucure.dao.UserDao;
import com.huatusoft.dcac.organizationalstrucure.entity.PermissionEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.securitystrategycenter.dao.PermissionDao;
import com.huatusoft.dcac.securitystrategycenter.service.PermissionService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

@Service
public class PermissionServiceImpl extends BaseServiceImpl<PermissionEntity, PermissionDao> implements PermissionService {
    @Autowired
    private PermissionDao permissionDao;

    @Autowired
    private UserDao userDao;

    @Override
    public Page<PermissionEntity> findAll(Pageable pageable,String permissionName) {
        Specification<PermissionEntity> specification = new Specification<PermissionEntity>() {
            @Override
            public Predicate toPredicate(Root<PermissionEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(permissionName)) {
                    predicates.add(criteriaBuilder.like(root.get("permissionName").as(String.class), "%" + permissionName +"%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public Message addPermission(PermissionEntity PermissionEntity) {
        if(checkNameByPara(PermissionEntity.getPermissionName())){
            permissionDao.add(PermissionEntity);
            return new Message(Message.Type.success,"添加成功");
        }
        else{
            return new Message(Message.Type.error,"权限集名称重复");
        }
    }

    @Override
    public Message delete(String... ids) {
        List<PermissionEntity> entities=permissionDao.findAllByIdIn(ids);
        if(entities.size()>0){
            String userName = "";
            for (PermissionEntity entity : entities) {
                List<UserEntity> pUsers=entity.getUsers();
                if(pUsers.size() == 0){
                    permissionDao.delete(entity);
                }else {
                    userName += entity.getPermissionName()+"、";
                }
            }
            if(!userName.equals("")){
                return new Message(Message.Type.error,"权限集 [" + userName.substring(0,userName.length()-1) + " ]正被使用，删除权限集 失败");
            }else {
                return new Message(Message.Type.success,"删除成功");
            }
        }else {
            return new Message(Message.Type.error,"不存在相应的权限集,请确认参数是否正确");
        }
    }

    /**
     * 根据名称判断权限集是否存在
     * @param permissionSetName
     * @return
     */
    private boolean checkNameByPara(String permissionSetName){
        PermissionEntity htPermissionSetEntity = permissionDao.findAllByPermissionName(permissionSetName);
        if(htPermissionSetEntity == null){
            return true;
        }else {
            return false;
        }
    }
}
