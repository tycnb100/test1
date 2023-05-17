<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<%@ page import="com.ssm.util.Constant" %> 
<div class="bjui-pageContent">
	<form action="${ctx}/sys/add${actionclass}.do" id="j_custom_form" data-toggle="ajaxform">
		<div class="bjui-row col-3">
			<label class="row-label">所属科目</label>
			<div class="row-input">
				<select name="courseId" id="Paper_course" data-rule="required">
					<c:forEach items="${list }" var="item">
						<option value="${item.id }">${item.name }</option>
					</c:forEach>
				</select>
			</div>
			<br />

			<label class="row-label">试卷名称</label>
			<div class="row-input">
				<input type="text" name="name" id="Paper_name" value="${modifybean.name}" data-rule="required">
			</div>
			<br />

			<label class="row-label">考试时长(分钟)</label>
			<div class="row-input">
				<input type="text" name="examTime" id="Paper_examTime" value="${modifybean.examTime}" data-rule="required;digits">
			</div>
			<br />
			<label class="row-label">单选题数量</label>
			<div class="row-input">
				<input type="text" name="danxuan" id="danxuan" value="" data-rule="required;digits">
			</div>
			<label class="row-label">单选题分值</label>
			<div class="row-input">
				<input type="text" name="danxuanfen" id="danxuanfen" value="<%=Constant.danxuan %>" data-rule="required;digits">
			</div>
			<br />
			<label class="row-label">多选题数量</label>
			<div class="row-input">
				<input type="text" name="duoxuan" id="duoxuan" value="" data-rule="required;digits">
			</div>
			<label class="row-label">多选题分值</label>
			<div class="row-input">
				<input type="text" name="duoxuanfen" id="duoxuanfen" value="<%=Constant.duoxuan %>" data-rule="required;digits">
			</div>
			<br />
			<label class="row-label">判断题数量</label>
			<div class="row-input">
				<input type="text" name="panduan" id="panduan" value="" data-rule="required;digits">
			</div>
			<label class="row-label">判断题分值</label>
			<div class="row-input">
				<input type="text" name="panduanfen" id="panduanfen" value="<%=Constant.panduan %>" data-rule="required;digits">
			</div>
			<br />
			<label class="row-label">填空题数量</label>
			<div class="row-input">
				<input type="text" name="tiankong" id="tiankong" value="" data-rule="required;digits">
			</div>
			<label class="row-label">填空题分值</label>
			<div class="row-input">
				<input type="text" name="tiankongfen" id="tiankongfen" value="<%=Constant.tiankong %>" data-rule="required;digits">
			</div>
			<br />
			<label class="row-label">简答题数量</label>
			<div class="row-input">
				<input type="text" name="jianda" id="jianda" value="" data-rule="required;digits">
			</div>
			<label class="row-label">简答题分值</label>
			<div class="row-input">
				<input type="text" name="jiandafen" id="jiandafen" value="<%=Constant.jianda %>" data-rule="required;digits">
			</div>
			<br />

			<label class="row-label">有效</label>
			<div class="row-input">
				<select name="youxiao">
					<option value="是">是</option>
					<option value="否">否</option>
				</select>
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
