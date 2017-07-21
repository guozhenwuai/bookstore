/**
 * 
 */
function showImg(){
	$("#book_items img").each(function(index, element) {
		var propotion= 4/3;
		var width = $(element).width();
		$(element).css("height",width*propotion);
    });
}

function minus(){
	var val = $("#book_num").val()-0;
	val = val - 1;
	$("#book_num").val(val);
	if(val<=1){
		$("#book_minus").attr("disabled",true);
	}
	if(val<=8){
		$("#book_plus").attr("disabled",false);
	}
}

function cartMinus(id){
	var cartNum = document.getElementsByName("cart_num")[id-0];
	var val = cartNum.value-0;
	val = val - 1;
	cartNum.value = val;
	if(val<=1){
		var cartMinus = document.getElementsByName("cart_minus")[id];
		cartMinus.disabled = true;
	}
	if(val<=8){
		var cartPlus = document.getElementsByName("cart_plus")[id];
		cartPlus.disabled = false;
	}
}

function plus(){
	var val = $("#book_num").val()-0;
	val = val + 1;
	$("#book_num").val(val);
	if(val>=2){
		$("#book_minus").attr("disabled",false);
	}
	if(val>=9){
		$("#book_plus").attr("disabled",true);
	}
}

function cartPlus(id){
	var cartNum = document.getElementsByName("cart_num")[id-0];
	var val = cartNum.value-0;
	val = val + 1;
	cartNum.value = val;
	if(val>=2){
		var cartMinus = document.getElementsByName("cart_minus")[id];
		cartMinus.disabled = false;
	}
	if(val>=9){
		var cartPlus = document.getElementsByName("cart_plus")[id];
		cartPlus.disabled = true;
	}
}

function addToCart(){
	var id = $("#hidden_book_id").val();
	var num = $("#book_num").val();
	jQuery.ajax({
    	url : 'cart!add',
		processData : true,
		dataType : "text",
		data :{
			id:id,
			num:num
		},
		complete: function(data) {
			location.reload();
		}
    });
}

function keySearch(){
	var category = $("#search_input").val();
	location.href="search?category="+ encodeURIComponent(encodeURIComponent(category));
}

function getBookDetail(id){
	jQuery.ajax({
		url : 'bookDetail',
		type: "post",
		dataType : "json",
		data :{
			id:id
		},
		success: function(result){
			result = JSON.parse(result);
			$("#hidden_book_id").val(result.id);

			$("#detail_cover").attr('src','getCover?id='+result.id);
			$("#detail_name").html(result.name);
			$("#detail_author").html(result.author);
			$("#detail_category").html(result.category);
			$("#detail_price").html(result.realPrice);
			
			$("#book_num").val("1");

			$("#book_detail_modal").modal("show");
		}
	});
}

function delCartItem(i){
	var item = document.getElementsByName("cart_item")[i];
	var id = item.value;
	jQuery.ajax({
		url:'cart!delete',
		type: "post",
		dataType : "text",
		data :{
			id:id
		},
		success: function(result){
			var tr = item.parentNode.parentNode;
			var tb = tr.parentNode;
			tb.removeChild(tr);
			var size = $("#cart_size").html()-0;
			size = size-1;
			$("#cart_size").html(size);
			if(size==0){
				emptyImage();
			}
		}
	});
}

function emptyImage(){
	var tb = document.getElementById("cart_table");
	var body = tb.parentNode;
	body.removeChild(tb);
	var p = document.createElement("p");
	p.innerHTML="Your cart is empty~";
	var img = document.createElement("img");
	img.src='img/empty_cart.png';
	img.style.width='450px';
	body.appendChild(p);
	body.appendChild(img);
	var footer = document.getElementById("footer");
	footer.parentNode.removeChild(footer);
}

function EmptyCart(){
	jQuery.ajax({
		url : 'cart!empty',
		processData : true,
		dataType : "text",
		data :{
		},
		complete: function(data) {
			emptyImage();
			$("#cart_size").html(0);
		}
	});
}

function PlaceOrder(){
	var item = document.getElementsByName("cart_item");
	var num = document.getElementsByName("cart_num");
	var map = {};
	var count = 0;
	for(var i=0;i<item.length;i++){
		if(item[i].checked==true){
			count++;
			var id = item[i].value;
			var count = num[i].value;
			map[id] = count;
		}
	}
	if(count==0){
		alert("nothing has been selected!");
		return;
	}
	str = JSON.stringify(map); 
	location.href="checkOrder?map="+str;
}


$(function(){
	$("#cart_modal").on('hide.bs.modal',function(){
		var item = document.getElementsByName("cart_item");
		var num = document.getElementsByName("cart_num");
		var map = {};
		for(var i=0;i<item.length;i++){
			var id = item[i].value;
			var count = num[i].value;
			map[id] = count;
		}
		str = JSON.stringify(map); 
		jQuery.ajax({
			url : 'cart!update',
			processData : true,
			dataType : "text",
			data :{
				map:str
			},
			complete: function(data) {
			}
		});
	});
	$("#cart_modal").on('show.bs.modal',function(){
		var num = document.getElementsByName("cart_num");
		for(var i=0;i<num.length;i++){
			var val = num[i].value;
			if(val<=1){
				num[i].value=1;
				var cartMinus = document.getElementsByName("cart_minus")[i];
				cartMinus.disabled = true;
			}
			if(val>=9){
				num[i].value=9;
				var cartPlus = document.getElementsByName("cart_plus")[i];
				cartPlus.disabled = true;
			}
		}
	});
	$("#book_detail_modal").on('show.bs.modal',function(){
		var num = document.getElementById("book_num");
		num.value = 1;
		var minus = document.getElementById("book_minus");
		minus.disabled = true;
	})
});