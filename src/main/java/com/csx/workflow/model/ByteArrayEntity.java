package com.csx.workflow.model;

import java.io.Serializable;
import java.util.Arrays;

public class ByteArrayEntity  implements Serializable{
	  /**
	 * 
	 */
	private static final long serialVersionUID = 5341755021907676198L;
	protected String id;
	protected String tempId;
	  protected int revision;
	  protected String name;
	  protected byte[] bytes;
	  protected String deploymentId;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getRevision() {
		return revision;
	}
	public void setRevision(int revision) {
		this.revision = revision;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public byte[] getBytes() {
		return bytes;
	}
	public void setBytes(byte[] bytes) {
		this.bytes = bytes;
	}
	public String getDeploymentId() {
		return deploymentId;
	}
	public void setDeploymentId(String deploymentId) {
		this.deploymentId = deploymentId;
	}
	@Override
	public String toString() {
		return "ByteArrayEntity [id=" + id + ", revision=" + revision
				+ ", name=" + name + ", bytes=" + Arrays.toString(bytes)
				+ ", deploymentId=" + deploymentId + "]";
	}
	public String getTempId() {
		return tempId;
	}
	public void setTempId(String tempId) {
		this.tempId = tempId;
	}
	  
}
