<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Book"%>
<%@ page import="model.User"%>
<%@ page import="model.OrderItem"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>My Bookstore - Order Page</title>
<%
	String path = request.getContextPath();
%>
    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path %>/css/font-awesome.min.css" rel="stylesheet">  
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Flat UI JS file -->
	<script type="text/javascript" src="<%=path%>/js/flat-ui.min.js"></script>
	
	<script type="text/javascript" src="<%=path%>/js/checkOrder.js"></script>
</head>
<body>
	<%
		ArrayList<OrderItem> cartItemList = new ArrayList<OrderItem>();
		if (request.getAttribute("cartItems") != null) {
			cartItemList = (ArrayList<OrderItem>) request.getAttribute("cartItems");
		}
		int cisize = cartItemList.size();
		
		String map = new String();
		if (request.getAttribute("map") != null) {
			map = (String) request.getAttribute("map");
		}
		
		User user = new User();
		if (request.getAttribute("user") != null) {
			user = (User) request.getAttribute("user");
		}
	%>

<!-- Content Section -->
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>Confirm Your Order</h2>
            <br>
            <br>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
        <%
            double totalPrice = 0;
			for (int i = 0; i < cisize; i++) {
				OrderItem orderItem = cartItemList.get(i);
				Book book = orderItem.getBook();
				totalPrice+=book.getPrice()*orderItem.getNum();
				if(i%2==0){
		%>
            <div class="row">
           <%
						}
			%>
            	<div class="thumbnail col-sm-6" style="height:180px">
            		<div class="col-sm-3">
            			<a class="thumbnail">
 							<img src="getCover?id=<%=book.getId() %>" onerror="this.src='img/default.jpg'"/>
 						</a>
            		</div>
            		<div class="col-sm-1"></div>
            		<div class="col-sm-8">
            			<h7><a><%=book.getName() %></a></h7>
            			<br><br>
            			<i>￥<%=book.getRealPrice() %></i>
            			<b>x<%=orderItem.getNum() %></b>
            		</div>
            	</div>
            	<%
 					if(i%2==1&&i!=cisize-1){
 				%>
            </div>
            <%
 					}
				}
			totalPrice = totalPrice/100;
			%>
        </div>
    </div>
    
    <div class="row">
    	<div class="col-md-12">
    		<h5><b>Total Price: <%=totalPrice %></b></h5>
    	</div>
    </div>
    
    <div class="row">
    	<div class="col-md-9">
    		<div class="form-group">
                <label for="receiver"><h6>Receiver Name</h6></label>
                <input type="text" id="receiver" placeholder="Receiver Name" class="form-control" 
                	value="<%=user.getReceiver()==null?"":user.getReceiver() %>"/>
            </div>
            <div class="form-group">
                <label for="address"><h6>Adress</h6></label>
                <input type="text" id="address" placeholder="Address" class="form-control"
                	value="<%=user.getAddress()==null?"":user.getAddress() %>"/>
            </div>
            <div class="form-group">
                <label for="phone"><h6>Phone</h6></label>
                <input type="text" id="phone" placeholder="Phone" class="form-control"
                	value="<%=user.getPhone()==null?"":user.getPhone() %>"/>
            </div>
            <input type="text" id="hidden_map"style="visibility: hidden" value='<%=map %>'/>
    		<div class="row">
    			
    			<div class="col-sm-2">
    				<a href="homepage"><button type="button" class="btn btn-default" >Cancel Order</button></a>
    			</div>
    			<div class="col-sm-2 col-sm-offset-8">
    				<button type="button" class="btn btn-primary" onclick="placeOrder(<%=user.getId() %>)" >Place Order</button>
    			</div>
    		</div>
    	</div>
    </div>
    
</div>
<!-- /Content Section -->
</body>
</html>