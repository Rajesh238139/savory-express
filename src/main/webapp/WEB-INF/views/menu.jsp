<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${restaurant.name} - Menu | Savory Express</title>
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
                        <li><a href="${pageContext.request.contextPath}/home">Restaurants</a></li>
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

    <!-- Restaurant Header -->
    <section class="menu-header">
        <div class="container">
            <div class="restaurant-header">
                <img src="${restaurant.imageUrl}" 
                     alt="${restaurant.name}" 
                     class="restaurant-image-large">
                
                <div class="restaurant-details">
                    <h1>${restaurant.name}</h1>
                    <p style="color: #ccc; margin-bottom: 1rem;">${restaurant.description}</p>
                    
                    <div style="display: flex; gap: 2rem; flex-wrap: wrap;">
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <span style="color: var(--primary-gold);">⭐</span>
                            <span><fmt:formatNumber value="${restaurant.rating}" maxFractionDigits="1"/></span>
                        </div>
                        
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <span style="color: var(--primary-gold);">🕒</span>
                            <span>${restaurant.deliveryTime}</span>
                        </div>
                        
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <span style="color: var(--primary-gold);">🚚</span>
                            <span>
                                <c:choose>
                                    <c:when test="${restaurant.deliveryFee == 0}">
                                        Free Delivery
                                    </c:when>
                                    <c:otherwise>
                                        ₹<fmt:formatNumber value="${restaurant.deliveryFee}" maxFractionDigits="2"/> delivery
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <span style="color: var(--primary-gold);">💰</span>
                            <span>Min. order ₹<fmt:formatNumber value="${restaurant.minOrder}" maxFractionDigits="2"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Menu Categories Navigation -->
    <c:if test="${not empty categories}">
        <section class="menu-categories">
            <div class="container">
                <div class="categories-list">
                    <c:forEach var="category" items="${categories}">
                        <a href="#${category.toLowerCase().replaceAll(' ', '-')}" 
                           class="category-btn"
                           onclick="scrollToCategory('${category.toLowerCase().replaceAll(' ', '-')}')">${category}</a>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>

    <!-- Menu Items -->
    <section class="menu-section">
        <div class="container">
            <c:choose>
                <c:when test="${empty menuItems}">
                    <div class="empty-state" style="text-align: center; padding: 4rem 2rem; color: var(--text-light);">
                        <div style="font-size: 4rem; margin-bottom: 1rem;">🍽️</div>
                        <h3 style="color: var(--primary-dark);">No Menu Items Available</h3>
                        <p>This restaurant is currently updating their menu. Please check back soon!</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn">Browse Other Restaurants</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:set var="currentCategory" value="" />
                    
                    <c:forEach var="item" items="${menuItems}">
                        <c:if test="${item.categoryName != currentCategory}">
                            <c:if test="${not empty currentCategory}">
                                </div> <!-- Close previous category -->
                            </c:if>
                            
                            <c:set var="currentCategory" value="${item.categoryName}" />
                            <h2 id="${item.categoryName.toLowerCase().replaceAll(' ', '-')}" 
                                style="color: var(--primary-dark); margin: 3rem 0 1rem 0; padding-top: 2rem;">
                                ${item.categoryName}
                            </h2>
                            <div class="menu-items">
                        </c:if>
                        
                        <div class="menu-item">
                            <img src="${item.imageUrl}" 
                                 alt="${item.name}" 
                                 class="menu-item-image">
                            
                            <div class="menu-item-content">
                                <div class="menu-item-header">
                                    <h4 class="menu-item-name">${item.name}</h4>
                                    <span class="menu-item-price">₹<fmt:formatNumber value="${item.price}" maxFractionDigits="2"/></span>
                                </div>
                                
                                <p class="menu-item-description">${item.description}</p>
                                
                                <div class="menu-item-footer">
                                    <div class="menu-item-tags">
                                        <c:if test="${item.vegetarian}">
                                            <span class="veg-tag">🌱 Vegetarian</span>
                                        </c:if>
                                        <c:if test="${not empty item.preparationTime}">
                                            <span class="prep-time">⏱️ ${item.preparationTime}</span>
                                        </c:if>
                                    </div>
                                    
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;" class="add-to-cart-form">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="itemId" value="${item.itemId}">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/login.jsp" class="add-to-cart-btn">Login to Order</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${not empty currentCategory}">
                        </div> <!-- Close last category -->
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Floating Cart Button (if user is logged in and has items) -->
    <c:if test="${not empty sessionScope.user && sessionScope.cartCount > 0}">
        <div id="floatingCart" style="position: fixed; bottom: 2rem; right: 2rem; z-index: 1000;">
            <a href="${pageContext.request.contextPath}/cart" 
               class="btn" 
               style="border-radius: 50px; padding: 1rem 2rem; box-shadow: 0 8px 25px var(--shadow-color);">
                🛒 View Cart (${sessionScope.cartCount})
            </a>
        </div>
    </c:if>

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
                        <li><a href="${pageContext.request.contextPath}/cart">My Cart</a></li>
                        <li><a href="${pageContext.request.contextPath}/index.jsp#about">About Us</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Restaurant Info</h3>
                    <ul>
                        <li>📍 ${restaurant.address}</li>
                        <li>⭐ <fmt:formatNumber value="${restaurant.rating}" maxFractionDigits="1"/> Rating</li>
                        <li>🍴 ${restaurant.cuisineType} Cuisine</li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Customer Care</h3>
                    <ul>
                        <li>📞 1-800-SAVORY-1</li>
                        <li>✉️ support@savoryexpress.com</li>
                        <li>🕒 24/7 Support</li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Savory Express. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Smooth scroll to category
        function scrollToCategory(categoryId) {
            const element = document.getElementById(categoryId);
            if (element) {
                element.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        }

        // Update active category link on scroll
        function updateActiveCategoryLink() {
            const categoryLinks = document.querySelectorAll('.category-btn');
            const sections = document.querySelectorAll('[id]');
            
            let current = '';
            
            sections.forEach(section => {
                const sectionTop = section.offsetTop;
                const sectionHeight = section.clientHeight;
                
                if (window.pageYOffset >= (sectionTop - 200)) {
                    current = section.getAttribute('id');
                }
            });

            categoryLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === '#' + current) {
                    link.classList.add('active');
                }
            });
        }

        // Listen for scroll events
        window.addEventListener('scroll', updateActiveCategoryLink);

        // Add to cart functionality with cart count update
        document.querySelectorAll('.add-to-cart-form').forEach(form => {
            form.addEventListener('submit', function(e) {
                const button = this.querySelector('.add-to-cart-btn');
                const originalText = button.textContent;
                
                button.textContent = 'Adding...';
                button.disabled = true;
                
                // Update cart count after adding
                const currentCount = parseInt(document.getElementById('cartCount').textContent) || 0;
                const newCount = currentCount + 1;
                document.getElementById('cartCount').textContent = newCount;
                
                // Show floating cart if hidden
                const floatingCart = document.getElementById('floatingCart');
                if (floatingCart && newCount > 0) {
                    floatingCart.style.display = 'block';
                    floatingCart.querySelector('a').innerHTML = `🛒 View Cart (${newCount})`;
                }
                
                // Re-enable button after a short delay (form will submit)
                setTimeout(() => {
                    button.textContent = 'Added!';
                    setTimeout(() => {
                        button.textContent = originalText;
                        button.disabled = false;
                    }, 1000);
                }, 500);
            });
        });

        // Animate menu items on load
        document.addEventListener('DOMContentLoaded', function() {
            const menuItems = document.querySelectorAll('.menu-item');
            
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            menuItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                item.style.transition = 'all 0.6s ease-out';
                
                observer.observe(item);
            });
        });
    </script>
</body>
</html>