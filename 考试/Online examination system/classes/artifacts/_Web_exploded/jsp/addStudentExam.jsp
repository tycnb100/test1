<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/add${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<div class="bjui-row col-3">
			<label class="row-label">学生</label>
			<div class="row-input">
				<select name="studentId"  id="StudentExam_student"  data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div><br />

			<label class="row-label">试卷</label>
			<div class="row-input">
				<select name="paperId"  id="StudentExam_paper"  data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div><br />

			<label class="row-label">阅卷完毕</label>
			<div class="row-input">
				<input type="text" name="finished" id="StudentExam_finished" value="${modifybean.finished}" data-rule="required">
			</div><br />

			<label class="row-label">客观题分值</label>
			<div class="row-input">
				<input type="text" name="keguan" id="StudentExam_keguan" value="${modifybean.keguan}" data-rule="required;digits">
			</div><br />

			<label class="row-label">主观题分值</label>
			<div class="row-input">
				<input type="text" name="zhuguan" id="StudentExam_zhuguan" value="${modifybean.zhuguan}" data-rule="required;digits">
			</div><br />

			<label class="row-label">总分</label>
			<div class="row-input">
				<input type="text" name="zong" id="StudentExam_zong" value="${modifybean.zong}" data-rule="required;digits">
			</div><br />

			<label class="row-label">考试日期</label>
			<div class="row-input">
				<input type="text" name="addDate" id="StudentExam_addDate" value="${modifybean.addDate}"
					data-toggle="datepicker" data-pattern="yyyy-MM-dd" readonly="readonly" data-rule="required">
			</div><br />

			<label class="row-label">阅卷教师</label>
			<div class="row-input">
				<select name="checkTeacherId"  id="StudentExam_checkTeacher"  data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
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
