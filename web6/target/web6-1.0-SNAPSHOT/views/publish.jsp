<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>发布二手物品</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <jsp:include page="header.jsp"/>

    <div class="form-container">
        <h2><c:choose>
            <c:when test="${edit}">修改物品信息</c:when>
            <c:otherwise>发布二手物品</c:otherwise>
        </c:choose></h2>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/item/${edit ? 'update' : 'add'}" method="post">
            <c:if test="${edit}">
                <input type="hidden" name="id" value="${item.id}">
            </c:if>

            <div class="form-group">
                <label for="title">物品标题：</label>
                <input type="text" id="title" name="title"
                       value="${item.title}" required>
            </div>

            <div class="form-group">
                <label for="description">物品描述：</label>
                <textarea id="description" name="description" rows="4" required>${item.description}</textarea>
            </div>

            <div class="form-group">
                <label for="category">物品分类：</label>
                <select id="category" name="category">
                    <option value="电子数码" <c:if test="${item.category == '电子数码'}">selected</c:if>>电子数码</option>
                    <option value="图书教材" <c:if test="${item.category == '图书教材'}">selected</c:if>>图书教材</option>
                    <option value="服饰鞋包" <c:if test="${item.category == '服饰鞋包'}">selected</c:if>>服饰鞋包</option>
                    <option value="生活用品" <c:if test="${item.category == '生活用品'}">selected</c:if>>生活用品</option>
                    <option value="运动器材" <c:if test="${item.category == '运动器材'}">selected</c:if>>运动器材</option>
                    <option value="其他" <c:if test="${item.category == '其他'}">selected</c:if>>其他</option>
                </select>
            </div>

            <div class="form-group">
                <label for="price">价格（元）：</label>
                <input type="number" id="price" name="price"
                       value="${item.price}" step="0.01" min="0" required>
            </div>

            <div class="form-group">
                <label for="imageUrl">图片URL：</label>
                <input type="text" id="imageUrl" name="imageUrl"
                       value="${item.imageUrl}"
                       placeholder="https://example.com/image.jpg">
            </div>

            <div class="form-group">
                <button type="submit" class="btn">
                    <c:choose>
                        <c:when test="${edit}">更新物品</c:when>
                        <c:otherwise>发布物品</c:otherwise>
                    </c:choose>
                </button>
                <a href="${pageContext.request.contextPath}/item/myItems" class="btn-link">返回我的发布</a>
            </div>
        </form>
    </div>

    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>