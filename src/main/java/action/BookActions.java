package action;

import java.io.File;
import java.util.List;
import org.aspectj.util.FileUtil;

import com.opensymphony.xwork2.ModelDriven;

import model.Book;
import net.sf.json.JSONObject;
import service.BookService;


public class BookActions extends BaseAction implements ModelDriven<Book> {
	private static final long serialVersionUID = 1L;

	private BookService bookService;
	
	private File upload;
	private String uploadContentType;
	private String uploadFileName;
	
	private String result;
	
	private Book bookBean = new Book();
	
	public Book getModel(){
		return bookBean;
	}
	
	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}
	
	public BookService getBookService() {
		return bookService;
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

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String list() throws Exception {
		List<Book> books = bookService.getAllBooks();
		request().setAttribute("books", books);

		return "list";
	}
	
	public String add() throws Exception {
		int id = bookService.addBook(bookBean);
		if(uploadFileName!=null){
			bookService.saveCover(id,FileUtil.readAsByteArray(upload));
		}
		
		return SUCCESS;
	}
	
	public String update() throws Exception {
		bookService.updateBook(bookBean);
		if(uploadFileName!=null){
			bookService.saveCover(bookBean.getId(), FileUtil.readAsByteArray(upload));
		}
		
		return SUCCESS;
	}
	
	public String delete() throws Exception {
		bookService.deleteBook(bookBean);
		bookService.deleteCover(bookBean.getId());
		
		return SUCCESS;
	}
	
	public String detail() throws Exception{
		bookBean = bookService.getBookById(bookBean.getId());
		JSONObject json=JSONObject.fromObject(bookBean);
		result=json.toString();
		
		return SUCCESS;
	}

}
