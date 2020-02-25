/**
 * @author yhj
 * @date 2019-10-30
 */
package com.huatusoft.electronictag.systemsetting.service.impl;

import com.huatusoft.electronictag.common.bo.Setting;
import com.huatusoft.electronictag.common.util.FreemarkerUtils;
import com.huatusoft.electronictag.common.util.SettingUtils;
import com.huatusoft.electronictag.systemsetting.service.FileService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class FileServiceImpl implements FileService,ServletContextAware {
    @Autowired
    private ServletContext servletContext;

    @Override
    public String uploadLocal(MultipartFile multipartFile) {
        if (multipartFile == null) {
            return null;
        }
        Setting setting = SettingUtils.get();
        String uploadPath;
        uploadPath = setting.getFileUploadPath();
        try {
            Map<String, Object> model = new HashMap<String, Object>();
            model.put("uuid", UUID.randomUUID().toString());
            String path = FreemarkerUtils.process(uploadPath, model);
            String destPath = path + UUID.randomUUID() + "." + FilenameUtils.getExtension(multipartFile.getOriginalFilename());
            File destFile = new File(servletContext.getRealPath(destPath));
            if (!destFile.getParentFile().exists()) {
                destFile.getParentFile().mkdirs();
            }
            multipartFile.transferTo(destFile);
            return destPath;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}
