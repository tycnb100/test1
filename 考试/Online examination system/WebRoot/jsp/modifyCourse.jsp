<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/update${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<input type="hidden" value="${modifybean.id}" name="id" />
		<div class="bjui-row col-3">
			<label class="row-label">科目名称</label>
			<div class="row-input">
				<input type="text" name="name" id="Course_name" value="${modifybean.name}" data-rule="required">
			</div>
			<br />

			<label class="row-label">授课教师</label>
			<div class="row-input">
				<select name="teacherId" id="Course_teacher" data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.fname }</option>
					</c:forEach>
				</select>
			</div>
			<br />



		</div>
	</form>
	<table class="table table-bordered" data-toggle="tablefixed" data-width="100%" data-nowrap="true">
		<thead>
			<tr>
				<th width="100">班级</th>
				<th width="100">学号</th>
				<th width="100">姓名</th>
				<th width="100">性别</th>
				<th width="100">联系电话</th>
				<th width="100">邮箱</th>
				<th width="100">出生日期</th>
				<th width="100">联系地址</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${stuList}" var="item">
				<tr data-id="${item.id }">
					<td>${item.clazz.name}</td>
					<td>${item.uname}</td>
					<td>${item.userName}</td>
					<td>${item.userGender}</td>
					<td>${item.userPhone}</td>
					<td>${item.userEmail}</td>
					<td>${item.userBirth}</td>
					<td>${item.userAddress}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
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
<script type="text/javascript">
	$("#Course_teacher").val("${modifybean.teacher.id}");
</script>
