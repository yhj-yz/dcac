/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.common.util;

import com.huatusoft.dcac.common.bo.Setting;
import org.springframework.web.multipart.MultipartFile;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.Date;

public class XmlUtils {

    private Document doc;

    private Element root;

    /**
     * 判断文件类型是否为xml
     * @param file
     * @param key
     * @return
     */
    public static InputStream encryptLocalFile(MultipartFile file, String key) {
        try {
            if (file.getOriginalFilename().contains(".xml")) {
                byte[] data;
                byte[] byteArray = file.getBytes();
                data = Rc4Utils.RC4Base(byteArray, key);
                InputStream is = new ByteArrayInputStream(data);
                return is;
            } else {
                System.out.println("所传文件为空或文件类型不是.xml类型,所传文件名为:" + file.getName());
                return null;
            }
        } catch (IOException e) {
            System.out.println("xml文件读取异常:" + e);
            return null;
        }
    }

    public static XmlUtils newInstanceFromString(String content, boolean withVersion) throws ParserConfigurationException, SAXException, IOException {
        // 创建DocumentBuilderFactory
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        // 创建DocumentBuilder
        DocumentBuilder builder = factory.newDocumentBuilder();
        // 创建Document
        Document document = builder.parse(new ByteArrayInputStream(content.getBytes("utf-8")));
        // 设置XML声明中standalone为yes，即没有dtd和schema作为该XML的说明文档，且不显示该属性
        document.setXmlStandalone(true);
        XmlUtils xmlUtil = new XmlUtils();
        xmlUtil.doc = document;
        xmlUtil.root = document.getDocumentElement();
        if (withVersion) {
            Setting setting = SettingUtils.get();
            xmlUtil.root.setAttribute("product", "DCAC");
            xmlUtil.root.setAttribute("version", setting.getSiteVersion());
            xmlUtil.root.setAttribute("date", DateUtils.DateToString(new Date(), DateStyle.YYYY_MM_DD));
        }
        return xmlUtil;
    }

    /**
     * 文档所有节点都转化为string字符串
     * @return
     */
    public String doc2String() {
        return doc2String(doc);
    }

    /**
     * 根据节点转化为string字符串
     * @param node
     * @return
     */
    public String doc2String(Node node) {
        // 创建TransformerFactory对象
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = null;
        StringWriter writer = null;
        try {
            // 创建Transformer对象
            // 使用Transformer的transform()方法将DOM树转换成XML
            transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            // 设置缩进量
            transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
            writer = new StringWriter();
            transformer.transform(new DOMSource(node), new StreamResult(writer));

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            try {
                writer.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return writer == null ? "" : writer.toString();
    }
}
