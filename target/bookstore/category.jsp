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
          <form class="navbar-form navbar-left" action="#" role="search">
            <div class="form-group">
              <div class="input-group">
                <input class="form-control" id="navbarInput-01" placeholder="Search" type="search">
                <span class="input-group-btn">
                  <button type="submit" class="btn"><span class="fa fa-search fa-lg"></span></button>
                </span>
              </div>
            </div>
          </form>
          <ul class="nav navbar-nav navbar-right">
          	<li><a>Welcome,<%=s.getAttribute("name") %></a></li>
          	<li><a data-toggle="modal" data-target="#cart_modal">
          		<span class="fa fa-cart-arrow-down fa-lg"></span>
          		<span class="badge badge-primary"><%=cisize %></span>
          	</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              	<span class="fa fa-user fa-lg"></span>
              	<b class="caret"></b>
              </a>
              <ul class="dropdown-menu">
                <li><a href="#">Personal Center</a></li>
                <%
                Integer admin = (Integer) s.getAttribute("admin");
                	if(admin!=null && admin!=0){
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
 						<a href="bookDetail(<%=id %>)" class="thumbnail">
 							<img src="<%=book.getCover() %>" onerror="this.src='img/default.jpg'"/>
 						</a>
 						<h7><a href="bookDetail(<%=id %>)"><%=book.getName() %></a></h7>
 						<br>
 						<i>￥<%=book.getRealPrice() %></i>
 						<a class="btn btn-primary btn-xs pull-right" 
 						href="bookDetail(<%=id %>)">View this book 
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
    
    <!-- Modal - Show book cover -->
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
				<img id="empty_cart" src="<%=path%>/img/empty_cart.png" style="width:450px;">
			<%
				}else{
			%>
				<div>
					<table class="table table-hover">
						<tbody>
							<%
								for (int i = 0; i < cisize; i++) {
									OrderItem cartItem = cartItemList.get(i);
									Book bk = cartItem.getBook();
							%>
							<tr>
								<td><%=bk.getName() %></td>
								<td>￥<%=bk.getRealPrice() %></td>
								<td><%=cartItem.getNum() %></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
				<%
					}
				%>
			</div>
			</div>
		</div>
	</div>
<!-- // Modal -->

</body>

</html>
