package com.huatusoft.dcac.client.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/23 17:57
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ClientLoginParamVo {

    /**
     * 登陆用户名
     */
    private String account;
    /**
     * 登陆用户密码
     */
    private String password;
    /**
     * 登陆时间戳
     */
    @DateTimeFormat(pattern = "yyyyMMddHHmmss")
    private Date timestamp;
}
