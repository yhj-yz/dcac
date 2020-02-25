/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.electronictag.common.xml;

import com.huatusoft.electronictag.common.constant.KeytConstants;
import com.huatusoft.electronictag.common.util.XmlUtils;
import org.springframework.web.multipart.MultipartFile;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.InputStream;

public class XmlDataReaderHelper {
    public static final String XML_3000_ROOT = "NewDataSet";
    public static final String XML_ORGTOOL_ROOT = "OrgGenerate";
    public static final String XML_Log_ROOT = "log";
    private Document doc;
    private Element root;

    public void initDom(InputStream is) throws Exception {
        // 创建DocumentBuilderFactory
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        // 创建DocumentBuilder
        DocumentBuilder builder = factory.newDocumentBuilder();
        // 创建Document
        Document document = builder.parse(is);
        // 设置XML声明中standalone为yes，即没有dtd和schema作为该XML的说明文档，且不显示该属性
        document.setXmlStandalone(false);
        this.doc = document;
        this.root = this.doc.getDocumentElement();

    }

    public Document document() {
        return doc;
    }

    public Element root() {
        return root;
    }

    /**
     * 是否支持从DSM 4.7.3000版本出的组织架构文件导入
     *
     * @return
     */
    public boolean isXml3000() {
        return XML_3000_ROOT.equals(root.getNodeName());
    }

    /**
     * 是否支持从组织架构生成工具（http://www.huatusoft.com/orgtool/）导出的组织架构文件导入
     *
     * @return
     */
    public boolean isOrgtool() {
        return XML_ORGTOOL_ROOT.equals(root.getNodeName());
    }

    public boolean isLog() {
        return XML_Log_ROOT.equals(root.getNodeName());
    }

    /**
     * 判断文件配置导入文件是否是加密文件
     *
     * @param inputStream
     * @param file
     * @return
     */
    public boolean isEncryptLocalFile(InputStream inputStream, MultipartFile file) {
        Boolean Message = false;
        try {
            inputStream = XmlUtils.encryptLocalFile(file, KeytConstants.COMMON_RC4_KEY);
            initDom(inputStream);
            Message = true;
        } catch (Exception e) {
            Message = false;
        }
        return Message;
    }


}
