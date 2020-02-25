package com.huatusoft.electronictag.organizationalstrucure.service.impl;

import com.huatusoft.electronictag.base.service.BaseServiceImpl;
import com.huatusoft.electronictag.common.bo.Message;
import com.huatusoft.electronictag.common.constant.PlatformConstants;
import com.huatusoft.electronictag.common.bo.Tree;
import com.huatusoft.electronictag.organizationalstrucure.dao.DepartmentDao;
import com.huatusoft.electronictag.organizationalstrucure.dao.UserDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.PermissionEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import com.huatusoft.electronictag.organizationalstrucure.service.DepartmentService;
import com.huatusoft.electronictag.organizationalstrucure.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 10:16
 */
@Service
public class DepartmentServiceImpl extends BaseServiceImpl<DepartmentEntity, DepartmentDao> implements DepartmentService {

    @Autowired
    private UserDao userDao;

    @Override
    public DepartmentEntity findByParentIdEquals(String parentId) {
        return super.dao.findByParentIdEquals(parentId);
    }

    @Override
    public List<DepartmentEntity> findAllAvailable() {
        return super.dao.findByStatusNotIn(PlatformConstants.DEPARTMENT_DISABLED,PlatformConstants.DEPARTMENT_DELETE);
    }

    @Override
    public boolean isParentAvailable(String parentId) {
        return super.dao.countByParentIdEqualsAndStatusIsNotIn(parentId, PlatformConstants.DEPARTMENT_DISABLED,PlatformConstants.DEPARTMENT_DELETE) > 0;
    }

    @Override
    public boolean isParentDisabled(String parentId) {
        return !isParentAvailable(parentId);
    }

    @Override
    public List<Tree> findTree(String id) {
        ArrayList<Tree> trees = new ArrayList<>();
        List<DepartmentEntity> availableList = this.findAllAvailable();
        for (DepartmentEntity available : availableList) {
            Tree tree = new Tree(available.getId(), available.getName(), available.getParentId());
            trees.add(tree);
        }
        return trees;
    }

    @Override
    public void saveOrUpdate(List<DepartmentEntity> departmentEntities) {
        for (DepartmentEntity departmentEntity : departmentEntities) {
            DepartmentEntity dept = dao.getOne(departmentEntity.getId());
            dao.save(dept);
        }
    }

    @Override
    public Message setUserPermission(PermissionEntity find, String[] ids) {
        for(String userId : ids){
            try {
                UserEntity user = userDao.find(userId);
                if(user.getPermissions() != find){
                    user.setPolicy(1);
                }
                user.setPermissions(find);
                userDao.update(user);
            }catch (Exception e){
                e.printStackTrace();
                return new Message(Message.Type.error,"设置失败");
            }
        }
        return new Message(Message.Type.success,"设置成功");
    }
}
