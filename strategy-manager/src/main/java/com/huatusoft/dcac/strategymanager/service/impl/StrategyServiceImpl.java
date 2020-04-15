package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.common.util.XmlUtils;
import com.huatusoft.dcac.organizationalstrucure.dao.UserDao;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import com.huatusoft.dcac.strategymanager.dao.*;
import com.huatusoft.dcac.strategymanager.entity.*;
import com.huatusoft.dcac.strategymanager.service.StrategyService;
import net.sf.ehcache.config.PersistenceConfiguration;
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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author yhj
 * @date 2020-3-20
 */
@Service
public class StrategyServiceImpl extends BaseServiceImpl<StrategyEntity, StrategyDao> implements StrategyService{
    @Autowired
    private StrategyDao strategyDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private DataClassifySmallDao dataClassifySmallDao;

    @Autowired
    private DataGradeDao dataGradeDao;

    @Autowired
    private StrategyRuleDao strategyRuleDao;

    @Autowired
    private StrategyMaskRuleDao strategyMaskRuleDao;

    @Autowired
    private UserService userService;

    @Override
    public Page<StrategyEntity> findAllByPage(Pageable pageable, String strategyName, String strategyDesc,String updateTime) {
        Specification<StrategyEntity> specification = new Specification<StrategyEntity>() {
            @Override
            public Predicate toPredicate(Root<StrategyEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(strategyName)) {
                    predicates.add(criteriaBuilder.like(root.get("strategyName").as(String.class), "%" + strategyName + "%"));
                }
                if(StringUtils.isNotBlank(strategyDesc)){
                    predicates.add(criteriaBuilder.like(root.get("strategyDesc").as(String.class),"%" + strategyDesc + "%"));
                }
                if(StringUtils.isNotBlank(updateTime)){
                    String[] updateTimes = updateTime.split("-");
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date startTime = null;
                    Date endTime = null;
                    try {
                        startTime = format.parse(updateTimes[0]);
                        endTime = format.parse(updateTimes[1]);
                    }catch (ParseException e){
                        e.printStackTrace();
                    }
                    predicates.add(criteriaBuilder.between(root.get("updateDateTime"),startTime,endTime));
                 }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public Result addStrategy(String strategyName, String strategyDesc, String dataClassifyName, String dataGradeName, String scanType, String ruleName, String responseType, String maskRuleName) {
        DataClassifySmallEntity dataClassifySmallEntity = dataClassifySmallDao.findByClassifyName(dataClassifyName);
        if(dataClassifySmallEntity == null ){
            return new Result("不存在相应的数据分类!");
        }
        DataGradeEntity dataGradeEntity = dataGradeDao.findByGradeName(dataGradeName);
        if(dataGradeEntity == null ){
            return new Result("不存在相应的数据分级!");
        }
        StrategyRuleEntity strategyRuleEntity = strategyRuleDao.findByRuleName(ruleName);
        if(strategyRuleEntity == null){
            return new Result("不存在相应的检测规则!");
        }
        StrategyMaskRuleEntity strategyMaskRuleEntity = strategyMaskRuleDao.findByRuleName(maskRuleName);
        if(strategyMaskRuleEntity == null){
            return new Result("不存在相应脱敏规则!");
        }
        if(isNameRepeat(strategyName)){
            return new Result("已存在策略名称");
        }
        try {
            StrategyEntity strategyEntity = new StrategyEntity();
            strategyEntity.setStrategyName(strategyName);
            strategyEntity.setStrategyDesc(strategyDesc);
            strategyEntity.setDataClassifyId(dataClassifySmallEntity.getId());
            strategyEntity.setDataGradeId(dataGradeEntity.getId());
            strategyEntity.setScanTypeCode(scanType);
            List<StrategyRuleEntity> strategyRuleEntities = new ArrayList<StrategyRuleEntity>();
            strategyRuleEntities.add(strategyRuleEntity);
            strategyEntity.setStrategyRuleEntities(strategyRuleEntities);
            List<StrategyMaskRuleEntity> strategyMaskRuleEntities = new ArrayList<StrategyMaskRuleEntity>();
            strategyMaskRuleEntities.add(strategyMaskRuleEntity);
            strategyEntity.setStrategyMaskRuleEntities(strategyMaskRuleEntities);
            strategyEntity.setResponseTypeCode(responseType);
            strategyDao.add(strategyEntity);
            UserEntity current = userService.getCurrentUser();
            current.setPolicyFileEdited(true);
            current.setPolicy(0);
            userService.update(current);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("数据库异常,请稍后再试!");
        }
        return new Result("200","新增策略成功!",null);
    }

    @Override
    public String getStrategyById(String id) throws Exception {
        UserEntity find = userDao.find(id);
        if (find == null) {
            throw new Exception("用户不存在!");
        }
        StringBuffer contrData = getStrategyData(find.getAccount());
        XmlUtils programDoc = XmlUtils.newInstanceFromString(contrData.toString(), true);
        String data = programDoc.doc2String();
        return data;
    }

    @Override
    public Result updateStrategy(String strategyId,String strategyName, String strategyDesc, String dataClassifyName, String dataGradeName, String scanType, String ruleName, String responseType, String maskRuleName) {
        DataClassifySmallEntity dataClassifySmallEntity = dataClassifySmallDao.findByClassifyName(dataClassifyName);
        if(dataClassifySmallEntity == null ){
            return new Result("不存在相应的数据分类!");
        }
        DataGradeEntity dataGradeEntity = dataGradeDao.findByGradeName(dataGradeName);
        if(dataGradeEntity == null ){
            return new Result("不存在相应的数据分级!");
        }
        StrategyRuleEntity strategyRuleEntity = strategyRuleDao.findByRuleName(ruleName);
        if(strategyRuleEntity == null){
            return new Result("不存在相应的检测规则!");
        }
        StrategyMaskRuleEntity strategyMaskRuleEntity = strategyMaskRuleDao.findByRuleName(maskRuleName);
        if(strategyMaskRuleEntity == null){
            return new Result("不存在相应脱敏规则!");
        }
        try {
            StrategyEntity strategyEntity = strategyDao.find(strategyId);
            strategyEntity.setStrategyName(strategyName);
            strategyEntity.setStrategyDesc(strategyDesc);
            strategyEntity.setDataClassifyId(dataClassifySmallEntity.getId());
            strategyEntity.setDataGradeId(dataGradeEntity.getId());
            strategyEntity.setScanTypeCode(scanType);
            List<StrategyRuleEntity> strategyRuleEntities = new ArrayList<StrategyRuleEntity>();
            strategyRuleEntities.add(strategyRuleEntity);
            strategyEntity.setStrategyRuleEntities(strategyRuleEntities);
            List<StrategyMaskRuleEntity> strategyMaskRuleEntities = new ArrayList<StrategyMaskRuleEntity>();
            strategyMaskRuleEntities.add(strategyMaskRuleEntity);
            strategyEntity.setStrategyMaskRuleEntities(strategyMaskRuleEntities);
            strategyEntity.setResponseTypeCode(responseType);
            strategyDao.update(strategyEntity);
            UserEntity current = userService.getCurrentUser();
            current.setPolicyFileEdited(true);
            current.setPolicy(0);
            userService.update(current);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("修改策略失败!");
        }
        return new Result("200","修改策略成功!",null);
    }

    public StringBuffer getStrategyData(String loginName){
        StringBuffer sb = new StringBuffer();

        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><Config cfg_id=\"1\" date=\"2020.04.09\" product=\"Vamtoo-DCAC\" version=\"V5.0.1000\">");

        List<StrategyEntity> strategyEntities = null;
        UserEntity loginUser = null;
        try {
            if (!"".equals(loginName)) {
                loginUser = userDao.findByAccountEquals(loginName);
                if(loginUser != null){
                    strategyEntities = strategyDao.findByCreateUserAccount(loginName);
                }else {
                    return sb;
                }
            }
            sb.append(findList(strategyEntities, true) +"</StrategyList>\n" +
                    "  <User>\n" +
                    "    <UserID>"+loginUser.getId()+"</UserID>\n" +
                    "    <UserName>"+loginUser.getAccount()+"</UserName>\n" +
                    "    <Password>"+loginUser.getPassword()+"</Password>\n" +
                    "  </User>\n"+
                    "</Config>");
        }catch (Exception e){
            e.printStackTrace();
            return sb;
        }
        return sb;
    }

    /**
     * 递归配置 父节点下的全部子节点
     *
     * @return
     */
    private StringBuffer findList(List<StrategyEntity> list, boolean hasNode) {

        StringBuffer sb = new StringBuffer();

        sb.append("<StrategyList>");
        try {
            if (list == null) {
                return sb;
            }
            for (StrategyEntity strategyEntity : list) {
                sb.append(getNodeXml(strategyEntity));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb;
    }
    /**
     * 拼接策略子节点
     * @param strategyEntity
     * @return
     */
    private StringBuffer getNodeXml(StrategyEntity strategyEntity){
        StringBuffer sb = new StringBuffer();
        if (strategyEntity == null) {
            return sb;
        } else {
            sb.append("<SL n=\"" + strategyEntity.getStrategyName() + "\">\n" +
                    "<ScreeningMethod>" + strategyEntity.getStrategyRuleEntities().get(0).getStrategyRuleContentEntities().get(0).getRuleTypeCode() + "</ScreeningMethod>\n" +
                    "<Keywords>" + strategyEntity.getStrategyRuleEntities().get(0).getStrategyRuleContentEntities().get(0).getMatchContent() + "</Keywords> \n" +
                    "<ProtectionMethod>" + strategyEntity.getResponseTypeCode() + "</ProtectionMethod>\n" +
                    "<DataType>" + strategyEntity.getDataClassifyId() + "</DataType>\n" +
                    "<DataClassification>" + strategyEntity.getDataGradeId() + "</DataClassification>\n" +
                    "</SL>\n");
        }
        return sb;
    }

    private boolean isNameRepeat(String strategyName){
        List<StrategyEntity> strategyEntities = strategyDao.findAll();
        for(StrategyEntity strategyEntity : strategyEntities){
            if(strategyEntity.getStrategyName().equals(strategyName)){
                return true;
            }
        }
        return false;
    }
}
