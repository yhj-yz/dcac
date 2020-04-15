package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.strategymanager.dao.DataClassifyBigDao;
import com.huatusoft.dcac.strategymanager.dao.DataClassifySmallDao;
import com.huatusoft.dcac.strategymanager.entity.DataClassifyBigEntity;
import com.huatusoft.dcac.strategymanager.entity.DataClassifySmallEntity;
import com.huatusoft.dcac.strategymanager.service.DataClassifyService;
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

/**
 * @author yhj
 * @date 2020-3-20
 */
@Service
public class DataClassifyServiceImpl extends BaseServiceImpl<DataClassifyBigEntity, DataClassifyBigDao> implements DataClassifyService {
    @Autowired
    private DataClassifyBigDao dataClassifyBigDao;

    @Autowired
    private DataClassifySmallDao dataClassifySmallDao;

    @Override
    public Page<DataClassifyBigEntity> findAllByPage(Pageable pageable, String bigClassifyName, String smallClassifyName, String createUserAccount, String classifyDesc) {
        Specification<DataClassifyBigEntity> specification = new Specification<DataClassifyBigEntity>() {
            @Override
            public Predicate toPredicate(Root<DataClassifyBigEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(bigClassifyName)) {
                    predicates.add(criteriaBuilder.like(root.get("classifyName").as(String.class), "%" + bigClassifyName + "%"));
                }
                if (StringUtils.isNotBlank(smallClassifyName)) {
                    predicates.add(criteriaBuilder.like(root.get("classifyName").as(String.class), "%" + bigClassifyName + "%"));
                }
                if (StringUtils.isNotBlank(createUserAccount)) {
                    predicates.add(criteriaBuilder.like(root.get("createUserAccount").as(String.class), "%" + createUserAccount + "%"));
                }
                if (StringUtils.isNotBlank(classifyDesc)) {
                    predicates.add(criteriaBuilder.like(root.get("classifyDesc").as(String.class), "%" + classifyDesc + "%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public Result addBigClassify(String classifyName, String classifyDesc) {
        if(isBigClassifyRepeat(classifyName)){
            return new Result("一级分类名称已存在,请重新输入!");
        }
        try {
            DataClassifyBigEntity dataClassifyBigEntity = new DataClassifyBigEntity();
            dataClassifyBigEntity.setClassifyName(classifyName);
            dataClassifyBigEntity.setClassifyDesc(classifyDesc);
            dataClassifyBigDao.add(dataClassifyBigEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("数据库异常,请稍后再试!");
        }
        return new Result("200","添加一级分类成功!",null);
    }

    @Override
    public Result addSmallClassify(String classifyId, String classifyName, String classifyDesc) {
        if(isSmallClassifyRepeat(classifyId,classifyName)){
            return new Result("二级分类名称已存在,请重新输入");
        }
        try {
            DataClassifyBigEntity bigEntity = dataClassifyBigDao.find(classifyId);
            DataClassifySmallEntity smallEntity = new DataClassifySmallEntity();
            smallEntity.setClassifyName(classifyName);
            smallEntity.setClassifyDesc(classifyDesc);
            smallEntity.setDataClassifyBigEntity(bigEntity);
            dataClassifySmallDao.add(smallEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("数据库异常,请稍后再试!");
        }
        return new Result("200","添加二级分类成功!",null);
    }

    @Override
    public boolean isBigClassifyRepeat(String classifyName) {
        List<DataClassifyBigEntity> list = dataClassifyBigDao.findAll();
        for(DataClassifyBigEntity entity : list){
            if(entity.getClassifyName().equals(classifyName)){
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean isSmallClassifyRepeat(String classifyId, String classifyName) {
        DataClassifyBigEntity dataClassifyBigEntity = dataClassifyBigDao.find(classifyId);
        for(DataClassifySmallEntity entity : dataClassifyBigEntity.getDataClassifySmallEntities()){
            if(entity.getClassifyName().equals(classifyName)){
                return true;
            }
        }
        return false;
    }

    @Override
    public void deleteSmallClassify(String[] classifyIds) {
        dataClassifySmallDao.delete(DataClassifySmallEntity.class,classifyIds);
    }

    @Override
    public DataClassifySmallEntity getSmallClassify(String id) {
        return dataClassifySmallDao.find(id);
    }

    @Override
    public Result updateBigClassify(String classifyId, String classifyName, String classifyDesc) {
        try {
            DataClassifyBigEntity dataClassifyBigEntity = dataClassifyBigDao.find(classifyId);
            dataClassifyBigEntity.setClassifyName(classifyName);
            dataClassifyBigEntity.setClassifyDesc(classifyDesc);
            dataClassifyBigDao.update(dataClassifyBigEntity);
        }catch (Exception e) {
            e.printStackTrace();
            return new Result("修改一级分类失败!");
        }
        return new Result("200","修改一级分类成功!",null);
    }

    @Override
    public Result updateSmallClassify(String classifyId, String classifyName, String classifyDesc) {
        try {
            DataClassifySmallEntity dataClassifySmallEntity = dataClassifySmallDao.find(classifyId);
            dataClassifySmallEntity.setClassifyName(classifyName);
            dataClassifySmallEntity.setClassifyDesc(classifyDesc);
            dataClassifySmallDao.update(dataClassifySmallEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("修改二级分类失败!");
        }
        return new Result("200","修改二级分类成功!",null);
    }
}
