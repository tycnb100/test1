<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/update${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<input type="hidden" value="${modifybean.id}" name="id" />
		<div class="bjui-row col-3">
			<label class="row-label">科目</label>
			<div class="row-input">
				<select name="courseId" id="fsedrwer34444444444444" data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div>
			<br />


			<label class="row-label">题目类型</label>
			<div class="row-input">
				<select name="quesType" id="fsedrwer344444444444441" onchange="showrwe33()">
					<option value="单选题">单选题</option>
					<option value="多选题">多选题</option>
					<option value="判断题">判断题</option>
					<option value="填空题">填空题</option>
					<option value="简答题">简答题</option>
				</select>
			</div>
			<br />

			<label class="row-label">难度</label>
			<div class="row-input">
				<select name="userType" id="fsedrwer344444444444442">
					<option value="简单">简单</option>
					<option value="中等">中等</option>
					<option value="困难">困难</option>
				</select>
			</div>
			<br />

			<label class="row-label">分值</label>
			<div class="row-input">
				<input type="text" name="score" id="Question_score" value="${modifybean.score}" data-rule="required;digits"
					readonly="readonly">
			</div>
			<br />

			<label class="row-label">题目</label>
			<div class="row-input">
				<textarea rows="5" cols="100" name="title">${modifybean.title }</textarea>
			</div>
			<br />

			<label class="row-label">答案</label>
			<div class="row-input">
				<input type="text" name="answer" id="Question_answer" value="${modifybean.answer}" data-rule="required">
			</div>
			<br />

			<label class="row-label uuikeee">选项A</label>
			<div class="row-input uuikeee">
				<input type="text" name="option1" id="Question_option1" value="${modifybean.option1}" data-rule=""
					size="100">
			</div>
			<br />

			<label class="row-label uuikeee">选项B</label>
			<div class="row-input uuikeee">
				<input type="text" name="option2" id="Question_option2" value="${modifybean.option2}" data-rule=""
					size="100">
			</div>
			<br />

			<label class="row-label uuikeee">选项C</label>
			<div class="row-input uuikeee">
				<input type="text" name="option3" id="Question_option3" value="${modifybean.option3}" data-rule=""
					size="100">
			</div>
			<br />

			<label class="row-label uuikeee">选项D</label>
			<div class="row-input uuikeee">
				<input type="text" name="option4" id="Question_option4" value="${modifybean.option4}" data-rule=""
					size="100">
			</div>
			<br />

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
	$("#fsedrwer344444444444442").val("${modifybean.userType}");
	$("#fsedrwer344444444444441").val("${modifybean.quesType}");
	$("#fsedrwer34444444444444").val("${modifybean.course.id}");
</script>
<script>
	function showrwe33() {
		var temp = $("#fsedrwer344444444444441").val();
		if (temp == '判断题' || temp == '填空题' || temp == '简答题') {
			$(".uuikeee").each(function() {
				$(this).hide();
			});
			$("#Question_option1").val("");
			$("#Question_option2").val("");
			$("#Question_option3").val("");
			$("#Question_option4").val("");
		} else {
			$(".uuikeee").each(function() {
				$(this).show();
			});
		}
	}
	showrwe33();
</script>