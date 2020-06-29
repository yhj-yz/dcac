package com.huatusoft.dcac.organizationalstrucure.service.impl;

import com.huatusoft.dcac.organizationalstrucure.dao.SystemDao;
import com.huatusoft.dcac.organizationalstrucure.entity.SystemEntity;
import com.huatusoft.dcac.organizationalstrucure.service.SystemService;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author yhj
 * @date 2020-5-15
 */
@Service
public class SystemServiceImpl extends BaseServiceImpl<SystemEntity, SystemDao>  implements SystemService {
    @Autowired
    private SystemDao systemDao;

    @Override
    public Result register(String appId, String productKey) {
        SystemEntity systemEntity = new SystemEntity();
        if(isExsist()){
            systemEntity = systemDao.findAll().get(0);
            systemEntity.setAppId(appId);
            systemEntity.setProductKey(productKey);
            systemDao.update(systemEntity);
            return new Result("200","注册成功!",null);
        }
        systemEntity.setAppId(appId);
        systemEntity.setProductKey(productKey);
        systemDao.add(systemEntity);
        return new Result("200","注册成功!",null);
    }

    /**
     * 判断是否存在了相应数据
     * @return
     */
    private boolean isExsist(){
        List<SystemEntity> list = findAll();
        if(list.size() > 0){
            return true;
        }
        return false;
    }
}
