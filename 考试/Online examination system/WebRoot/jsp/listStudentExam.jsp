<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageHeader">
	<form data-toggle="ajaxsearch" action="${ctx}/sys/query${actionclass}.do" id="pagefrom_${actionclass}">
		<div style="margin: 0; padding: 1px 5px 5px;">

			<span>阅卷:</span>
			 <select name="type"  class="form-control" data-toggle="selectpicker">
                <option value="">全部</option>
                <option value="未阅卷">未阅卷</option>
                <option value="已阅卷">已阅卷</option>
            </select> 

			<div class="btn-group">
				<button type="submit" class="btn-green" data-icon="search">搜索</button>
			</div>
			<!--             <button type="button" class="btn-blue" data-toggle="dialog" data-options="{url:'../../html/datagrid/datagrid-search-source.html', id:'dialog-datagrid-search', width:1000, height:600, title:'查看Datagrid示例- 页头搜索、自定义编辑 - 源码'}">点击查看示例源码</button> -->
			<div class="btn-group">
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
                <th>班级</th>
                <th>科目名称</th>
                <th>试卷编号</th>
                <th>试卷名称</th>
                <th>考试时长</th>
                <th>阅卷完毕</th>
                <th>客观题分值</th>
                <th>主观题分值</th>
                <th>总分</th>
                <th>考试日期</th>
                <th>阅卷教师</th>

                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${SESSION_PAGE.list}" var="item">
            <tr data-id="${item.id }">
            	<td>
					<input type="checkbox" name="ids" data-toggle="icheck" value="${item.id }">
				</td>
				<td>${item.student.uname}</td>
				<td>${item.student.userName}</td>
				<td>${item.student.clazz.name}</td>
				<td>${item.paper.course.name}</td>
				<td>${item.paper.sid}</td>
				<td>${item.paper.name}</td>
				<td>${item.paper.examTime}</td>
				<td>${item.finished}</td>
				<td>${item.keguan}</td>
				<td>${item.zhuguan}</td>
				<td>${item.zong}</td>
				<td>${item.addDate}</td>
				<td>${item.checkTeacher.fname}</td>

                <td>
					<a href="${ctx}/sys/getStudentExamSelf.do?uid=${item.id}" class="btn btn-green" target="_selfexam">查看</a>
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
