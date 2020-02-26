package com.huatusoft.dcac.client.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/7 16:06
 */
@Setter
@Getter
public class ElectronicTagInfoVo {
    /**
     * 文件路径
     */
    private String file_path;
    /**
     * 创建者ID
     */
    private String creator_userid;
    /**
     * 创建者
     */
    private String creator_username;
    /**
     * 创建时间
     */
    private String creatortime;
    /**
     * 终端编码
     */
    private String termcode;
    /**
     * 文件ID
     */
    private String fileid;
    /**
     * 文件涉密等级
     */
    private String classlevel;
    /**
     * 文件操作权限
     */
    private String operate_policy;
    /**
     * 流转属性
     */
    private List<TranInfoVo> traninfo;
    
}
