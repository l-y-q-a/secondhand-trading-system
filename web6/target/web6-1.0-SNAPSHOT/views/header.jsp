<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
    <div class="logo">
        <h1>二手交易系统</h1>
    </div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/views/index.jsp">首页</a></li>
            <c:if test="${empty sessionScope.user}">
                <li><a href="${pageContext.request.contextPath}/views/login.jsp">登录</a></li>
                <li><a href="${pageContext.request.contextPath}/views/register.jsp">注册</a></li>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <li><a href="${pageContext.request.contextPath}/item/list">浏览物品</a></li>
                <li><a href="${pageContext.request.contextPath}/views/publish.jsp">发布物品</a></li>
                <li><a href="${pageContext.request.contextPath}/views/search.jsp">搜索</a></li>
                <li><a href="${pageContext.request.contextPath}/item/myItems">我的发布</a></li>
                <li>欢迎，${sessionScope.user.username}</li>
                <li><a href="${pageContext.request.contextPath}/user/logout">退出</a></li>
            </c:if>
        </ul>
    </nav>
</header>