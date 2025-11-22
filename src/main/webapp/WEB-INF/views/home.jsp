<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Restaurants - Savory Express</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <a href="${pageContext.request.contextPath}/index.jsp" class="logo">🍽️ Savory Express</a>
                
                <nav>
                    <ul class="nav-menu">
                        <li><a href="${pageContext.request.contextPath}/home" class="active">Restaurants</a></li>
                        <li><a href="${pageContext.request.contextPath}/index.jsp#about">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/index.jsp#contact">Contact</a></li>
                    </ul>
                </nav>
                
                <div class="user-section">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/cart" class="cart-icon">
                                🛒 <span class="cart-count" id="cartCount">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                            </a>
                            <span>Hello, ${sessionScope.user.fullName}</span>
                            <form action="${pageContext.request.contextPath}/auth" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="logout">
                                <button type="submit" class="btn btn-small">Logout</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-small">Login</a>
                            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-small">Register</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </header>

    <!-- Search Section -->
    <section class="search-section">
        <div class="container">
            <form action="${pageContext.request.contextPath}/home" method="get" class="search-container">
                <div class="search-box">
                    <input type="text" 
                           name="search" 
                           class="search-input" 
                           placeholder="Search restaurants, cuisines, or dishes..."
                           value="${searchTerm}">
                </div>
                <button type="submit" class="search-btn">Search</button>
            </form>
            
            <!-- Cuisine Filters -->
            <div class="cuisine-filters">
                <a href="${pageContext.request.contextPath}/home" 
                   class="cuisine-btn ${empty selectedCuisine ? 'active' : ''}">All Cuisines</a>
                
                <c:forEach var="cuisine" items="${cuisineTypes}">
                    <a href="${pageContext.request.contextPath}/home?cuisine=${cuisine}" 
                       class="cuisine-btn ${selectedCuisine eq cuisine ? 'active' : ''}">${cuisine}</a>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- Results Section -->
    <section class="restaurants-section">
        <div class="container">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2>
                    <c:choose>
                        <c:when test="${not empty searchTerm}">
                            Search Results for "${searchTerm}"
                        </c:when>
                        <c:when test="${not empty selectedCuisine}">
                            ${selectedCuisine} Restaurants
                        </c:when>
                        <c:otherwise>
                            All Restaurants
                        </c:otherwise>
                    </c:choose>
                </h2>
                <p style="color: var(--text-light); margin: 0;">
                    <c:choose>
                        <c:when test="${empty restaurants}">
                            No restaurants found
                        </c:when>
                        <c:otherwise>
                            ${restaurants.size()} restaurant(s) available
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <c:choose>
                <c:when test="${empty restaurants}">
                    <div class="empty-state" style="text-align: center; padding: 4rem 2rem; color: var(--text-light);">
                        <div style="font-size: 4rem; margin-bottom: 1rem;">🍽️</div>
                        <h3 style="color: var(--primary-dark); margin-bottom: 1rem;">No Restaurants Found</h3>
                        <p style="margin-bottom: 2rem;">
                            <c:choose>
                                <c:when test="${not empty searchTerm}">
                                    Try searching with different keywords or browse all restaurants.
                                </c:when>
                                <c:otherwise>
                                    No restaurants available in this category. Please try another cuisine type.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/home" class="btn">Browse All Restaurants</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="restaurants-grid">
                        <c:forEach var="restaurant" items="${restaurants}">
                            <div class="restaurant-card">
                                <img src="${restaurant.imageUrl}" 
                                     alt="${restaurant.name}" 
                                     class="restaurant-image">
                                
                                <div class="restaurant-info">
                                    <h3 class="restaurant-name">${restaurant.name}</h3>
                                    <p class="restaurant-description">${restaurant.description}</p>
                                    
                                    <div class="restaurant-meta">
                                        <div class="rating">
                                            ⭐ <fmt:formatNumber value="${restaurant.rating}" maxFractionDigits="1"/>
                                        </div>
                                        <div class="delivery-time">🕒 ${restaurant.deliveryTime}</div>
                                        <div class="delivery-fee">
                                            <c:choose>
                                                <c:when test="${restaurant.deliveryFee == 0}">
                                                    Free Delivery
                                                </c:when>
                                                <c:otherwise>
                                                    ₹<fmt:formatNumber value="${restaurant.deliveryFee}" maxFractionDigits="2"/> delivery
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <div class="restaurant-footer">
                                        <span class="cuisine-tag">${restaurant.cuisineType}</span>
                                        <a href="${pageContext.request.contextPath}/menu?restaurant=${restaurant.restaurantId}" 
                                           class="view-menu-btn">View Menu</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>Savory Express</h3>
                    <p>Delivering exceptional cuisine with unmatched elegance and speed.</p>
                </div>
                
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home">Browse Restaurants</a></li>
                        <li><a href="${pageContext.request.contextPath}/index.jsp#about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart">My Cart</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Customer Care</h3>
                    <ul>
                        <li>📞 1-800-SAVORY-1</li>
                        <li>✉️ support@savoryexpress.com</li>
                        <li>🕒 24/7 Customer Support</li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Connect With Us</h3>
                    <p>Follow us for exclusive offers and culinary inspiration.</p>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Savory Express. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Add smooth animations on page load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.restaurant-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.6s ease-out';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });

        // Search form enhancement
        const searchInput = document.querySelector('.search-input');
        const searchForm = document.querySelector('.search-container');
        
        searchForm.addEventListener('submit', function(e) {
            if (searchInput.value.trim() === '') {
                e.preventDefault();
                window.location.href = '${pageContext.request.contextPath}/home';
            }
        });
    </script>
</body>
</html>