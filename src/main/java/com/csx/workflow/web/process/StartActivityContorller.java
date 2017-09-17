package com.csx.workflow.web.process;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.csx.workflow.model.Page;
import com.csx.workflow.model.ProcessDefEntity;
import com.csx.workflow.model.SimpleResult;
import com.csx.workflow.service.ProcessDefinitionService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;


/**
 * 启动流程
 */
@Controller
@RequestMapping("startActivity")
public class StartActivityContorller {

    private static final transient Logger log = LoggerFactory.getLogger(StartActivityContorller.class);



    @Autowired
    private ProcessDefinitionService processDefinitionService;

    @Autowired
    private HistoryService historyService;
    @Autowired
    private RuntimeService runtimeService;


    /**
     * 前往流程key
     *
     * @param processKey
     * @return
     */
    @RequestMapping("qotoStartForm")
    public String qotoStartForm(String processKey, Model model) {
        model.addAttribute("processKey", processKey);
        return "jsp/startForm";
    }
    
    
    @SuppressWarnings("finally")
	@RequestMapping(value = "startProcess", method = RequestMethod.POST)
    @ResponseBody
    public SimpleResult startProcess(String key, String formData, HttpServletRequest request) {
        //UserInfo userInfo = (UserInfo) request.getSession().getAttribute(Constants.userInfo);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("startUserId", "xx");
        JSONObject formDataH = new JSONObject();
     
        //业务数据
        JSONArray jsonArray = JSON.parseArray(formData);
        if (jsonArray.size() > 0) {
            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject jsonObject1 = jsonArray.getJSONObject(i);
                String name1 = jsonObject1.getString("name");
                Object value1 = jsonObject1.get("value");
                formDataH.put(name1, value1);
            }
        }
        map.put("fomrData_test", formDataH.toJSONString());
        //启动成功
        SimpleResult simpleResult = new SimpleResult();
        try {
        	runtimeService.startProcessInstanceByKeyAndTenantId(key,map,"1");
            simpleResult.setSuccess(true);
            simpleResult.setMessage("发起成功");
        } catch (Exception e) {
            log.error("startProcess", e);
        } finally {
            return simpleResult;
        }
    }

    /**
     * 可以启动的所有流程
     *
     * @param page
     * @param pageSize
     * @param request
     * @return
     */
    @RequestMapping(value = "startActivityPage", produces = "application/json", method = RequestMethod.POST)
    @ResponseBody
    public Page startActivityPage(ProcessDefEntity processDefEntity, Integer page, Integer pageSize, HttpServletRequest request) {
        Page pageJson = new Page();
        PageInfo<ProcessDefEntity> pageInfo = processDefinitionService.queryPageAllProcess(processDefEntity, page, pageSize);
        pageJson.setTotal(pageInfo.getTotal());
        pageJson.setRows(pageInfo.getList());
        pageJson.setPage(pageInfo.getPrePage());
        pageJson.setTotalPage(pageInfo.getPages());
        log.info("startActivityPage {}", pageJson);
        return pageJson;
    }


   

}
