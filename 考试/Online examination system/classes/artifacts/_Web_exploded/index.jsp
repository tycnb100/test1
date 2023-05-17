<%@ page pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="./common/head.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>${appTitle }</title>
<link rel="stylesheet" href="${ctx}/static/login/css/style.css">
<body>
	<div class="login-container">
		<h1>${appTitle }</h1>
		<div class="connect">
			<p style="color: #ff7575">${signErrorMessage }</p>
		</div>
		<form action="${ctx}/com/login.do" method="post" id="loginForm">
			<div>
				<input type="text" name="username" class="username" placeholder="用户名" autocomplete="off" value="">
			</div>
			<div>
				<input type="password" name="password" class="password" placeholder="密码" oncontextmenu="return false"
					onpaste="return false">
			</div>
			<div>
				<input type="text" name="checkcode" class="code" placeholder="验证码" autocomplete="off" value="">
			</div>
			<div>
				<select name="loginType" class="username" style="float: left;width:35%;margin-left: 1px">
					<option value="SysUser">&nbsp;&nbsp;&nbsp;管理员</option>
					<option value="SimpleUser">&nbsp;&nbsp;&nbsp;学生</option>
					<option value="Teacher">&nbsp;&nbsp;&nbsp;教师</option>
				</select>
				<a href="javascript:void(0);">
					<img style="border: 0px; margin-top: 10px; margin-left: 25px;float: left" width="55%" height="40px"
						src="${pageContext.request.contextPath }/checkcode" alt="验证码" align="left"
						onclick="this.src = '${pageContext.request.contextPath }/checkcode?' + Math.random();" />
				</a>
			</div>
			<div>
				
			</div>
			<button id="submit" type="submit">登 陆</button>
		</form>
		<a href="${ctx}/reg.jsp">
<!-- 			<button type="button" class="register-tis">还有没有账号？</button> -->
		</a>
	</div>
</body>
<script src="${ctx}/static/login/js/jquery/1.11.1/jquery.min.js"></script>
<script src="${ctx}/static/login/js/common.js"></script>
<script src="${ctx}/static/login/js/supersized.3.2.7.min.js"></script>
<script src="${ctx}/static/login/js/supersized-init.js"></script>
<script src="${ctx}/static/login/js/jquery.validate.min.js"></script>
</html>

<%
	session.removeAttribute("signErrorMessage");
%>