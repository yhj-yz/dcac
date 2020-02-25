package com.huatusoft.dcac.client.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

/**
 * @author WangShun
 */
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "HT_ELECTRONICTAG_TRAN")
public class TranEntity extends BaseEntity {
    private static final long serialVersionUID = -7560632862897255232L;
    /**
     * 流转时所有者用户
     */
    @Column(name = "TRAN_USER")
    private String tranUser;
    /**
     * 流转时所有者终端编码
     */
    @Column(name = "TERM_CODE")
	private String termCode;
    /**
     * 流转时时间
     */
    @Column(name = "OPE_TIME")
	private Date opeTime;
    /**
     * 流转类型:0导入 1导出
     */
    @Column(name = "OPE_TYPE")
	private Integer opeType;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "TRAN_ID")
	private ElectronicTagEntity electronicTag;
	

}
