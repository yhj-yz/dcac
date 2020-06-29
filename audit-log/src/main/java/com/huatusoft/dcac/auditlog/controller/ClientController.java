package com.huatusoft.dcac.auditlog.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.huatusoft.dcac.auditlog.entity.*;
import com.huatusoft.dcac.auditlog.service.FileLogService;
import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.common.util.JsonUtils;
import com.huatusoft.dcac.auditlog.entity.LoginReturnEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.LoginParamEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import com.huatusoft.dcac.strategymanager.entity.TerminalEntity;
import com.huatusoft.dcac.strategymanager.service.TerminalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author yhj
 * @date 2020-4-9
 */
@Controller
@RequestMapping("/DGAPI/api")
public class ClientController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private FileLogService fileLogService;

    @Autowired
    private TerminalService terminalService;

    /**
     * 日志服务接口
     * @param content
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/log/1/upload_file_log")
    public @ResponseBody
    RecvEntity<List<FileOperInfo>> uploadFileLog(@RequestBody String content){
        try {
            FileLogEntity fileLogEntity = JsonUtils.toObjectByGson(content, FileLogEntity.class);
            fileLogService.add(fileLogEntity);
            return RecvEntity.success(null);
        } catch (Exception e) {
            e.printStackTrace();
            return RecvEntity.nodata();
        }

    }

    /**
     * 上传终端信息
     * @param content
     * @return
     */
    @PostMapping(value = "/dg/1/register")
    public @ResponseBody
    RecvEntity<TerminalEntity> register(@RequestBody String content){
        try {
            TerminalEntity terminalEntity = JsonUtils.toObjectByGson(content, TerminalEntity.class);
            terminalService.add(terminalEntity);
            return RecvEntity.success(null);
        } catch (Exception e) {
            e.printStackTrace();
            return RecvEntity.nodata();
        }
    }

    /**
     * 更新终端的扫描状态
     * @param content
     * @return
     */
    @PostMapping(value = "log/1/upload_scan_status")
    public @ResponseBody
    RecvEntity<TerminalEntity> uploadScanStatus(@RequestBody String content){
        try {
            TerminalEntity terminalEntity = JsonUtils.toObjectByGson(content, TerminalEntity.class);
            TerminalEntity oldTerminalEntity = terminalService.findByClientId(terminalEntity.getClientId());
            oldTerminalEntity.setScanStatus(terminalEntity.getScanStatus());
            terminalService.update(oldTerminalEntity);
            return RecvEntity.success(null);
        }catch (Exception e){
            e.printStackTrace();
            return RecvEntity.nodata();
        }
    }

    @GetMapping(value = "/common/1/test_connect")
    public @ResponseBody
    RecvEntity<RecvSlaveEntity> testConnect(){
        return RecvEntity.success(null);
    }

    @PostMapping(value = "/dg/1/login")
    public @ResponseBody
    RecvEntity<LoginReturnEntity> login(@RequestBody String content){
        try {
            LoginParamEntity paramEntity = JsonUtils.toObjectByGson(content, LoginParamEntity.class);
            UserEntity user = userService.login(paramEntity);
            if (user == null) {
                return RecvEntity.namePasswordError();
            }
            return RecvEntity.success(null);
        } catch (Exception e) {
            e.printStackTrace();
            return RecvEntity.namePasswordError();
        }
    }
}
