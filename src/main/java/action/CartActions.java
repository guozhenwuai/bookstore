package action;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import net.sf.json.JSONObject;



public class CartActions extends BaseAction {
	private static final long serialVersionUID = 1L;
	
	private int id;
	private int num;
	private String map;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	public String getMap() {
		return map;
	}
	public void setMap(String map) {
		this.map = map;
	}
	public String add(){
		Map<Integer,Integer> cart = (HashMap<Integer,Integer>) session().getAttribute("cart");
		if (cart == null) {
            cart = new HashMap<Integer,Integer>();
        }
		Integer cnt = (Integer)cart.get(id);
        if (cnt == null) {
            cnt = 0;
        }
        cnt += num;
        cart.put(id, cnt);
        session().setAttribute("cart", cart);
        
        return SUCCESS;
	}
	
	public String update(){
		HashMap<Integer,Integer> cart = new HashMap<Integer,Integer>();
		JSONObject  jsonObject = JSONObject.fromObject(map);
		Iterator iter = jsonObject.keys();
		while(iter.hasNext()){
			String key = (String) iter.next();
			String value = jsonObject.getString(key);  
			cart.put(Integer.parseInt(key), Integer.parseInt(value));
		}
		
		session().setAttribute("cart", cart);
		
		return SUCCESS;
	}
	
	public String delete(){
		Map<Integer,Integer> cart = (HashMap<Integer,Integer>) session().getAttribute("cart");
		cart.remove(id);
		session().setAttribute("cart", cart);
		
		return SUCCESS;
	}
	
	public String empty(){
		HashMap<Integer,Integer> cart = new HashMap<Integer,Integer>();
		session().setAttribute("cart", cart);
		
		return SUCCESS;
	}

}
