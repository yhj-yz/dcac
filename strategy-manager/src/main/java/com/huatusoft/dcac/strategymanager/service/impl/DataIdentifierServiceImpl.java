package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.strategymanager.dao.DataIdentifierDao;
import com.huatusoft.dcac.strategymanager.entity.DataIdentifierEntity;
import com.huatusoft.dcac.strategymanager.service.DataIdentifierService;
import com.opencsv.CSVReader;
import com.sun.org.apache.regexp.internal.RE;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.boot.model.naming.Identifier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhj
 * @date 2020-3-27
 */
@Service
public class DataIdentifierServiceImpl extends BaseServiceImpl<DataIdentifierEntity, DataIdentifierDao> implements DataIdentifierService{
    @Autowired
    private DataIdentifierDao dataIdentifierDao;

    @Override
    public Page<DataIdentifierEntity> findAllByPage(Pageable pageable, String identifierName, String identifierType) {
        Specification<DataIdentifierEntity> specification = new Specification<DataIdentifierEntity>() {
            @Override
            public Predicate toPredicate(Root<DataIdentifierEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(identifierName)) {
                    predicates.add(criteriaBuilder.like(root.get("identifierName").as(String.class), "%" + identifierName + "%"));
                }
                if (StringUtils.isNotBlank(identifierType)) {
                    predicates.add(criteriaBuilder.like(root.get("createUserAccount").as(String.class), "%" + identifierType + "%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public Result importIdentifier(MultipartFile uploadFile) {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new InputStreamReader(uploadFile.getInputStream()));
            String str = null;
            int line = 0;
            while ((str = br.readLine()) != null){
                line++;
                if(line == 1){
                    continue;
                }
                String[] row = changeData(str).split(",");
                DataIdentifierEntity dataIdentifierEntity = null;
                if(isIdentifierNameRepeat(row[0]) != null){
                    dataIdentifierEntity = isIdentifierNameRepeat(row[0]);
                }else {
                    dataIdentifierEntity = new DataIdentifierEntity();
                }
                dataIdentifierEntity.setIdentifierName(row[0].replace("'",","));
                dataIdentifierEntity.setIdentifierType(row[1].replace("'",","));
                dataIdentifierEntity.setIdentifierDesc(row[2].replace("'",","));
                String indentifierRule = row[3].replace("'",",");
                indentifierRule = indentifierRule.replace(">","&gt;");
                indentifierRule = indentifierRule.replace("<","&lt;");
                dataIdentifierEntity.setIdentifierRule(indentifierRule);
                if(isIdentifierNameRepeat(row[0].replace("'",",")) != null){
                    dataIdentifierDao.update(dataIdentifierEntity);
                }else {
                    dataIdentifierDao.add(dataIdentifierEntity);
                }
            }
            br.close();
        }catch (IOException e){
            e.printStackTrace();
            return new Result("导入失败,请稍后再试!");
        }
        return new Result("200","导入成功!",null);
    }

    private DataIdentifierEntity isIdentifierNameRepeat(String identifierName){
        DataIdentifierEntity dataIdentifierEntity = dataIdentifierDao.findByIdentifierName(identifierName);
        if(dataIdentifierEntity == null){
            return null;
        }
        return dataIdentifierEntity;
    }

    /**递归替换单元格内的逗号为单引号*/
    private String changeData(String str){
        if(str.contains("\"")){
            int index = str.indexOf("\"");
            int second = str.indexOf("\"",index+1);
            String left = str.substring(0,index);
            String middle = str.substring(index+1,second).replace(",","'");
            String right = str.substring(second+1);
            return left+middle+changeData(right);
        }else {
            return str;
        }
    }
}
