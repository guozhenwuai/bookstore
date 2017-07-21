package action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ModelDriven;

import model.Book;
import model.OrderItem;
import model.User;
import service.BookService;
import service.UserService;

public class UserProfileAction extends BaseAction implements ModelDriven<User>{
	private static final long serialVersionUID = 1L;

	private UserService userService;
	
	private BookService bookService;
	
	private User userBean = new User();
	
	private String newpwd;
	
	private String result;
	
	public UserService getUserService() {
		return userService;
	}
	
	public User getModel(){
		return userBean;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}
	
	public BookService getBookService() {
		return bookService;
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getNewpwd() {
		return newpwd;
	}

	public void setNewpwd(String newpwd) {
		this.newpwd = newpwd;
	}

	private void listCart(){
		Map<Integer,Integer> cart = (HashMap<Integer,Integer>) session().getAttribute("cart");
		List<OrderItem> cartItem = new ArrayList<OrderItem>();
		if(cart!=null){
			Iterator iter = cart.entrySet().iterator();
	        while (iter.hasNext()) {
	            Map.Entry<Integer,Integer> entry = (Map.Entry<Integer,Integer>) iter.next();
	            OrderItem item = new OrderItem();
	            int id = (Integer)entry.getKey();
	            item.setBookId(id);
	            item.setNum((Integer) entry.getValue());
	            System.out.println(id+":"+entry.getValue());
	            item.setBook(bookService.getBookById(id));
	            cartItem.add(item);
	        }
		}
		request().setAttribute("cartItems", cartItem);
	}
	
	public String list(){
		listCart();
		int id = (Integer)session().getAttribute("id");
		User user = userService.getUserById(id);
		request().setAttribute("user", user);
		
		return SUCCESS;
	}
	
	public String save(){
		userService.updateUserProfile(userBean);
		
		return SUCCESS;
	}
	
	public String resetPassword(){
		if(userService.updatePassword(userBean, newpwd)){
			result="true";
		}
		else result="false";
		
		return "resetPassword";
	}
	
}
