<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Savory Express</title>
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
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="login.jsp">Login</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <!-- Register Section -->
    <section style="padding: 4rem 0; min-height: 70vh;">
        <div class="container">
            <div class="form-container">
                <h2 style="text-align: center; margin-bottom: 2rem; color: var(--primary-dark);">
                    Join Savory Express
                </h2>
                <p style="text-align: center; margin-bottom: 2rem; color: var(--text-light);">
                    Create your account and start enjoying premium food delivery
                </p>

                <% if (request.getAttribute("registerError") != null) { %>
                    <div class="alert alert-error">
                        ${registerError}
                    </div>
                <% } %>

                <form action="auth" method="post" id="registerForm">
                    <input type="hidden" name="action" value="register">
                    
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="username" class="form-label">Username *</label>
                            <input type="text" 
                                   id="username" 
                                   name="username" 
                                   class="form-input" 
                                   required 
                                   placeholder="Choose a username">
                        </div>

                        <div class="form-group">
                            <label for="email" class="form-label">Email *</label>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   class="form-input" 
                                   required 
                                   placeholder="Enter your email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="fullName" class="form-label">Full Name *</label>
                        <input type="text" 
                               id="fullName" 
                               name="fullName" 
                               class="form-input" 
                               required 
                               placeholder="Enter your full name">
                    </div>

                    <div class="form-group">
                        <label for="password" class="form-label">Password *</label>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               class="form-input" 
                               required 
                               placeholder="Create a strong password"
                               minlength="6">
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">Confirm Password *</label>
                        <input type="password" 
                               id="confirmPassword" 
                               name="confirmPassword" 
                               class="form-input" 
                               required 
                               placeholder="Confirm your password"
                               minlength="6">
                    </div>

                    <div class="form-group">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" 
                               id="phone" 
                               name="phone" 
                               class="form-input" 
                               placeholder="Enter your phone number">
                    </div>

                    <div class="form-group">
                        <label for="address" class="form-label">Delivery Address</label>
                        <textarea id="address" 
                                  name="address" 
                                  class="form-textarea" 
                                  placeholder="Enter your default delivery address"
                                  rows="3"></textarea>
                    </div>

                    <button type="submit" class="btn" style="width: 100%; margin-bottom: 1rem;">
                        Create Account
                    </button>
                </form>

                <div style="text-align: center; margin-top: 1.5rem;">
                    <p style="color: var(--text-light); margin: 0;">
                        Already have an account? 
                        <a href="login.jsp" style="color: var(--primary-gold); font-weight: 600; text-decoration: none;">
                            Sign In
                        </a>
                    </p>
                </div>

                <div style="text-align: center; margin-top: 2rem; padding-top: 2rem; border-top: 1px solid #eee;">
                    <p style="font-size: 0.9rem; color: var(--text-light); line-height: 1.5;">
                        By creating an account, you agree to our 
                        <a href="#" style="color: var(--primary-gold);">Terms of Service</a> and 
                        <a href="#" style="color: var(--primary-gold);">Privacy Policy</a>
                    </p>
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
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const fullName = document.getElementById('fullName').value.trim();
            
            // Check required fields
            if (!username || !email || !password || !fullName) {
                e.preventDefault();
                alert('Please fill in all required fields (marked with *)');
                return false;
            }
            
            // Password validation
            if (password.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long');
                return false;
            }
            
            // Password confirmation
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match');
                return false;
            }
            
            // Email format validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }
        });

        // Real-time password confirmation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.setCustomValidity('Passwords do not match');
                this.style.borderColor = 'var(--accent-burgundy)';
            } else {
                this.setCustomValidity('');
                this.style.borderColor = '#ddd';
            }
        });

        // Auto-focus first input
        document.getElementById('username').focus();
    </script>
</body>
</html>