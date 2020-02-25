package com.huatusoft.electronictag.base.response;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/29 9:22
 */
@Getter
@Setter
public class Result implements Serializable {

    /** 响应业务状态 */
    private String status;

    /** 响应消息 */
    private String msg;

    /** 响应中的数据 */
    private Object data;

    public Result(String msg) {
        this("500", msg, null);
    }

    public Result(Object data) {
        this("200", "OK", data);
    }

    public Result(String status, String msg, Object data) {
        this.status = status;
        this.msg = msg;
        this.data = data;
    }

    public static Result ok() {
        return new Result(null);
    }

    public static Result ok(Object data) {
        return new Result(data);
    }

    public static Result build(String msg) {
        return new Result(msg);
    }

    public static Result build(String status, String msg) {
        return new Result(status, msg, null);
    }

    public static Result build(String status, String msg, Object data) {
        return new Result(status, msg, data);
    }
}
