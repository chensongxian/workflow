package com.csx.workflow.dao;



import com.csx.workflow.model.ProcessModel;

import java.util.List;

/**
 * 流程模型查詢
 */
public interface ProcessModelDao {

    List<ProcessModel>  query(ProcessModel processModel);

	ProcessModel selectOneById(String id);
	int insertBySelect(ProcessModel processModel);
}
