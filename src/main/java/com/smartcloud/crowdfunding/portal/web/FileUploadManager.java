package com.smartcloud.crowdfunding.portal.web;

import com.smartcloud.crowdfunding.portal.utils.FileUploadUtils;
import com.smartcloud.platform.component.common.i18n.ResourceMessages;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.context.FileUploaded;
import com.smartcloud.platform.component.mvc.framework.WebAction;

@URI(description="文件上传管理",path="/portal/fileupload/*",portal=true)
public class FileUploadManager extends WebAction{

	
	private int code;
	
	private String message;
	/**
	 * 文件上传，返回文件存储路径
	 * @return
	 */
	@Action(description = "文件上传", responses = { @Response(name = SUCCESS, json=@JSON(contentType="text/html;charset=UTF-8")) })
	public String ajaxupload(String field){
		FileUploaded upload=request.getFileUploadedMap().get(field);
		if(upload!=null){
			String url=FileUploadUtils.saveFileToUploadDirectory(upload.getContent(), upload.getFilename());
			response.addToRequest("url2", url);
			this.code=1;
			this.message=ResourceMessages.getI18nMessage("FileUploadManager_upload_success");
		}else{
			this.code=-1;
			this.message=ResourceMessages.getI18nMessage("FileUploadManager_upload_failure");
			
		}
		return SUCCESS;
	}
	
	public int getCode() {
		return code;
	}
	
	public String getMessage() {
		return message;
	}
	

	
}
