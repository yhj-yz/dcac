package com.huatusoft.dcac.web.aspect.log;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.common.annotation.ManagerLog;
import com.huatusoft.dcac.common.constant.SystemConstants;
import com.huatusoft.dcac.common.util.HttpUtils;
import com.huatusoft.dcac.auditlog.entity.ManagerLogEntity;
import com.huatusoft.dcac.auditlog.service.ManagerLogService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/6 16:46
 */
@Aspect
@Component
public class ManagerLogAnnotationAspect extends BaseController {
    @Autowired
    private ManagerLogService managerLogService;

    @Around("@annotation(com.huatusoft.dcac.common.annotation.ManagerLog)")
    public Object aroundAdvice(ProceedingJoinPoint pjp) throws Throwable {
        // 1.方法执行前的处理，相当于前置通知
        // 获取方法签名
        MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
        // 获取方法
        Method method = methodSignature.getMethod();
        // 获取方法上面的注解
        ManagerLog managerLogAnnotation = method.getAnnotation(ManagerLog.class);
        // 获取操作描述的属性值
        //获取操作模块名称
        String operateModel = managerLogAnnotation.operateModel();
        //获取操作描述
        String description = managerLogAnnotation.description();
        //获取当前操作人账号
        String operateUserAccount = String.valueOf(getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT));
        //获取当前操作人的IP
        String operateIp = HttpUtils.getRealIp(getRequest());
        // 创建一个日志对象(准备记录日志)
        ManagerLogEntity managerLogEntity = new ManagerLogEntity();
        managerLogEntity.setOperationModel(operateModel);
        managerLogEntity.setDescription(description);
        managerLogEntity.setUserAccount(operateUserAccount);
        managerLogEntity.setIp(operateIp);
        Object result = null;
        try {
            //让代理方法执行
            result = pjp.proceed();
            // 2.相当于后置通知(方法成功执行之后走这里)
            managerLogEntity.setOperationType("成功");
        } catch (Exception e) {
            //获取异常原因
            if (e instanceof CustomException) {
                managerLogEntity.setDescription(managerLogEntity.getDescription() + "[cause :" + ((CustomException)e).getResultMessage().getMessage() + "]");
                managerLogEntity.setOperationType("失败");
            }
            throw e;
        } finally {
            managerLogService.addManagerLog(managerLogEntity);
        }
        return result;
    }
}
