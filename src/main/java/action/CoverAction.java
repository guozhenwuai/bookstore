package action;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;

import service.BookService;

public class CoverAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	
	private int id;
	
	private BookService bookService;
	
	private ByteArrayInputStream inputStream;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public BookService getBookService() {
		return bookService;
	}
	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}
	
	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}
	
	public String show(){
		byte[] img = bookService.getCover(id);
		inputStream = new ByteArrayInputStream(img);
		return SUCCESS;
	}

}
