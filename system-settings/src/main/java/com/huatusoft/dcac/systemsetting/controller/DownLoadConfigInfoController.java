package com.huatusoft.dcac.systemsetting.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.common.util.JsonUtils;
import com.huatusoft.dcac.systemsetting.service.FileService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

/**
 * @author yhj
 * @date 2020-4-10
 */
@Controller
@RequestMapping("/DGAPI/api/file")
public class DownLoadConfigInfoController extends BaseController {

    @Autowired
    private FileService fileService;

    @PostMapping(value = "/1/download_file")
    public @ResponseBody
    void downloadfile(@RequestBody String content, HttpServletResponse response, HttpServletRequest request)  throws Exception {
        try {
            File downLoadFile=null;

            String loginName = JsonUtils.getJsonString(content,"loginName");

            downLoadFile =fileService.GetXMLFileByMd5(loginName, request);

            if (downLoadFile != null) {
                byte[] byteArray = FileUtils.readFileToByteArray(downLoadFile);
                response.addHeader("Content-Disposition","inline;filename=dg.xml");
                response.addHeader("Content-Length", String.valueOf(byteArray.length));
                response.addHeader("Cache-Control", "private");
                response.addHeader("Content-Type","application/octet-stream; charset=utf-8");
                response.getOutputStream().write(byteArray);
            }

        } catch (Exception e) {
            e.printStackTrace();
            //return RecvEntity.nodata();
        }
    }
}
