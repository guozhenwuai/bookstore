<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="model.Book"%>
<%@ page import="model.OrderItem"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
	String path = request.getContextPath();
	HttpSession s = request.getSession();
%>
    <title>My Bookstore</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	<link href="<%=path %>/css/font-awesome.min.css" rel="stylesheet">  
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Flat UI JS file -->
	<script type="text/javascript" src="<%=path%>/js/flat-ui.min.js"></script>
	
	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/homepage.js"></script>
	
	<style type="text/css">
	.product-item {
 		padding-bottom: 32px;
 		img {
 		width:100%;
 		}
 		h2 {
 		font-size: @font-size-large;
 		line-height: 1.2;
 		padding: 0 !important;
 		margin-top:6px;
 		margin-bottom:2px;
 		}
 		p {
 		font-size: @font-size-small;
 		line-height:1.3;
 		color:@gray;
 		}
	}
	.badge-gray{
		background-color:#5d6d7e;
	}
	.badge-primary{
		background-color:#1abc9c;
		vertical-align: super;
		font-size:8px;
	}
	.detail-item{
		text-align:left;
	}
	
	</style>
	
</head>

<body onload="showImg()">
	<%
		ArrayList<Book> bookList = new ArrayList<Book>();
		if (request.getAttribute("books") != null) {
			bookList = (ArrayList<Book>) request.getAttribute("books");
		}
		int bsize = bookList.size();
		
		ArrayList<OrderItem> cartItemList = new ArrayList<OrderItem>();
		if (request.getAttribute("cartItems") != null) {
			cartItemList = (ArrayList<OrderItem>) request.getAttribute("cartItems");
		}
		int cisize = cartItemList.size();
		
	%>

	<div class="container">
 		<h1>My Bookstore <small>Wisdom is the new elegance</small></h1>
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
    
    <div role="main">
    	<div class="container">
    		<ol class="breadcrumb">
    			<li><a href="homepage">Homepage</a></li>
    			<li><a class="active"><%=request.getAttribute("category") %></a></li>
    		</ol>
    	</div>
    </div>

    <!-- Page Content -->
    <div class="container">

        <div class="row">

            <div class="products-grid col-sm-12" id="book_items">
            <%
					for (int i = 0; i < bsize; i++) {
						Book book = bookList.get(i);
						int id = book.getId();
						if(i%4==0){
			%>
				<div class="row">
			<%
						}
			%>
				
 					<div class="product-item col-xs-6 col-sm-3"> 
 						<a class="thumbnail" onclick="getBookDetail(<%=book.getId() %>)">
 							<img src="getCover?id=<%=book.getId() %>" onerror="this.src='img/default.jpg'"/>
 						</a>
 						<h7><a><%=book.getName() %></a></h7>
 						<br>
 						<i>￥<%=book.getRealPrice() %></i>
 						<a class="btn btn-primary btn-xs pull-right"
 							onclick="getBookDetail(<%=book.getId() %>)"
 						>View this book 
 							<i class="fa fa-arrow-circle-right"></i>
 						</a>
 					</div>
 					<%
 						if(i%4==3&&i!=bsize-1){
 					%>
				</div>
				<!-- /.row -->
				<%
 						}
					}
				%>
				</div>
				<!-- /.row -->
			</div>


        </div>
        <!-- /.row -->

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-inverse">
        <div class="container">
            <p class="m-0 text-center text-white">Copyright &copy; Your Website 2017</p>
        </div>
        <!-- /.container -->
    </footer>
    
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
            						<input name="cart_num" class="input-intable" value="<%=cartItem.getNum()%>" disabled="disabled" />
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

<!-- Modal - Show book detail -->
	<div class="modal text-center" id="book_detail_modal" tabindex="1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" style="display:inline-block;width:auto;">
			<div class="modal-content">
				<div class="modal-header">
                	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                	<h4 class="modal-title">Book Detail</h4>
            	</div>
            	<div class="modal-body">
            		<div class="row" style="width:630px;">
            			<div class="col-sm-6">
            				<img id="detail_cover" class="img-thumbnail" 
            				onerror="this.src='img/default.jpg'" style="width:300px;">
            			</div>
            			<div class="col-sm-6">
            				<h6 class="detail-item">Name: <span style="font-size:18px;" id="detail_name"></span></h6>
            				<br>
            				<h6 class="detail-item">Category: <span style="font-size:18px;" id="detail_category"></span></h6>
            				<br>
            				<h6 class="detail-item">Author: <span style="font-size:18px;" id="detail_author"></span></h6>
            				<br>
            				<h6 class="detail-item">Price: ￥<span style="font-size:18px;" id="detail_price"></span></h6>
            			</div>
            		</div>
            		<hr>
            		<input type="hidden" id="hidden_book_id">
            		<div class="row">
            			<button class="btn btn-danger" id="book_minus" onclick="minus()">
            				<span class="fa fa-minus"></span>
            			</button>
            			<input id="book_num" class="input-lg" style="width:45px;" disabled="disabled" />
            			<button class="btn btn-danger" id="book_plus" onclick="plus()">
            				<span class="fa fa-plus"></span>
            			</button>
            			<button class="btn btn-primary" onclick="addToCart()">
            				Add To Cart <span class="fa fa-cart-plus"></span>
            			</button>
            		</div>
            	</div>
            </div>
        </div>
    </div>
<!-- // Modal -->

</body>

</html>
