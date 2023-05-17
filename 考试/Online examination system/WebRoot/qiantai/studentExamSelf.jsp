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
<!-- modernizr enables HTML5 elements and feature detects -->
<script type="text/javascript" src="${ctx }/qiantai/js/modernizr-1.5.min.js"></script>
<style type="text/css">
<!--
body {
	font-family: "微软雅黑"
}
</style>
</head>
<body>
	<div id="main">
		<header>
			<nav>
				<div id="menu_container">
					<ul class="sf-menu" id="nav" style="float: left">
						<c:if test="${not empty SESSION_BEAN }">
							<li style="width: 300px;"><a href="#" style="color: red">欢迎您: ${SESSION_BEAN.user.userName }</a></li>
						</c:if>
					</ul>
				</div>
			</nav>
		</header>
		<div id="site_content" style="overflow: inherit">
			<div class="content" style="width: 100%">
				<form action="${ctx }/sys/updateStudentExam.do" method="post" id="voteform">
					<input type="hidden" name="uid" value="${modifybean.id }" />
					<h3>${modifybean.student.userName }
						阅卷情况
						<c:if test="${empty SESSION_BEAN }">
							<span style="color: red">请先登录后查看</span>
						</c:if>
					</h3>
					<%int questionExamIndex = 1;%>
					<table style="width: 100%" class="table table-striped table-hover table-bordered">
						<tbody>
							<c:forEach items="${danxuanlist }" var="p1">
								<tr>
									<td>
										<table style="width: 100%" class="table table-striped table-hover table-bordered">
											<tr style="background-color: #8E8E8E;color:white;">
												<td style="width: 10%"><%=questionExamIndex++ %>: <br/> [单选]</td>
												<td style="width: 89%">
													<a id="itemTitle_item_${p1.id }"> ${p1.question.title }</a> <span style="color: orange;"><c:if
															test="${p1.correct}">正确</c:if> <c:if test="${!p1.correct }">错误</c:if></span>
												</td>
											</tr>
											<tr>
												<td></td>
												<td>
													正确答案: ${p1.question.answer}<br /> 学生答案: ${p1.answer }
												</td>
											</tr>
											<tr>
												<td>A:</td>
												<td>${p1.question.option1 }</td>
											</tr>
											<tr>
												<td>B:</td>
												<td>${p1.question.option2 }</td>
											</tr>
											<tr>
												<td>C:</td>
												<td>${p1.question.option3 }</td>
											</tr>
											<tr>
												<td>D:</td>
												<td>${p1.question.option4 }</td>
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<table style="width: 100%" class="table table-striped table-hover table-bordered">
						<tbody>
							<c:forEach items="${duoxuanlist }" var="p1">
								<tr>
									<td>
										<table style="width: 100%" class="table table-striped table-hover table-bordered">
											<tr  style="background-color: #8E8E8E;color:white;">
												<td style="width: 10%"><%=questionExamIndex++ %>: <br/> [多选]</td>
												<td style="width: 89%">
													<a id="itemTitle_item_${p1.id }"> ${p1.question.title }</a> <span style="color: orange;"><c:if
															test="${p1.correct}">正确</c:if> <c:if test="${!p1.correct }">错误</c:if></span>
												</td>
											</tr>
											<tr>
												<td></td>
												<td>
													正确答案: ${p1.question.answer}<br /> 学生答案: ${p1.answer }
												</td>
											</tr>
											<tr>
												<td>A:</td>
												<td>${p1.question.option1 }</td>
											</tr>
											<tr>
												<td>B:</td>
												<td>${p1.question.option2 }</td>
											</tr>
											<tr>
												<td>C:</td>
												<td>${p1.question.option3 }</td>
											</tr>
											<tr>
												<td>D:</td>
												<td>${p1.question.option4 }</td>
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<table style="width: 100%" class="table table-striped table-hover table-bordered">
						<tbody>
							<c:forEach items="${panduanlist }" var="p1">
								<tr>
									<td>
										<table style="width: 100%" class="table table-striped table-hover table-bordered">
											<tr  style="background-color: #8E8E8E;color:white;">
												<td style="width: 10%"><%=questionExamIndex++ %>: <br/> [判断]</td>
												<td style="width: 89%">
													<a id="itemTitle_item_${p1.id }"> ${p1.question.title }</a> <span style="color: orange;"><c:if
															test="${p1.correct}">正确</c:if> <c:if test="${!p1.correct }">错误</c:if></span>
												</td>
											</tr>
											<tr>
												<td></td>
												<td>
													正确答案: <c:if test="${p1.question.answer=='1' }">正确</c:if> <c:if test="${p1.question.answer=='0' }">错误</c:if><br /> 
													学生答案: <c:if test="${p1.answer=='1' }">正确</c:if> <c:if test="${p1.answer=='0' }">错误</c:if>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<table style="width: 100%" class="table table-striped table-hover table-bordered">
						<tbody>
							<c:forEach items="${tiankonglist }" var="p1">
								<tr>
									<td>
										<table style="width: 100%" class="table table-striped table-hover table-bordered">
											<tr  style="background-color: #8E8E8E;color:white;">
												<td style="width: 10%"><%=questionExamIndex++ %>: <br/> [填空]</td>
												<td style="width: 89%">
													<a id="itemTitle_item_${p1.id }"> ${p1.question.title }</a> <span style="color: orange;"><c:if
															test="${p1.correct}">正确</c:if> <c:if test="${!p1.correct }">错误</c:if></span>
												</td>
											</tr>
											<tr>
												<td></td>
												<td>
													正确答案: ${p1.question.answer}<br /> 学生答案: ${p1.answer }
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					 <table style="width: 100%" class="table table-striped table-hover table-bordered">
							<tbody>
								<c:forEach items="${jiandalist }" var="p1">
									<tr>
										<td>
											<table style="width: 100%" class="table table-striped table-hover table-bordered">
												<tr  style="background-color: #8E8E8E;color:white;">
													<td style="width:10%"><%=questionExamIndex++ %>: <br/> [简答]</td>
													<td style="width:89%"><a id="itemTitle_item_${p1.id }"> ${p1.question.title }</a> <c:if test="${p1.exam.finished=='未阅卷'}">未阅卷</c:if></td>
												</tr>
												<tr>
													<td></td>
													<td>${p1.answer }</td>
												</tr>
											</table>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					 
					 
				</form>
			</div>
		</div>
		<div id="scroll">
			<a title="Scroll to the top" class="top" href="#"><img src="${ctx }/qiantai/images/top.png" alt="top" /></a>
		</div>
	</div>
	<!-- javascript at the bottom for fast page loading -->
	<script type="text/javascript" src="${ctx }/qiantai/js/jquery.js"></script>
	<script type="text/javascript" src="${ctx }/qiantai/js/jquery.easing-sooper.js"></script>
	<script type="text/javascript" src="${ctx }/qiantai/js/jquery.sooperfish.js"></script>
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
		function showanswer() {
			var spananswer = $(".spananswer");
			for (var i = 0; i < spananswer.length; i++) {
				var rid = spananswer[i].id;
				$("#" + rid).show();
			}
		}
		function checkFormRadio() {
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
