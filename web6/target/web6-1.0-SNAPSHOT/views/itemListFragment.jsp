<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="items">
    <c:forEach var="item" items="${items}">
        <div class="item-card">
            <c:if test="${not empty item.imageUrl}">
                <div class="item-image">
                    <img src="${item.imageUrl}" alt="${item.title}"
                         onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgZmlsbD0iI2YwZjBmMCIvPjx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBkb21pbmFudC1iYXNlbGluZT0iY2VudHJhbCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZm9udC1zaXplPSIyMCIgZmlsbD0iIzk5OSI+Tm8gSW1hZ2U8L3RleHQ+PC9zdmc+'">
                </div>
            </c:if>
            <c:if test="${empty item.imageUrl}">
                <div class="item-image">
                    <div class="no-image">无图片</div>
                </div>
            </c:if>
            <div class="item-info">
                <h3 class="item-title">${item.title}</h3>
                <p class="item-description">
                    <c:choose>
                        <c:when test="${item.description.length() > 50}">
                            ${item.description.substring(0,50)}...
                        </c:when>
                        <c:otherwise>
                            ${item.description}
                        </c:otherwise>
                    </c:choose>
                </p>
                <div class="item-details">
                    <span class="category">${item.category}</span>
                    <span class="price">¥<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></span>
                    <span class="status ${item.status}">${item.status}</span>
                </div>
                <div class="item-meta">
                    <span class="date">发布时间：${item.createdAt}</span>
                </div>
                <div class="item-actions">
                    <c:if test="${sessionScope.user.id == item.userId}">
                        <a href="${pageContext.request.contextPath}/item/edit?id=${item.id}"
                           class="btn-small">编辑</a>
                        <a href="${pageContext.request.contextPath}/item/delete?id=${item.id}"
                           class="btn-small btn-danger"
                           onclick="return confirm('确定要删除吗？')">删除</a>
                    </c:if>
                </div>
            </div>
        </div>
    </c:forEach>
</div>