<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/add${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<div class="bjui-row col-3">
			<label class="row-label">试卷</label>
			<div class="row-input">
				<select name="paperId"  id="PaperQuestion_paper"  data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div><br />

			<label class="row-label">题目</label>
			<div class="row-input">
				<select name="questionId"  id="PaperQuestion_question"  data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div><br />

			<label class="row-label">分值</label>
			<div class="row-input">
				<input type="text" name="questionScore" id="PaperQuestion_questionScore" value="${modifybean.questionScore}" data-rule="required;digits">
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
