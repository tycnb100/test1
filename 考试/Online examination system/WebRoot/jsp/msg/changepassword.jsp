<%@ page pageEncoding="UTF-8"%>
<%@ include file="../../common/head.jsp"%>
<div class="bjui-pageContent">
    <form action="${ctx}/com/update${SESSION_BEAN.role }Password.do" data-toggle="validate" method="post" data-close-current="true">
        <div class="bjui-row col-1">
            <label class="row-label">姓名:</label>
            <div class="row-input">${SESSION_BEAN.user.userName }</div>
            <label class="row-label">登陆账号:</label>
            <div class="row-input">${SESSION_BEAN.user.uname }</div>
            <label class="row-label">旧密码:</label>
            <div class="row-input required">
                <input type="password" id="j_userinfo_changepass_oldpass" name="oldpassword" value="" data-rule="required">
            </div>
            <label class="row-label">新密码:</label>
            <div class="row-input required">
                <input type="password" id="j_userinfo_changepass_newpass" name="password" value="" data-rule="新密码:required;length(3~)">
            </div>
            <label class="row-label">确认密码:</label>
            <div class="row-input required">
                <input type="password" id="j_userinfo_changepass_confirmpass" name="" value="" data-rule="required;match(#j_userinfo_changepass_newpass)">
            </div>
        </div>
    </form>
</div>
<div class="bjui-pageFooter">
    <ul>
        <li><button type="button" class="btn-close" data-icon="close">关闭</button></li>
        <li><button type="submit" class="btn-default" data-icon="check">确认修改</button></li>
    </ul>
</div>