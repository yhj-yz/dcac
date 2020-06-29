package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;

/**
 * @author yhj
 * @date 2020-6-24
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_TERMINAL")
public class TerminalEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 313316212521421345L;

    /**设备名称 */
    @Column(name = "COMPUTER_NAME",length = 255)
    private String computerName;

    /**IP地址 */
    @Column(name = "IP_ADDRESS",length = 20)
    private String ip;

    /**系统版本 */
    @Column(name = "SYSTEM_VERSION",length = 20)
    private String systemVersion;

    /**账号信息 */
    @Column(name = "USER_ID",length = 32)
    private String userId;

    /**部门信息 */
    @Column(name = "DEPARTMENT_INFORM",length = 255)
    private String departmentInform;

    /**版本信息 */
    @Column(name = "CLIENT_VERSION")
    private String clientVersion;

    /**连接状态 */
    @Column(name = "CONNECT_STATUS")
    private String connectStatus;

    /**策略信息 */
    @Column(name = "GROUP_ID")
    private String groupId;

    /**扫描状态 */
    @Column(name = "SCAN_STATUS")
    private String scanStatus;

    /**客户端id */
    @Column(name = "CLIENT_ID")
    private String clientId;
}
