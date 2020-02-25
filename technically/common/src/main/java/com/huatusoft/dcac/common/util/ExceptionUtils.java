/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.common.util;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ExceptionUtils {

    private ExceptionUtils() {
    }
    /**
     * 返回异常堆栈字符串
     * @param e
     * @return
     */
    public static String getExceptionContent(Exception e){
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        e.printStackTrace(new PrintStream(baos));
        String content = baos.toString();
        return content;
    }
    /**
     * 通过message获取异常堆栈信息
     * @param e
     * @return
     */
    public static String getMessageContent(Exception e) {
        String content = e.getMessage();
        return matcherMessage(content);
    }
    /**
     * 获取出现CauseBy异常字符串 如果没有 则返回异常堆栈信息
     * @param e
     * @return
     */
    public static String getCauseByContent(Exception e) {
        String content = getExceptionContent(e);
        return matcherMessage(content);

    }
    private static String matcherMessage(String content){
        String regEx = "Caused by:(.*)";
        Pattern pat = Pattern.compile(regEx);
        Matcher mat = pat.matcher(content);
        boolean rs = mat.find();
        if (rs) {
            return mat.group(1);
        }else{
            return content;
        }
    }
    public static void main(String[] args) {
        try {
            throw new NullPointerException();
        } catch (Exception e) {
            System.out.println(getCauseByContent(e));
        }

    }
}
