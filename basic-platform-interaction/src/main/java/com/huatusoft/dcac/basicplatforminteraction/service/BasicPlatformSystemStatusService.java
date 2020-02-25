package com.huatusoft.dcac.basicplatforminteraction.service;

import com.huatusoft.dcac.basicplatforminteraction.vo.MemoryVO;
import com.huatusoft.dcac.basicplatforminteraction.vo.ServiceVo;
import com.huatusoft.dcac.basicplatforminteraction.vo.StatusReportVo;
import com.sun.jna.Platform;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

/**
 * @author WangShun
 */
@Service
public class BasicPlatformSystemStatusService {

    private String SYSTEM_STATUS_SH_PATH;

    private static final String IP = "GetSystemInfo.sh -gi";
    private static final String CPU = "GetSystemInfo.sh -gc";
    private static final String TOTAL_MEMORY = "GetSystemInfo.sh -gma";
    private static final String FREE_MEMORY = "GetSystemInfo.sh -gmf";
    private static final String TOTAL_DISK_SIZE = "GetSystemInfo.sh -gda";
    private static final String FREE_DISK_SIZE = "GetSystemInfo.sh -gc";
    private static final String NETWORK_UTILIZATION = "GetSystemInfo.sh -gn";
    private static final String SERVER_NAME = "GetSystemInfo.sh -gsn";
    private static final String SERVER_STATUS = "GetSystemInfo.sh -gss";

    /**
     * 调用此接口获取linux系统状态参数
     */
    public StatusReportVo checkSysStatus(String platformAppId, String platformAppSecret, ServletContext servletContext) throws IOException {
        SYSTEM_STATUS_SH_PATH = servletContext.getRealPath("") + "/WEB-INF/classes/sh/";
        if (Platform.isWindows()) {
            return null;
        }
        StatusReportVo statusReportVo = new StatusReportVo();
        MemoryVO memory = new MemoryVO();
        MemoryVO disk = new MemoryVO();
        List<ServiceVo> services = new ArrayList<ServiceVo>();
        ServiceVo service = new ServiceVo();
        addExecutePermission();
        statusReportVo.setIp(exec(IP));
        statusReportVo.setCpu(exec(CPU));
        memory.setTotal(exec(TOTAL_MEMORY));
        memory.setFree(exec(FREE_MEMORY));
        disk.setFree(String.valueOf(Integer.parseInt(exec(FREE_DISK_SIZE)) / 1024));
        disk.setTotal(String.valueOf(Integer.parseInt(exec(TOTAL_DISK_SIZE)) / 1024));
        statusReportVo.setDisk(disk);
        statusReportVo.setNetwork(exec(NETWORK_UTILIZATION));
        service.setSvname(exec(SERVER_NAME));
        service.setSvstatus(exec(SERVER_STATUS));
        services.add(service);
        statusReportVo.setMemory(memory);
        statusReportVo.setServices(services);
        return statusReportVo;
    }

    private void addExecutePermission() throws IOException {
        String run = " sudo chmod +x " + SYSTEM_STATUS_SH_PATH + "GetSystemInfo.sh";
        Runtime.getRuntime().exec(run);
    }

    /**
     * 执行shell 获取结果
     */
    private String exec(String name) throws IOException {
        Process p = Runtime.getRuntime().exec(SYSTEM_STATUS_SH_PATH + name);
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
        return br.readLine();
    }
}