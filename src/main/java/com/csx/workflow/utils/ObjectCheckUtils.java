package com.csx.workflow.utils;

import java.util.List;

/**
 * Created by wyp on 2017/4/20.
 * 对象有效校验
 */
public class ObjectCheckUtils {

    public static boolean isEmptyString(String s1){
        if(s1 ==null || "".equals(s1.trim())){
            return true;
        }
        return false;
    }
    public static boolean isEmptyCollection(List list){
        if(list !=null && list.size()>0){
            return false;
        }
        return true;
    }
}
