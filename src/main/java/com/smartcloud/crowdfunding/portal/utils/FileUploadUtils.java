package com.smartcloud.crowdfunding.portal.utils;

import java.io.File;
import java.io.FileOutputStream;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

import com.smartcloud.crowdfunding.portal.dict.SystemConfigurationFactory;
import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.common.utils.StringUtils;
import com.smartcloud.platform.component.mvc.framework.Framework;

public class FileUploadUtils {


	private static final String UPLOAD_DIR="/upload";
	
	/**
	 * 将保存文件到应用指定路径下，并且返回保存后的文件名
	 * @param data 文件字节数组
	 * @param filename 源文件名
	 * @return
	 */
	
	public static String saveFileToUploadDirectory(byte[] data,String filename){

		String fileuploadRootPath=PropertyResourceConfigurer.getInstance().getProperty(SystemConfigurationFactory.KEY_FILEUPLOAD_ROOT_PATH);
		String accessPrefix=PropertyResourceConfigurer.getInstance().getProperty(SystemConfigurationFactory.KEY_FILE_ACCESS_PREFIX);
		
		if(StringUtils.isNullOrBlank(fileuploadRootPath)){
			fileuploadRootPath=Framework.getInstance().getAppConfiguration().getWarRealPath();
		}
		String extName=StringUtils.substringAfterLast(filename, ".");
		FileOutputStream fos=null;
		try{
			//生成当前日期的文件夹
			String fileDirPath=DateUtils.getCurrentDate().replace("-","/");
			String relativeDirPath=new StringBuilder(UPLOAD_DIR).append("/").append(fileDirPath).toString();
			String targetDirPath=new StringBuilder(fileuploadRootPath).append(relativeDirPath).toString();
			
			File targetDir=new File(targetDirPath);
			if(!targetDir.exists()){
				FileUtils.forceMkdir(targetDir);
				targetDir=new File(targetDirPath);
			}
			
			File f=new File(targetDir,String.valueOf(System.currentTimeMillis())+"."+extName);

			fos=new FileOutputStream(f);
			IOUtils.write(data, fos);
			
			String imageUrl="";
			if(StringUtils.isNotNullAndBlank(accessPrefix)){
				imageUrl=new StringBuilder(accessPrefix).append(relativeDirPath).append("/").append(f.getName()).toString();
			}else{
				imageUrl=new StringBuilder("/").append(Framework.getInstance().getAppConfiguration().getWebContextPath()).
						append(relativeDirPath).append("/").append(f.getName()).toString();
			}

			return imageUrl;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
		finally{
			IOUtils.closeQuietly(fos);
		}
		
	}
	
}
