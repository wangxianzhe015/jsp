package com.smartcloud.crowdfunding.portal.utils;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.charset.Charset;

import org.apache.commons.io.IOUtils;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;


public class Html2Pdf {

	/**
	 * 生成PDF文件
	 * @param html HTML文件路径或HTML内容
	 * @param file 输出文件路径
	 * @param isFile 是否文件
	 */
    public static void createPdf(String html,String file,boolean isFile) {
        Document document = new Document();
        InputStream is=null;
        try{
	        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(file));
	        document.open();
	   
	        if(isFile){
	        	is=new FileInputStream(html);
	        }else{
	        	is=new ByteArrayInputStream(html.getBytes());
	        }
	        XMLWorkerHelper.getInstance().parseXHtml(writer, document,is, Charset.forName("UTF-8"));
        
        }catch(Exception e){
        	
        }finally{
        	document.close();
        	IOUtils.closeQuietly(is);
        }
    }

     public static  void  main(String [] args){
        Html2Pdf.createPdf("D:\\2.html", "d:\\2.pdf",true);
     }
}
