package com.geshanzsq.common.core.web.response;

import com.geshanzsq.common.core.constant.HttpStatus;
import com.geshanzsq.common.core.util.message.MessageUtils;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * 返回前端统一响应
 *
 * @author geshanzsq
 * @date 2022/3/19
 */
@ApiModel("统一响应")
@Getter
@Setter
public class ResponseResult<T> {

    @ApiModelProperty("状态码")
    private int code;

    @ApiModelProperty("提示消息")
    private String message;

    @ApiModelProperty("数据")
    private T data;

    public static ResponseResult success() {
        return success(null);
    }

    public static <T> ResponseResult success(T data) {
        return success(HttpStatus.SUCCESS, MessageUtils.message("operate.success"), data);
    }

    public static <T> ResponseResult success(String message, T data) {
        return success(HttpStatus.SUCCESS, message, data);
    }

    public static <T> ResponseResult success(int code, String message, T data) {
        return new ResponseResult(code, message, data);
    }

    public static ResponseResult fail(String message) {
        return fail(HttpStatus.FAIL, message);
    }

    public static ResponseResult fail(int code) {
        return fail(code, MessageUtils.message("operate.fail"));
    }

    public static ResponseResult fail(int code, String message) {
        return fail(code, message, null);
    }

    public static <T> ResponseResult fail(int code, String message, T data) {
        return new ResponseResult(code, message, data);
    }

    public ResponseResult(int code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }
}
