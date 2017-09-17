package com.csx.workflow.utils;

import java.util.UUID;

/**
 * Created by Administrator on 2016/12/6.
 */
public class UUIDutils
{
    public static String createUUID(){
       return UUID.randomUUID().toString();
    }
    public static void main(String args[]){
        System.out.print(createUUID());
    }

}
