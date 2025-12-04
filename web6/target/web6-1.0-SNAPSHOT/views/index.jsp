<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>二手交易系统 - 首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <jsp:include page="header.jsp"/>

    <div class="main-content">
        <h2>欢迎来到二手交易系统</h2>

        <c:if test="${empty sessionScope.user}">
            <div class="welcome">
                <p>请先<a href="${pageContext.request.contextPath}/views/login.jsp">登录</a>或<a href="${pageContext.request.contextPath}/views/register.jsp">注册</a></p>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.user}">
            <div class="welcome">
                <h3>欢迎回来，${sessionScope.user.username}！</h3>
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/views/publish.jsp" class="btn">发布二手物品</a>
                    <a href="${pageContext.request.contextPath}/item/list" class="btn">浏览所有物品</a>
                    <a href="${pageContext.request.contextPath}/views/search.jsp" class="btn">搜索物品</a>
                    <a href="${pageContext.request.contextPath}/item/myItems" class="btn">我的发布</a>
                </div>
            </div>
        </c:if>

    </div>

    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>