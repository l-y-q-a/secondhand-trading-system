<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>二手物品列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <jsp:include page="header.jsp"/>

    <div class="main-content">
        <h2>二手物品列表</h2>

        <c:if test="${not empty sessionScope.message}">
            <div class="message">${sessionScope.message}</div>
            <c:remove var="message" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.error}">
            <div class="error">${sessionScope.error}</div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/views/publish.jsp" class="btn">发布新物品</a>
            <a href="${pageContext.request.contextPath}/views/search.jsp" class="btn">搜索物品</a>
        </div>

        <c:if test="${not empty items}">
            <jsp:include page="itemListFragment.jsp"/>
        </c:if>

        <c:if test="${empty items}">
            <div class="no-result">
                <p>暂无物品信息</p>
            </div>
        </c:if>
    </div>

    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>