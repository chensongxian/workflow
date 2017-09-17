package com.csx.workflow.service.impl;

import static com.alibaba.fastjson.JSON.parseObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.csx.workflow.dao.LogDao;
import com.csx.workflow.model.CheckData;
import com.csx.workflow.model.HandlerLog;
import com.csx.workflow.service.LogService;
import com.csx.workflow.utils.InnerActivitiVarConstants;
import com.csx.workflow.utils.InnerBusinessVarConstants;
import com.csx.workflow.utils.ReadFileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;




/**
 * Created by wyp on 2017/4/11.
 */
@Service
public class LogServiceImpl implements LogService {

    @Autowired
    private LogDao logDao;
    @Override
    public List<CheckData> queryHandleLogByProcessInstanceId(String processInstanceId) {
       List<CheckData>  list = logDao.queryHandleLogByProcessInstanceId(processInstanceId);
       if(list!=null && list.size()>0){
           for(CheckData checkData:list){
               String doWhat = checkData.getDoWhat();
              HandlerLog handlerLog =  parseObject(doWhat, HandlerLog.class);
              Map<String,String> handle = ReadFileUtils.readJsonData(LogServiceImpl.class);
               checkData.setDoWhat(handle.get(handlerLog.getType()));
              checkData.setCheckUser(handlerLog.getHandleUser());
              checkData.setDoTime(handlerLog.getHandleTime());
              checkData.setRemark(handlerLog.getRemark());
           }
       }
        return list;
    }



    @Override
    public List<JSONObject> queryCheckLogByProcessInstanceId(String processInstanceId,String type) {
        //850994f8-526d-11e7-a2b8-e8b1fc035b51
        List<String> list = logDao.queryCheckLogByProcessInstanceId(processInstanceId,type);
        List<JSONObject> list1 = new ArrayList<JSONObject>(0);
        if(InnerActivitiVarConstants.HM_ACITVITI_CHECK_ADVICE_INFO.equals(type)){
            for(String s : list){
                JSONObject jsonObject = JSONArray.parseObject(s);
                list1.add(jsonObject);
            }
        }
        if(InnerBusinessVarConstants.FILE_URL_PATH.equals(type)){
            for(String s : list){
                JSONArray jsonArray  =JSONArray.parseArray(s);
                for (int i = 0; i < jsonArray.size(); i++) {
                    list1.add(jsonArray.getJSONObject(i));
                }

            }
        }


        return list1;
    }
}
