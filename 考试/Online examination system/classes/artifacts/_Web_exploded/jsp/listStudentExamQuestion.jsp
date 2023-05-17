<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageHeader">
	<form data-toggle="ajaxsearch" action="${ctx}/sys/query${actionclass}.do" id="pagefrom_${actionclass}">
		<div style="margin: 0; padding: 1px 5px 5px;">
			<span>:</span>
			<input type="text" name="s_" class="form-control" size="13">

<!-- 			<span>:</span> -->
<!-- 			 <select name="type"  class="form-control" data-toggle="selectpicker"> -->
<!--                 <option value="">全部</option> -->
<!--             </select>  -->

			<div class="btn-group">
				<button type="submit" class="btn-green" data-icon="search">搜索</button>
			</div>
			<!--             <button type="button" class="btn-blue" data-toggle="dialog" data-options="{url:'../../html/datagrid/datagrid-search-source.html', id:'dialog-datagrid-search', width:1000, height:600, title:'查看Datagrid示例- 页头搜索、自定义编辑 - 源码'}">点击查看示例源码</button> -->
			<div class="btn-group">
				<button type="button" class="btn-blue" data-url="${ctx}/sys/add2${actionclass}.do" data-toggle="navtab"
					data-options="{reloadWarn:''}" data-id="baseAdd" data-icon="plus" title="添加记录">添加${actionname}</button>
				&nbsp;
				<button type="button" class="btn-red" data-url="${ctx}/sys/delete${actionclass}.do" data-toggle="doajaxchecked"
					data-confirm-msg="确定要删除选中项吗？" data-idname="ids" data-group="ids" data-icon="remove" title="">批量删除</button>
				&nbsp;
			</div>
		</div>
	</form>
</div>
<div class="bjui-pageContent tableContent">
	<table class="table table-bordered" data-toggle="tablefixed" data-width="100%" data-nowrap="true">
		<thead>
			<tr>
				<th width="2%">
					<input type="checkbox" class="checkboxCtrl" data-group="ids" data-toggle="icheck">
				</th>
                <th>学号</th>
                <th>姓名</th>
                <th>专业</th>
                <th>班级</th>
                <th>科目名称</th>
                <th>工号</th>
                <th>姓名</th>
                <th>试卷编号</th>
                <th>试卷名称</th>
                <th>考试时长</th>
                <th>有效</th>
                <th>阅卷完毕</th>
                <th>客观题分值</th>
                <th>主观题分值</th>
                <th>总分</th>
                <th>考试日期</th>
                <th>工号</th>
                <th>姓名</th>
                <th>科目名称</th>
                <th>工号</th>
                <th>姓名</th>
                <th>工号</th>
                <th>姓名</th>
                <th>题目类型</th>
                <th>难度</th>
                <th>分值</th>
                <th>题目</th>
                <th>答案</th>
                <th>选项A</th>
                <th>选项B</th>
                <th>选项C</th>
                <th>选项D</th>
                <th>考生答案</th>
                <th>是否正确</th>
                <th>简答题得分</th>
                <th>题目分值</th>

                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${SESSION_PAGE.list}" var="item">
            <tr data-id="${item.id }">
            	<td>
					<input type="checkbox" name="ids" data-toggle="icheck" value="${item.id }">
				</td>
				<td>${item.exam.student.uname}</td>
				<td>${item.exam.student.userName}</td>
				<td>${item.exam.student.zhuanye}</td>
				<td>${item.exam.student.banji}</td>
				<td>${item.exam.paper.course.name}</td>
				<td>${item.exam.paper.course.teacher.uname}</td>
				<td>${item.exam.paper.course.teacher.userName}</td>
				<td>${item.exam.paper.sid}</td>
				<td>${item.exam.paper.name}</td>
				<td>${item.exam.paper.examTime}</td>
				<td>${item.exam.paper.youxiao}</td>
				<td>${item.exam.finished}</td>
				<td>${item.exam.keguan}</td>
				<td>${item.exam.zhuguan}</td>
				<td>${item.exam.zong}</td>
				<td>${item.exam.addDate}</td>
				<td>${item.exam.checkTeacher.uname}</td>
				<td>${item.exam.checkTeacher.userName}</td>
				<td>${item.question.course.name}</td>
				<td>${item.question.course.teacher.uname}</td>
				<td>${item.question.course.teacher.userName}</td>
				<td>${item.question.teacher.uname}</td>
				<td>${item.question.teacher.userName}</td>
				<td>${item.question.quesType}</td>
				<td>${item.question.userType}</td>
				<td>${item.question.score}</td>
				<td>${item.question.title}</td>
				<td>${item.question.answer}</td>
				<td>${item.question.option1}</td>
				<td>${item.question.option2}</td>
				<td>${item.question.option3}</td>
				<td>${item.question.option4}</td>
				<td>${item.answer}</td>
				<td>${item.correct}</td>
				<td>${item.jiandascore}</td>
				<td>${item.questionScore}</td>

                <td>
					<a href="${ctx}/sys/get${actionclass}.do?uid=${item.id}" class="btn btn-green" data-toggle="navtab"
						data-options="{reloadWarn:''}" data-id="baseAdd" data-reload-warn="本页已有打开的内容，确定将刷新本页内容，是否继续？"
						data-title="${actionname}信息">查看</a>
					<a href="${ctx}/sys/delete${actionclass}.do?ids=${item.id}" class="btn btn-red" data-toggle="doajax"
						data-confirm-msg="确定要删除该行信息吗？">删除</a>
				</td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<div class="bjui-pageFooter">
	<div data-toggle="pagination"
		data-options="{total:${SESSION_PAGE.totalNumber}, pageCurrent:${SESSION_PAGE.currentPageNumber}, form:'#pagefrom_${actionclass}'}">
	</div>
</div>
