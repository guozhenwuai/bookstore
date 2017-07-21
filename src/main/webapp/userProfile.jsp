<%@ page import="java.util.ArrayList"%>
<%@ page import="model.OrderItem"%>
<%@ page import="model.User"%>
<%@ page import="model.Book"%>
<%@ page import="model.Order"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	HttpSession s = request.getSession();
%>
	<title>My Bookstore - Personal Center</title>
	<!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path %>/css/font-awesome.min.css" rel="stylesheet">  
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Flat UI JS file -->
	<script type="text/javascript" src="<%=path%>/js/flat-ui.min.js"></script>
	
	<script type="text/javascript" src="<%=path%>/js/userProfile.js"></script>
	<script type="text/javascript" src="<%=path%>/js/homepage.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>
</head>
<body>
	<%
		ArrayList<OrderItem> cartItemList = new ArrayList<OrderItem>();
		if (request.getAttribute("cartItems") != null) {
			cartItemList = (ArrayList<OrderItem>) request.getAttribute("cartItems");
		}
		int cisize = cartItemList.size();
		
		User userInfo = new User();
		if (request.getAttribute("user") != null) {
			userInfo = (User) request.getAttribute("user");
		}
	%>
	
	<div class="container">
 		<h1>Personal Center</h1>
	</div>
	
	<!-- Navigation -->
    <div class="container">
    <nav class="navbar navbar-inverse navbar-lg" role="navigation">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse-7">
            <span class="sr-only">Toggle navigation</span>
          </button>
          <a class="navbar-brand" href="homepage">Homepage</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="navbar-collapse-7">
          <ul class="nav navbar-nav">
            <li><a href="about">About Me</a></li>
            <li><a></a></li>
           </ul>
          <form class="navbar-form navbar-left" role="search">
            <div class="form-group">
              <div class="input-group">
                <input class="form-control" id="search_input" placeholder="Search" type="search">
                <span class="input-group-btn">
                  <button type="button" class="btn" onclick="keySearch()"><span class="fa fa-search fa-lg"></span></button>
                </span>
              </div>
            </div>
          </form>
          <ul class="nav navbar-nav navbar-right">
          	<li><a>Welcome,<%=s.getAttribute("user") %></a></li>
          	<li><a data-toggle="modal" data-target="#cart_modal">
          		<span class="fa fa-cart-arrow-down fa-lg"></span>
          		<span class="badge badge-primary" id="cart_size"><%=cisize %></span>
          	</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              	<span class="fa fa-user fa-lg"></span>
              	<b class="caret"></b>
              </a>
              <ul class="dropdown-menu">
                <li><a href="userProfile!list">Personal Center</a></li>
                <%
                Integer admin = (Integer) s.getAttribute("admin");
                	if(admin!=null && admin==1){
                %>
                		<li><a href="book!list">Management Center</a></li>
                <%
                	}
                %>
                <li class="divider"></li>
                <li><a href="logout">Log Off</a></li>
              </ul>
            </li>
            
          </ul>
        </div><!-- /.navbar-collapse -->
    </nav>
    </div>
    
    <div class="container">
    	<div class="row">
    		<div class="col-sm-6">
    			<div class="row">
    				<a class="thumbnail" onclick="avatar.click()" >
 						<img src="getAvatar?id=<%=userInfo.getId() %>" 
 							onerror="this.src='img/default.jpg'"/>
 					</a>
    			</div>
    			<div class="row">
    				<div style="text-align:right">
    					<input type="file" id="avatar" name="upload" onchange="updateAvatar(<%=userInfo.getId() %>)"
    					style="visibility: hidden; position: absolute;"/>
    					<button type="button" class="btn btn-success" onclick="orderHistory(<%=userInfo.getId() %>)">Order History</button>
    					<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#password_modal">Reset Password</button>
    					<button type="button" class="btn btn-primary" onclick="saveProfile(<%=userInfo.getId() %>)">Save Profile</button>
    				</div>
    			</div>
    		</div>
    		<div class="col-sm-6">
    			<h6><b><%=userInfo.getUsername() %></b></h6>
    			<br>
    			<div class="form-group">
                    <label for="email">Email</label>
                    <input type="text" id="email" placeholder="Email" class="form-control" value="<%=userInfo.getEmail()==null?"":userInfo.getEmail() %>"/>
                </div>
    			<div class="form-group">
                    <label for="receiver">Receiver</label>
                    <input type="text" id="receiver" placeholder="Receiver" class="form-control" value="<%=userInfo.getReceiver()==null?"":userInfo.getReceiver() %>"/>
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" placeholder="Address" class="form-control" value="<%=userInfo.getAddress()==null?"":userInfo.getAddress() %>"/>
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" placeholder="Phone Number" class="form-control" value="<%=userInfo.getPhone()==null?"":userInfo.getPhone() %>"/>
                </div>
    		</div>
    	</div>
    </div>
    
    <!-- Modal - Show cart -->
	<div class="modal text-center" id="cart_modal" tabindex="1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" style="display:inline-block;width:auto;">
			<div class="modal-content">
			<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">My Cart</h4>
            </div>
            <div class="modal-body">
			<%
				if(cisize==0){
			%>
				<p>Your cart is empty~</p>
				<img src="<%=path%>/img/empty_cart.png" style="width:450px;">
			<%
				}else{
			%>
				<div>
					<table class="table table-hover">
						<tbody id="cart_table">
							<%
								for (int i = 0; i < cisize; i++) {
									OrderItem cartItem = cartItemList.get(i);
									Book bk = cartItem.getBook();
									int id = bk.getId();
							%>
							<tr>
								<td>
									<input value="<%=id%>" name="cart_item" type="checkbox">
								</td>
								<td><%=bk.getName() %></td>
								<td></td>
								<td>￥<%=bk.getRealPrice() %></td>
								<td>
									<button class="btn btn-primary btn-xs" name="cart_minus" onclick="cartMinus('<%=i%>')">
            							<span class="fa fa-minus"></span>
            						</button>
            					</td>
            					<td>
            						<input name="cart_num" class="input-intable" value="<%=cartItem.getNum()%>"/>
            					</td>
            					<td>
            						<button class="btn btn-primary btn-xs" name="cart_plus" onclick="cartPlus('<%=i%>')">
            							<span class="fa fa-plus"></span>
            						</button>
            					</td>
            					<td></td>
								<td>
									<button class="btn btn-danger btn-xs" onclick="delCartItem(<%=i%>)">
										<span class="fa fa-close"></span>
									</button>
								</td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer" id="footer">
				<button type="button" class="btn btn-default" onclick="EmptyCart()">Empty Cart</button>
                <button type="button" class="btn btn-primary" onclick="PlaceOrder()" >Place Order</button>
                <%
					}
				%>
			</div>
			</div>
		</div>
	</div>
	<!-- // Modal -->
	
	<div class="modal text-center" id="password_modal" tabindex="1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" style="display:inline-block;width:400px;">
			<div class="modal-content">
				<div class="modal-header">
                	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                	<h4 class="modal-title">Reset Password</h4>
            	</div>
            	<div class="modal-body">
            		<div class="form-group">
                    	<label for="old_password">Old Password</label>
                    	<input type="password" id="old_password" placeholder="Old Password" class="form-control"/>
                	</div>
                	<div class="form-group">
                    	<label for="new_password">New Password</label>
                    	<input type="password" id="new_password" placeholder="New Password" class="form-control"/>
                	</div>
            	</div>
            	<div class="modal-footer">
            		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                	<button type="button" class="btn btn-primary" onclick="resetPassword(<%=userInfo.getId() %>)">Confirm Change</button>
            	</div>
            </div>
        </div>
	</div>
</body>
</html>