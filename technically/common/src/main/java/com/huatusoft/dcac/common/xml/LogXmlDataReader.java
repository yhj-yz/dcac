/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.common.xml;

import com.huatusoft.dcac.common.annotation.SimpleXmlElement;
import com.huatusoft.dcac.common.annotation.SimpleXmlRoot;
import com.huatusoft.dcac.common.exception.DataStoreReadException;
import com.huatusoft.dcac.common.util.ReflectUtils;
import com.huatusoft.dcac.common.util.ValidatorUtils;
import org.apache.commons.lang.StringUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


@SuppressWarnings("unchecked")
public class LogXmlDataReader<E> extends BaseDataStore<E> implements DataReader<E> {

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

    public void initDom(Document document) throws Exception {
        this.doc = document;
        this.root = this.doc.getDocumentElement();
    }
    public LogXmlDataReader() {
    }

    public LogXmlDataReader(Collection<E> data) {
        super(data);
    }

    @Override
    public void init(Class<?> clazz) {
        this.clazz = clazz;
        SimpleXmlRoot sheet = clazz.getAnnotation(SimpleXmlRoot.class);
        int size = 0;
        if (sheet != null) {
            this.title = sheet.value();
        }
        Field[] fields = clazz.getDeclaredFields();
        for (Field field : fields) {
            SimpleXmlElement anno = field.getAnnotation(SimpleXmlElement.class);
            if (anno != null) {
                size++;
            }
        }
        colNames = new String[size];
        colProNames = new String[size];
        int index = 0;
        for (Field field : fields) {
            SimpleXmlElement anno = field.getAnnotation(SimpleXmlElement.class);
            if (anno != null) {
                colNames[index] = anno.value();
                colProNames[index] = field.getName();
                index++;
            }
        }
    }

    @Override
    public boolean valid() throws Exception {
        boolean valid = false;
        if (root != null && root.getNodeName().equals(XmlDataReaderHelper.XML_Log_ROOT)) {
            valid = true;
        } else {
            throw new DataStoreReadException(String.format("数据格式不正确:根节点名称不匹配"));
        }
        return valid;
    }

    //只检查一条日志
    public <T> List<T> getNodesAndExecOnlyOne(LogXmlDataReader<T> reader) throws Exception {
        List<T> result = new ArrayList<T>();
        if (StringUtils.isBlank(reader.title)){
            return result;
        }
        NodeList childNodes = this.root.getChildNodes();
        if (childNodes.getLength() > 0){
            for (int i = 0; i < 2; i++) {
                Node item = childNodes.item(i);
                if (item.getNodeName().equals(reader.title)){//一个FileAuthLogXmlVO节点对应一条日志
                    T t = execNode(item, reader);
                    if (t != null) {
                        result.add(t);
                    }
                }
            }
        }
        return result;
    }

    /**
     *
     * @param node 一个node对应一条日志     *
     * @param reader
     * @return
     * @throws Exception
     */
    private <T> T execNode(Node node, LogXmlDataReader<T> reader) throws Exception {
        NodeList childNodes = node.getChildNodes();
        T obj = (T) reader.clazz.newInstance();
        boolean isEmpty = true;
        String errorMsg = null;
        if (childNodes.getLength() > 0){
            outer: for (int j = 0; j < reader.colNames.length; j++) {
                String colName = reader.colNames[j];
                for (int i = 0; i < childNodes.getLength(); i++) {
                    Node item = childNodes.item(i);
                    if (item.getNodeName().equals(colName)){
                        //判断子节点个数是否大于1：大于1是表示不是文本，需要进一步判断子集合
                        NodeList itemChilds = item.getChildNodes();
                        if(itemChilds.getLength()>1){
                            for(int k=0;k<itemChilds.getLength();k++){
                                Node subItem=itemChilds.item(k);
                            }
                        }else{
                            String textContent = item.getTextContent();
                            if (textContent != null) {
                                textContent = textContent.trim();
                                if (isEmpty) {
                                    errorMsg = String.format("%s=%s", colName, textContent);
                                }
                                isEmpty = false;
                            }
                            ReflectUtils.setter(obj, reader.colProNames[j], textContent, String.class);
                        }
                        continue outer;
                    }
                }
            }
        }
        if (isEmpty) {
            return null;
        }
        ValidatorUtils.isValid(obj, String.format("%s表 %s :", reader.title, errorMsg));
        return obj;
    }

    public  <T> int getNodesAndExecLength(LogXmlDataReader<T> reader) throws Exception {
        if (StringUtils.isBlank(reader.title)){
            return 0;
        }
        NodeList childNodes = this.root.getChildNodes();
        if (childNodes.getLength() > 0){
            return childNodes.getLength();
        }else{
            return 0;
        }
    }


    public <T> List<T> getNodesAndExec(LogXmlDataReader<T> reader,Integer start,Integer length) throws Exception {
        List<T> result = new ArrayList<T>();
        if (StringUtils.isBlank(reader.title)){
            return result;
        }
        NodeList childNodes = this.root.getChildNodes();
        if (childNodes.getLength() > 0){
            System.out.println("start:"+start);
            System.out.println("length:"+length);
            for (int i = start; i < length; i++) {
                Node item = childNodes.item(i);
                if (item.getNodeName().equals(reader.title)){//一个FileAuthLogXmlVO节点对应一条日志
                    T t = execNode(item, reader);
                    if (t != null) {
                        result.add(t);
                    }
                }
            }
        }
        return result;
    }
}
