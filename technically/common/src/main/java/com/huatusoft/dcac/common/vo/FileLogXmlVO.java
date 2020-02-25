package com.huatusoft.dcac.common.vo;

import com.huatusoft.dcac.common.annotation.SimpleXmlElement;
import com.huatusoft.dcac.common.annotation.SimpleXmlRoot;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Pattern;

@Getter
@Setter
@SimpleXmlRoot("FileLogXmlVO")
public class FileLogXmlVO {
    @NotEmpty(message = "用户账号 不能为空")
    @Length(max = 32, message = "用户账号 长度需要在 {min} 和 {max} 之间")
    @Pattern(regexp = "^[^\\\\/:*,?\"<>| ]+$", message = "用户账号 不允许含限定字符\\/:*,?\"<>| ")
    @SimpleXmlElement("userAccount")
    private String userAccount;

    @SimpleXmlElement("userName")
    private String userName;

    @SimpleXmlElement("ipAddress")
    private String ipAddress;

    @SimpleXmlElement("deviceName")
    private String deviceName;

    @NotEmpty(message = "日志时间 不能为空")
    @SimpleXmlElement("createDate")
    private String createDate;

    @SimpleXmlElement("operationType")
    private String operationType;

    @SimpleXmlElement("docName")
    private String docName;

    @SimpleXmlElement("fileServerPath")
    private String fileServerPath;

    @SimpleXmlElement("fileTime")
    private String fileTime;

    @SimpleXmlElement("departIds")
    private String departIds;

    @NotEmpty(message = "GUID 不能为空")
    @SimpleXmlElement("guid")
    private String guid;
}
