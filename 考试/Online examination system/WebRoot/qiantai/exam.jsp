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
							<c:if test="${not empty paper }">
								<li style=""><a href="#" style="color: white">[考试科目: ${paper.course.name}], [试卷编号: ${paper.sid}]</a></li>
							</c:if>
						</c:if>
					</ul>
				</div>
			</nav>
		</header>
		<div id="site_content">
			<div class="content" style="width: 100%">
				<h3>
					在线考试
					<c:if test="${closeable}">
						<a href="javascript:;" onclick="javascript:window.close()" style="margin-left: 20px; color: red">关闭页面</a>
					</c:if>
					<c:if test="${empty SESSION_BEAN }">
						<span style="color: red">请先登录后答题</span>
					</c:if>
				</h3>
				<c:if test="${empty paper }">
				</c:if>
				<c:if test="${not empty paper }">
					<%int questionExamIndex = 1; %>
					<form action="${ctx}/sys/finishExam.do" method="post" id="voteform">
						<input type="hidden" name="uid" value="${paper.id }" />
						<table style="width: 100%" class="table table-striped table-hover table-bordered">
							<tbody>
								<c:forEach items="${danxuanlist_exam }" var="p1">
									<tr >
										<td>
											<table style="width: 100%" class="table table-striped table-hover table-bordered">
												<tr  style="background-color: #8E8E8E;color:white;">
													<td style="width:10%"><%=questionExamIndex++ %>: <br/> [单选]</td>
													<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${p1.id }" value="A" /> A:</td>
													<td>${p1.option1 }</td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${p1.id }" value="B" /> B:</td>
													<td>${p1.option2 }</td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${p1.id }" value="C" /> C:</td>
													<td>${p1.option3 }</td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${p1.id }" value="D" /> D:</td>
													<td>${p1.option4 }</td>
												</tr>
											</table>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<table style="width: 100%" class="table table-striped table-hover table-bordered">
							<tbody>
								<c:forEach items="${duoxuanlist_exam }" var="p1">
									<tr>
										<td>
											<table style="width: 100%" class="table table-striped table-hover table-bordered">
												<tr  style="background-color: #8E8E8E;color:white;">
													<td style="width:10%"><%=questionExamIndex++ %>: <br/> [多选]</td>
													<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
												</tr>
												<tr>
													<td><input type="checkbox" name="item_${p1.id }" id="item_${p1.id }" value="A" /> A:</td>
													<td>${p1.option1 }</td>
												</tr>
												<tr>
													<td><input type="checkbox" name="item_${p1.id }" id="item_${p1.id }" value="B" /> B:</td>
													<td>${p1.option2 }</td>
												</tr>
												<tr>
													<td><input type="checkbox" name="item_${p1.id }" id="item_${p1.id }" value="C" /> C:</td>
													<td>${p1.option3 }</td>
												</tr>
												<tr>
													<td><input type="checkbox" name="item_${p1.id }" id="item_${p1.id }" value="D" /> D:</td>
													<td>${p1.option4 }</td>
												</tr>
											</table>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<table style="width: 100%" class="table table-striped table-hover table-bordered">
							<tbody>
								<c:forEach items="${panduanlist_exam }" var="p1">
									<tr>
										<td>
											<table style="width: 100%" class="table table-striped table-hover table-bordered">
												<tr  style="background-color: #8E8E8E;color:white;">
													<td style="width:10%"><%=questionExamIndex++ %>: <br/> [判断]</td>
													<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${p1.id }" value="1" /></td>
													<td>正确</td>
												</tr>
												<tr>
													<td><input type="radio" name="item_${p1.id }" id="item_${p1.id }" value="0" /></td>
													<td>错误</td>
												</tr>
											</table>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<table style="width: 100%" class="table table-striped table-hover table-bordered">
							<tbody>
								<c:forEach items="${tiankonglist_exam }" var="p1">
									<tr>
										<td>
											<table style="width: 100%" class="table table-striped table-hover table-bordered">
												<tr  style="background-color: #8E8E8E;color:white;">
													<td style="width:10%"><%=questionExamIndex++ %>: <br/> [填空]</td>
													<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
												</tr>
												<tr>
													<td></td>
													<td><input type="text" name="item_${p1.id }" id="item_${p1.id }" value="" size="60" placeholder="输入答案" /></td>
												</tr>
											</table>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<table style="width: 100%" class="table table-striped table-hover table-bordered">
							<tbody>
								<c:forEach items="${jiandalist_exam }" var="p1">
									<tr>
										<td>
											<table style="width: 100%" class="table table-striped table-hover table-bordered">
												<tr  style="background-color: #8E8E8E;color:white;">
													<td style="width:10%"><%=questionExamIndex++ %>: <br/> [简答]</td>
													<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.title }</a></td>
												</tr>
												<tr>
													<td></td>
													<td><textarea rows="15" cols="60" name="item_${p1.id }" id="item_${p1.id }" placeholder="输入答案" style="width:100%"></textarea></td>
												</tr>
											</table>
										</td>
									</tr>
									
								</c:forEach>
							</tbody>
						</table>
						<input type="button" onclick="checkFormRadio()" value="提交试卷" class="button orange">
						<div id="editInfo" style="float: right; width: 300px; position: absolute; top: 200px; left: 20px; color: red">
							<c:if test="${not empty paper }">倒计时: <input type="text" name="mss" id="mss" readonly="readonly" />
							</c:if>
						</div>
					</form>
					
					<script type="text/javascript">
					<!--
						window.onload = function() {
							daojishi();
						};
						var counttime = ${sessionScope.examtime} ;//总秒钟
						function daojishi() {
							if (counttime >= 0) {
								var ms = counttime % 60;//余数 89%60==29秒
								var mis = Math.floor(counttime / 60);//分钟
								if (mis >= 60) {
									var hour = Math.floor(mis / 60);
									mis = Math.floor((counttime - hour * 60 * 60) / 60);
									document.getElementById("mss").value = hour+ "小时 " + mis + "分 " + ms + "秒";
								} else if (mis >= 1) {
									document.getElementById("mss").value = mis+ "分 " + ms + "秒";
								} else {
									document.getElementById("mss").value = ms+ "秒";
								}
								counttime--;
								vartt = window.setTimeout("daojishi()", 1000);
							} else {
								window.clearTimeout(vartt);
								tijiao();
							}
						}
						function tijiao() {
							document.forms[0].submit();
						}
						$(function() {
							$(window).scroll(function() {
							var top = $(window).scrollTop()+200;
							var left= $(window).scrollLeft()+20;
							$("#editInfo").css({ left:left + "px", top: top + "px" });
							});
						});
						function flushexamtime(){
							$.ajax({
					     		url:"${ctx}/sys/flushtime.do",
					     		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
					     		type:"post",
					     		dataType:"json",
					     		data:{},
					     		success:function(json){
					     			 
					     		},
					     		error:function(json){}
							});
							window.setTimeout("flushexamtime()", 1000*60*2);
						}
						window.setTimeout("flushexamtime()", 1000);
					//-->
					</script>
				</c:if>
			</div>
		</div>
		<div id="scroll">
			<a title="Scroll to the top" class="top" href="#"><img src="${ctx }/qiantai/images/top.png" alt="top" /></a>
		</div>
	</div>
	<!-- javascript at the bottom for fast page loading -->
	<script type="text/javascript" src="${ctx }/qiantai/js/jquery.easing-sooper.js"></script>
	<script type="text/javascript" src="${ctx }/qiantai/js/jquery.sooperfish.js"></script>
	<script type="text/javascript">
		var editor = new Array(); 
		
		var textareas = $("textarea");
		//根据 name集合长度 遍历name集合  
	
		KindEditor.ready(function(K) {
			for (var i = 0; i < textareas.length; i++) {
				var rid = textareas[i].id;
				editor[i] = K.create('#' + rid, {
					uploadJson : '${ctx}/qiantai/js/kindeditor/jsp/upload_json.jsp',
					fileManagerJson : '${ctx}/qiantai/js/kindeditor/jsp/file_manager_json.jsp',
					allowFileManager : false,
					afterCreate : function() {
						this.sync();
					},
					afterBlur : function() {
						this.sync();
					}
				});
			}
	
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('ul.sf-menu').sooperfish();
			$('.top').click(function() {
				$('html, body').animate({
					scrollTop : 0
				}, 'fast'); return false;
			});
		});
	</script>
	<script type="text/javascript">
		function checkFormRadio() {
			for(var i = 0;i < editor.length;i++){
				editor[i].sync();
			}
			
			var count = 0;
			var radios = $("input[type='radio']");
			var first = null;
			//根据 name集合长度 遍历name集合  
			for (var i = 0; i < radios.length; i++) {
				var rid = radios[i].id;
				var list = $('input:radio[id="' + rid + '"]:checked').val();
				if (list == null) {
					count++;
					if (first == null) {
						first = rid;
					}
	
				}
	
			}
			var checkboxs = $("input[type='checkbox']");
			//根据 name集合长度 遍历name集合  
			for (var i = 0; i < checkboxs.length; i++) {
				var rid = checkboxs[i].id;
				var list = $('input:checkbox[id="' + rid + '"]:checked').val();
				if (list == null) {
					count++;
					if (first == null) {
						first = rid;
					}
	
				}
	
			}
			var texts = $("input[type='text']");
			//根据 name集合长度 遍历name集合  
			for (var i = 0; i < texts.length; i++) {
				var rid = texts[i].id;
				var list = $('input:text[id="' + rid + '"]').val();
				if (list == null || list == "") {
					count++;
					if (first == null) {
						first = rid;
					}
	
				}
	
			}
			var textareas = $("textarea[name^='item_']");
			//根据 name集合长度 遍历name集合  
			for (var i = 0; i < textareas.length; i++) {
				var rid = textareas[i].id;
				var list = $('textarea[id="' + rid + '"]').val();
				if (list == null || list == "") {
					count++;
					if (first == null) {
						first = rid;
					}
				}
			}
			if (count > 0) {
				first = "itemTitle_" + first;
				if (!$("#" + first).length) {
					first = "elseitems";
				}
	
				alert("您还没有回答所有问题");
				$("html,body").animate({
					scrollTop : $("#" + first).offset().top
				}, 1000);
				return false;
			}
			$("#voteform").submit();
			return true;
		}
	</script>
	<c:if test="${not empty VoteErrorMessage}">
		<script type="text/javascript">
			$(function() {
				alert("${VoteErrorMessage}");
			});
		</script>
	</c:if>
	<%
		session.removeAttribute("VoteErrorMessage");
	%>
</body>
</html>
