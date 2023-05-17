<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/add${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<div class="bjui-row col-3">
			<label class="row-label">科目名称</label>
			<div class="row-input">
				<input type="text" name="name" id="Course_name" value="${modifybean.name}" data-rule="required">
			</div><br />

			 
			<label class="row-label">授课教师</label>
			<div class="row-input">
				<select name="teacherId"  id="Course_teacher"  data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.fname }</option>
					</c:forEach>
				</select>
			</div><br />


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
