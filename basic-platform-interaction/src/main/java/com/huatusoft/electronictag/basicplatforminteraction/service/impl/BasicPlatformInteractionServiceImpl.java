package com.huatusoft.electronictag.basicplatforminteraction.service.impl;

import com.huatusoft.electronictag.basicplatforminteraction.service.BasicPlatformInteractionService;
import com.huatusoft.electronictag.basicplatforminteraction.service.BasicPlatformSyncService;
import com.huatusoft.electronictag.basicplatforminteraction.vo.BasicPlatformDepartmentVo;
import com.huatusoft.electronictag.basicplatforminteraction.vo.BasicPlatformUserVo;
import com.huatusoft.electronictag.basicplatforminteraction.vo.PlatformSyncData;
import com.huatusoft.electronictag.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import com.huatusoft.electronictag.organizationalstrucure.service.DepartmentService;
import com.huatusoft.electronictag.organizationalstrucure.service.UserService;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 16:03
 */
@Service
public class BasicPlatformInteractionServiceImpl extends AbstractBasicPlatformService implements BasicPlatformInteractionService {

    @Override
    public Integer syncSaveDepartments(BasicPlatformSyncService basicPlatformSyncService, DepartmentService departmentService, String accessToken, Date syncDate, Integer pageNumber, Integer pageRows) throws Exception {
        PlatformSyncData<BasicPlatformDepartmentVo> data = basicPlatformSyncService.syncDepartments(syncDate, accessToken, pageNumber,pageRows).getData();
        departmentService.saveOrUpdate(this.basicPlatformDepartmentVoConversionDepartmentEntity(data.getInfo()));
        return Integer.parseInt(data.getTotal());
    }

    @Override
    public Integer syncSaveUsers(BasicPlatformSyncService basicPlatformSyncService, UserService userService, String accessToken, Date syncDate, Integer pageNumber, Integer pageRows) throws Exception {
        //开始同步用户
        PlatformSyncData<BasicPlatformUserVo> data = basicPlatformSyncService.syncUsers(syncDate, accessToken, pageNumber, pageRows).getData();
        userService.saveOrUpdate(this.basicPlatformUserVoConversionUserEntity(data.getInfo()));
        return Integer.parseInt(data.getTotal());
    }

    private List<DepartmentEntity> basicPlatformDepartmentVoConversionDepartmentEntity(List<BasicPlatformDepartmentVo> basicPlatformDepartmentVoList) {
        ArrayList<DepartmentEntity> departmentEntities = new ArrayList<DepartmentEntity>();
        for (BasicPlatformDepartmentVo basicPlatformDepartmentVo : basicPlatformDepartmentVoList) {
            DepartmentEntity departmentEntity = new DepartmentEntity();
            departmentEntity.setId(basicPlatformDepartmentVo.getId());
            departmentEntity.setDesc(basicPlatformDepartmentVo.getDesc());
            departmentEntity.setIsZone(Integer.parseInt(basicPlatformDepartmentVo.getIsorg()));
            departmentEntity.setName(basicPlatformDepartmentVo.getName());
            departmentEntity.setParentId(basicPlatformDepartmentVo.getPid());
            departmentEntity.setStatus(Integer.parseInt(basicPlatformDepartmentVo.getStatus()));
            departmentEntity.setUnitCode(basicPlatformDepartmentVo.getUnitcode());
            departmentEntities.add(departmentEntity);
        }
        return departmentEntities;
    }

    private List<UserEntity> basicPlatformUserVoConversionUserEntity(List<BasicPlatformUserVo> basicPlatformUserVoList) {
        ArrayList<UserEntity> userEntities = new ArrayList<UserEntity>();
        for (BasicPlatformUserVo basicPlatformUserVo : basicPlatformUserVoList) {
            UserEntity userEntity = new UserEntity();
            userEntity.setId(basicPlatformUserVo.getId());
            userEntity.setAccount(basicPlatformUserVo.getPwduser());
            userEntity.setName(basicPlatformUserVo.getName());
            userEntity.setDid(basicPlatformUserVo.getDid());
            userEntity.setRoleName(basicPlatformUserVo.getRole());
            userEntity.setKeyUser(basicPlatformUserVo.getKeyuser());
            userEntity.setSignCert(basicPlatformUserVo.getSigncert());
            userEntity.setEncCert(basicPlatformUserVo.getEnccert());
            userEntity.setCertLevel(Integer.parseInt(basicPlatformUserVo.getCertlevel()));
            userEntity.setMLevel(Integer.parseInt(basicPlatformUserVo.getMlevel()));
            userEntity.setSex(Integer.parseInt(basicPlatformUserVo.getSex()));
            userEntity.setPost(basicPlatformUserVo.getPost());
            userEntity.setMilitaryId(basicPlatformUserVo.getMilitarynum());
            userEntity.setTelephone(basicPlatformUserVo.getTelephone());
            userEntity.setStatus(Integer.parseInt(basicPlatformUserVo.getStatus()));
            userEntity.setUnitCode(basicPlatformUserVo.getUnitcode());
        }
        return userEntities;
    }


}
