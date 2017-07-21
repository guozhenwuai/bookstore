<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Book"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
	String path = request.getContextPath();
%>
    <title>Book Management</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>

	<!-- Custom JS file -->
	<script type="text/javascript" src="<%=path%>/js/BookManage.js"></script>
	<script type="text/javascript" src="<%=path%>/js/ajaxfileupload.js"></script>

	<script src="<%=path%>/js/flat-ui.min.js"></script>
	
</head>
<body>
	<%
		ArrayList<Book> bookList = new ArrayList<Book>();
		if (request.getAttribute("books") != null) {
			bookList = (ArrayList<Book>) request.getAttribute("books");
		}
		int size = bookList.size();
	%>

<!-- Content Section -->
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>Bookstore Management System</h2>
        </div>
    </div>
    <div class="row">
    	<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="homepage">My Bookstore</a>
				</div>
				<div>
					<ul class="nav navbar-nav">
						<li class="active"><a href="book!list">Book</a></li>
						<li><a href="user!list">User</a></li>
						<li><a href="order!list">Order</a></li>
						<li><a href="orderItem!list">Order Item</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <button class="btn btn-success" id="add_new_record">Add New Record</button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h5><b>Records:</b></h5>
			
            <div>
            	<table class='table table-bordered table-striped table-hover' id="dataTables">
            		<thead><tr>
            			<th>ID</th>
            			<th>Book Name</th>
            			<th>Author</th>
            			<th>Category</th>
            			<th>Price</th>
            			<th>Cover</th>
            			<th>Update</th>
            			<th>Delete</th>
            		</tr></thead>
            		<tbody>
            			<%
							for (int i = 0; i < size; i++) {
								Book book = bookList.get(i);
						%>
						<tr>
            				<td><%=book.getId()%></td>
            				<td><%=book.getName()%></td>
            				<td><%=book.getAuthor()%></td>
            				<td><%=book.getCategory()%></td>
            				<td><%=book.getRealPrice()%></td>
            				<td>
            					<button onclick='showCover(<%=book.getId()%>)' class="btn btn-primary">Cover</button>
            				</td>
            				<td>
								<button class="btn btn-warning edit" type="button" 
								data-id="<%=book.getId()%>"
								data-name="<%=book.getName() %>"
								data-author="<%=book.getAuthor() %>"
								
								data-category="<%=book.getCategory()%>"
								data-price="<%=book.getRealPrice()%>">Update</button>
							</td>
							<td>
								<button onclick='DeleteBook(<%=book.getId()%>)' class='btn btn-danger'>Delete</button>
							</td>
            			</tr>
            		<%
						}
					%>
					</tbody>
            	</table>
            </div>
        </div>
    </div>
</div>
<!-- /Content Section -->


<!-- Bootstrap Modals -->
<!-- Modal - Add New Record/Book -->
<div class="modal fade" id="add_new_record_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Add New Record</h4>
            </div>
            <div class="modal-body">
            <form enctype="multipart/form-data">

                <div class="form-group">
                    <label for="bookname">Book Name</label>
                    <input type="text" id="bookname" placeholder="Book Name" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <input type="text" id="category" placeholder="Category" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="author">Author</label>
                    <input type="text" id="author" placeholder="Author" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="cover">Cover</label>
                    <button type="button" class="btn btn-success" onclick="cover.click()">Upload Cover</button>
                    <input type="file" id="cover" name="upload" style="visibility: hidden; position: absolute;"/>
                </div>
                
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="text" id="price" placeholder="Price" class="form-control"/>
                </div>

			</form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="addRecord()">Add Record</button>
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

<!-- Modal - Update Book details -->
<div class="modal fade" id="update_book_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Update</h4>
            </div>
            <div class="modal-body">
            <form enctype="multipart/form-data">

                <div class="form-group">
                    <label for="update_bookname">Book Name</label>
                    <input type="text" id="update_bookname"
                    placeholder="Book Name" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="update_category">Category</label>
                    <input type="text" id="update_category"
                    placeholder="Category" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="update_author">Author</label>
                    <input type="text" id="update_author"
                    placeholder="Author" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="update_cover">Cover</label>
                    <button type="button" class="btn btn-success" onclick='update_cover.click()'>Update Cover</button>
                    <input type="file" id="update_cover" name="upload" style="visibility: hidden; position: absolute;"/>
                </div>
                
                <div class="form-group">
                    <label for="update_price">Price</label>
                    <input type="text" id="update_price"
                    placeholder="Price" class="form-control"/>
                </div>
                
			</form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="UpdateBookDetails()" >Save Changes</button>
                <input type="hidden" id="hidden_book_id">
                <input type="hidden" id="hidden_cover_src">
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

<!-- Modal - Show book cover -->
<div class="modal text-center" id="cover_modal" tabindex="1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" style="display:inline-block;width:auto;">
		<div class="modal-content">
			<img id="cover_img" class="img-thumbnail" onerror="this.src='img/default.jpg'">
		</div>
	</div>
</div>
<!-- // Modal -->


</body>
</html>
