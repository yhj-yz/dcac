package com.huatusoft.dcac.auditlog.entity;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

/**类里面所有属性null值不转换
 * @author yhj
 * @date 2020-4-9
 * @param <T>
 */
@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RecvEntity<T> {

    /** 消息描述-没有数据*/
    private static final String NODATA_DESC = "无数据返回";
    /** 消息描述-成功*/
    private static final String SUCCESS_DESC = "成功";
    /** 消息描述-非法参数*/
    private static final String ILLEGAL_DESC = "非法参数";
    /** 消息描述-用户名密码错误*/
    private static final String NAME_PASSOWRD_ERROR_DESC = "登陆失败,用户名密码错误";
    /** 消息码-用户名密码错误*/
    private static final String NAME_PASSOWRD_ERROR_CODE = "800";
    /** 消息码-没有数据*/
    private static final String NODATA_CODE = "300";
    /** 消息码-成功*/
    private static final String SUCCESS_CODE = "200";
    /** 消息码-非法参数*/
    private static final String ILLEGAL_CODE = "400";
    /** 消息码 */
    private String result;
    /** 消息描述 */
    private String description;
    /** 数据 */
    private T data;

    /**
     * 初始化一个新创建的 Message 对象，使其表示一个空消息。
     */
    public RecvEntity() {

    }

    public RecvEntity(String result, String description, T data) {
        this.result = result;
        this.description = description;
        this.data = data;
    }

    /**
     * 成功消息
     * @param data
     * @return
     */
    public static <T> RecvEntity<T> success(T data){
        return new RecvEntity<T>(SUCCESS_CODE, SUCCESS_DESC, data);
    }

    /**
     * 无数据消息
     * @return
     */
    public static <T> RecvEntity<T> nodata(){
        return new RecvEntity<T>(NODATA_CODE, NODATA_DESC, null);
    }

    /**
     * 参数非法消息
     * @return
     */
    public static <T> RecvEntity<T> illegal(){
        return new RecvEntity<T>(ILLEGAL_CODE, ILLEGAL_DESC, null);
    }

    /**
     * 用户名密码错误消息
     * @return
     */
    public static <T> RecvEntity<T> namePasswordError(){
        return new RecvEntity<T>(NAME_PASSOWRD_ERROR_CODE, NAME_PASSOWRD_ERROR_DESC, null);
    }

    /**
     * 自定义错误消息
     * @param result 错误码
     * @param message 返回的错误消息
     * @return
     */
    public static <T> RecvEntity<T> message(String result, String message){
        return new RecvEntity<T>(result, message, null);
    }
}
