package com.huatusoft.dcac.common.bo;

import org.apache.commons.lang.StringUtils;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 系统设置
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class Setting implements Serializable {

    private static final long serialVersionUID = -1478999889661796840L;

    /**
     * 水印位置
     */
    public enum WatermarkPosition {

        /**
         * 无
         */
        no,

        /**
         * 左上
         */
        topLeft,

        /**
         * 右上
         */
        topRight,

        /**
         * 居中
         */
        center,

        /**
         * 左下
         */
        bottomLeft,

        /**
         * 右下
         */
        bottomRight
    }

    /**
     * 小数位精确方式
     */
    public enum RoundType {

        /**
         * 四舍五入
         */
        roundHalfUp,

        /**
         * 向上取整
         */
        roundUp,

        /**
         * 向下取整
         */
        roundDown
    }

    /**
     * 验证码类型
     */
    public enum CaptchaType {

        /**
         * 会员登录
         */
        memberLogin,

        /**
         * 会员注册
         */
        memberRegister,

        /**
         * 后台登录
         */
        adminLogin,

        /**
         * 找回密码
         */
        findPassword,

        /**
         * 重置密码
         */
        resetPassword,

        /**
         * 其它
         */
        other
    }

    /**
     * 账号锁定类型
     */
    public enum AccountLockType {

        /**
         * 会员
         */
        member,

        /**
         * 管理员
         */
        admin
    }

    /**
     * 缓存名称
     */
    public static final String CACHE_NAME = "setting";

    /**
     * 缓存Key
     */
    public static final Integer CACHE_KEY = 0;

    /**
     * 分隔符
     */
    private static final String SEPARATOR = ",";

    /**
     * 网站名称
     */
    private String siteName;

    /**
     * 网站网址
     */
    private String siteUrl;

    /**
     * logo
     */
    private String logo;

    /**
     * 联系地址
     */
    private String address;

    /**
     * 联系电话
     */
    private String phone;

    /**
     * 邮政编码
     */
    private String zipCode;

    /**
     * E-mail
     */
    private String email;

    /**
     * 备案编号
     */
    private String certtext;

    /**
     * 是否网站开启
     */
    private Boolean isSiteEnabled;

    /**
     * 网站关闭消息
     */
    private String siteCloseMessage;

    /**
     * 水印透明度
     */
    private Integer watermarkAlpha;

    /**
     * 水印图片
     */
    private String watermarkImage;

    /**
     * 水印位置
     */
    private WatermarkPosition watermarkPosition;

    /**
     * 是否开放注册
     */
    private Boolean isRegisterEnabled;

    /**
     * 是否允许E-mail重复注册
     */
    private Boolean isDuplicateEmail;

    /**
     * 禁用用户名
     */
    private String disabledUsername;

    /**
     * 用户名最小长度
     */
    private Integer usernameMinLength;

    /**
     * 用户名最大长度
     */
    private Integer usernameMaxLength;

    /**
     * 密码最小长度
     */
    private Integer passwordMinLength;

    /**
     * 密码最大长度
     */
    private Integer passwordMaxLength;

    /**
     * 注册初始积分
     */
    private Long registerPoint;

    /**
     * 注册协议
     */
    private String registerAgreement;

    /**
     * 是否允许E-mail登录
     */
    private Boolean isEmailLogin;

    /**
     * 验证码类型
     */
    private CaptchaType[] captchaTypes;

    /**
     * 账号锁定类型
     */
    private AccountLockType[] accountLockTypes;

    /**
     * 连续登录失败最大次数
     */
    private Integer accountLockCount;

    /**
     * 自动解锁时间
     */
    private Integer accountLockTime;

    /**
     * 安全密匙有效时间
     */
    private Integer safeKeyExpiryTime;

    /**
     * 上传文件最大限制
     */
    private Integer uploadMaxSize;

    /**
     * 允许上传图片扩展名
     */
    private String uploadImageExtension;

    /**
     * 允许上传Flash扩展名
     */
    private String uploadFlashExtension;

    /**
     * 允许上传媒体扩展名
     */
    private String uploadMediaExtension;

    /**
     * 允许上传文件扩展名
     */
    private String uploadFileExtension;

    /**
     * 图片上传路径
     */
    private String imageUploadPath;

    /**
     * Flash上传路径
     */
    private String flashUploadPath;

    /**
     * 媒体上传路径
     */
    private String mediaUploadPath;


    /**
     * 文件上传路径
     */
    private String fileUploadPath;
    /**
     * 流转文件上传路径
     */
    private String cirUploadPath;


    /**
     * 脱签文件上传文件
     */
    private String destUploadPath;
    /**
     * 发件人邮箱
     */
    private String smtpFromMail;

    /**
     * SMTP服务器地址
     */
    private String smtpHost;

    /**
     * SMTP服务器端口
     */
    private Integer smtpPort;

    /**
     * SMTP用户名
     */
    private String smtpUsername;

    /**
     * SMTP密码
     */
    private String smtpPassword;

    /**
     * 是否开启开发模式
     */
    private Boolean isDevelopmentEnabled;

    /**
     * Cookie路径
     */
    private String cookiePath;

    /**
     * Cookie作用域
     */
    private String cookieDomain;

    /**
     * 是否开启CNZZ统计
     */
    private Boolean isCnzzEnabled;

    /**
     * CNZZ统计站点ID
     */
    private String cnzzSiteId;

    /**
     * CNZZ统计密码
     */
    private String cnzzPassword;

    /**
     * 控制台版本
     */
    private String siteVersion;

    /**
     * 数据库版本
     */
    private String dataVersion;

    /**
     * 自动同步时间间隔（分钟）
     */
    private Integer syncTime;

    /**
     * 用于单点登录校验token的地址，如http://http://192.168.2.134:8080/restapi/verifytoken
     */
    private String verifytokenUrl;

    /**
     * 子系统在平台注册时生成的app_id
     */
    private String appId;

    /**
     * 子系统在平台注册时生成的app_secret
     */
    private String appSecret;

    /**
     * 部署方式：true单机部署，false网络部署,默认false
     */
    private Boolean isSolo;

    public Boolean getIsSolo() {
        return isSolo;
    }

    public void setIsSolo(Boolean isSolo) {
        this.isSolo = isSolo;
    }

    public String getAppSecret() {
        return appSecret;
    }

    public void setAppSecret(String appSecret) {
        this.appSecret = appSecret;
    }

    public String getVerifytokenUrl() {
        return verifytokenUrl;
    }

    public void setVerifytokenUrl(String verifytokenUrl) {
        this.verifytokenUrl = verifytokenUrl;
    }

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public Integer getSyncTime() {
        return syncTime;
    }

    public void setSyncTime(Integer syncTime) {
        this.syncTime = syncTime;
    }

    public String getSiteVersion() {
        return siteVersion;
    }

    public void setSiteVersion(String siteVersion) {
        this.siteVersion = siteVersion;
    }

    public String getDataVersion() {
        return dataVersion;
    }

    public void setDataVersion(String dataVersion) {
        this.dataVersion = dataVersion;
    }

    /**
     * 获取网站名称
     *
     * @return 网站名称
     */
    @NotEmpty
    @Length(max = 200)
    public String getSiteName() {
        return siteName;
    }

    /**
     * 设置网站名称
     *
     * @param siteName 网站名称
     */
    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    /**
     * 获取网站网址
     *
     * @return 网站网址
     */
    @NotEmpty
    @Length(max = 200)
    public String getSiteUrl() {
        return siteUrl;
    }

    /**
     * 设置网站网址
     *
     * @param siteUrl 网站网址
     */
    public void setSiteUrl(String siteUrl) {
        this.siteUrl = StringUtils.removeEnd(siteUrl, "/");
    }

    /**
     * 获取logo
     *
     * @return logo
     */
    @NotEmpty
    @Length(max = 200)
    public String getLogo() {
        return logo;
    }

    /**
     * 设置logo
     *
     * @param logo logo
     */
    public void setLogo(String logo) {
        this.logo = logo;
    }

    /**
     * 获取联系地址
     *
     * @return 联系地址
     */
    @Length(max = 200)
    public String getAddress() {
        return address;
    }

    /**
     * 设置联系地址
     *
     * @param address 联系地址
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * 获取联系电话
     *
     * @return 联系电话
     */
    @Length(max = 200)
    public String getPhone() {
        return phone;
    }

    /**
     * 设置联系电话
     *
     * @param phone 联系电话
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * 获取邮政编码
     *
     * @return 邮政编码
     */
    @Length(max = 200)
    public String getZipCode() {
        return zipCode;
    }

    /**
     * 设置邮政编码
     *
     * @param zipCode 邮政编码
     */
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    /**
     * 获取E-mail
     *
     * @return E-mail
     */
    @Email
    @Length(max = 200)
    public String getEmail() {
        return email;
    }

    /**
     * 设置E-mail
     *
     * @param email E-mail
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * 获取备案编号
     *
     * @return 备案编号
     */
    @Length(max = 200)
    public String getCerttext() {
        return certtext;
    }

    /**
     * 设置备案编号
     *
     * @param certtext 备案编号
     */
    public void setCerttext(String certtext) {
        this.certtext = certtext;
    }

    /**
     * 获取是否网站开启
     *
     * @return 是否网站开启
     */
    @NotNull
    public Boolean getIsSiteEnabled() {
        return isSiteEnabled;
    }

    /**
     * 设置是否网站开启
     *
     * @param isSiteEnabled 是否网站开启
     */
    public void setIsSiteEnabled(Boolean isSiteEnabled) {
        this.isSiteEnabled = isSiteEnabled;
    }


    /**
     * 获取网站关闭消息
     *
     * @return 网站关闭消息
     */
    @NotEmpty
    public String getSiteCloseMessage() {
        return siteCloseMessage;
    }

    /**
     * 设置网站关闭消息
     *
     * @param siteCloseMessage 网站关闭消息
     */
    public void setSiteCloseMessage(String siteCloseMessage) {
        this.siteCloseMessage = siteCloseMessage;
    }

    /**
     * 获取水印透明度
     *
     * @return 水印透明度
     */
    public Integer getWatermarkAlpha() {
        return watermarkAlpha;
    }

    /**
     * 设置水印透明度
     *
     * @param watermarkAlpha 水印透明度
     */
    public void setWatermarkAlpha(Integer watermarkAlpha) {
        this.watermarkAlpha = watermarkAlpha;
    }

    /**
     * 获取水印图片
     *
     * @return 水印图片
     */
    public String getWatermarkImage() {
        return watermarkImage;
    }

    /**
     * 设置水印图片
     *
     * @param watermarkImage 水印图片
     */
    public void setWatermarkImage(String watermarkImage) {
        this.watermarkImage = watermarkImage;
    }

    /**
     * 获取水印位置
     *
     * @return 水印位置
     */
    public WatermarkPosition getWatermarkPosition() {
        return watermarkPosition;
    }

    /**
     * 设置水印位置
     *
     * @param watermarkPosition 水印位置
     */
    public void setWatermarkPosition(WatermarkPosition watermarkPosition) {
        this.watermarkPosition = watermarkPosition;
    }

    /**
     * 获取是否开放注册
     *
     * @return 是否开放注册
     */
    @NotNull
    public Boolean getIsRegisterEnabled() {
        return isRegisterEnabled;
    }

    /**
     * 设置是否开放注册
     *
     * @param isRegisterEnabled 是否开放注册
     */
    public void setIsRegisterEnabled(Boolean isRegisterEnabled) {
        this.isRegisterEnabled = isRegisterEnabled;
    }

    /**
     * 获取是否允许E-mail重复注册
     *
     * @return 是否允许E-mail重复注册
     */
    @NotNull
    public Boolean getIsDuplicateEmail() {
        return isDuplicateEmail;
    }

    /**
     * 设置是否允许E-mail重复注册
     *
     * @param isDuplicateEmail 是否允许E-mail重复注册
     */
    public void setIsDuplicateEmail(Boolean isDuplicateEmail) {
        this.isDuplicateEmail = isDuplicateEmail;
    }

    /**
     * 获取禁用用户名
     *
     * @return 禁用用户名
     */
    @Length(max = 200)
    public String getDisabledUsername() {
        return disabledUsername;
    }

    /**
     * 设置禁用用户名
     *
     * @param disabledUsername 禁用用户名
     */
    public void setDisabledUsername(String disabledUsername) {
        if (disabledUsername != null) {
            disabledUsername = disabledUsername.replaceAll("[,\\s]*,[,\\s]*", ",").replaceAll("^,|,$", "");
        }
        this.disabledUsername = disabledUsername;
    }

    /**
     * 获取用户名最小长度
     *
     * @return 用户名最小长度
     */
    @NotNull
    @Min(1)
    @Max(117)
    public Integer getUsernameMinLength() {
        return usernameMinLength;
    }

    /**
     * 设置用户名最小长度
     *
     * @param usernameMinLength 用户名最小长度
     */
    public void setUsernameMinLength(Integer usernameMinLength) {
        this.usernameMinLength = usernameMinLength;
    }

    /**
     * 获取用户名最大长度
     *
     * @return 用户名最大长度
     */
    @NotNull
    @Min(1)
    @Max(117)
    public Integer getUsernameMaxLength() {
        return usernameMaxLength;
    }

    /**
     * 设置用户名最大长度
     *
     * @param usernameMaxLength 用户名最大长度
     */
    public void setUsernameMaxLength(Integer usernameMaxLength) {
        this.usernameMaxLength = usernameMaxLength;
    }

    /**
     * 获取密码最小长度
     *
     * @return 密码最小长度
     */
    @NotNull
    @Min(1)
    @Max(117)
    public Integer getPasswordMinLength() {
        return passwordMinLength;
    }

    /**
     * 设置密码最小长度
     *
     * @param passwordMinLength 密码最小长度
     */
    public void setPasswordMinLength(Integer passwordMinLength) {
        this.passwordMinLength = passwordMinLength;
    }

    /**
     * 获取密码最大长度
     *
     * @return 密码最大长度
     */
    @NotNull
    @Min(1)
    @Max(117)
    public Integer getPasswordMaxLength() {
        return passwordMaxLength;
    }

    /**
     * 设置密码最大长度
     *
     * @param passwordMaxLength 密码最大长度
     */
    public void setPasswordMaxLength(Integer passwordMaxLength) {
        this.passwordMaxLength = passwordMaxLength;
    }

    /**
     * 获取注册初始积分
     *
     * @return 注册初始积分
     */
    public Long getRegisterPoint() {
        return registerPoint;
    }

    /**
     * 设置注册初始积分
     *
     * @param registerPoint 注册初始积分
     */
    public void setRegisterPoint(Long registerPoint) {
        this.registerPoint = registerPoint;
    }

    /**
     * 获取注册协议
     *
     * @return 注册协议
     */
    @NotEmpty
    public String getRegisterAgreement() {
        return registerAgreement;
    }

    /**
     * 设置注册协议
     *
     * @param registerAgreement 注册协议
     */
    public void setRegisterAgreement(String registerAgreement) {
        this.registerAgreement = registerAgreement;
    }

    /**
     * 获取是否允许E-mail登录
     *
     * @return 是否允许E-mail登录
     */
    @NotNull
    public Boolean getIsEmailLogin() {
        return isEmailLogin;
    }

    /**
     * 设置是否允许E-mail登录
     *
     * @param isEmailLogin 是否允许E-mail登录
     */
    public void setIsEmailLogin(Boolean isEmailLogin) {
        this.isEmailLogin = isEmailLogin;
    }

    /**
     * 获取验证码类型
     *
     * @return 验证码类型
     */
    public CaptchaType[] getCaptchaTypes() {
        return captchaTypes;
    }

    /**
     * 设置验证码类型
     *
     * @param captchaTypes 验证码类型
     */
    public void setCaptchaTypes(CaptchaType[] captchaTypes) {
        this.captchaTypes = captchaTypes;
    }

    /**
     * 获取账号锁定类型
     *
     * @return 账号锁定类型
     */
    public AccountLockType[] getAccountLockTypes() {
        return accountLockTypes;
    }

    /**
     * 设置账号锁定类型
     *
     * @param accountLockTypes 账号锁定类型
     */
    public void setAccountLockTypes(AccountLockType[] accountLockTypes) {
        this.accountLockTypes = accountLockTypes;
    }

    /**
     * 获取连续登录失败最大次数
     *
     * @return 连续登录失败最大次数
     */
    @NotNull
    @Min(1)
    public Integer getAccountLockCount() {
        return accountLockCount;
    }

    /**
     * 设置连续登录失败最大次数
     *
     * @param accountLockCount 连续登录失败最大次数
     */
    public void setAccountLockCount(Integer accountLockCount) {
        this.accountLockCount = accountLockCount;
    }

    /**
     * 获取自动解锁时间
     *
     * @return 自动解锁时间
     */
    @NotNull
    @Min(0)
    public Integer getAccountLockTime() {
        return accountLockTime;
    }

    /**
     * 设置自动解锁时间
     *
     * @param accountLockTime 自动解锁时间
     */
    public void setAccountLockTime(Integer accountLockTime) {
        this.accountLockTime = accountLockTime;
    }

    /**
     * 获取安全密匙有效时间
     *
     * @return 安全密匙有效时间
     */
    @NotNull
    @Min(0)
    public Integer getSafeKeyExpiryTime() {
        return safeKeyExpiryTime;
    }

    /**
     * 设置安全密匙有效时间
     *
     * @param safeKeyExpiryTime 安全密匙有效时间
     */
    public void setSafeKeyExpiryTime(Integer safeKeyExpiryTime) {
        this.safeKeyExpiryTime = safeKeyExpiryTime;
    }

    /**
     * 获取上传文件最大限制
     *
     * @return 上传文件最大限制
     */
    @NotNull
    @Min(0)
    public Integer getUploadMaxSize() {
        return uploadMaxSize;
    }

    /**
     * 设置上传文件最大限制
     *
     * @param uploadMaxSize 上传文件最大限制
     */
    public void setUploadMaxSize(Integer uploadMaxSize) {
        this.uploadMaxSize = uploadMaxSize;
    }

    /**
     * 获取允许上传图片扩展名
     *
     * @return 允许上传图片扩展名
     */
    @Length(max = 200)
    public String getUploadImageExtension() {
        return uploadImageExtension;
    }

    /**
     * 设置允许上传图片扩展名
     *
     * @param uploadImageExtension 允许上传图片扩展名
     */
    public void setUploadImageExtension(String uploadImageExtension) {
        if (uploadImageExtension != null) {
            uploadImageExtension = uploadImageExtension.replaceAll("[,\\s]*,[,\\s]*", ",").replaceAll("^,|,$", "").toLowerCase();
        }
        this.uploadImageExtension = uploadImageExtension;
    }

    /**
     * 获取允许上传Flash扩展名
     *
     * @return 允许上传Flash扩展名
     */
    @Length(max = 200)
    public String getUploadFlashExtension() {
        return uploadFlashExtension;
    }

    /**
     * 设置允许上传Flash扩展名
     *
     * @param uploadFlashExtension 允许上传Flash扩展名
     */
    public void setUploadFlashExtension(String uploadFlashExtension) {
        if (uploadFlashExtension != null) {
            uploadFlashExtension = uploadFlashExtension.replaceAll("[,\\s]*,[,\\s]*", ",").replaceAll("^,|,$", "").toLowerCase();
        }
        this.uploadFlashExtension = uploadFlashExtension;
    }

    /**
     * 获取允许上传媒体扩展名
     *
     * @return 允许上传媒体扩展名
     */
    @Length(max = 200)
    public String getUploadMediaExtension() {
        return uploadMediaExtension;
    }

    /**
     * 设置允许上传媒体扩展名
     *
     * @param uploadMediaExtension 允许上传媒体扩展名
     */
    public void setUploadMediaExtension(String uploadMediaExtension) {
        if (uploadMediaExtension != null) {
            uploadMediaExtension = uploadMediaExtension.replaceAll("[,\\s]*,[,\\s]*", ",").replaceAll("^,|,$", "").toLowerCase();
        }
        this.uploadMediaExtension = uploadMediaExtension;
    }

    /**
     * 获取允许上传文件扩展名
     *
     * @return 允许上传文件扩展名
     */
    @Length(max = 200)
    public String getUploadFileExtension() {
        return uploadFileExtension;
    }

    /**
     * 设置允许上传文件扩展名
     *
     * @param uploadFileExtension 允许上传文件扩展名
     */
    public void setUploadFileExtension(String uploadFileExtension) {
        if (uploadFileExtension != null) {
            uploadFileExtension = uploadFileExtension.replaceAll("[,\\s]*,[,\\s]*", ",").replaceAll("^,|,$", "").toLowerCase();
        }
        this.uploadFileExtension = uploadFileExtension;
    }

    /**
     * 获取图片上传路径
     *
     * @return 图片上传路径
     */
    @NotEmpty
    @Length(max = 200)
    public String getImageUploadPath() {
        return imageUploadPath;
    }

    /**
     * 设置图片上传路径
     *
     * @param imageUploadPath 图片上传路径
     */
    public void setImageUploadPath(String imageUploadPath) {
        if (imageUploadPath != null) {
            if (!imageUploadPath.startsWith("/")) {
                imageUploadPath = "/" + imageUploadPath;
            }
            if (!imageUploadPath.endsWith("/")) {
                imageUploadPath += "/";
            }
        }
        this.imageUploadPath = imageUploadPath;
    }

    /**
     * 获取Flash上传路径
     *
     * @return Flash上传路径
     */
    @NotEmpty
    @Length(max = 200)
    public String getFlashUploadPath() {
        return flashUploadPath;
    }

    /**
     * 设置Flash上传路径
     *
     * @param flashUploadPath Flash上传路径
     */
    public void setFlashUploadPath(String flashUploadPath) {
        if (flashUploadPath != null) {
            if (!flashUploadPath.startsWith("/")) {
                flashUploadPath = "/" + flashUploadPath;
            }
            if (!flashUploadPath.endsWith("/")) {
                flashUploadPath += "/";
            }
        }
        this.flashUploadPath = flashUploadPath;
    }

    /**
     * 获取媒体上传路径
     *
     * @return 媒体上传路径
     */
    @NotEmpty
    @Length(max = 200)
    public String getMediaUploadPath() {
        return mediaUploadPath;
    }

    /**
     * 设置媒体上传路径
     *
     * @param mediaUploadPath 媒体上传路径
     */
    public void setMediaUploadPath(String mediaUploadPath) {
        if (mediaUploadPath != null) {
            if (!mediaUploadPath.startsWith("/")) {
                mediaUploadPath = "/" + mediaUploadPath;
            }
            if (!mediaUploadPath.endsWith("/")) {
                mediaUploadPath += "/";
            }
        }
        this.mediaUploadPath = mediaUploadPath;
    }

    /**
     * 获取文件上传路径
     *
     * @return 文件上传路径
     */
    @NotEmpty
    @Length(max = 200)
    public String getFileUploadPath() {
        return fileUploadPath;
    }


    @NotEmpty
    @Length(max = 200)
    public String getCirUploadPath() {
        return cirUploadPath;
    }


    /**
     * 设置流转文件地址
     *
     * @param cirUploadPath
     */
    public void setCirUploadPath(String cirUploadPath) {
        if (cirUploadPath != null) {
            if (!cirUploadPath.startsWith("/")) {
                cirUploadPath = "/" + cirUploadPath;
            }
            if (!cirUploadPath.endsWith("/")) {
                cirUploadPath += "/";
            }
        }
        this.cirUploadPath = cirUploadPath;
    }

    @NotEmpty
    @Length(max = 200)
    public String getDestUploadPath() {
        return destUploadPath;
    }


    /**
     * 设置流转文件地址
     *
     * @param destUploadPath
     */
    public void setDestUploadPath(String destUploadPath) {
        if (destUploadPath != null) {
            if (!destUploadPath.startsWith("/")) {
                destUploadPath = "/" + destUploadPath;
            }
            if (!destUploadPath.endsWith("/")) {
                destUploadPath += "/";
            }
        }
        this.destUploadPath = destUploadPath;
    }

    /**
     * 设置文件上传路径
     *
     * @param fileUploadPath 文件上传路径
     */
    public void setFileUploadPath(String fileUploadPath) {
//		if (fileUploadPath != null) {
//			if (!fileUploadPath.startsWith("/")) {
//				fileUploadPath = "/" + fileUploadPath;
//			}
//			if (!fileUploadPath.endsWith("/")) {
//				fileUploadPath += "/";
//			}
//		}
        this.fileUploadPath = fileUploadPath;
    }

    /**
     * 获取发件人邮箱
     *
     * @return 发件人邮箱
     */
    @NotEmpty
    @Email
    @Length(max = 200)
    public String getSmtpFromMail() {
        return smtpFromMail;
    }

    /**
     * 设置发件人邮箱
     *
     * @param smtpFromMail 发件人邮箱
     */
    public void setSmtpFromMail(String smtpFromMail) {
        this.smtpFromMail = smtpFromMail;
    }

    /**
     * 获取SMTP服务器地址
     *
     * @return SMTP服务器地址
     */
    @NotEmpty
    @Length(max = 200)
    public String getSmtpHost() {
        return smtpHost;
    }

    /**
     * 设置SMTP服务器地址
     *
     * @param smtpHost SMTP服务器地址
     */
    public void setSmtpHost(String smtpHost) {
        this.smtpHost = smtpHost;
    }

    /**
     * 获取SMTP服务器端口
     *
     * @return SMTP服务器端口
     */
    @NotNull
    @Min(0)
    public Integer getSmtpPort() {
        return smtpPort;
    }

    /**
     * 设置SMTP服务器端口
     *
     * @param smtpPort SMTP服务器端口
     */
    public void setSmtpPort(Integer smtpPort) {
        this.smtpPort = smtpPort;
    }

    /**
     * 获取SMTP用户名
     *
     * @return SMTP用户名
     */
    @NotEmpty
    @Length(max = 200)
    public String getSmtpUsername() {
        return smtpUsername;
    }

    /**
     * 设置SMTP用户名
     *
     * @param smtpUsername SMTP用户名
     */
    public void setSmtpUsername(String smtpUsername) {
        this.smtpUsername = smtpUsername;
    }

    /**
     * 获取SMTP密码
     *
     * @return SMTP密码
     */
    @Length(max = 200)
    public String getSmtpPassword() {
        return smtpPassword;
    }

    /**
     * 设置SMTP密码
     *
     * @param smtpPassword SMTP密码
     */
    public void setSmtpPassword(String smtpPassword) {
        this.smtpPassword = smtpPassword;
    }


    /**
     * 获取是否开启开发模式
     *
     * @return 是否开启开发模式
     */
    @NotNull
    public Boolean getIsDevelopmentEnabled() {
        return isDevelopmentEnabled;
    }

    /**
     * 设置是否开启开发模式
     *
     * @param isDevelopmentEnabled 是否开启开发模式
     */
    public void setIsDevelopmentEnabled(Boolean isDevelopmentEnabled) {
        this.isDevelopmentEnabled = isDevelopmentEnabled;
    }


    /**
     * 获取Cookie路径
     *
     * @return Cookie路径
     */
    @NotEmpty
    @Length(max = 200)
    public String getCookiePath() {
        return cookiePath;
    }

    /**
     * 设置Cookie路径
     *
     * @param cookiePath Cookie路径
     */
    public void setCookiePath(String cookiePath) {
        if (cookiePath != null && !cookiePath.endsWith("/")) {
            cookiePath += "/";
        }
        this.cookiePath = cookiePath;
    }

    /**
     * 获取Cookie作用域
     *
     * @return Cookie作用域
     */
    @Length(max = 200)
    public String getCookieDomain() {
        return cookieDomain;
    }

    /**
     * 设置Cookie作用域
     *
     * @param cookieDomain Cookie作用域
     */
    public void setCookieDomain(String cookieDomain) {
        this.cookieDomain = cookieDomain;
    }

    /**
     * 获取是否开启CNZZ统计
     *
     * @return 是否开启CNZZ统计
     */
    public Boolean getIsCnzzEnabled() {
        return isCnzzEnabled;
    }

    /**
     * 设置是否开启CNZZ统计
     *
     * @param isCnzzEnabled 是否开启CNZZ统计
     */
    public void setIsCnzzEnabled(Boolean isCnzzEnabled) {
        this.isCnzzEnabled = isCnzzEnabled;
    }

    /**
     * 获取CNZZ统计站点ID
     *
     * @return CNZZ统计站点ID
     */
    public String getCnzzSiteId() {
        return cnzzSiteId;
    }

    /**
     * 设置CNZZ统计站点ID
     *
     * @param cnzzSiteId CNZZ统计站点ID
     */
    public void setCnzzSiteId(String cnzzSiteId) {
        this.cnzzSiteId = cnzzSiteId;
    }

    /**
     * 获取CNZZ统计密码
     *
     * @return CNZZ统计密码
     */
    public String getCnzzPassword() {
        return cnzzPassword;
    }

    /**
     * 设置CNZZ统计密码
     *
     * @param cnzzPassword CNZZ统计密码
     */
    public void setCnzzPassword(String cnzzPassword) {
        this.cnzzPassword = cnzzPassword;
    }

    /**
     * 获取禁用用户名
     *
     * @return 禁用用户名
     */
    public String[] getDisabledUsernames() {
        return StringUtils.split(disabledUsername, SEPARATOR);
    }

    /**
     * 获取允许上传图片扩展名
     *
     * @return 允许上传图片扩展名
     */
    public String[] getUploadImageExtensions() {
        return StringUtils.split(uploadImageExtension, SEPARATOR);
    }

    /**
     * 获取允许上传Flash扩展名
     *
     * @return 允许上传Flash扩展名
     */
    public String[] getUploadFlashExtensions() {
        return StringUtils.split(uploadFlashExtension, SEPARATOR);
    }

    /**
     * 获取允许上传媒体扩展名
     *
     * @return 允许上传媒体扩展名
     */
    public String[] getUploadMediaExtensions() {
        return StringUtils.split(uploadMediaExtension, SEPARATOR);
    }

    /**
     * 获取允许上传文件扩展名
     *
     * @return 允许上传文件扩展名
     */
    public String[] getUploadFileExtensions() {
        return StringUtils.split(uploadFileExtension, SEPARATOR);
    }

}