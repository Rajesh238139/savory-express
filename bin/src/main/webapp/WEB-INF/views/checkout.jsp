<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Savory Express</title>
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
                        <li><a href="${pageContext.request.contextPath}/cart">Back to Cart</a></li>
                    </ul>
                </nav>
                
                <div class="user-section">
                    <span>Hello, ${sessionScope.user.fullName}</span>
                </div>
            </div>
        </div>
    </header>

    <!-- Checkout Section -->
    <section style="padding: 2rem 0; min-height: 70vh;">
        <div class="container">
            <h1 style="color: var(--primary-dark); margin-bottom: 2rem; text-align: center;">
                Complete Your Order
            </h1>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ${error}
                </div>
            </c:if>
            
            <div style="display: grid; grid-template-columns: 1fr 400px; gap: 3rem; max-width: 1000px; margin: 0 auto;">
                <!-- Checkout Form -->
                <div class="form-container" style="margin: 0;">
                    <h3 style="color: var(--primary-dark); margin-bottom: 1.5rem;">
                        Delivery & Payment Details
                    </h3>
                    
                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                        <input type="hidden" name="total" value="${total}">
                        
                        <!-- Delivery Information -->
                        <div style="margin-bottom: 2rem;">
                            <h4 style="color: var(--primary-dark); margin-bottom: 1rem; border-bottom: 2px solid var(--primary-gold); padding-bottom: 0.5rem;">
                                🏠 Delivery Information
                            </h4>
                            
                            <div class="form-group">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" 
                                       id="fullName" 
                                       name="fullName" 
                                       class="form-input" 
                                       value="${user.fullName}" 
                                       readonly
                                       style="background: #f9f9f9;">
                            </div>
                            
                            <div class="form-group">
                                <label for="phone" class="form-label">Contact Number *</label>
                                <input type="tel" 
                                       id="phone" 
                                       name="phone" 
                                       class="form-input" 
                                       value="${user.phone}" 
                                       required 
                                       placeholder="Enter your contact number">
                            </div>
                            
                            <div class="form-group">
                                <label for="deliveryAddress" class="form-label">Delivery Address *</label>
                                <textarea id="deliveryAddress" 
                                          name="deliveryAddress" 
                                          class="form-textarea" 
                                          required 
                                          placeholder="Enter your complete delivery address including apartment/unit number"
                                          rows="4">${user.address}</textarea>
                            </div>
                        </div>
                        
                        <!-- Payment Method -->
                        <div style="margin-bottom: 2rem;">
                            <h4 style="color: var(--primary-dark); margin-bottom: 1rem; border-bottom: 2px solid var(--primary-gold); padding-bottom: 0.5rem;">
                                💳 Payment Method
                            </h4>
                            
                            <div style="display: grid; gap: 1rem;">
                                <label style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem; border: 2px solid #ddd; border-radius: var(--border-radius-small); cursor: pointer; transition: var(--transition-smooth);" 
                                       class="payment-option">
                                    <input type="radio" name="paymentMethod" value="Credit Card" checked 
                                           style="accent-color: var(--primary-gold);">
                                    <div>
                                        <strong>💳 Credit/Debit Card</strong>
                                        <div style="font-size: 0.9rem; color: var(--text-light); margin-top: 0.25rem;">
                                            Visa, Mastercard, American Express
                                        </div>
                                    </div>
                                </label>
                                
                                <label style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem; border: 2px solid #ddd; border-radius: var(--border-radius-small); cursor: pointer; transition: var(--transition-smooth);" 
                                       class="payment-option">
                                    <input type="radio" name="paymentMethod" value="Digital Wallet" 
                                           style="accent-color: var(--primary-gold);">
                                    <div>
                                        <strong>📱 Digital Wallet</strong>
                                        <div style="font-size: 0.9rem; color: var(--text-light); margin-top: 0.25rem;">
                                            PayPal, GPay, PhonePe, Paytm
                                        </div>
                                    </div>
                                </label>
                                
                                <label style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem; border: 2px solid #ddd; border-radius: var(--border-radius-small); cursor: pointer; transition: var(--transition-smooth);" 
                                       class="payment-option">
                                    <input type="radio" name="paymentMethod" value="Cash on Delivery" 
                                           style="accent-color: var(--primary-gold);">
                                    <div>
                                        <strong>💵 Cash on Delivery</strong>
                                        <div style="font-size: 0.9rem; color: var(--text-light); margin-top: 0.25rem;">
                                            Pay when your food arrives
                                        </div>
                                    </div>
                                </label>
                            </div>
                        </div>
                        
                        <!-- Special Instructions -->
                        <div style="margin-bottom: 2rem;">
                            <h4 style="color: var(--primary-dark); margin-bottom: 1rem; border-bottom: 2px solid var(--primary-gold); padding-bottom: 0.5rem;">
                                📝 Special Instructions (Optional)
                            </h4>
                            
                            <textarea name="specialInstructions" 
                                      class="form-textarea" 
                                      placeholder="Any special delivery instructions, dietary requirements, or notes for the restaurant..."
                                      rows="3"></textarea>
                        </div>
                        
                        <button type="submit" class="btn" style="width: 100%; font-size: 1.1rem; padding: 1.2rem;">
                            🛒 Place Order - ₹<fmt:formatNumber value="${total}" maxFractionDigits="2"/>
                        </button>
                    </form>
                </div>
                
                <!-- Order Summary -->
                <div class="cart-summary" style="height: fit-content; position: sticky; top: 2rem;">
                    <h3 style="color: var(--primary-dark); margin-bottom: 1.5rem;">Order Summary</h3>
                    
                    <div style="margin-bottom: 1.5rem; max-height: 300px; overflow-y: auto;">
                        <c:forEach var="item" items="${cartItems}">
                            <div style="display: flex; justify-content: space-between; align-items: center; padding: 0.75rem 0; border-bottom: 1px solid #eee;">
                                <div style="flex: 1;">
                                    <div style="font-weight: 600; font-size: 0.9rem; color: var(--primary-dark);">
                                        ${item.itemName}
                                    </div>
                                    <div style="font-size: 0.8rem; color: var(--text-light);">
                                        ${item.restaurantName} × ${item.quantity}
                                    </div>
                                </div>
                                <div style="font-weight: 600; color: var(--primary-gold);">
                                    ₹<fmt:formatNumber value="${item.totalPrice}" maxFractionDigits="2"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
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
                    
                    <div class="summary-row" style="font-size: 1.1rem;">
                        <strong>Total Amount</strong>
                        <strong style="color: var(--primary-gold);">₹<fmt:formatNumber value="${total}" maxFractionDigits="2"/></strong>
                    </div>
                    
                    <div style="margin-top: 1.5rem; padding: 1rem; background: var(--primary-cream); border-radius: var(--border-radius-small); font-size: 0.9rem; text-align: center;">
                        <div style="margin-bottom: 0.5rem;">
                            <strong style="color: var(--accent-forest);">🕒 Estimated Delivery Time</strong>
                        </div>
                        <div style="color: var(--text-dark);">
                            35-45 minutes
                        </div>
                    </div>
                    
                    <div style="margin-top: 1rem; padding: 1rem; background: #f0f8f0; border: 1px solid #d4e6d4; border-radius: var(--border-radius-small); font-size: 0.85rem; text-align: center; color: var(--accent-forest);">
                        🔒 Your payment information is secure and encrypted
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-bottom">
                <p>&copy; 2024 Savory Express. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Form validation
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const phone = document.getElementById('phone').value.trim();
            const address = document.getElementById('deliveryAddress').value.trim();
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
            
            if (!phone || !address || !paymentMethod) {
                e.preventDefault();
                alert('Please fill in all required fields');
                return false;
            }
            
            // Phone validation (simple)
            if (phone.length < 10) {
                e.preventDefault();
                alert('Please enter a valid phone number');
                return false;
            }
            
            // Show processing message
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.textContent = 'Processing Order...';
            submitBtn.disabled = true;
        });

        // Payment option styling
        document.querySelectorAll('.payment-option input[type="radio"]').forEach(radio => {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.payment-option').forEach(option => {
                    option.style.borderColor = '#ddd';
                    option.style.background = 'white';
                });
                
                this.closest('.payment-option').style.borderColor = 'var(--primary-gold)';
                this.closest('.payment-option').style.background = 'var(--primary-cream)';
            });
        });

        // Set initial active payment option
        document.querySelector('.payment-option input[type="radio"]:checked').dispatchEvent(new Event('change'));

        // Add animations
        document.addEventListener('DOMContentLoaded', function() {
            const formElements = document.querySelectorAll('.form-group, .payment-option');
            
            formElements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    element.style.transition = 'all 0.6s ease-out';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>