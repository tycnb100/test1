<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/add${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<div class="bjui-row col-3">
			<label class="row-label">班级</label>
			<div class="row-input">
				<select name="clazzId" class="">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div>
			<label class="row-label">学号</label>
			<div class="row-input required">
				<input type="text" name="uname" id="${actionclass}_uname" value="${modifybean.uname}" data-rule="required">
			</div>

			<label class="row-label">密码</label>
			<div class="row-input required">
				<input type="password" name="userPassword" id="${actionclass}_userPassword" value="${modifybean.userPassword}"
					data-rule="required">
			</div>

			<label class="row-label">姓名</label>
			<div class="row-input required">
				<input type="text" name="userName" id="${actionclass}_userName" value="${modifybean.userName}" data-rule="required">
			</div>

			<label class="row-label">性别</label>
			<div class="row-input">
				<select name="userGender" id="${actionclass}_userGender" data-toggle="selectpicker" data-rule="required">
					<option value="女">女</option>
					<option value="男">男</option>
				</select>
			</div>

			<label class="row-label">联系电话</label>
			<div class="row-input">
				<input type="text" name="userPhone" id="${actionclass}_userPhone" value="${modifybean.userPhone}" data-rule="mobile"
					maxlength="11">
			</div>

			<label class="row-label">邮箱</label>
			<div class="row-input">
				<input type="text" name="userEmail" id="${actionclass}_userEmail" value="${modifybean.userEmail}" data-rule="email">
			</div>

			<label class="row-label">出生日期</label>
			<div class="row-input">
				<input type="text" name="userBirth" id="${actionclass}_userBirth" value="${modifybean.userBirth}"
					data-toggle="datepicker" data-pattern="yyyy-MM-dd" readonly="readonly" data-rule="">
			</div>

			<label class="row-label">联系地址</label>
			<div class="row-input">
				<input type="text" name="userAddress" id="${actionclass}_userAddress" value="${modifybean.userAddress}" data-rule="">
			</div>
		</div>
	</form>
</div>
<div class="bjui-pageFooter">
	<ul>
		<li>
			<button type="button" class="btn-close" data-icon="close">取消</button>
		</li>
		<li>
			<button type="submit" class="btn-default" data-icon="save">保存</button>
		</li>
	</ul>
</div>