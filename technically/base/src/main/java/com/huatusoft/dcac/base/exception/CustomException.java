package com.huatusoft.dcac.base.exception;

import com.huatusoft.dcac.base.response.message.ResultMessage;
import com.huatusoft.dcac.common.bo.CommonAttributes;
import lombok.Getter;

import javax.servlet.ServletException;
import java.util.Objects;

/**
 * @author WangShun
 */

@Getter
public class CustomException extends ServletException {

    private static final long serialVersionUID = 1851133562326220008L;

    private Object data;
    private ResultMessage resultMessage;

    public CustomException(ResultMessage resultMessage) {
        super(resultMessage.toString(), null);
    }

    public CustomException(ResultMessage resultMessage, Object data) {
        super(data != null && !Objects.equals(CommonAttributes.STRING_NULL, data) ? resultMessage.toString() + CommonAttributes.DATA_SEPARATOR + data : resultMessage.toString() + CommonAttributes.DATA_SEPARATOR);
        this.data = data;
        this.resultMessage = resultMessage;
    }
}