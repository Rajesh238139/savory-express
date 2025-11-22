<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - Savory Express</title>
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
                        <li><a href="${pageContext.request.contextPath}/home">Browse Restaurants</a></li>
                        <li><a href="${pageContext.request.contextPath}/index.jsp#about">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/index.jsp#contact">Contact</a></li>
                    </ul>
                </nav>
                
                <div class="user-section">
                    <span>Hello, ${sessionScope.user.fullName}</span>
                    <form action="${pageContext.request.contextPath}/auth" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="logout">
                        <button type="submit" class="btn btn-small">Logout</button>
                    </form>
                </div>
            </div>
        </div>
    </header>

    <!-- Order Confirmation Section -->
    <section style="padding: 4rem 0; min-height: 70vh; display: flex; align-items: center;">
        <div class="container">
            <div style="max-width: 600px; margin: 0 auto; text-align: center;">
                <!-- Success Animation -->
                <div style="margin-bottom: 2rem;">
                    <div class="success-icon" style="font-size: 4rem; color: var(--accent-forest); margin-bottom: 1rem; animation: bounceIn 0.8s ease-out;">
                        ✅
                    </div>
                    <h1 style="color: var(--accent-forest); margin-bottom: 0.5rem;">
                        Order Confirmed!
                    </h1>
                    <p style="font-size: 1.1rem; color: var(--text-light); margin-bottom: 2rem;">
                        Thank you for your order. We're preparing your delicious meal!
                    </p>
                </div>

                <!-- Order Details Card -->
                <div class="form-container" style="text-align: left; margin-bottom: 2rem;">
                    <h3 style="color: var(--primary-dark); margin-bottom: 1.5rem; text-align: center; border-bottom: 2px solid var(--primary-gold); padding-bottom: 0.5rem;">
                        📋 Order Details
                    </h3>
                    
                    <div style="background: var(--primary-cream); padding: 1.5rem; border-radius: var(--border-radius-small); margin-bottom: 1.5rem;">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                            <div>
                                <strong style="color: var(--primary-dark);">Order ID:</strong>
                                <div style="font-size: 1.1rem; color: var(--primary-gold); font-weight: 600;">
                                    #${orderId}
                                </div>
                            </div>
                            <div>
                                <strong style="color: var(--primary-dark);">Order Total:</strong>
                                <div style="font-size: 1.3rem; color: var(--accent-forest); font-weight: 700;">
                                    ₹<fmt:formatNumber value="${orderTotal}" maxFractionDigits="2"/>
                                </div>
                            </div>
                        </div>
                        
                        <div style="margin-bottom: 1rem;">
                            <strong style="color: var(--primary-dark);">Payment Method:</strong>
                            <div style="margin-top: 0.25rem; color: var(--text-dark);">
                                <c:choose>
                                    <c:when test="${paymentMethod == 'Credit Card'}">💳 Credit/Debit Card</c:when>
                                    <c:when test="${paymentMethod == 'Digital Wallet'}">📱 Digital Wallet</c:when>
                                    <c:when test="${paymentMethod == 'Cash on Delivery'}">💵 Cash on Delivery</c:when>
                                    <c:otherwise>${paymentMethod}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div>
                            <strong style="color: var(--primary-dark);">Delivery Address:</strong>
                            <div style="margin-top: 0.25rem; color: var(--text-dark); line-height: 1.5;">
                                ${deliveryAddress}
                            </div>
                        </div>
                    </div>
                    
                    <!-- Delivery Information -->
                    <div style="background: #f0f8f0; border: 1px solid #d4e6d4; padding: 1.5rem; border-radius: var(--border-radius-small); text-align: center;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                            <div style="text-align: left;">
                                <strong style="color: var(--accent-forest);">🚚 Estimated Delivery Time</strong>
                                <div style="font-size: 1.2rem; color: var(--accent-forest); font-weight: 600; margin-top: 0.25rem;">
                                    35-45 minutes
                                </div>
                            </div>
                            <div style="text-align: right;">
                                <strong style="color: var(--accent-forest);">📍 Order Status</strong>
                                <div style="font-size: 1.1rem; color: var(--accent-forest); font-weight: 600; margin-top: 0.25rem;">
                                    Confirmed & Processing
                                </div>
                            </div>
                        </div>
                        
                        <div style="font-size: 0.9rem; color: var(--text-dark); line-height: 1.5;">
                            Your order has been confirmed and sent to the restaurant. You'll receive SMS updates about your order status.
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/home" class="btn">
                        🍽️ Order More Food
                    </a>
                    
                    <button onclick="window.print()" class="btn btn-secondary">
                        🖨️ Print Receipt
                    </button>
                </div>
                
                <!-- Contact Information -->
                <div style="margin-top: 3rem; padding: 2rem; background: var(--primary-cream); border-radius: var(--border-radius); text-align: center;">
                    <h4 style="color: var(--primary-dark); margin-bottom: 1rem;">
                        Need Help with Your Order?
                    </h4>
                    <p style="margin-bottom: 1.5rem; color: var(--text-dark);">
                        Our customer service team is here to help you 24/7
                    </p>
                    
                    <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap;">
                        <div style="text-align: center;">
                            <div style="font-size: 1.5rem; margin-bottom: 0.5rem;">📞</div>
                            <strong>Call Us</strong>
                            <div style="color: var(--primary-gold); font-weight: 600;">1-800-SAVORY-1</div>
                        </div>
                        
                        <div style="text-align: center;">
                            <div style="font-size: 1.5rem; margin-bottom: 0.5rem;">✉️</div>
                            <strong>Email Us</strong>
                            <div style="color: var(--primary-gold); font-weight: 600;">support@savoryexpress.com</div>
                        </div>
                        
                        <div style="text-align: center;">
                            <div style="font-size: 1.5rem; margin-bottom: 0.5rem;">💬</div>
                            <strong>Live Chat</strong>
                            <div style="color: var(--primary-gold); font-weight: 600;">Available 24/7</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>Savory Express</h3>
                    <p>Thank you for choosing Savory Express. We appreciate your business!</p>
                </div>
                
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home">Order Again</a></li>
                        <li><a href="${pageContext.request.contextPath}/index.jsp#about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/index.jsp#contact">Contact</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Customer Support</h3>
                    <ul>
                        <li>📞 1-800-SAVORY-1</li>
                        <li>✉️ support@savoryexpress.com</li>
                        <li>🕒 24/7 Support Available</li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Follow Your Order</h3>
                    <p>Track your order status and get real-time updates via SMS and email.</p>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Savory Express. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <style>
        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: scale(0.3) translateY(-50px);
            }
            50% {
                opacity: 1;
                transform: scale(1.1);
            }
            70% {
                transform: scale(0.95);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        @media print {
            .header, .footer, .btn {
                display: none !important;
            }
            
            body {
                background: white !important;
            }
            
            .form-container {
                box-shadow: none !important;
                border: 1px solid #ccc;
            }
        }
    </style>

    <script>
        // Add celebratory animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Add fade-in animation to elements
            const elements = document.querySelectorAll('.form-container > *');
            
            elements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    element.style.transition = 'all 0.6s ease-out';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, 500 + (index * 150));
            });

            // Simulate confetti effect (simple version)
            setTimeout(() => {
                createConfetti();
            }, 1000);
        });

        function createConfetti() {
            const colors = ['var(--primary-gold)', 'var(--accent-forest)', 'var(--accent-burgundy)'];
            const container = document.body;
            
            for (let i = 0; i < 50; i++) {
                setTimeout(() => {
                    const confetti = document.createElement('div');
                    confetti.style.position = 'fixed';
                    confetti.style.width = '10px';
                    confetti.style.height = '10px';
                    confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
                    confetti.style.left = Math.random() * 100 + 'vw';
                    confetti.style.top = '-20px';
                    confetti.style.borderRadius = '50%';
                    confetti.style.pointerEvents = 'none';
                    confetti.style.zIndex = '9999';
                    confetti.style.animation = 'fall 3s linear forwards';
                    
                    container.appendChild(confetti);
                    
                    setTimeout(() => {
                        confetti.remove();
                    }, 3000);
                }, i * 100);
            }
        }

        // Add CSS for confetti animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes fall {
                to {
                    transform: translateY(100vh) rotate(360deg);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);

        // Auto-redirect to home page after 60 seconds (optional)
        setTimeout(() => {
            const redirect = confirm('Would you like to browse more restaurants?');
            if (redirect) {
                window.location.href = '${pageContext.request.contextPath}/home';
            }
        }, 60000);
    </script>
</body>
</html>