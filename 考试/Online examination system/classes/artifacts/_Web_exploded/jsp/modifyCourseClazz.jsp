<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/addCourseClazz.do" id="j_custom_form" data-toggle="ajaxform">
		<input type="hidden" value="${modifybean.id}" name="courseId" />
		<div class="bjui-row col-3">
			<label class="row-label">课程</label>
			<div class="row-input">${modifybean.name }</div>
			<br />
			<label class="row-label">教师</label>
			<div class="row-input">${modifybean.teacher.fname }</div>
			<br />

			<label class="row-label">选择班级</label>
			<div class="row-input">
				<select name="clazzId" id="CourseClazz_clazz" data-rule="required">
					<c:forEach items="${clist }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div>
			<br />


		</div>
	</form>
	<table class="table table-bordered" data-toggle="tablefixed" data-width="100%" data-nowrap="true">
		<thead>
			<tr>
				<th>班级名称</th>

				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${cclist}" var="item">
				<tr data-id="${item.id }">
					<td>${item.clazz.name}</td>

					<td>
						<a href="${ctx}/sys/deleteCourseClazz.do?ids=${item.id}" class="btn btn-red" data-toggle="doajax"
							data-confirm-msg="确定要删除该行信息吗？">删除</a>
					</td>
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
			<button type="submit" class="btn-default" data-icon="save">添加上课班级</button>
		</li>
	</ul>
</div>
<script type="text/javascript">

</script>
