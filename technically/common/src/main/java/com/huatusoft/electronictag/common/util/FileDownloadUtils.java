package com.huatusoft.electronictag.common.util;


import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/5 16:19
 */
public class FileDownloadUtils {
    public static void download(HttpServletResponse response, File file) throws IOException {
        response.setCharacterEncoding("UTF-8");
        // 设置文件名，解决乱码
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(file.getName(), "UTF-8"));
        // 设置缓冲区大小
        int bufferSize = 4096;
        int readSize = 0;
        int writeSize = 0;

        // allocateDirect速度更快
        ByteBuffer buff = ByteBuffer.allocateDirect(bufferSize);
        try (FileInputStream fileInputStream = new FileInputStream(file);
             FileChannel fileChannel = fileInputStream.getChannel();) {
            while ((readSize = fileChannel.read(buff)) != -1) {
                if (readSize == 0) {
                    continue;
                }
                buff.position(0);
                buff.limit(readSize);
                while (buff.hasRemaining()) {
                    writeSize = Math.min(buff.remaining(), bufferSize);
                    byte[] byteArr = new byte[writeSize];
                    buff.get(byteArr, 0, writeSize);

                    response.getOutputStream().write(byteArr);
                }
                buff.clear();
            }
        } finally {
            buff.clear();
        }
    }
}
