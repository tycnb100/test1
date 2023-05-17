<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/add${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<input type="hidden" value="${item.id}" name="clazzId"/>
		<div class="bjui-row col-3">
			<label class="row-label">班级</label>
			<div class="row-input">
				${item.name }
			</div><br />
			<label class="row-label">密码</label>
			<div class="row-input">
				<input type="text" name="pwd" id="pwd" value="" data-rule="required">
			</div><br />

		</div>
	</form>
	<table class="table table-bordered" data-toggle="tablefixed" data-width="100%" data-nowrap="true">
		<thead>
			<tr>
                <th>科目名称</th>
                <th>工号</th>
                <th>姓名</th>

            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${list}" var="item">
            <tr data-id="${item.id }">
				<td>${item.name}</td>
				<td>${item.teacher.uname}</td>
				<td>${item.teacher.userName}</td>

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
			<button type="submit" class="btn-default" data-icon="save">加入班级</button>
		</li>
	</ul>
</div>
