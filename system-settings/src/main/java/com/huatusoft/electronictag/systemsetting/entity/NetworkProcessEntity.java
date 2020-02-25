/**
 * @author yhj
 * @date 2019-10-18
 */
package com.huatusoft.electronictag.systemsetting.entity;

import com.huatusoft.electronictag.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Getter
@Setter
@Entity
@Table(name="HT_ELECTRONICTAG_NETWORK_PROCESS")
public class NetworkProcessEntity extends BaseEntity{
    /**进程名*/
    @Column(name = "PROCESS_NAME",length = 255)
    private String processName;
}
