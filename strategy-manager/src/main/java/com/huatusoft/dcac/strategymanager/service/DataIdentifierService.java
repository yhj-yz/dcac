package com.huatusoft.dcac.strategymanager.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.strategymanager.dao.DataIdentifierDao;
import com.huatusoft.dcac.strategymanager.entity.DataIdentifierEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author yhj
 * @date 2020-3-27
 */
public interface DataIdentifierService extends BaseService<DataIdentifierEntity, DataIdentifierDao> {
    /**
     * 分页查询
     * @param pageable
     * @param identifierName
     * @param identifierType
     * @return
     */
    Page<DataIdentifierEntity> findAllByPage(Pageable pageable,String identifierName,String identifierType);

    /**
     * 导入数据标识符
     * @param uploadFile
     * @return
     */
    Result importIdentifier(MultipartFile uploadFile);
}
