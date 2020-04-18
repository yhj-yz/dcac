package com.huatusoft.dcac.strategymanager.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.strategymanager.dao.DataClassifyBigDao;
import com.huatusoft.dcac.strategymanager.entity.DataClassifyBigEntity;
import com.huatusoft.dcac.strategymanager.entity.DataClassifySmallEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * @author yhj
 * @date 2020-3-20
 */
public interface DataClassifyService extends BaseService<DataClassifyBigEntity, DataClassifyBigDao>{

    /**
     * 分页查询
     * @param pageable
     * @param bigDataClassifyName
     * @param smallDataClassifyName
     * @param createUserAccount
     * @param classifyDesc
     * @return
     */
    Page<DataClassifyBigEntity> findAllByPage(Pageable pageable, String bigClassifyName, String smallClassifyName, String createUserAccount, String classifyDesc);

    /**
     * 添加一级分类
     * @param classifyName
     * @param classifyDesc
     * @return
     */
    Result addBigClassify(String classifyName,String classifyDesc);

    /**
     * 添加耳机分类
     * @param classifyId
     * @param classifyName
     * @param classifyDesc
     * @return
     */
    Result addSmallClassify(String classifyId,String classifyName,String classifyDesc);

    /**
     * 判断一级分类是否重复
     * @param classifyName
     * @return
     */
    boolean isBigClassifyRepeat(String classifyName);

    /**
     * 判断二级分类是否重复
     * @param classifyId
     * @param classifyName
     * @return
     */
    boolean isSmallClassifyRepeat(String classifyId,String classifyName);

    /**
     * 删除二级分类
     * @param classifyIds
     * @return
     */
    Result deleteSmallClassify(String[] classifyIds);

    /**
     * 根据ID获取数据分类小类
     * @param id
     * @return
     */
    DataClassifySmallEntity getSmallClassify(String id);

    /**
     * 修改一级分类
     * @param classifyId
     * @param classifyName
     * @param classifyDesc
     * @return
     */
    Result updateBigClassify(String classifyId,String classifyName,String classifyDesc);

    /**
     * 修改二级分类
     * @param classifyId
     * @param classifyName
     * @param classifyDesc
     * @return
     */
    Result updateSmallClassify(String classifyId,String classifyName,String classifyDesc);

    /**
     * 删除数据分类大类
     * @param classifyIds
     * @return
     */
    Result deleteBigClassify(String[] classifyIds);
}
