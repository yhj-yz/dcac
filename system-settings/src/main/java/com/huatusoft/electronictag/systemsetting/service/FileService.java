/**
 * @author yhj
 * @date 2019-10-30
 */
package com.huatusoft.electronictag.systemsetting.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileService{
    /**
     * 上传系统配置文件
     * @param multipartFile
     * @return
     */
    String uploadLocal(MultipartFile multipartFile);
}
