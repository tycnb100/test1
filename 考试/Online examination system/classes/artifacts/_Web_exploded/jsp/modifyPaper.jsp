<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/update${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<input type="hidden" value="${modifybean.id}" name="id"/>
		<div class="bjui-row col-3">
			<label class="row-label">所属科目</label>
			<div class="row-input">
				${modifybean.course.name }
			</div><br />

			<label class="row-label">试卷编号</label>
			<div class="row-input">
				<input type="text" name="sid" id="Paper_sid" value="${modifybean.sid}" data-rule="required" readonly="readonly">
			</div><br />

			<label class="row-label">试卷名称</label>
			<div class="row-input">
				<input type="text" name="name" id="Paper_name" value="${modifybean.name}" data-rule="required">
			</div><br />

			<label class="row-label">考试时长</label>
			<div class="row-input">
				<input type="text" name="examTime" id="Paper_examTime" value="${modifybean.examTime}" data-rule="required;digits">
			</div><br />

			<label class="row-label">有效</label>
			<div class="row-input">
				<select name="youxiao" id="hklj3k4lj32l4kj23lk">
					<option value="是">是</option>
					<option value="否">否</option>
				</select>
			</div>
			<br />


		</div>
	</form>
	<table class="table table-bordered" data-toggle="tablefixed" data-width="100%" data-nowrap="true">
		<thead>
			<tr>
                <th>题目类型</th>
                <th>难度</th>
                <th>分值</th>
                <th width="600">题目</th>
                <th>答案</th>
                <th>选项A</th>
                <th>选项B</th>
                <th>选项C</th>
                <th>选项D</th>

            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${qlist}" var="item">
            <tr data-id="${item.id }">
				<td>${item.question.quesType}</td>
				<td>${item.question.userType}</td>
				<td>${item.question.score}</td>
				<td>${item.question.title}</td>
				<td>${item.question.answer}</td>
				<td>${item.question.option1}</td>
				<td>${item.question.option2}</td>
				<td>${item.question.option3}</td>
				<td>${item.question.option4}</td>

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
$("#hklj3k4lj32l4kj23lk").val("${modifybean.youxiao}");

</script>
