package dao.impl;

import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Updates.set;

import java.util.List;
import model.Book;

import org.bson.Document;
import org.bson.types.Binary;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import util.MongoUtil;
import dao.BookDao;

public class BookDaoImpl extends HibernateDaoSupport implements BookDao {

	public Integer save(Book book) {
		return (Integer) getHibernateTemplate().save(book);
	}

	public void delete(Book book) {
		getHibernateTemplate().delete(book);
	}

	public void update(Book book) {
		getHibernateTemplate().merge(book);
	}

	public Book getBookById(int id) {
		@SuppressWarnings("unchecked")
		List<Book> books = (List<Book>) getHibernateTemplate().find(
				"from Book as b where b.id=?", id);
		Book book = books.size() > 0 ? books.get(0) : null;
		return book;
	}

	public List<Book> getAllBooks() {
		@SuppressWarnings("unchecked")
		List<Book> books = (List<Book>) getHibernateTemplate()
				.find("from Book");
		return books;
	}
	
	public List<Book> getBooksByCategory(String category) {
		@SuppressWarnings("unchecked")
		List<Book> books = (List<Book>) getHibernateTemplate()
				.find("from Book as b where b.category=?",category);
		return books;
	}
	
	public List<Book> getBooksByKeyWord(String key){
		String hql= "from Book as b where b.name like ? or b.author like ?";
		String pattern = "%"+key+"%";
		@SuppressWarnings("unchecked")
		List<Book> books = (List<Book>) getHibernateTemplate()
				.find(hql,pattern,pattern);
		return books;
	}
	
	public byte[] getCover(int id){
		MongoDatabase db = MongoUtil.getDB();
        MongoCollection<Document> collection = db.getCollection("bookcover");
        Document doc = collection.find(eq("bookid", id)).first();
        if (doc == null || doc.get("cover") == null) {
            return null;
        } else {
            Binary binary = (Binary) doc.get("cover");
            return binary.getData();
        }
	}
	
	public void saveCover(int id,byte[] cover){
		if (cover == null) {
            return;
        }

        Binary img = new Binary(cover);

        MongoCollection<Document> collection = MongoUtil.getDB().getCollection("bookcover");
        Document doc = collection.find(eq("bookid", id)).first();
        if (doc == null) {
            doc = new Document();
            doc.append("bookid", id).append("cover", img);
            collection.insertOne(doc);
        } else {
            collection.updateOne(eq("bookid", id), set("cover", img));
        }
	}
	
	public void deleteCover(int id){
		MongoDatabase db = MongoUtil.getDB();
        MongoCollection<Document> collection = db.getCollection("bookcover");
		collection.deleteOne(eq("bookid",id));
	}

}
