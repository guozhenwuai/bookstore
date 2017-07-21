package service.impl;

import java.util.List;

import dao.UserDao;
import model.User;
import service.UserService;

public class UserServiceImpl implements UserService{
	private UserDao userDao;
	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	public Integer addUser(User user) {
		return userDao.save(user);
	}

	public void deleteUser(User user) {
		userDao.delete(user);
	}

	public void updateUser(User user) {
		userDao.update(user);
	}

	public User getUserById(int id) {
		return userDao.getUserById(id);
	}

	public List<User> getAllUsers() {
		return userDao.getAllUsers();
	}
	
	public User login(User user){
		String pwd = user.getPassword();
		User nuser = userDao.getUserByName(user.getUsername());
		if(nuser==null || !pwd.equals(nuser.getPassword())){
			return null;
		}
		return nuser;
	}
	
	public boolean nameAvail(String name){
		User user = userDao.getUserByName(name);
		if(user==null){
			return true;
		}
		else return false;
	}

	public byte[] getAvatar(int id){
		return userDao.getAvatar(id);
	}
	
	public void saveAvatar(int id,byte[] avatar){
		userDao.saveAvatar(id, avatar);
	}
	
	public void deleteAvatar(int id){
		userDao.deleteAvatar(id);
	}
	
	public void updateUserProfile(User user){
		User source = userDao.getUserById(user.getId());
		source.setAddress(user.getAddress());
		source.setEmail(user.getEmail());
		source.setPhone(user.getPhone());
		source.setReceiver(user.getReceiver());
		userDao.update(source);
	}
	
	public boolean updatePassword(User user, String newpwd){
		User source = userDao.getUserById(user.getId());
		if(!(source.getPassword()).equals(user.getPassword())){
			return false;
		}
		else{
			source.setPassword(newpwd);
			userDao.update(source);
			return true;
		}
	}
}
