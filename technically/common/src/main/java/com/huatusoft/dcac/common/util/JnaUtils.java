package com.huatusoft.dcac.common.util;

import com.huatusoft.dcac.common.constant.SystemConstants;
import com.sun.jna.Library;
import com.sun.jna.Native;

/**
 * @author WangShun
 */
public class JnaUtils {

    public interface ElectronicTagLibrary extends Library {

        ElectronicTagLibrary electronicTagLibrary = Native.loadLibrary(SystemConstants.JNA_LIBRARY_NAME,ElectronicTagLibrary.class);

        /**
         * 标签分离
         * @param src_filepath 分离原路径
         * @param des_filepath 分离目标路径
         * @param unitCode 单位编码
         * @return
         */
        int RemoveFileLabelAttrS(String src_filepath, String des_filepath, String unitCode);

        /**
         * 判断是否是标签文件
         * @param szFilePath 文件路径
         * @return
         */
        int IsLabelFile(String szFilePath);
    }

}
