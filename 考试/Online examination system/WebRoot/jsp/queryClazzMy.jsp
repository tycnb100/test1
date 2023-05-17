<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageHeader">
	<form data-toggle="ajaxsearch" action="${ctx}/sys/queryClazzMy.do" id="pagefrom_${actionclass}">
		<div style="margin: 0; padding: 1px 5px 5px;">

<!-- 			<span>:</span> -->
<!-- 			 <select name="type"  class="form-control" data-toggle="selectpicker"> -->
<!--                 <option value="">全部</option> -->
<!--             </select>  -->

			<div class="btn-group">
				<button type="submit" class="btn-green" data-icon="search">搜索</button>
			</div>
			<!--             <button type="button" class="btn-blue" data-toggle="dialog" data-options="{url:'../../html/datagrid/datagrid-search-source.html', id:'dialog-datagrid-search', width:1000, height:600, title:'查看Datagrid示例- 页头搜索、自定义编辑 - 源码'}">点击查看示例源码</button> -->
			<div class="btn-group">
			</div>
		</div>
	</form>
</div>
<div class="bjui-pageContent tableContent">
	<table class="table table-bordered" data-toggle="tablefixed" data-width="100%" data-nowrap="true">
		<thead>
			<tr>
                <th>班级名称</th>

            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${SESSION_PAGE.list}" var="item">
            <tr data-id="${item.id }">
				<td>${item.clazz.name}</td>

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
