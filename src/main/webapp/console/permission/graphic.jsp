<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>权限地图</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/permission/raphael-min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/permission/graphic.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/common/javascripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">

	node_border_colors["app"] = "red";
	node_border_colors["module"] = "#be0000";
	node_border_colors["func"] = "#bfac00";
	node_border_colors["end"] = "#666666";
	
	$(document).ready(function(){  
	         var data={"user.userId":"1"};
			 $.ajax({
			 url: "<%=request.getContextPath()%>/platform/console/function/getPermissionGraphic.action",
			 type: 'POST',
			 data: JSON.stringify(data),
			 cache: false,
			 type : 'POST',
			 contentType:'text/json',
			 success: function (data) {
			 	var json = data.nodes;
				drawGraph(json);
			 },
			 error: function (jqXHR, textStatus, errorThrown) {
			     alert(jqXHR.responseText);
			 }
			});
	 });   
	
	
	/* only do all this when document has finished loading (needed for RaphaelJS) */
	function drawGraph(nodes){
	    if(!nodes){
	    	return;
	    }
	    var width = $(document).width() - 20;
	    var height = $(document).height() - 60;
	    
	    var graphic = new PermissionGraph("canvas",width,height);
		
		for(var i=0;i<nodes.length;i++){
			var node = nodes[i];
			graphic.addNode(node);
			if(node.connections){
				for(var j=0;j<node.connections.length;j++){
					graphic.addEdge(node.id, node.connections[j], { directed : true } );
				}
			}
		}
		graphic.draw();
	   
	};
	</script>	
	<style>
		*{
			font-family: "Microsoft YaHei", "宋体", "Segoe UI", sans-serif;
    		font-size: 13px;
		}
	</style>
</head>
<body style="">
<div id="canvas"></div>

</body>
</html>
