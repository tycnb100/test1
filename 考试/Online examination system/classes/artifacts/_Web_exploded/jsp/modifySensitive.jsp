<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageContent">
	<form action="${ctx}/sys/update${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<input type="hidden" value="${modifybean.id}" name="id"/>
		<div class="bjui-row col-3">
			<label class="row-label">敏感词</label>
			<div class="row-input">
				<input type="text" name="word" id="Sensitive_word" value="${modifybean.word}" data-rule="required">
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

</script>
