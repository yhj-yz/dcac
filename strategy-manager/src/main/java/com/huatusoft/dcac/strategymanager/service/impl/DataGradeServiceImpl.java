package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import com.huatusoft.dcac.strategymanager.dao.DataGradeDao;
import com.huatusoft.dcac.strategymanager.dao.StrategyDao;
import com.huatusoft.dcac.strategymanager.entity.DataClassifyBigEntity;
import com.huatusoft.dcac.strategymanager.entity.DataGradeEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.service.DataGradeService;
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
import javax.xml.crypto.Data;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhj
 * @date 2020-3-20
 */
@Service
public class DataGradeServiceImpl extends BaseServiceImpl<DataGradeEntity, DataGradeDao> implements DataGradeService{

    @Autowired
    private DataGradeDao dataGradeDao;

    @Autowired
    private UserService userService;

    @Override
    public Page<DataGradeEntity> findAllByPage(Pageable pageable, String gradeName, String createUserAccount, String gradeDesc) {
        Specification<DataGradeEntity> specification = new Specification<DataGradeEntity>() {
            @Override
            public Predicate toPredicate(Root<DataGradeEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(gradeName)) {
                    predicates.add(criteriaBuilder.like(root.get("gradeName").as(String.class), "%" + gradeName + "%"));
                }
                if (StringUtils.isNotBlank(createUserAccount)) {
                    predicates.add(criteriaBuilder.like(root.get("createUserAccount").as(String.class), "%" + createUserAccount + "%"));
                }
                if (StringUtils.isNotBlank(gradeDesc)) {
                    predicates.add(criteriaBuilder.like(root.get("gradeDesc").as(String.class), "%" + gradeDesc + "%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public Result addGrade(String gradeName, String gradeDesc) {
        if(isGradeRepeat(gradeName)){
            return new Result("分级名称已存在,请重新输入!");
        }
        try {
            DataGradeEntity dataGradeEntity = new DataGradeEntity();
            dataGradeEntity.setGradeName(gradeName);
            dataGradeEntity.setGradeDesc(gradeDesc);
            dataGradeDao.add(dataGradeEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("数据库异常,请稍后再试!");
        }
        return new Result("200","添加分级成功!",null);
    }

    @Override
    public boolean isGradeRepeat(String gradeName) {
        List<DataGradeEntity> list = dataGradeDao.findAll();
        for(DataGradeEntity entity : list){
            if(entity.getGradeName().equals(gradeName)){
                return true;
            }
        }
        return false;
    }

    @Override
    public Result updateGrade(String gradeId, String gradeName, String gradeDesc) {
        try {
            DataGradeEntity dataGradeEntity = dataGradeDao.find(gradeId);
            if(isGradeRepeat(gradeName) && !gradeName.equals(dataGradeEntity.getGradeName())){
                return new Result("分级名称已存在,请重新输入!");
            }
            dataGradeEntity.setGradeName(gradeName);
            dataGradeEntity.setGradeDesc(gradeDesc);
            dataGradeDao.update(dataGradeEntity);
            UserEntity current = userService.getCurrentUser();
            current.setPolicyFileEdited(true);
            current.setPolicy(0);
            userService.update(current);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("修改数据分级失败!");
        }
        return new Result("200","修改数据分级成功!",null);
    }

    @Override
    public Result deleteGrade(String[] gradeIds) {
        List<DataGradeEntity> dataGradeEntities = dataGradeDao.findByIdIn(gradeIds);
        for (DataGradeEntity dataGradeEntity : dataGradeEntities){
            if(dataGradeEntity.getStrategyEntities().size() > 0){
                return new Result(dataGradeEntity.getGradeName()+"该数据分级已被使用,请重新选择!");
            }
        }
        try {
            delete(DataGradeEntity.class,gradeIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除数据分级失败,请稍后再试!");
        }
        return new Result("200","删除数据分级成功!",null);
    }
}
