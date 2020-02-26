/**
 * @author yhj
 * @date 2019-10-29
 */
package com.huatusoft.dcac.common.util;

import com.huatusoft.dcac.common.bo.Setting;
import com.huatusoft.dcac.common.constant.TableOpera;
import com.huatusoft.dcac.common.exception.DisunionKeyException;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class DataSourceUtils {

    private static final String mysqlCmdInto[] = new String[]{"mysql -h "," -P "," -u"," -p"," --default-character-set=utf8 "};//mysql导入sql文件命令

    private static final String mysqlCmdOut[] = new String[]{"mysqldump -h "," -P "," -u"," -p"," "};//mysql导出sql文件命令

    private static final String fileStartString = "-- MySQL dump";//解密后的sql文件的首行开头的字符串

    public static final String backup_key = "a_dzbq_backup_key";

    /**
     * 执行sql文件
     * @param
     * @throws Exception
     */
    public static void dbRecover(String filePath,String authKey) throws Exception {
        Map<String, String> dbPorperties = getDbPorperties();
        String dbHost = dbPorperties.get("dHost");
        String dbPort = dbPorperties.get("dPort");
        String dbUser = dbPorperties.get("dUser");
        String dbPass = Rc4Utils.decode(dbPorperties.get("dPwd"));
        String dbSchema = dbPorperties.get("dSchema");
        // 获取操作数据库的相关属性
        Runtime runtime = Runtime.getRuntime();
        String intoCmd = "{0}" + dbHost + "{1}" + dbPort + "{2}" + dbUser +  "{3}" + dbPass + "{4}" + dbSchema;
        String format = MessageFormat.format(intoCmd, mysqlCmdInto);
        System.out.println("还原数据库："+format);
        Process process = runtime.exec(format);
        OutputStream outputStream = process.getOutputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath),"utf-8"));
        String str = null;
        StringBuffer sb = new StringBuffer();
        while ((str = br.readLine()) != null) {
            sb.append(str + "\r\n");
        }
        str = sb.toString();
        boolean uniteKey = uniteKey(str, authKey);
        if (!uniteKey) {
            throw new DisunionKeyException("DisunionKey");
        }
        String decode = Rc4Utils.decode(str, authKey);
        String badsql="CONSTRAINT `FK6DC153503A3ED029` FOREIGN KEY (`last_user`) REFERENCES `ht_electronictag_user` (`id`)\r\n" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
        String  decodes=decode.replace(badsql, "");
        OutputStreamWriter writer = new OutputStreamWriter(outputStream,"utf-8");
        writer.write(decodes);
        writer.flush();
        outputStream.close();
        br.close();
        writer.close();
    }

    /***
     * 读取数据库源信息
     * @return
     */
    public  static Map<String,String> getDbPorperties (){
        Map<String,String> map = new HashMap<String,String>();
        String dUrl = System.getProperty("jdbc.dzbq.url");
        String dHost = dUrl.split("/")[2].split(":")[0];
        String dPort = dUrl.split("/")[2].split(":")[1];
        String dSchema = dUrl.substring(dUrl.lastIndexOf("/")+1,dUrl.indexOf("?"));
        String dUser = System.getProperty("jdbc.dzbq.username");
        String dPwd = System.getProperty("jdbc.dzbq.password");
        map.put("dHost",dHost);
        map.put("dPort",dPort);
        map.put("dSchema",dSchema);
        map.put("dUser",dUser);
        map.put("dPwd",dPwd);
        return map;
    }


    /**
     * 备份数据库
     *
     * @throws Exception
     */
    public static String dbBackup(HttpServletRequest request, String authKey) throws Exception {

        //获取数据源数据
        Map<String, String> dbPorperties = getDbPorperties();
        String dbHost = dbPorperties.get("dHost");
        String dbPort = dbPorperties.get("dPort");
        String dbUser = dbPorperties.get("dUser");
        String dbPass = Rc4Utils.decode(dbPorperties.get("dPwd"));
        String dbSchema = dbPorperties.get("dSchema");
        Runtime runtime = Runtime.getRuntime();
        // -u后面是用户名，-p是密码-p后面最好不要有空格，-family是数据库的名字

        String ml = "{0}" + dbHost + "{1}" + dbPort + "{2}" + dbUser + "{3}" + dbPass + "{4}" + dbSchema;
        // mysqldump -h 127.0.0.1 -P3306 -uroot -proot a_dzbq
        //mysqldump -h127.0.0.1 -uroot -proot a_dzbq > /opt/a_dzbq.sql
        String format = MessageFormat.format(ml, mysqlCmdOut);
        System.out.println("备份数据库："+format);
        Process process = runtime.exec(format);
        InputStream inputStream = process.getInputStream();// 得到输入流，写成.sql文件
        InputStreamReader reader = new InputStreamReader(inputStream,"utf-8");
        BufferedReader br = new BufferedReader(reader);
        String s = null;
        StringBuffer sb = new StringBuffer();
        boolean append = true;
        while ((s = br.readLine()) != null) {
            String[] copyTable = TableOpera.COPY_TABLE;
            for (int i = 0; i <copyTable.length ; i++) {
                if (s.contains(copyTable[i])) {
                    append = true;
                }
            }
            String[] ignoreTable1 = TableOpera.IGNORE_TABLE;
            for (int i = 0; i <ignoreTable1.length ; i++) {
                if (s.contains(ignoreTable1[i])){
                    if (s.startsWith("DROP TABLE")){
                        append = true;
                    }else if (s.startsWith("LOCK")||s.startsWith("INSERT")){
                        append = false;
                    }
                }
            }
            if (append) {
                sb.append(s + "\r\n");
            }
        }
        sb.append(TableOpera.UPDATE_USER + "\r\n");
        s = sb.toString();
        String encodeString = Rc4Utils.encode(s, authKey);
        Setting setting = SettingUtils.get();
        String fileUploadPath = setting.getFileUploadPath();
        Map<String, Object> model = new HashMap<String, Object>();
        model.put("uuid", UUID.randomUUID().toString());
        String path = FreemarkerUtils.process(fileUploadPath, model);
        String filePath= request.getSession().getServletContext().getRealPath("/") + path+"a_dzbq.sql";
        File file = new File(filePath);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        fileOutputStream.write(encodeString.getBytes());
        fileOutputStream.close();
        br.close();
        reader.close();
        inputStream.close();
        return filePath;
    }


    /***
     * 判断的当前文件加密的密钥是否和系统自身密钥相同
     * @param fileString
     * @param authKey
     * @return
     */
    private static boolean  uniteKey (String fileString ,String authKey){

        String decode = Rc4Utils.decode(fileString, authKey);
        if(decode.startsWith(fileStartString)){
            return true;
        } else {
            return false;
        }
    }
}
