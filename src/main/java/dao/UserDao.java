package dao;

import java.util.List;

import model.User;

public interface UserDao {

	public Integer save(User user);

	public void delete(User user);

	public void update(User user);

	public User getUserById(int id);
	
	public User getUserByName(String name);

	public List<User> getAllUsers();
	
	public byte[] getAvatar(int id);
	
	public void saveAvatar(int id,byte[] avatar);
	
	public void deleteAvatar(int id);

}