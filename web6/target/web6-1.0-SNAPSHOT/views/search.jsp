<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>搜索二手物品</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <jsp:include page="header.jsp"/>

    <div class="main-content">
        <h2>搜索二手物品</h2>

        <div class="search-box">
            <form action="${pageContext.request.contextPath}/item/search" method="get">
                <input type="text" name="keyword"
                       placeholder="请输入搜索关键词（标题或描述）"
                       value="${keyword}">
                <button type="submit" class="btn">搜索</button>
                <a href="${pageContext.request.contextPath}/item/list" class="btn">显示全部</a>
            </form>
        </div>

        <c:if test="${not empty items}">
            <div class="item-list">
                <h3>搜索结果（${items.size()}件）</h3>
                <jsp:include page="itemListFragment.jsp"/>
            </div>
        </c:if>

        <c:if test="${empty items and not empty keyword}">
            <div class="no-result">
                <p>没有找到与"${keyword}"相关的物品</p>
            </div>
        </c:if>
    </div>

    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>