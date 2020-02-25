package com.huatusoft.electronictag.client.entity;

import com.huatusoft.electronictag.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/7 16:21
 */
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "HT_ELECTRONICTAG_ELECTRONICTAG")
public class ElectronicTagEntity extends BaseEntity {

    private static final long serialVersionUID = -4008864127595339494L;
    /**
     * 文件路径
     */
    @Column(name = "FILE_PATH")
    private String filePath;
    /**
     * 创建者ID
     */
    @Column(name = "USER_ID", length = 40)
    private String userId;
    /**
     * 创建者账号
     */
    @Column(name = "CREATE_USER_ACCOUNT", length = 40)
    private String createAccount;
    /**
     * 终端编码
     */
    @Column(name = "TERM_CODE", length = 40)
    private String termCode;
    /**
     * 文件ID
     */
    @Column(name = "FILE_Id", length = 40)
    private String fileId;
    /**
     * 文件涉密等级
     */
    @Column(name = "CLASS_LEVEL", length = 1)
    private Integer classLevel = 0;
    /**
     * 文件操作权限(打印 1，复制2，编辑4，外发8）
     */
    @Column(name = "OPERATE_POLICY", length = 1)
    private Integer operatePolicy = 0;

    /**
     * 流转属性
     */
    @OneToMany(mappedBy = "electronicTag", fetch = FetchType.LAZY,cascade = {CascadeType.REMOVE})
    private List<TranEntity> trans;

}
