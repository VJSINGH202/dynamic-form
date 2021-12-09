package com.adject.dynamicform.model;

import org.springframework.web.multipart.MultipartFile;

public class UploadFileDto {
   private MultipartFile file;
   private String uploadPath;
   
   public UploadFileDto() {
	// TODO Auto-generated constructor stub
}
   
public UploadFileDto(MultipartFile file, String uploadPath) {
	super();
	this.file = file;
	this.uploadPath = uploadPath;
}
public MultipartFile getFile() {
	return file;
}
public void setFile(MultipartFile file) {
	this.file = file;
}
public String getUploadPath() {
	return uploadPath;
}
public void setUploadPath(String uploadPath) {
	this.uploadPath = uploadPath;
}
@Override
public String toString() {
	return "UploadFileDto [file=" + file + ", uploadPath=" + uploadPath + "]";
}
   
   
}
