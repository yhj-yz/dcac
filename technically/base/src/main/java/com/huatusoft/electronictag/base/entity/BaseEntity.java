package com.huatusoft.electronictag.base.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.huatusoft.electronictag.base.entity.listener.BaseEntityListener;
import com.huatusoft.electronictag.common.constant.SystemConstants;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/25 16:04
 */

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@MappedSuperclass
@EntityListeners(BaseEntityListener.class)
public class BaseEntity implements Serializable {
    @Id
    @Column(name = "ID",length = 32)
    @GeneratedValue(generator = "spring-data-uuid")
    @GenericGenerator(name = "spring-data-uuid", strategy = "uuid")
    private String id;

    /** 创建者*/
    @CreatedBy
    @Column(name = "CREATE_USER_ACCOUNT", length = 16)
    private String createUserAccount;

    @CreatedDate
    @DateTimeFormat(pattern = SystemConstants.DATE_TIME_PATTERN)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    @Column(name = "CREATE_DATE_TIME", length = 16)
    private Date createDateTime;

    /** 修改者*/
    @LastModifiedBy
    @Column(name = "UPDATE_USER_ACCOUNT", length = 16)
    private String updateUserAccount;

    @LastModifiedDate
    @DateTimeFormat(pattern = SystemConstants.DATE_TIME_PATTERN)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
    @Column(name = "UPDATE_DATE_TIME", length = 16)
    private Date updateDateTime;
}
