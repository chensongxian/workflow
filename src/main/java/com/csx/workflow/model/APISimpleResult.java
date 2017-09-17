package com.csx.workflow.model;

import java.io.Serializable;

/**
 * API 返回Bean
 *
 * @author shareniu
 */
public class APISimpleResult implements Serializable {


    /**
	 * 
	 */
	private static final long serialVersionUID = 6278501798801287960L;
	protected String message = null;
    protected Integer result;
    protected Object data = null;
    protected String errorMsg;
    protected String errorCode;

    public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
	@Override
	public String toString() {
		return "APISimpleResult [message=" + message + ", result=" + result + ", data=" + data + ", errorMsg="
				+ errorMsg + "]";
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}


}
