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

    @Autowired
    private StrategyGroupDao strategyGroupDao;

    @Autowired
    private StrategyGroupRelationDao strategyGroupRelationDao;

    @Autowired
    private DataIdentifierDao dataIdentifierDao;

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
    public Result addStrategy(String strategyName, String strategyDesc, String dataClassifyId, String dataGradeId, String scanType, String scanPath, String ruleId, String responseType, String maskRuleId,String matchValue) {
        if(isNameRepeat(strategyName)){
            return new Result("已存在策略名称!");
        }
        DataClassifySmallEntity dataClassifySmallEntity = dataClassifySmallDao.find(dataClassifyId);
        DataGradeEntity dataGradeEntity = dataGradeDao.find(dataGradeId);
        StrategyRuleEntity strategyRuleEntity = strategyRuleDao.find(ruleId);
        try {
            StrategyEntity strategyEntity = new StrategyEntity();
            try {
                int match_value = Integer.parseInt(matchValue);
                strategyEntity.setMatchValue(match_value);
            }catch (NumberFormatException e){
                e.printStackTrace();
                return new Result("输入的匹配数必须为数字!");
            }
            strategyEntity.setStrategyName(strategyName);
            strategyEntity.setStrategyDesc(strategyDesc);
            //路径扫描
            if("2".equals(scanType)){
                strategyEntity.setScanPath(scanPath);
            }
            strategyEntity.setDataClassifySmallEntity(dataClassifySmallEntity);
            strategyEntity.setDataGradeEntity(dataGradeEntity);
            strategyEntity.setScanTypeCode(scanType);
            List<StrategyRuleEntity> strategyRuleEntities = new ArrayList<StrategyRuleEntity>();
            strategyRuleEntities.add(strategyRuleEntity);
            strategyEntity.setStrategyRuleEntities(strategyRuleEntities);
            if(null != maskRuleId && !"".equals(maskRuleId)){
                String[] maskRuleIds = maskRuleId.split(",");
                List<StrategyMaskRuleEntity> strategyMaskRuleEntities = strategyMaskRuleDao.findByIdIn(maskRuleIds);
                strategyEntity.setStrategyMaskRuleEntities(strategyMaskRuleEntities);
            }
            strategyEntity.setResponseTypeCode(responseType);
            strategyDao.add(strategyEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("新增策略失败,请稍后再试!");
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
    public Result updateStrategy(String strategyId,String strategyName, String strategyDesc, String dataClassifyId, String dataGradeId, String scanType,String scanPath, String ruleId, String responseType, String maskRuleId,String matchValue) {
        DataClassifySmallEntity dataClassifySmallEntity = dataClassifySmallDao.find(dataClassifyId);
        DataGradeEntity dataGradeEntity = dataGradeDao.find(dataGradeId);
        StrategyRuleEntity strategyRuleEntity = strategyRuleDao.find(ruleId);
        try {
            StrategyEntity strategyEntity = strategyDao.find(strategyId);
            if(isNameRepeat(strategyName) && !strategyName.equals(strategyEntity.getStrategyName())){
                return new Result("策略名称已存在!");
            }
            try {
                int match_value = Integer.parseInt(matchValue);
                strategyEntity.setMatchValue(match_value);
            }catch (NumberFormatException e){
                e.printStackTrace();
                return new Result("输入的匹配数必须为数字!");
            }
            strategyEntity.setStrategyName(strategyName);
            strategyEntity.setStrategyDesc(strategyDesc);
            //路径扫描
            if("2".equals(scanType)){
                strategyEntity.setScanPath(scanPath);
            }
            strategyEntity.setDataClassifySmallEntity(dataClassifySmallEntity);
            strategyEntity.setDataGradeEntity(dataGradeEntity);
            strategyEntity.setScanTypeCode(scanType);
            List<StrategyRuleEntity> strategyRuleEntities = new ArrayList<StrategyRuleEntity>();
            strategyRuleEntities.add(strategyRuleEntity);
            strategyEntity.setStrategyRuleEntities(strategyRuleEntities);
            if(null != maskRuleId && !"".equals(maskRuleId)){
                String[] maskRuleIds = maskRuleId.split(",");
                List<StrategyMaskRuleEntity> strategyMaskRuleEntities = strategyMaskRuleDao.findByIdIn(maskRuleIds);
                strategyEntity.setStrategyMaskRuleEntities(strategyMaskRuleEntities);
            }else {
                strategyEntity.setStrategyMaskRuleEntities(null);
            }
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

    @Override
    public Result deleteRule(String[] strategyIds) {
        List<StrategyEntity> strategyEntities = strategyDao.findByIdIn(strategyIds);
        for(StrategyEntity strategyEntity : strategyEntities){
            if(strategyEntity.getStrategyGroupEntities().size() > 0){
                return new Result(strategyEntity.getStrategyName()+"该策略正在被使用,请重新选择!");
            }
        }
        try {
            delete(StrategyEntity.class,strategyIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除策略失败,请稍后再试!");
        }
        return new Result("删除策略成功!");
    }

    public StringBuffer getStrategyData(String loginName){
        StringBuffer sb = new StringBuffer();

        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><Config version=\"V5.0.1000\" product=\"Vamtoo-DCAC\" date=\"2020.04.09\" cfg_id=\"1\">");

        List<StrategyGroupEntity> strategyGroupEntities = null;
        UserEntity loginUser = null;
        try {
            if (!"".equals(loginName)) {
                loginUser = userDao.findByAccountEquals(loginName);
                if(loginUser != null){
                    strategyGroupEntities = strategyGroupDao.findByCreateUserAccount(loginName);
                }else {
                    return sb;
                }
            }
            sb.append(findList(strategyGroupEntities, true) +"</StrategyList>" +
                    "<User>" +
                    "<UserID>"+loginUser.getId()+"</UserID>" +
                    "<UserName>"+loginUser.getAccount()+"</UserName>" +
                    "<Password>"+loginUser.getPassword()+"</Password>" +
                    "</User>"+
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
    private StringBuffer findList(List<StrategyGroupEntity> list, boolean hasNode) {

        StringBuffer sb = new StringBuffer();

        sb.append("<StrategyList>");
        try {
            if (list == null) {
                return sb;
            }
            List<StrategyGroup> strategyGroups =  strategyGroupRelationDao.findByStrategyGroupEntityOrderByPriorityAsc(list.get(0));
            for(StrategyGroup strategyGroup : strategyGroups){
                sb.append(getNodeXml(strategyGroup.getStrategyEntity()));
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
            sb.append("<StrategyInfo id=\"" + strategyEntity.getId() + "\" description=\"" + strategyEntity.getStrategyDesc() + "\" name=\"" + strategyEntity.getStrategyName() + "\">" +
                    "<DataType>" + strategyEntity.getDataClassifySmallEntity().getId() + "</DataType>" +
                    "<DataClassification>" + strategyEntity.getDataGradeEntity().getId() + "</DataClassification>" +
                    "<HitsThreshold>"+strategyEntity.getMatchValue()+"</HitsThreshold>"+
                    "<DetectionRules id=\"" + strategyEntity.getStrategyRuleEntities().get(0).getId() + "\" description=\"" + strategyEntity.getStrategyRuleEntities().get(0).getRuleDesc() + "\" name=\"" + strategyEntity.getStrategyRuleEntities().get(0).getRuleName() + "\">" +
                    "<MatchingRules>");
            for (StrategyRuleContentEntity strategyRuleContentEntity : strategyEntity.getStrategyRuleEntities().get(0).getStrategyRuleContentEntities()) {
                sb.append(getStrategyRule(strategyRuleContentEntity));
            }
            sb.append("</MatchingRules>" +
                    "</DetectionRules>" +
                    "<ResponseRules type=\""+strategyEntity.getResponseTypeCode()+"\">");
            if("1".equals(strategyEntity.getResponseTypeCode())){
                for(StrategyMaskRuleEntity strategyMaskRuleEntity : strategyEntity.getStrategyMaskRuleEntities()){
                    sb.append(getMaskRule(strategyMaskRuleEntity));
                }
            }
            sb.append("</ResponseRules>"+
                    "</StrategyInfo>");
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

    private StringBuffer getStrategyRule(StrategyRuleContentEntity strategyRuleContentEntity){
        StringBuffer sb = new StringBuffer();
        if(strategyRuleContentEntity == null){
            return sb;
        }else {
            sb.append("<MR id=\""+strategyRuleContentEntity.getId()+"\" info=\""+strategyRuleContentEntity.getRuleContent()+"\" type=\""+strategyRuleContentEntity.getRuleTypeCode()+"\"/>");
        }
        return sb;
    }

    private StringBuffer getMaskRule(StrategyMaskRuleEntity strategyMaskRuleEntity){
        StringBuffer sb = new StringBuffer();
        if(strategyMaskRuleEntity == null){
            return sb;
        }else {
            if("0".equals(strategyMaskRuleEntity.getRuleTypeCode())){
                DataIdentifierEntity dataIdentifierEntity = dataIdentifierDao.findByIdentifierName(strategyMaskRuleEntity.getMaskContent());
                sb.append("<DesensitizationInfo type=\""+strategyMaskRuleEntity.getRuleTypeCode()+"\" replace_after=\""+strategyMaskRuleEntity.getMaskEffect()+"\" replace_before=\""+dataIdentifierEntity.getIdentifierRule()+"\"/>");
            }else {
                sb.append("<DesensitizationInfo type=\""+strategyMaskRuleEntity.getRuleTypeCode()+"\" replace_after=\""+strategyMaskRuleEntity.getMaskEffect()+"\" replace_before=\""+strategyMaskRuleEntity.getMaskContent()+"\"/>");
            }
        }
        return sb;
    }
}
