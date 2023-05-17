<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageHeader">
	<form data-toggle="ajaxsearch" action="${ctx}/sys/query${actionclass}.do" id="pagefrom_${actionclass}">
		<div style="margin: 0; padding: 1px 5px 5px;">
			<span>题目:</span>
			<input type="text" name="s_title" class="form-control" size="13">
			<span>科目:</span>
			<select name="s_courseId" class="form-control" data-toggle="selectpicker">
					<option value="">全部</option> 
				<c:forEach items="${list }" var="item">
					<option value="${item.id }">${item.name }</option>
				</c:forEach>
			</select>
			<span>题目类型:</span>
			 <select name="s_quesType"  class="form-control" data-toggle="selectpicker">
			 	<option value="">全部</option> 
                <option value="单选题">单选题</option>
                <option value="多选题">多选题</option>
                <option value="判断题">判断题</option>
                <option value="填空题">填空题</option>
                <option value="简答题">简答题</option>
            </select> 

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
                <th>科目名称</th>
                <th>题目类型</th>
                <th>难度</th>
                <th>分值</th>
                <th width="600">题目</th>
                <th>答案</th>
                <th>选项A</th>
                <th>选项B</th>
                <th>选项C</th>
                <th>选项D</th>

                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${SESSION_PAGE.list}" var="item">
            <tr data-id="${item.id }">
            	<td>
					<input type="checkbox" name="ids" data-toggle="icheck" value="${item.id }">
				</td>
				<td>${item.course.name}</td>
				<td>${item.quesType}</td>
				<td>${item.userType}</td>
				<td>${item.score}</td>
				<td>${item.title}</td>
				<td>${item.answer}</td>
				<td>${item.option1}</td>
				<td>${item.option2}</td>
				<td>${item.option3}</td>
				<td>${item.option4}</td>

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
