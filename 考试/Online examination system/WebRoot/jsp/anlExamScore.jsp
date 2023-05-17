<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<div class="bjui-pageHeader">
	<form data-toggle="ajaxsearch" action="${ctx}/sys/anlExamScore.do" id="pagefrom_${actionclass}">
		<div style="margin: 0; padding: 1px 5px 5px;">
			<span>科目:</span>
			<select name="uid" class="form-control" data-toggle="selectpicker">
				<option value="">全部</option>
				<c:forEach items="${list }" var="item">
					<option value="${item.id }">${item.name }</option>
				</c:forEach>
			</select>

			<div class="btn-group">
				<button type="submit" class="btn-green" data-icon="search">统计</button>
			</div>
			<!--             <button type="button" class="btn-blue" data-toggle="dialog" data-options="{url:'../../html/datagrid/datagrid-search-source.html', id:'dialog-datagrid-search', width:1000, height:600, title:'查看Datagrid示例- 页头搜索、自定义编辑 - 源码'}">点击查看示例源码</button> -->
			<div class="btn-group"></div>
		</div>
	</form>
</div>
<div class="bjui-pageContent tableContent">
	<div id="container11" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</div>
<c:if test="${not empty course }">
	<script type="text/javascript">
		$(function() {
			$('#container11').highcharts({
				chart : {
					type : 'column'
				},
				title : {
					text : '${course.name} - 各分数段的学生人数'
				},
				xAxis : {
					categories : [
						'60以下',
						'60-70及格',
						'70-90良',
						'90-100优'
					],
					crosshair : true
				},
				yAxis : {
					min : 0,
					title : {
						text : '人数 (人)'
					}
				},
				tooltip : {
					headerFormat : '<span style="font-size:10px">{point.key}</span><table>',
					pointFormat : '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
						'<td style="padding:0"><b>{point.y:.0f} 人</b></td></tr>',
					footerFormat : '</table>',
					shared : true,
					useHTML : true
				},
				plotOptions : {
					column : {
						pointPadding : 0.2,
						borderWidth : 0
					}
				},
				series : [ {
					name : '人数',
					data : [ ${count1},  ${count2},  ${count3},  ${count4} ]
				} ]
			});
		});
		
	</script>
</c:if>