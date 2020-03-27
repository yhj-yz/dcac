package com.huatusoft.dcac.auditlog.entity;

import com.huatusoft.dcac.auditlog.entity.base.LogEntity;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author yhj
 * @date 2020-2-25
 */
@Getter
@Setter
@Entity
@Table(name = "HT_ELECTRONICTAG_ALARM_LOG")
@DynamicInsert
@DynamicUpdate
public class AlarmLogEntity extends LogEntity {
    @Transient
    private static final long serialVersionUID = -6060671623132341383L;

    public enum ReadFlag{
        /**已读*/
        read,
        /**未读*/
        unread,
    }

    /**告警类别 */
    @Column(name = "TYPE")
    private String type;
    /**保密终端编码 */
    @Column(name = "MCODE")
    private String mcode;
    /**告警等级 */
    @Column(name = "LEVEL")
    private String level;
    /**处置结果描述 */
    @Column(name = "RESULT")
    private String result;
    /**告警详细描述信息 */
    @Column(name = "WARN_DETAIL")
    private String warnDetail;
    /**告警ID */
    @Column(name = "WARN_ID")
    private String warnId;
    /**告警处置结果 */
    @Column(name = "STATUS")
    private Integer status;
    /**是否已读 */
    @Column(name = "READ_FLAG")
    private ReadFlag readFlag;

}
