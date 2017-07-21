package service;

import java.util.List;

import model.User;

public interface UserService {
	public Integer addUser(User user);

	public void deleteUser(User user);

	public void updateUser(User user);

	public User getUserById(int id);

	public List<User> getAllUsers();
	
	public User login(User user);
	
	public boolean nameAvail(String name);
	
	public byte[] getAvatar(int id);
	
	public void saveAvatar(int id,byte[] avatar);
	
	public void deleteAvatar(int id);
	
	public void updateUserProfile(User user);
	
	public boolean updatePassword(User user,String newpwd);
}
