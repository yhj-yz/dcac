/**
 * @author yhj
 * @date 2019-10-29
 */
package com.huatusoft.dcac.systemsetting.controller;

import com.huatusoft.dcac.common.exception.DisunionKeyException;
import com.huatusoft.dcac.common.service.cache.CacheService;
import com.huatusoft.dcac.common.util.DataSourceUtils;
import com.huatusoft.dcac.common.util.DateUtils;
import com.huatusoft.dcac.systemsetting.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.MessageFormat;

@Controller("systemBackUpController")
@RequestMapping("/admin/backUp")
public class SystemBackUpController {

    private static final String system_sql_file[] = new String[] { "系统配置-", ".xml" };// mysql导出sql文件命令

    @Autowired
    private CacheService cacheService;

    @Autowired
    private FileService fileService;

    /***
     * 系统数据配置页面
     * @return
     */
    @GetMapping(value = "/backUpView")
    public String backUpView() {
        return "/systemSetting/systemBackUp/list.ftl";
    }

    @RequestMapping(value = "/dbRecover", method = RequestMethod.POST)
    public String dbRecover(RedirectAttributes redirectAttributes, MultipartFile file, HttpServletRequest request) {
        if (file.getSize() == 0) {
            redirectAttributes.addFlashAttribute("data", "请选择数据文件");
            return "redirect:/admin/backUp/backUpView.do";
        }
//        String name = file.getOriginalFilename();
        String url = fileService.uploadLocal(file);
        String filePath = request.getSession().getServletContext().getRealPath("/") + url;
        try {
            DataSourceUtils.dbRecover(filePath, DataSourceUtils.backup_key);
            cacheService.myClear();
        } catch (DisunionKeyException e) {
            redirectAttributes.addFlashAttribute("data", "该文件的密钥与系统密钥不符");
            return "redirect:/admin/backUp/backUpView.do";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("data", "导入数据时失败");
            return "redirect:/admin/backUp/backUpView.do";
        }
        redirectAttributes.addFlashAttribute("data", "导入成功");
        return "redirect:/admin/backUp/backUpView.do";
    }

    @RequestMapping(value = "/dbBackUp")
    public void dbBackup(HttpServletResponse response, HttpServletRequest request) {
        try {
            String filePath = DataSourceUtils.dbBackup(request, DataSourceUtils.backup_key);
            File file = new File(filePath);
            byte[] byteArray = org.apache.commons.io.FileUtils.readFileToByteArray(file);
            String appendFileName = "{0}" + DateUtils.getCurrentDate() + "{1}";
            String format = MessageFormat.format(appendFileName, system_sql_file);
            String fileName = format.replace(" ", "");
            response.setContentType("application/x-download charset=UTF-8");
            request.setCharacterEncoding("UTF-8");
            String header = request.getHeader("User-Agent").toUpperCase();
            if (header.contains("MSIE") || header.contains("TRIDENT") || header.contains("EDGE")) {
                fileName = URLEncoder.encode(fileName, "utf-8");
                fileName = fileName.replace("+", "%20"); // IE下载文件名空格变+号问题
            } else if ("firefox".equals(getExplorerType(request))) {
                String filenamedisplay = URLEncoder.encode(fileName, "UTF-8");// 火狐浏览器会对文件先处理一次
                fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
            } else {
                fileName = new String(fileName.getBytes(), "ISO8859-1");
            }
            response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.addHeader("Content-Length", String.valueOf(byteArray.length));
            response.addHeader("Cache-Control", "private");
            response.addHeader("Content-Type", "application/octet-stream; charset=utf-8");
            response.getOutputStream().write(byteArray);
        } catch (Exception e) {
            try {
                response.sendRedirect(request.getContextPath() + "/admin/backUp/backUpView.do?error=error");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    public static String getExplorerType(HttpServletRequest request) {
        String agent = request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {
            return "firefox";
        } else if (agent != null && agent.toLowerCase().indexOf("msie") > 0) {
            return "ie";
        } else if (agent != null && agent.toLowerCase().indexOf("chrome") > 0) {
            return "chrome";
        } else if (agent != null && agent.toLowerCase().indexOf("opera") > 0) {
            return "opera";
        } else if (agent != null && agent.toLowerCase().indexOf("safari") > 0) {
            return "safari";
        }
        return "others";
    }
}
