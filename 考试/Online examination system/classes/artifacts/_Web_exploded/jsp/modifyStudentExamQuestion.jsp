<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/update${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<input type="hidden" value="${modifybean.id}" name="id"/>
		<div class="bjui-row col-3">
			<label class="row-label">考试</label>
			<div class="row-input">
				<select name="examId"  id="StudentExamQuestion_exam"  data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div><br />

			<label class="row-label">题目</label>
			<div class="row-input">
				<select name="questionId"  id="StudentExamQuestion_question"  data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div><br />

			<label class="row-label">考生答案</label>
			<div class="row-input">
				<input type="text" name="answer" id="StudentExamQuestion_answer" value="${modifybean.answer}" data-rule="required">
			</div><br />

			<label class="row-label">是否正确</label>
			<div class="row-input">
				<select name="correct" id="StudentExamQuestion_correct" data-toggle="selectpicker" data-rule="required">
					<option value="1111">1111</option>
					<option value="1111">1111</option>
				</select>
			</div><br />

			<label class="row-label">简答题得分</label>
			<div class="row-input">
				<input type="text" name="jiandascore" id="StudentExamQuestion_jiandascore" value="${modifybean.jiandascore}" data-rule="required;digits">
			</div><br />

			<label class="row-label">题目分值</label>
			<div class="row-input">
				<input type="text" name="questionScore" id="StudentExamQuestion_questionScore" value="${modifybean.questionScore}" data-rule="required;digits">
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
<script type="text/javascript">
$("#StudentExamQuestion_correct").val("${modifybean.correct}");
$("#StudentExamQuestion_question").val("${modifybean.question.id}");
$("#StudentExamQuestion_exam").val("${modifybean.exam.id}");

</script>
