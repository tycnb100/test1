<%@ page contentType="text/html; charset=UTF-8"%>
<meta name="Keywords" content=""/>
<meta name="Description" content=""/> 
<!-- bootstrap - css -->
<link href="${pageContext.request.contextPath}/static/B-JUI/themes/css/bootstrap.css" rel="stylesheet">
<!-- core - css -->
<link href="${pageContext.request.contextPath}/static/B-JUI/themes/css/style.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/B-JUI/themes/blue/core.css" id="bjui-link-theme" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/B-JUI/themes/css/fontsize.css" id="bjui-link-theme" rel="stylesheet">
<!-- plug - css -->
<link href="${pageContext.request.contextPath}/static/B-JUI/plugins/kindeditor_4.1.11/themes/default/default.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/B-JUI/plugins/colorpicker/css/bootstrap-colorpicker.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/B-JUI/plugins/nice-validator-1.0.7/jquery.validator.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/B-JUI/plugins/bootstrapSelect/bootstrap-select.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/B-JUI/plugins/webuploader/webuploader.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/static/B-JUI/themes/css/FA/css/font-awesome.min.css" rel="stylesheet">
<!-- Favicons -->
<!--[if lte IE 7]>
<link href="${pageContext.request.contextPath}/static/B-JUI/themes/css/ie7.css" rel="stylesheet">
<![endif]-->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lte IE 9]>
    <script src="${pageContext.request.contextPath}/static/B-JUI/other/html5shiv.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/B-JUI/other/respond.min.js"></script>
<![endif]-->
<!-- jquery -->
<script src="${pageContext.request.contextPath}/static/B-JUI/js/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath}/static/B-JUI/js/jquery.cookie.js"></script>
<!--[if lte IE 9]>
<script src="${pageContext.request.contextPath}/static/B-JUI/other/jquery.iframe-transport.js"></script>
<![endif]-->
<!-- B-JUI -->
<script src="${pageContext.request.contextPath}/static/B-JUI/js/bjui-all.js"></script>
<!-- plugins -->
<!-- swfupload for kindeditor -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/swfupload/swfupload.js"></script>
<!-- Webuploader -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/webuploader/webuploader.js"></script>
<!-- kindeditor -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/kindeditor_4.1.11/kindeditor-all.js"></script>
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/kindeditor_4.1.11/lang/zh-CN.js"></script>
<!-- colorpicker -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/colorpicker/js/bootstrap-colorpicker.min.js"></script>
<!-- ztree -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/ztree/jquery.ztree.all-3.5.js"></script>
<!-- nice validate -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/nice-validator-1.0.7/jquery.validator.js"></script>
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/nice-validator-1.0.7/jquery.validator.themes.js"></script>
<!-- bootstrap plugins -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/bootstrapSelect/bootstrap-select.min.js"></script>
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/bootstrapSelect/defaults-zh_CN.min.js"></script>
<!-- icheck -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/icheck/icheck.min.js"></script>
<!-- HighCharts -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/highcharts/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/highcharts/highcharts-3d.js"></script>
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/highcharts/themes/gray.js"></script>
<!-- other plugins -->
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/other/jquery.autosize.js"></script>
<link href="${pageContext.request.contextPath}/static/B-JUI/plugins/uploadify/css/uploadify.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/uploadify/scripts/jquery.uploadify.min.js"></script>
<script src="${pageContext.request.contextPath}/static/B-JUI/plugins/download/jquery.fileDownload.js"></script>
<!-- init -->
<script type="text/javascript">
$(function() {
    BJUI.init({
        JSPATH       : '${pageContext.request.contextPath}/static/B-JUI/',         //[可选]框架路径
        PLUGINPATH   : '${pageContext.request.contextPath}/static/B-JUI/plugins/', //[可选]插件路径
        loginInfo    : {url:'login_timeout.html', title:'登录', width:440, height:240}, // 会话超时后弹出登录对话框
        statusCode   : {ok:200, error:300, timeout:301}, //[可选]
        ajaxTimeout  : 300000, //[可选]全局Ajax请求超时时间(毫秒)
        alertTimeout : 3000,  //[可选]信息提示[info/correct]自动关闭延时(毫秒)
        pageInfo     : {total:'totalRow', pageCurrent:'pageCurrent', pageSize:'pageSize', orderField:'orderField', orderDirection:'orderDirection'}, //[可选]分页参数
        keys         : {statusCode:'statusCode', message:'message'}, //[可选]
        ui           : {
                         sidenavWidth     : 220,
                         showSlidebar     : true, //[可选]左侧导航栏锁定/隐藏
                         overwriteHomeTab : false //[可选]当打开一个未定义id的navtab时，是否可以覆盖主navtab(我的主页)
                       },
        debug        : true,    // [可选]调试模式 [true|false，默认false]
        theme        : 'green' // 若有Cookie['bjui_theme'],优先选择Cookie['bjui_theme']。皮肤[五种皮肤:default, orange, purple, blue, red, green]
    })
    //时钟
    var today = new Date(), time = today.getTime()
    $('#bjui-date').html(today.formatDate('yyyy/MM/dd'))
    setInterval(function() {
        today = new Date(today.setSeconds(today.getSeconds() + 1))
        $('#bjui-clock').html(today.formatDate('HH:mm:ss'))
    }, 1000)
})

/*window.onbeforeunload = function(){
    return "确定要关闭本系统 ?";
}*/

//菜单-事件-zTree
function MainMenuClick(event, treeId, treeNode) {
    if (treeNode.target && treeNode.target == 'dialog' || treeNode.target == 'navtab')
        event.preventDefault()
    
    if (treeNode.isParent) {
        var zTree = $.fn.zTree.getZTreeObj(treeId)
        
        zTree.expandNode(treeNode)
        return
    }
    
    if (treeNode.target && treeNode.target == 'dialog')
        $(event.target).dialog({id:treeNode.targetid, url:treeNode.url, title:treeNode.name})
    else if (treeNode.target && treeNode.target == 'navtab')
        $(event.target).navtab({id:treeNode.targetid, url:treeNode.url, title:treeNode.name, fresh:treeNode.fresh, external:treeNode.external})
}

// 满屏开关
var bjui_index_container = 'container_fluid'

function bjui_index_exchange() {
    bjui_index_container = bjui_index_container == 'container_fluid' ? 'container' : 'container_fluid'
    
    $('#bjui-top').find('> div').attr('class', bjui_index_container)
    $('#bjui-navbar').find('> div').attr('class', bjui_index_container)
    $('#bjui-body-box').find('> div').attr('class', bjui_index_container)
}
</script>
<!-- highlight && ZeroClipboard -->
<link href="${pageContext.request.contextPath}/static/assets/prettify.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/static/assets/prettify.js"></script>
<link href="${pageContext.request.contextPath}/static/assets/ZeroClipboard.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/static/assets/ZeroClipboard.js"></script>
