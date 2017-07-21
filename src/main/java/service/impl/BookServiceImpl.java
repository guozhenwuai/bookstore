package service.impl;

import java.util.List;

import dao.BookDao;
import model.Book;
import service.BookService;

public class BookServiceImpl implements BookService {
	private BookDao bookDao;
	
	public void setBookDao(BookDao bookDao) {
		this.bookDao = bookDao;
	}
	
	public Integer addBook(Book book) {
		return bookDao.save(book);
	}

	public void deleteBook(Book book) {
		bookDao.delete(book);
	}

	public void updateBook(Book book) {
		bookDao.update(book);
	}

	public Book getBookById(int id) {
		return bookDao.getBookById(id);
	}

	public List<Book> getAllBooks() {
		return bookDao.getAllBooks();
	}
	
	public List<Book> getBooksByCategory(String category) {
		return bookDao.getBooksByCategory(category);
	}
	
	public byte[] getCover(int id){
		return bookDao.getCover(id);
	}
	
	public void saveCover(int id,byte[] cover){
		bookDao.saveCover(id, cover);
	}	
	
	public void deleteCover(int id){
		bookDao.deleteCover(id);
	}
	
	public List<Book> getBooksByKeyWord(String key){
		return bookDao.getBooksByKeyWord(key);
	}
}
