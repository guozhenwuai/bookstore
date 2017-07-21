package dao.impl;

import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Updates.set;

import java.util.List;

import model.User;
import util.MongoUtil;

import org.bson.Document;
import org.bson.types.Binary;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import dao.UserDao;

public class UserDaoImpl extends HibernateDaoSupport implements UserDao {

	public Integer save(User user) {
		return (Integer) getHibernateTemplate().save(user);
	}

	public void delete(User user) {
		getHibernateTemplate().delete(user);
	}

	public void update(User user) {
		getHibernateTemplate().merge(user);
	}

	public User getUserById(int id) {
		@SuppressWarnings("unchecked")
		List<User> users = (List<User>) getHibernateTemplate().find(
				"from User as u where u.id=?", id);
		User user = users.size() > 0 ? users.get(0) : null;
		return user;
	}
	
	public User getUserByName(String name) {
		@SuppressWarnings("unchecked")
		List<User> users = (List<User>) getHibernateTemplate().find(
				"from User as u where u.username=?", name);
		User user = users.size() > 0 ? users.get(0) : null;
		return user;
	}

	public List<User> getAllUsers() {
		@SuppressWarnings("unchecked")
		List<User> users = (List<User>) getHibernateTemplate()
				.find("from User");
		return users;
	}
	
	public byte[] getAvatar(int id){
		MongoDatabase db = MongoUtil.getDB();
        MongoCollection<Document> collection = db.getCollection("avatar");
        Document doc = collection.find(eq("userid", id)).first();
        if (doc == null || doc.get("avatar") == null) {
            return null;
        } else {
            Binary binary = (Binary) doc.get("avatar");
            return binary.getData();
        }
	}
	
	public void saveAvatar(int id,byte[] avatar){
		if (avatar == null) {
            return;
        }

        Binary img = new Binary(avatar);

        MongoCollection<Document> collection = MongoUtil.getDB().getCollection("avatar");
        Document doc = collection.find(eq("userid", id)).first();
        if (doc == null) {
            doc = new Document();
            doc.append("userid", id).append("avatar", img);
            collection.insertOne(doc);
        } else {
            collection.updateOne(eq("userid", id), set("avatar", img));
        }
	}
	
	public void deleteAvatar(int id){
		MongoDatabase db = MongoUtil.getDB();
        MongoCollection<Document> collection = db.getCollection("avatar");
		collection.deleteOne(eq("userid",id));
	}

}