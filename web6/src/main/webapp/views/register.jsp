<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <jsp:include page="header.jsp"/>

    <div class="form-container">
        <h2>用户注册</h2>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/user/register" method="post">
            <div class="form-group">
                <label for="username">用户名：</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-group">
                <label for="email">邮箱：</label>
                <input type="email" id="email" name="email">
            </div>

            <div class="form-group">
                <label for="phone">电话：</label>
                <input type="tel" id="phone" name="phone">
            </div>

            <div class="form-group">
                <button type="submit" class="btn">注册</button>
                <a href="${pageContext.request.contextPath}/views/login.jsp" class="btn-link">已有账号？立即登录</a>
            </div>
        </form>
    </div>

    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>