/**
 * 
 */

function loadChart(){
	
	jQuery.ajax({
		url : 'sales!list',
		processData : true,
		dataType : "json",
		data :{
		},
		success: function(result) {
			result = JSON.parse(result);
			var fillColor = "rgba(151,187,205,0.5)";
			var strokeColor = "rgba(151,187,205,1)";
			var data = {};
			var labels = [];
			var datasets = [];
			var stat = {};
			stat["fillColor"] = fillColor;
			stat["strokeColor"] = strokeColor;
			var d = [];
			
			var money = 0;
			var count = 0;
			for(var key in result){
				count++;
				labels.push(key);
				money += result[key];
				d.push(result[key]/100.0);
			}
			
			if(count==0){
				$("#total_sales").html("<h5>No Records</5>");
				var ctx = document.getElementById("myChart").getContext("2d");
				var myNewChart = new Chart(ctx);
				return;
			}
			
			$("#total_sales").html("<h5>Total Sales: "+money/100+"</5>");
			
			stat["data"] = d;
			datasets.push(stat);
			data["labels"] = labels;
			data["datasets"] = datasets;
		    
			var ctx = document.getElementById("myChart").getContext("2d");
			document.getElementById("myChart").width = 100*count;
			var myNewChart = new Chart(ctx).Bar(data);
		}
	});
}

function criteria(){
	var userId = $("#user").val();
	var dataMap = {};
	if(userId!=""){
		dataMap["id"]=userId;
	}
	var startYear = $("#start_year").val();
	var startMonth = $("#start_month").val();
	var startDay = $("#start_day").val();
	if(startYear!=""&&startMonth!=""&&startDay!=""){
		var startDate = startYear+"-"+startMonth+"-"+startDay;
		dataMap["start"]=startDate;
	}
	
	var endYear = $("#end_year").val();
	var endMonth = $("#end_month").val();
	var endDay = $("#end_day").val();
	if(endYear!=""&&endMonth!=""&&endDay!=""){
		var endDate = endYear+"-"+endMonth+"-"+endDay;
		dataMap["end"]=endDate;
	}
	
	var book_cate = $("input[name='book_category']:checked").val();
	var name = $("#name").val();
	if(name!=""){
		dataMap[book_cate] = encodeURIComponent(name);
	}
	jQuery.ajax({
		url : 'sales!criteria',
		processData : true,
		dataType : "json",
		data : dataMap,
		success: function(result) {
			result = JSON.parse(result);
			var fillColor = "rgba(151,187,205,0.5)";
			var strokeColor = "rgba(151,187,205,1)";
			var data = {};
			var labels = [];
			var datasets = [];
			var stat = {};
			stat["fillColor"] = fillColor;
			stat["strokeColor"] = strokeColor;
			var d = [];
			
			var count = 0;
			var money = 0;
			for(var key in result){
				count++;
				labels.push(key);
				money += result[key];
				d.push(result[key]/100.0);
			}
			
			if(count==0){
				$("#total_sales").html("<h5>No Records</5>");
				var ctx = document.getElementById("myChart").getContext("2d");
				var myNewChart = new Chart(ctx);
				$("#specify_modal").modal("hide");
				return;
			}
			
			$("#total_sales").html("<h5>Total Sales: "+money/100+"</5>");
			
			stat["data"] = d;
			datasets.push(stat);
			data["labels"] = labels;
			data["datasets"] = datasets;
		    
			var ctx = document.getElementById("myChart").getContext("2d");
			document.getElementById("myChart").width = 100*count;
			var myNewChart = new Chart(ctx).Bar(data);
			$("#specify_modal").modal("hide");
		}
	});
}

function showModal(){
	$("#specify_modal").modal("show");
}