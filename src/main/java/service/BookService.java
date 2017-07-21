package service;

import java.util.List;

import model.Book;

public interface BookService {
	
	public Integer addBook(Book book);

	public void deleteBook(Book book);

	public void updateBook(Book book);

	public Book getBookById(int id);

	public List<Book> getAllBooks();
	
	public List<Book> getBooksByCategory(String category);
	
	public byte[] getCover(int id);
	
	public void saveCover(int id,byte[] cover);
	
	public void deleteCover(int id);
	
	public List<Book> getBooksByKeyWord(String key);
}
