package com.huatusoft.dcac.strategymanager.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.strategymanager.dao.DataGradeDao;
import com.huatusoft.dcac.strategymanager.entity.DataClassifyBigEntity;
import com.huatusoft.dcac.strategymanager.entity.DataGradeEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * @author yhj
 * @date 2020-3-27
 */
public interface DataGradeService extends BaseService<DataGradeEntity, DataGradeDao>{
    /**
     * 分页查询
     * @param pageable
     * @param gradeName
     * @param createUserAccount
     * @param gradeDesc
     * @return
     */
    Page<DataGradeEntity> findAllByPage(Pageable pageable, String gradeName, String createUserAccount, String gradeDesc);

    /**
     * 新增分级
     * @param gradeName
     * @param gradeDesc
     * @return
     */
    Result addGrade(String gradeName, String gradeDesc);

    /**
     * 判断分级是否重复
     * @param gradeName
     * @return
     */
    boolean isGradeRepeat(String gradeName);

    /**
     * 更新数据分级
     * @param gradeId
     * @param gradeName
     * @param gradeDesc
     * @return
     */
    Result updateGrade(String gradeId,String gradeName,String gradeDesc);
}
