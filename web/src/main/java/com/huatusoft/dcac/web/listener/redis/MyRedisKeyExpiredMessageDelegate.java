//package com.huatusoft.dcac.web.listener.redis;
//
//import com.ht.base.util.HttpUtil;
//import com.huatusoft.dcac.common.constant.SystemConstants;
//import com.huatusoft.dcac.common.util.JsonUtils;
//import com.huatusoft.dcac.common.util.SpringContextUtils;
//import org.apache.shiro.SecurityUtils;
//import org.springframework.data.redis.connection.Message;
//import org.springframework.data.redis.connection.MessageListener;
//import org.springframework.data.redis.core.RedisTemplate;
//
//import java.util.HashMap;
//import java.util.Map;
//import java.util.concurrent.TimeUnit;
//
///**
// * @author yhj
// * @date 2020-5-7
// * redis数据失效监听
// */
//public class MyRedisKeyExpiredMessageDelegate implements MessageListener {
//
//    @Override
//    public void onMessage(Message message, byte[] bytes) {
//        System.out.println("失效key:"+new String(message.getBody()));
//        String userNo = new String(message.getBody()).substring(5);
//        Map<String,String> paramMap = new HashMap<String, String>(1);
//        paramMap.put("userNo",userNo);
//        String result = HttpUtil.signPost("http://172.16.23.148:7073/api/token/getTokenByUserNo", SystemConstants.APP_ID, SystemConstants.PRODUCT_KEY, String.valueOf(System.currentTimeMillis()), paramMap);
//        String code = JsonUtils.getJsonString(result, "code");
//        if ("1".equals(code)) {
//            String data = JsonUtils.getJsonString(result, "data");
//            RedisTemplate redisTemplate = SpringContextUtils.getBean(RedisTemplate.class);
//            redisTemplate.opsForValue().set("data_" + userNo, data);
//            redisTemplate.expire("data_" + userNo, 28, TimeUnit.MINUTES);
//        } else {
//            System.out.println(userNo + "登陆信息过期!");
//            SecurityUtils.getSubject().logout();
//        }
//    }
//}
