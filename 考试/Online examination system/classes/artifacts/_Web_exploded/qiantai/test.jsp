<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title>${appTitle}</title>
<meta name="description" content="website description" />
<meta name="keywords" content="website keywords, website keywords" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="${ctx }/qiantai/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/qiantai/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctx }/qiantai/css/btn.css" />
<!-- modernizr enables HTML5 elements and feature detects -->
<script type="text/javascript" src="${ctx }/qiantai/js/modernizr-1.5.min.js"></script>
<script type="text/javascript" src="${ctx }/qiantai/js/jquery.js"></script>
<link href="${ctx}/qiantai/js/kindeditor/themes/default/default.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="${ctx}/qiantai/js/kindeditor/kindeditor-all.js"></script>
<script type="text/javascript" src="${ctx}/qiantai/js/kindeditor/lang/zh-CN.js"></script>
<style type="text/css">
<!--
body {
	font-family: "微软雅黑"
}
-->
</style>
</head>
<body>
	<div id="main">
		<header>
			<nav>
				<div id="menu_container">
					<ul class="sf-menu" id="nav" style="float: left">
						<c:if test="${not empty SESSION_BEAN }">
							<li style="width: 300px;"><a href="#" style="color: white">欢迎您: ${SESSION_BEAN.user.userName } (
									${SESSION_BEAN.user.uname })</a></li>
								<li style=""><a href="#" style="color: white">[练习科目: ${course.name}]</a></li>
						</c:if>
					</ul>
				</div>
			</nav>
		</header>
		<div id="site_content" style="overflow: inherit">
			<div class="content" style="width: 100%">
				<h3>
					在线练习
					<c:if test="${closeable}">
						<a href="javascript:;" onclick="javascript:window.close()" style="margin-left: 20px; color: red">关闭页面</a>
					</c:if>
					<c:if test="${empty SESSION_BEAN }">
						<span style="color: red">请先登录后答题</span>
					</c:if>
				</h3>
				<h3>
					<button class="button black" onclick="jiexi()">查看答案</button>
					<button class="button green" onclick="shang()">上一题</button>
					<button class="button green" onclick="xia()">下一题</button>
				</h3>
				<c:if test="${empty quesList }">
					<span style="color: red">没有找到相关信息</span>
				</c:if>
				<c:if test="${not empty quesList }">
					<form action="${ctx}/sys/finishExam.do" method="post" id="voteform">
						<table style="width: 100%" class="table table-striped table-hover table-bordered">
							<tbody>
								<c:forEach items="${quesList }" var="p1" varStatus="vitem">
									<c:if test="${p1.quesType=='单选题' }">
									<tr id="questionli_${vitem.count }" style="display: none" class="questionli">
										<td>
											<table style="width: 100%" class="table table-striped table-hover table-bordered">
												<tr  style="background-color: #8E8E8E;color:white;">
													<td style="width:10%">${vitem.count }/${quesListSize }: <br/> [单选]</td>
													<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${vitem.count }" value="A" /> A:</td>
													<td>${p1.option1 }</td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${vitem.count }" value="B" /> B:</td>
													<td>${p1.option2 }</td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${vitem.count }" value="C" /> C:</td>
													<td>${p1.option3 }</td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${vitem.count }" value="D" /> D:</td>
													<td>${p1.option4 }</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr id="answerdiv_${vitem.count }" style="display: none" class="questionli"><td>答案: ${p1.answer }</td></tr>
									</c:if>
									
									<c:if test="${p1.quesType=='多选题' }">
										<tr id="questionli_${vitem.count }" style="display: none" class="questionli">
											<td>
												<table style="width: 100%" class="table table-striped table-hover table-bordered">
													<tr  style="background-color: #8E8E8E;color:white;">
														<td style="width:10%">${vitem.count }/${quesListSize }: <br/> [多选]</td>
														<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
													</tr>
													<tr>
														<td><input type="checkbox" name="item_${p1.id }" id="item_${vitem.count }" value="A" /> A:</td>
														<td>${p1.option1 }</td>
													</tr>
													<tr>
														<td><input type="checkbox" name="item_${p1.id }" id="item_${vitem.count }" value="B" /> B:</td>
														<td>${p1.option2 }</td>
													</tr>
													<tr>
														<td><input type="checkbox" name="item_${p1.id }" id="item_${vitem.count }" value="C" /> C:</td>
														<td>${p1.option3 }</td>
													</tr>
													<tr>
														<td><input type="checkbox" name="item_${p1.id }" id="item_${vitem.count }" value="D" /> D:</td>
														<td>${p1.option4 }</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr id="answerdiv_${vitem.count }" style="display: none" class="questionli"><td>答案: ${p1.answer }</td></tr>
									</c:if>
									
									<c:if test="${p1.quesType=='判断题' }">
										<tr id="questionli_${vitem.count }" style="display: none" class="questionli">
											<td>
												<table style="width: 100%" class="table table-striped table-hover table-bordered">
													<tr  style="background-color: #8E8E8E;color:white;">
														<td style="width:10%">${vitem.count }/${quesListSize }: <br/> [判断]</td>
														<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
													</tr>
													<tr>
														<td><input type="radio" name="item_${p1.id }" id="item_${vitem.count }" value="1" /></td>
														<td>正确</td>
													</tr>
													<tr>
														<td><input type="radio" name="item_${p1.id }" id="item_${vitem.count }" value="0" /></td>
														<td>错误</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr id="answerdiv_${vitem.count }" style="display: none" class="questionli"><td>答案: 
													<c:if test="${p1.answer=='1' }">正确</c:if>
													<c:if test="${p1.answer=='0' }">错误</c:if>
										</td></tr>
									</c:if>
									
									<c:if test="${p1.quesType=='填空题' }">
										<tr id="questionli_${vitem.count }" style="display: none" class="questionli">
											<td>
												<table style="width: 100%" class="table table-striped table-hover table-bordered">
													<tr  style="background-color: #8E8E8E;color:white;">
														<td style="width:10%">${vitem.count }/${quesListSize }: <br/> [填空]</td>
														<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
													</tr>
													<tr>
														<td></td>
														<td><input type="text" name="item_${p1.id }" id="item_${vitem.count }" value="" size="60" placeholder="输入答案" /></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr id="answerdiv_${vitem.count }" style="display: none" class="questionli"><td>答案: ${p1.answer }</td></tr>
									</c:if>
									
									<c:if test="${p1.quesType=='简答题' }">
										<tr id="questionli_${vitem.count }" style="display: none" class="questionli">
											<td>
												<table style="width: 100%" class="table table-striped table-hover table-bordered">
													<tr  style="background-color: #8E8E8E;color:white;">
														<td style="width:10%">${vitem.count }/${quesListSize }: <br/> [简答]</td>
														<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr id="answerdiv_${vitem.count }" style="display: none" class="questionli"><td>答案: 无</td></tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</form>
				</c:if>
			</div>
		</div>
	</div>
	<!-- javascript at the bottom for fast page loading -->
	<script type="text/javascript" src="${ctx }/qiantai/js/jquery.easing-sooper.js"></script>
	<script type="text/javascript" src="${ctx }/qiantai/js/jquery.sooperfish.js"></script>
	 
	<script type="text/javascript">
	 var total = ${quesListSize};
	 var currentIndex = 1;
	 $("#questionli_1").show();
	 function jiexi(){
		 tijiao();
		 $("#answerdiv_"+currentIndex).show();
	 }
	 function shang(){
		 tijiao();
		 if(currentIndex==1){
			 alert("没有上一题了");
			 return false; 
		 }
		 $(".questionli").hide();
		 currentIndex=currentIndex-1;
		 $("#questionli_"+currentIndex).show();
		 
	 }
	 function xia(){
		 tijiao();
		 if(currentIndex==total){
			 alert("没有下一题了");
			 return false; 
		 }
		 $(".questionli").hide();
		 currentIndex=currentIndex+1;
		 $("#questionli_"+currentIndex).show();
	 }
	 function tijiao(){
		 var rid = "item_"+currentIndex;
		 if($("#"+rid).length==0)return ;
		 var type = $("#"+rid).attr("type");
		 var list = "";
		 if("text"==type){
			 list = $("#"+rid).val();
		 }else{
			$('input:'+type+'[id="' + rid + '"]:checked').each(function(){
	           list+=$(this).val();
            });
		 }
		 if (list != "") {
			 var qid = $("#"+rid).attr("name");
			 $.ajax({
		     		url:"${ctx }/sys/lianxiAns.do",
		     		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		     		type:"post",
		     		dataType:"json",
		     		data:{"qid":qid,"ans":list},
		     		success:function(json){
		     		},
		     		error:function(json){}
			});
		 }
	 }
	</script>
</body>
</html>
