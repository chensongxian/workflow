package com.csx.workflow.web.process;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.csx.workflow.model.Page;
import com.csx.workflow.model.ProcessType;
import com.csx.workflow.service.ProcessTypeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by wyp on 2017/4/18.
 */
@Controller
@RequestMapping("processType")
public class ProcessTypeController {

    private final static Logger logger = LoggerFactory.getLogger(ProcessTypeController.class);

    @Autowired
    private ProcessTypeService processTypeService;

    @RequestMapping(value = "queryList",method = RequestMethod.POST)
    @ResponseBody
    public Page queryList(ProcessType processType, HttpServletRequest request) {
        processType.setState(0);
        Page page = new Page();
        page.setRows(processTypeService.queryList(processType));
        logger.info("queryList {}",page);
        return page;
    }

    /**
     * 查询所有的职位类别
     * @return
     */
    @RequestMapping(value = "query",method = RequestMethod.POST)
    @ResponseBody
    public List<ProcessType> query() {
        ProcessType processType = new ProcessType();
        processType.setState(0);
        List<ProcessType> list  = processTypeService.queryList(processType);
        logger.info("query {}",list);
        return list;
    }


}
