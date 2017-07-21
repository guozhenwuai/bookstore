package action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.net.URLDecoder;

import model.Book;
import model.OrderItem;
import service.BookService;

public class HomepageActions extends BaseAction{
	private static final long serialVersionUID = 1L;

	private BookService bookService;
	
	private String category;
	
	private int id;
	
	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}
	
	public BookService getBookService() {
		return bookService;
	}
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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
	
	private void listCategory(List<Book> books){
		int bsize = books.size();
		Map<String,Integer> categories = new HashMap<String,Integer>();
		for(int i=0;i<bsize;++i){
			Book book = books.get(i);
			String name = book.getCategory();
			if(categories.containsKey(name)){
				int val = categories.get(name)+1;
				categories.put(name,val);
			}
			else{
				categories.put(name, 1);
			}
		}
		request().setAttribute("categories", categories);
	}
	
	public String list(){
		List<Book> books = bookService.getAllBooks();
		listCategory(books);
		request().setAttribute("books", books);
		listCart();
		
		return SUCCESS;
	}
	
	public String category() throws UnsupportedEncodingException{
		request().setAttribute("category", category);
		List<Book> books = bookService.getBooksByCategory(category);
		request().setAttribute("books", books);
		listCart();
		
		return SUCCESS;
	}
	
	public String search() throws UnsupportedEncodingException{
		category = URLDecoder.decode(category,"UTF-8");
		System.out.println(category);
		request().setAttribute("category", category);
		List<Book> books = bookService.getBooksByKeyWord(category);
		request().setAttribute("books", books);
		listCart();
		
		return SUCCESS;
	}
}
