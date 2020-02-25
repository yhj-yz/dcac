package com.huatusoft.electronictag.base.vo;

import com.huatusoft.electronictag.base.entity.listener.BaseEntityListener;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
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
public class BaseVo implements Serializable {

    private String id;

    /** 创建者*/
    private String createUserAccount;

    private Date createDateTime;

    /** 修改者*/
    private String updateUserAccount;

    private Date updateDateTime;
}
