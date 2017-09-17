package com.csx.workflow.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

/**
 * Created by wyp on 2017/3/11.
 * 读取文件工具类
 */
public class ReadFileUtils {

    public static Map<String, String> map = null;

    public static Map<String,String> urlMap = null;

    public static final String url = "url";


    private ReadFileUtils(){

    }

    /**
     * 读取Properties文件
     *
     * @param propertiesName 文件名称
     * @param key            key
     * @return
     */
    public static synchronized String readProperties(String propertiesName, String key) {
       if(urlMap ==null){
           urlMap = new HashMap<>();
           //执行
          ResourceBundle resourceBundle =  ResourceBundle.getBundle(url);
             Set<String> set = resourceBundle.keySet();
           for(String keys : set){
               urlMap.put(keys,resourceBundle.getString(keys));
           }
       }
        return urlMap.get(key);
    }



    /**
     * 读取json文件
     *
     * @param
     * @return
     */
    public static Map<String, String> readJsonData(Class<?> clas) {
        if (map == null) {
            map = new HashMap<>();
            InputStream dataJson = clas.getClassLoader().getResourceAsStream("handlelog.json");
            String json = null;
            try {
                json = IOUtils.toString(dataJson, "utf-8");
            } catch (IOException e) {
                e.printStackTrace();
            }
            JSONArray json1 = JSON.parseArray(json);
            for(int i=0;i<json1.size();i++){
                JSONObject jsonObject = json1.getJSONObject(i);
                map.put(jsonObject.getString("id"),jsonObject.getString("name"));
            }
        }
        return map;
    }


}
