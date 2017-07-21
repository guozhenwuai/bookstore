package action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.opensymphony.xwork2.ModelDriven;

import model.Book;
import model.Order;
import model.OrderItem;
import model.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import service.BookService;
import service.OrderService;
import service.UserService;


public class OrderActions extends BaseAction implements ModelDriven<Order> {
	private static final long serialVersionUID = 1L;

	private OrderService orderService;
	
	private UserService userService;
	
	private BookService bookService;
	
	private Order orderBean = new Order();
	
	public Order getModel(){
		return orderBean;
	}
	
	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	
	public OrderService getOrderService() {
		return orderService;
	}
	
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	
	public UserService getUserService(){
		return userService;
	}

	
	public BookService getBookService() {
		return bookService;
	}

	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}

	public String list() throws Exception {
		List<Order> orders = orderService.getAllOrders();
		List<User> users = userService.getAllUsers();
		List<Book> books = bookService.getAllBooks();
		request().setAttribute("books", books);
		request().setAttribute("orders", orders);
		request().setAttribute("users", users);

		return "list";
	}
	
	public String userSpecOrder(){
		System.out.println("userid:"+orderBean.getId());
		List<Order> orders = orderService.getOrdersByUser(orderBean.getId());
		request().setAttribute("orders", orders);
		
		return "history";
	}
	
	public String add() throws Exception {
		orderService.addOrder(orderBean);
		
		return SUCCESS;
	}
	
	public String update() throws Exception {
		orderService.updateOrder(orderBean);
		
		return SUCCESS;
	}
	
	public String delete() throws Exception {
		orderService.deleteOrder(orderBean);
		
		return SUCCESS;
	}
	
	
}
