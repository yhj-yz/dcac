/**
 * @author yhj
 * @date 2019-10-30
 */
package com.huatusoft.dcac.systemsetting.service.impl;

import com.huatusoft.dcac.common.bo.Setting;
import com.huatusoft.dcac.common.util.FileUtils;
import com.huatusoft.dcac.common.util.FreemarkerUtils;
import com.huatusoft.dcac.common.util.SettingUtils;
import com.huatusoft.dcac.organizationalstrucure.dao.UserDao;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyService;
import com.huatusoft.dcac.systemsetting.service.FileService;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.validator.internal.util.privilegedactions.GetResource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class FileServiceImpl implements FileService,ServletContextAware {
    @Autowired
    private UserDao userDao;

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private StrategyService strategyService;

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
    public File GetXMLFileByMd5(String loginName, HttpServletRequest request) {
        String xmlPath =  this.getClass().getClassLoader().getResource("/").getPath() + "\\" + loginName + ".xml";
        File loginNameXml = GetXmlByLoginName(loginName, xmlPath);

        if (loginNameXml != null) {
            return loginNameXml;
        } else {
            return GetXMLFileByDataBase(xmlPath, loginName, request);
        }
    }

    public File GetXmlByLoginName(String loginName, String xmlPath) {

        File xmlFile = new File(xmlPath);
        UserEntity fileUser = userDao.findByAccountEquals(loginName);

        //存在用户的xml文件 ，并且用户当前配置未修改
        if (xmlFile.exists() && fileUser.getPolicyFileEdited() != null && (fileUser.getPolicy().equals(0)) && (!fileUser.getPolicyFileEdited())) {
            //当修改过 再判断客户端的md5值是否一致
//			if(md5.toLowerCase().equals(FileMd5Utils.getFileMD5(xmlFile).toLowerCase())){
//				return xmlFile;
//			}else{
//				return null;
//			}
            return xmlFile;

        } else {
            return null;
        }
    }

    /***
     * 根据数据库中的策略生成XML并将受控程序的受控属性改为true
     * @param path
     * @return
     */
    private File GetXMLFileByDataBase(String path, String loginName, HttpServletRequest request) {
        String fileName = java.util.UUID.randomUUID() + ".xml";
        String xmlPath = this.getClass().getClassLoader().getResource("/").getPath() +"\\strategy-manager\\" + fileName;
        if (createXml(xmlPath, loginName)) {
            FileUtils.copyFileCover(xmlPath, path, true);
            File xmlFile = new File(path);
            FileUtils.deleteFile(xmlPath);
            UserEntity user = userDao.findByAccountEquals(loginName);
            if (user != null) {
                user.setPolicyFileEdited(false);
                user.setPolicy(0);
                userDao.update(user);
            }
            return xmlFile;
        } else {

            return null;
        }
    }

    /**
     * 解析数据库中的策略保存至xml
     * @param xmlpath  保存xml路径
     * @return boolean
     */
    public boolean createXml(String xmlpath, String loginName) {

        try {
            createXmlByPid(xmlpath, loginName);

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 解析数据库中的策略保存至xml
     *
     * @param xmlpath  保存xml路径
     * @return boolean
     */
    public boolean createXmlByPid(String xmlpath, String loginName) {

        try {
            // 创建xml文件
            //FileUtils.createFile(xmlpath);

            File xmlFile = new File(xmlpath);
            if (!xmlFile.exists()) {
                if (!FileUtils.createFile(xmlpath)) {
                    return false;
                }
            }

            //老方法
            //StringBuffer sb=new StringBuffer();
            // 读取 control_manager 拼接字符串
            //sb=getContrData(parentid,xmlpath,loginname);

            //新方法
            String sbXMl = "";
            UserEntity curUser = userDao.findByAccountEquals(loginName);
            sbXMl = strategyService.getStrategyById(curUser.getId());

            // 将字符串写入xml文件
            writeIntoXml(sbXMl, xmlpath);

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    /**
     * 将StringBuffer写入xml
     *
     * @param sb   xml StringBuffer
     * @return boolean
     */
    private static void writeIntoXml(String sb, String xmlpath) {

        try {
//			System.out.println(xmlpath);
//			FileWriter fw=new FileWriter(xmlpath);
//	        fw.write(sb);
//	        fw.flush();
//	        fw.close();
            FileUtils.write(new File(xmlpath), sb, "utf-8");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}
