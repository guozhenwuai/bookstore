package action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;

import org.aspectj.util.FileUtil;

import service.BookService;
import service.UserService;

public class AvatarAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	
	private int id;
	
	private UserService userService;
	
	private File upload;
	private String uploadContentType;
	private String uploadFileName;
	
	private ByteArrayInputStream inputStream;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}
	
	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	
	public String show(){
		byte[] img = userService.getAvatar(id);
		inputStream = new ByteArrayInputStream(img);
		return SUCCESS;
	}
	
	public String save() throws IOException{
		if(uploadFileName!=null){
			userService.saveAvatar(id,FileUtil.readAsByteArray(upload));
		}
		return SUCCESS;
	}

}
