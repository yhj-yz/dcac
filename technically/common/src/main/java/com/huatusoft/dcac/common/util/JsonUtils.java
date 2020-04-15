/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.common.util;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.util.Assert;

import java.io.IOException;
import java.io.Writer;
import java.lang.reflect.Field;

public final class JsonUtils {

    /** ObjectMapper */
    private static ObjectMapper mapper = new ObjectMapper();

    private static Gson gson = new GsonBuilder()
//			.setPrettyPrinting()//格式化
            .disableHtmlEscaping()//不转译网页相关的特殊字符
            .create();
    /**
     * 不可实例化
     */
    private JsonUtils() {
    }

    /**
     * 将对象转换为JSON字符串
     *
     * @param value
     *            对象
     * @return JSOn字符串
     */
    public static String toJson(Object value) {
        try {
            return mapper.writeValueAsString(value);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    /**
     * 将对象转换为JSON字符串
     *
     * @param value
     *            对象
     * @return JSOn字符串
     */
    public static String toJsonByGson(Object value) {
        try {
            return gson.toJson(value);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将JSON字符串转换为对象
     *
     * @param json
     *            JSON字符串
     * @param valueType
     *            对象类型
     * @return 对象
     */
    public static <T> T toObject(String json, Class<T> valueType) {
        Assert.hasText(json);
        Assert.notNull(valueType);
        try {
            return mapper.readValue(json, valueType);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    /**
     * 将JSON字符串转换为对象
     *
     * @param json
     *            JSON字符串
     * @param valueType
     *            对象类型
     * @return 对象
     */
    public static <T> T toObjectByGson(String json, Class<T> valueType) {
        Assert.hasText(json);
        Assert.notNull(valueType);
        try {

            return gson.fromJson(json, valueType);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static <T> T toObjectByGson(String json, Class<T> valueType,boolean isSupper,String... decodeAttribute) {
        Assert.hasText(json);
        Assert.notNull(valueType);
        try {
            T obj = gson.fromJson(json, valueType);
            if (decodeAttribute == null || decodeAttribute.length == 0) {
                return obj;
            }
            for (int i = 0; i < decodeAttribute.length; i++) {
                Field f = null;
                if (isSupper) {
                    f = obj.getClass().getSuperclass().getDeclaredField(decodeAttribute[i]);
                }else {
                    f = obj.getClass().getDeclaredField(decodeAttribute[i]);
                }
                f.setAccessible(true);
                Object fVal = f.get(obj);
                String decodeVal = Rc4Utils.decode(fVal.toString());
                f.set(obj, decodeVal);
            }
            return obj;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    /**
     * 将JSON字符串转换为对象
     *
     * @param json
     *            JSON字符串
     * @param typeReference
     *            对象类型
     * @return 对象
     */
    public static <T> T toObject(String json, TypeReference<?> typeReference) {
        Assert.hasText(json);
        Assert.notNull(typeReference);
        try {
            return mapper.readValue(json, typeReference);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将JSON字符串转换为对象
     *
     * @param json
     *            JSON字符串
     * @param javaType
     *            对象类型
     * @return 对象
     */
    public static <T> T toObject(String json, JavaType javaType) {
        Assert.hasText(json);
        Assert.notNull(javaType);
        try {
            return mapper.readValue(json, javaType);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将对象转换为JSON流
     *
     * @param writer
     *            writer
     * @param value
     *            对象
     */
    public static void writeValue(Writer writer, Object value) {
        try {
            mapper.writeValue(writer, value);
        } catch (JsonGenerationException e) {
            e.printStackTrace();
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getJsonString(String jsonString,String field){
        JSONObject jsonObject = JSONObject.parseObject(jsonString);
        return jsonObject.getString(field);
    }

}