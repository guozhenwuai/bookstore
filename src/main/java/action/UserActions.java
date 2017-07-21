package action;

import java.io.ByteArrayInputStream;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import model.User;
import service.UserService;


public class UserActions extends BaseAction implements ModelDriven<User> {
	private static final long serialVersionUID = 1L;

	private UserService userService;
	
	private User userBean = new User();
	
	private ByteArrayInputStream inputStream;
	
	public User getModel(){
		return userBean;
	}
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public UserService getUserService() {
		return userService;
	}
	
	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String list() throws Exception {
		List<User> users = userService.getAllUsers();
		request().setAttribute("users", users);

		return "list";
	}
	
	public String add() throws Exception {
		userService.addUser(userBean);
		
		return SUCCESS;
	}
	
	public String update() throws Exception {
		userService.updateUser(userBean);
		
		return SUCCESS;
	}
	
	public String delete() throws Exception {
		userService.deleteUser(userBean);
		
		return SUCCESS;
	}
	
	public String nameAvail() throws Exception {
		String res = "false";
		if(userService.nameAvail(userBean.getUsername())){
			res = "true";
		}
		inputStream = new ByteArrayInputStream(res.getBytes());
		return SUCCESS;
	}
	
	public String login() throws Exception {
		User res = userService.login(userBean);
		if(res==null){
			request().setAttribute("Message",1);
			return "login";
		}
		session().setAttribute("user",userBean.getUsername());
		session().setAttribute("id", res.getId());
		if(res.isAdmin()){
			session().setAttribute("admin",1);
			return "admin";
		}
		else{
			return "user";
		}
	}
	
	public String register() throws Exception {
		int id = userService.addUser(userBean);
		session().setAttribute("user",userBean.getUsername());
		session().setAttribute("id", id);
		return "user";
	}
	
	public String logout() throws Exception {
		session().removeAttribute("user");
		session().removeAttribute("id");
		session().removeAttribute("admin");
		return "login";
	}
}
