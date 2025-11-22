<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Premium Food Delivery - Gourmet Cuisine at Your Doorstep</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <a href="index.jsp" class="logo">🍽️ Savory Express</a>
                
                <nav>
                    <ul class="nav-menu">
                        <li><a href="home">Browse Restaurants</a></li>
                        <li><a href="#about">About Us</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                </nav>
                
                <div class="user-section">
                    <% if (session.getAttribute("user") != null) { %>
                        <a href="cart" class="cart-icon">
                            🛒 <span class="cart-count" id="cartCount">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
                        </a>
                        <span>Hello, ${user.fullName}</span>
                        <form action="auth" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="logout">
                            <button type="submit" class="btn btn-small">Logout</button>
                        </form>
                    <% } else { %>
                        <a href="login.jsp" class="btn btn-small">Login</a>
                        <a href="register.jsp" class="btn btn-small">Register</a>
                    <% } %>
                </div>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <h1>Exquisite Cuisine, Delivered Fresh</h1>
                <p>Experience the finest restaurants and gourmet meals delivered to your doorstep with elegance and speed</p>
                <a href="home" class="btn" style="font-size: 1.2rem; padding: 1.2rem 2.5rem;">Explore Restaurants</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section" style="padding: 4rem 0; background: white;">
        <div class="container">
            <h2 style="text-align: center; margin-bottom: 3rem; color: var(--primary-dark);">Why Choose Savory Express?</h2>
            
            <div class="features-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                <div class="feature-card" style="text-align: center; padding: 2rem; background: var(--primary-cream); border-radius: var(--border-radius); box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">⚡</div>
                    <h3>Lightning Fast Delivery</h3>
                    <p>Premium ingredients delivered fresh to your door in record time, maintaining quality and temperature.</p>
                </div>
                
                <div class="feature-card" style="text-align: center; padding: 2rem; background: var(--primary-cream); border-radius: var(--border-radius); box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">👨‍🍳</div>
                    <h3>Master Chef Partners</h3>
                    <p>Collaborate with the finest chefs and restaurants to bring you authentic, gourmet dining experiences.</p>
                </div>
                
                <div class="feature-card" style="text-align: center; padding: 2rem; background: var(--primary-cream); border-radius: var(--border-radius); box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">🌟</div>
                    <h3>Premium Quality</h3>
                    <p>Every meal is crafted with the highest standards, using only the finest, freshest ingredients available.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Popular Cuisines Section -->
    <section class="cuisines-section" style="padding: 4rem 0; background: var(--gradient-gold);">
        <div class="container">
            <h2 style="text-align: center; margin-bottom: 3rem; color: var(--primary-dark);">Popular Cuisines</h2>
            
            <div class="cuisines-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem;">
                <a href="home?cuisine=Indian" class="cuisine-card interactive-hover" style="display: block; text-align: center; padding: 2rem 1rem; background: white; border-radius: var(--border-radius); text-decoration: none; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">🍛</div>
                    <h4 style="color: var(--primary-dark); margin-bottom: 0.5rem;">Indian</h4>
                    <p style="color: var(--text-light); margin: 0; font-size: 0.9rem;">Spicy & Authentic</p>
                </a>
                
                <a href="home?cuisine=Italian" class="cuisine-card interactive-hover" style="display: block; text-align: center; padding: 2rem 1rem; background: white; border-radius: var(--border-radius); text-decoration: none; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">🍝</div>
                    <h4 style="color: var(--primary-dark); margin-bottom: 0.5rem;">Italian</h4>
                    <p style="color: var(--text-light); margin: 0; font-size: 0.9rem;">Classic & Elegant</p>
                </a>
                
                <a href="home?cuisine=Chinese" class="cuisine-card interactive-hover" style="display: block; text-align: center; padding: 2rem 1rem; background: white; border-radius: var(--border-radius); text-decoration: none; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">🥢</div>
                    <h4 style="color: var(--primary-dark); margin-bottom: 0.5rem;">Chinese</h4>
                    <p style="color: var(--text-light); margin: 0; font-size: 0.9rem;">Fresh & Traditional</p>
                </a>
                
                <a href="home?cuisine=Mexican" class="cuisine-card interactive-hover" style="display: block; text-align: center; padding: 2rem 1rem; background: white; border-radius: var(--border-radius); text-decoration: none; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">🌮</div>
                    <h4 style="color: var(--primary-dark); margin-bottom: 0.5rem;">Mexican</h4>
                    <p style="color: var(--text-light); margin: 0; font-size: 0.9rem;">Bold & Vibrant</p>
                </a>
                
                <a href="home?cuisine=Japanese" class="cuisine-card interactive-hover" style="display: block; text-align: center; padding: 2rem 1rem; background: white; border-radius: var(--border-radius); text-decoration: none; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">🍣</div>
                    <h4 style="color: var(--primary-dark); margin-bottom: 0.5rem;">Japanese</h4>
                    <p style="color: var(--text-light); margin: 0; font-size: 0.9rem;">Pure & Refined</p>
                </a>
                
                <a href="home?cuisine=American" class="cuisine-card interactive-hover" style="display: block; text-align: center; padding: 2rem 1rem; background: white; border-radius: var(--border-radius); text-decoration: none; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">🍔</div>
                    <h4 style="color: var(--primary-dark); margin-bottom: 0.5rem;">American</h4>
                    <p style="color: var(--text-light); margin: 0; font-size: 0.9rem;">Comfort & Hearty</p>
                </a>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="about-section" style="padding: 4rem 0; background: white;">
        <div class="container">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: center;">
                <div>
                    <h2 style="color: var(--primary-dark); margin-bottom: 2rem;">Our Story</h2>
                    <p style="font-size: 1.1rem; line-height: 1.8; margin-bottom: 1.5rem;">
                        Born from a passion for exceptional cuisine and impeccable service, Savory Express connects food enthusiasts with the finest restaurants in the city. We believe that great food should be accessible, convenient, and delivered with the same care as dining in the restaurant itself.
                    </p>
                    <p style="font-size: 1.1rem; line-height: 1.8; margin-bottom: 2rem;">
                        Our carefully curated selection of partner restaurants ensures that every meal meets our high standards of quality, freshness, and taste. From family-owned gems to award-winning establishments, we bring the city's best flavors directly to your table.
                    </p>
                    <a href="home" class="btn">Start Your Culinary Journey</a>
                </div>
                <div style="text-align: center;">
                    <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=600&h=400&fit=crop&q=80" 
                         alt="Restaurant Kitchen" 
                         style="width: 100%; max-width: 500px; border-radius: var(--border-radius); box-shadow: 0 10px 40px rgba(0,0,0,0.15);">
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
                    <p>Delivering exceptional cuisine with unmatched elegance and speed. Your satisfaction is our culinary masterpiece.</p>
                    <div style="margin-top: 1rem;">
                        <span style="color: var(--primary-gold);">⭐⭐⭐⭐⭐</span>
                        <span style="color: #ccc; margin-left: 0.5rem;">Rated #1 Food Delivery</span>
                    </div>
                </div>
                
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="home">Browse Restaurants</a></li>
                        <li><a href="#cuisines">Popular Cuisines</a></li>
                        <li><a href="#about">About Us</a></li>
                        <li><a href="cart">My Cart</a></li>
                        <li><a href="#contact">Contact Support</a></li>
                    </ul>
                </div>
                
                <div class="footer-section">
                    <h3>Customer Care</h3>
                    <ul>
                        <li>📞 1-800-SAVORY-1</li>
                        <li>✉️ support@savoryexpress.com</li>
                        <li>🕒 24/7 Customer Support</li>
                        <li>💬 Live Chat Available</li>
                    </ul>
                </div>
                
                <div class="footer-section" id="contact">
                    <h3>Connect With Us</h3>
                    <p>Follow us for the latest updates, exclusive offers, and culinary inspiration.</p>
                    <div style="margin-top: 1rem;">
                        <a href="#" style="margin-right: 1rem; font-size: 1.5rem;">📘</a>
                        <a href="#" style="margin-right: 1rem; font-size: 1.5rem;">📷</a>
                        <a href="#" style="margin-right: 1rem; font-size: 1.5rem;">🐦</a>
                        <a href="#" style="font-size: 1.5rem;">📺</a>
                    </div>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2024 Savory Express. All rights reserved. | Privacy Policy | Terms of Service | Cookie Policy</p>
            </div>
        </div>
    </footer>

    <script>
        // Simple cart count update (you would integrate with actual cart data)
        function updateCartCount() {
            // This would be implemented with AJAX to get real cart count
            // For now, it's just a placeholder
        }

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Add animation on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-fade-in');
                }
            });
        }, observerOptions);

        // Observe all feature cards and cuisine cards
        document.querySelectorAll('.feature-card, .cuisine-card').forEach(card => {
            observer.observe(card);
        });
    </script>
</body>
</html>