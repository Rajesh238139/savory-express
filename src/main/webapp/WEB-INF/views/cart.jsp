<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Savory Express</title>
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
                    <c:if test="${not empty sessionScope.user}">
                        <span>Hello, ${sessionScope.user.fullName}</span>
                        <form action="${pageContext.request.contextPath}/auth" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="logout">
                            <button type="submit" class="btn btn-small">Logout</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </header>

    <!-- Cart Section -->
    <section class="cart-section">
        <div class="container">
            <h1 style="color: var(--primary-dark); margin-bottom: 2rem;">Your Shopping Cart</h1>
            
            <c:choose>
                <c:when test="${isEmpty}">
                    <div class="empty-cart">
                        <div class="empty-cart-icon">🛒</div>
                        <h3 style="color: var(--primary-dark); margin-bottom: 1rem;">Your cart is empty</h3>
                        <p style="margin-bottom: 2rem;">Looks like you haven't added any delicious items to your cart yet. Start exploring our amazing restaurants!</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn">Browse Restaurants</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="display: grid; grid-template-columns: 1fr 400px; gap: 2rem;">
                        <!-- Cart Items -->
                        <div class="cart-items">
                            <h3 style="color: var(--primary-dark); margin-bottom: 1.5rem;">Order Items</h3>
                            
                            <c:forEach var="item" items="${cartItems}">
                                <div class="cart-item">
                                    <img src="${item.itemImageUrl}" 
                                         alt="${item.itemName}" 
                                         class="cart-item-image">
                                    
                                    <div class="cart-item-details">
                                        <h4 class="cart-item-name">${item.itemName}</h4>
                                        <p class="cart-item-restaurant">from ${item.restaurantName}</p>
                                        <c:if test="${item.vegetarian}">
                                            <span style="font-size: 0.8rem; color: var(--accent-forest); margin-top: 0.25rem; display: block;">
                                                🌱 Vegetarian
                                            </span>
                                        </c:if>
                                    </div>
                                    
                                    <div class="quantity-controls">
                                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="itemId" value="${item.itemId}">
                                            <input type="hidden" name="quantity" value="${item.quantity - 1}">
                                            <button type="submit" class="quantity-btn" ${item.quantity <= 1 ? 'disabled' : ''}>-</button>
                                        </form>
                                        
                                        <span class="quantity-display">${item.quantity}</span>
                                        
                                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="itemId" value="${item.itemId}">
                                            <input type="hidden" name="quantity" value="${item.quantity + 1}">
                                            <button type="submit" class="quantity-btn">+</button>
                                        </form>
                                    </div>
                                    
                                    <div class="cart-item-price">
                                        ₹<fmt:formatNumber value="${item.totalPrice}" maxFractionDigits="2"/>
                                    </div>
                                    
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="margin-left: 1rem;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                        <button type="submit" class="btn btn-danger btn-small">Remove</button>
                                    </form>
                                </div>
                            </c:forEach>
                            
                            <div style="margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid #eee;">
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="clear">
                                    <button type="submit" class="btn btn-secondary btn-small" 
                                            onclick="return confirm('Are you sure you want to clear your cart?')">
                                        Clear Cart
                                    </button>
                                </form>
                                
                                <a href="${pageContext.request.contextPath}/home" 
                                   class="btn btn-secondary btn-small" 
                                   style="margin-left: 1rem;">
                                    Continue Shopping
                                </a>
                            </div>
                        </div>
                        
                        <!-- Order Summary -->
                        <div class="cart-summary">
                            <h3 style="color: var(--primary-dark); margin-bottom: 1.5rem;">Order Summary</h3>
                            
                            <div class="summary-row">
                                <span>Subtotal</span>
                                <span>₹<fmt:formatNumber value="${subtotal}" maxFractionDigits="2"/></span>
                            </div>
                            
                            <div class="summary-row">
                                <span>Delivery Fee</span>
                                <span>₹<fmt:formatNumber value="${deliveryFee}" maxFractionDigits="2"/></span>
                            </div>
                            
                            <div class="summary-row">
                                <span>Tax (8%)</span>
                                <span>₹<fmt:formatNumber value="${tax}" maxFractionDigits="2"/></span>
                            </div>
                            
                            <div class="summary-row">
                                <strong>Total</strong>
                                <strong>₹<fmt:formatNumber value="${total}" maxFractionDigits="2"/></strong>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/checkout" class="proceed-btn">
                                Proceed to Checkout
                            </a>
                            
                            <div style="margin-top: 1rem; padding: 1rem; background: var(--primary-cream); border-radius: var(--border-radius-small); font-size: 0.9rem; text-align: center;">
                                <p style="margin: 0; color: var(--text-dark);">
                                    🔒 Your payment information is secure and encrypted
                                </p>
                            </div>
                        </div>
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
                        <li><a href="${pageContext.request.contextPath}/index.jsp#contact">Contact</a></li>
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
                
                <div class="footer-section">
                    <h3>Secure Shopping</h3>
                    <ul>
                        <li>🔒 SSL Encrypted</li>
                        <li>💳 Secure Payments</li>
                        <li>🛡️ Privacy Protected</li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Savory Express. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Add loading states to buttons
        document.querySelectorAll('form[action*="/cart"] button').forEach(button => {
            button.addEventListener('click', function() {
                if (this.type === 'submit') {
                    const originalText = this.textContent;
                    this.textContent = 'Processing...';
                    this.disabled = true;
                    
                    // Re-enable after submission (page will reload)
                    setTimeout(() => {
                        this.textContent = originalText;
                        this.disabled = false;
                    }, 2000);
                }
            });
        });

        // Animate cart items on load
        document.addEventListener('DOMContentLoaded', function() {
            const cartItems = document.querySelectorAll('.cart-item');
            
            cartItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateX(-20px)';
                
                setTimeout(() => {
                    item.style.transition = 'all 0.6s ease-out';
                    item.style.opacity = '1';
                    item.style.transform = 'translateX(0)';
                }, index * 100);
            });
        });

        // Add confirmation for quantity changes that would remove items
        document.querySelectorAll('input[name="quantity"][value="0"]').forEach(input => {
            const form = input.closest('form');
            form.addEventListener('submit', function(e) {
                if (!confirm('This will remove the item from your cart. Continue?')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>