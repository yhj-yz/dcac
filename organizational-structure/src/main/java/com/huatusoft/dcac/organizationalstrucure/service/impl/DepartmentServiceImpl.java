package com.huatusoft.dcac.organizationalstrucure.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.common.constant.DefaultNodeConstants;
import com.huatusoft.dcac.common.constant.PlatformConstants;
import com.huatusoft.dcac.common.bo.Tree;
import com.huatusoft.dcac.organizationalstrucure.dao.DepartmentDao;
import com.huatusoft.dcac.organizationalstrucure.dao.UserDao;
import com.huatusoft.dcac.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.PermissionEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.DepartmentService;
import com.mysql.cj.xdevapi.FindStatement;
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

    @Autowired
    private DepartmentDao departmentDao;

    @Override
    public List<DepartmentEntity> findAllAvailable(String id) {
        return super.dao.findByParentIdAndStatusNotIn(id,PlatformConstants.DEPARTMENT_DISABLED,PlatformConstants.DEPARTMENT_DELETE);
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
        List<DepartmentEntity> availableList = this.findAllAvailable(id);
        for (DepartmentEntity available : availableList) {
            Tree tree = new Tree(available.getId(), available.getName(), available.getParentId());
            if(departmentDao.findByParentId(available.getId()).size() > 0){
                tree.setIsParent(true);
            }
            if(available.getParentId().equals(DefaultNodeConstants.EMPTY_DEPT_ID)){
                tree.setIconSkin(Tree.OGNI_ICON);
            }
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

    @Override
    public Result addDepartment(String departmentName, String departmentDesc, String departmentId) {
        if(isDepartmentNameRepeat(departmentName)){
            return new Result("部门名称重复,请重新输入!");
        }
        DepartmentEntity departmentEntity = new DepartmentEntity();
        departmentEntity.setName(departmentName);
        departmentEntity.setDesc(departmentDesc);
        departmentEntity.setParentId(departmentId);
        departmentDao.add(departmentEntity);
        return new Result("200","新增部门成功!",null);
    }

    @Override
    public Result updateDepartment(String departmentName, String departmentDesc, String departmentId) {
        DepartmentEntity departmentEntity = departmentDao.find(departmentId);
        if(departmentEntity == null){
            return new Result("不存在相应的部门!");
        }
        if(isDepartmentNameRepeat(departmentName) && !departmentName.equals(departmentEntity.getName())){
            return new Result("部门名称重复,请重新输入!");
        }
        departmentEntity.setName(departmentName);
        departmentEntity.setDesc(departmentDesc);
        departmentDao.update(departmentEntity);
        return new Result("200","更新部门成功!",null);
    }

    @Override
    public Result deleteById(String id) {
        try {
            departmentDao.deleteByIdOrParentId(id,id);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除部门失败!");
        }
        return new Result("200","删除部门成功！",null);
    }

    /**
     * 判断部门名称是否重复
     * @param departmentName
     * @return
     */
    private boolean isDepartmentNameRepeat(String departmentName){
        List<DepartmentEntity> list = findAll();
        for(DepartmentEntity departmentEntity :list){
            if(departmentEntity.getName().equals(departmentName)){
                return true;
            }
        }
        return false;
    }
}
