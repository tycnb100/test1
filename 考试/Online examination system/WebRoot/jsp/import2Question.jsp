<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/importQuestion.do" id="j_custom_form" data-toggle="ajaxform">
		<div class="bjui-row col-3">
			<label class="row-label">科目</label>
			<div class="row-input">
				<select name="courseId" id="Question_course" data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div>
			<br />

			 <label class="row-label">Excel文件</label>
			<div class="row-input">
				<input type="file" data-name="excelFile" name="excelFile" data-toggle="webuploader"
					data-options="
		               {
		                   pick: {label: '点击选择文件'},
		                   server: '${ctx}/com/fileUpload.do',
		                   fileNumLimit: 1,
		                   formData: {dir:'upload'},
		                   required: true,
		                   uploaded: '',
		                   basePath: '',
		                   upunit: '个文件',
		                   accept: {
		                       title: '文件',
		                       extensions: 'xls',
		                       mimeTypes: '.xls'
		                   }
		               }">
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