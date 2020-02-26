/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.common.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

public class XmlUtils {
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

}
