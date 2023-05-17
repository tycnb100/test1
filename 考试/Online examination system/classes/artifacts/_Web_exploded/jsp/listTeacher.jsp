<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageHeader">
	<form data-toggle="ajaxsearch" action="${ctx}/sys/query${actionclass}.do" id="pagefrom_${actionclass}">
		<div style="margin: 0; padding: 1px 5px 5px;">
			<span>工号:</span>
			<input type="text" name="s_uname" class="form-control" size="13">

			<span>姓名:</span>
			<input type="text" name="s_userName" class="form-control" size="13">

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
				<th width="10">
					<input type="checkbox" class="checkboxCtrl" data-group="ids" data-toggle="icheck">
				</th>
				<th width="50"></th>
				<th width="100">工号</th>
				<th width="100">姓名</th>
				<th width="100">性别</th>
				<th width="100">联系电话</th>
				<th width="100">邮箱</th>
				<th width="100">出生日期</th>
				<th width="100">联系地址</th>
				<th width="100">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${SESSION_PAGE.list}" var="item">
				<tr data-id="${item.id }">
					<td>
						<input type="checkbox" name="ids" data-toggle="icheck" value="${item.id }">
					</td>
					<td>
					<img alt="" src="${ctx}/resource/${item.photo}" style="border-radius:0.1em;" width="60px" onerror="javascript:this.src='${ctx}/resource/no.jpg'">
					</td>
					<td>${item.uname}</td>
					<td>${item.userName}</td>
					<td>${item.userGender}</td>
					<td>${item.userPhone}</td>
					<td>${item.userEmail}</td>
					<td>${item.userBirth}</td>
					<td>${item.userAddress}</td>
					<td>
						<a href="${ctx}/sys/get${actionclass}.do?uid=${item.id}" class="btn btn-green" data-toggle="navtab"
							data-options="{reloadWarn:''}" data-id="baseAdd" data-reload-warn="本页已有打开的内容，确定将刷新本页内容，是否继续？"
							data-title="更新${actionname}">查看</a>
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