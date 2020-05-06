/**
 * @author yhj
 * @date 2019-10-30
 */
package com.huatusoft.dcac.systemsetting.service;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

public interface FileService{
    /**
     * 上传系统配置文件
     * @param multipartFile
     * @return
     */
    String uploadLocal(MultipartFile multipartFile);

    /***
     * 根据客户端上传md5值获取xml
     * @param loginName
     * @return
     */
    File GetXMLFileByMd5(String loginName, HttpServletRequest request);

}
