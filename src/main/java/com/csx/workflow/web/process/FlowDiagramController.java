package com.csx.workflow.web.process;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.csx.workflow.utils.UUIDutils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.engine.ActivitiException;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Model;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.PNGTranscoder;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

@RestController
@RequestMapping("/flowDiagram")
public class FlowDiagramController {

	private Logger logger = LoggerFactory.getLogger(FlowDiagramController.class);
	final String MODEL_ID = "modelId";
	final String MODEL_NAME = "name";
	final String MODEL_REVISION = "revision";
	final String MODEL_DESCRIPTION = "description";
	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private RepositoryService repositoryService;

	@RequestMapping(value = "/model/{modelId}/save", method = RequestMethod.PUT)
	@ResponseStatus(value = HttpStatus.OK)
	public void saveModel(@PathVariable String modelId, @RequestBody MultiValueMap<String, String> values) {
		try {
			Model model = repositoryService.getModel(modelId);
			ObjectNode modelJson = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
			modelJson.put(MODEL_NAME, values.getFirst("name"));
			modelJson.put(MODEL_DESCRIPTION, values.getFirst("description"));
			model.setMetaInfo(modelJson.toString());
			model.setName(values.getFirst("name"));
			// 保存版本
			// Integer version = model.getVersion()+1;
			// model.setVersion(version);
			repositoryService.saveModel(model);
			// 处理json_xml的数据格式
			String json_xml = values.getFirst("json_xml");
			logger.debug("变更前保存数据的json传", json_xml);
			repositoryService.addModelEditorSource(model.getId(), json_xml.getBytes("utf-8"));

			InputStream svgStream = new ByteArrayInputStream(values.getFirst("svg_xml").getBytes("utf-8"));
			TranscoderInput input = new TranscoderInput(svgStream);

			PNGTranscoder transcoder = new PNGTranscoder();
			// Setup output
			ByteArrayOutputStream outStream = new ByteArrayOutputStream();
			TranscoderOutput output = new TranscoderOutput(outStream);
			// Do the transformation
			transcoder.transcode(input, output);
			final byte[] result = outStream.toByteArray();
			repositoryService.addModelEditorSourceExtra(model.getId(), result);
			outStream.close();

		} catch (Exception e) {
			logger.error("Error saving model", e);
			throw new ActivitiException("Error saving model", e);
		}
	}

	@RequestMapping(value = "/editor/stencilset", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String getStencilset() {
		InputStream stencilsetStream = this.getClass().getClassLoader().getResourceAsStream("stencilset.json");
		try {
			String json = IOUtils.toString(stencilsetStream, "utf-8");
			// 解析模板字符串
			JSONObject jsonObject = JSON.parseObject(json);
			JSONArray jsonArray = jsonObject.getJSONArray("propertyPackages");
			// 获取流程的整体配置
			JSONObject jsonObject1 = jsonArray.getJSONObject(0);
			jsonObject1.getJSONArray("properties").getJSONObject(0).put("value", "a" + UUIDutils.createUUID());

			return jsonObject.toString();
		} catch (Exception e) {
			throw new ActivitiException("Error while loading stencil set", e);
		}
	}

	@RequestMapping(value = "/model/{modelId}/json", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ObjectNode getEditorJson(@PathVariable String modelId) {
		ObjectNode modelNode = null;

		Model model = repositoryService.getModel(modelId);

		if (model != null) {
			try {
				if (StringUtils.isNotEmpty(model.getMetaInfo())) {
					modelNode = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
				} else {
					modelNode = objectMapper.createObjectNode();
					modelNode.put(MODEL_NAME, model.getName());
				}
				modelNode.put(MODEL_ID, model.getId());
				// 对json格式的戒心
				String jsonNode = new String(repositoryService.getModelEditorSource(model.getId()), "utf-8");
				ObjectNode editorJsonNode = (ObjectNode) objectMapper.readTree(jsonNode);
				modelNode.put("model", editorJsonNode);

			} catch (Exception e) {
				logger.error("Error creating model JSON", e);
				throw new ActivitiException("Error creating model JSON", e);
			}
		}
		return modelNode;
	}

	@RequestMapping(value = "create", method = RequestMethod.POST)
	public void create(@RequestParam("name") String name, @RequestParam("key") String key,
			@RequestParam("systemId") String systemId, @RequestParam("description") String description,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			ObjectNode editorNode = objectMapper.createObjectNode();
			editorNode.put("id", "canvas");
			editorNode.put("resourceId", "canvas");
			ObjectNode stencilSetNode = objectMapper.createObjectNode();
			stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
			editorNode.put("stencilset", stencilSetNode);
			Model modelData = repositoryService.newModel();

			ObjectNode modelObjectNode = objectMapper.createObjectNode();
			modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, name);
			// 开始编辑的
			modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
			description = StringUtils.defaultString(description);
			modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, description);

			modelData.setMetaInfo(modelObjectNode.toString());
			modelData.setName(name);
			modelData.setKey(StringUtils.defaultString(key));
			modelData.setTenantId(systemId);
			modelData.setVersion(0);
			repositoryService.saveModel(modelData);
			repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));

			response.sendRedirect(request.getContextPath() + "/modeler.html?modelId=" + modelData.getId());
		} catch (Exception e) {
			logger.error("创建模型失败", e);
		}
	}
}
