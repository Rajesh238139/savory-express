<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Savory Express</title>
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
                        <li><a href="register.jsp">Register</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <!-- Login Section -->
    <section style="padding: 4rem 0; min-height: 70vh; display: flex; align-items: center;">
        <div class="container">
            <div class="form-container">
                <h2 style="text-align: center; margin-bottom: 2rem; color: var(--primary-dark);">
                    Welcome Back
                </h2>
                <p style="text-align: center; margin-bottom: 2rem; color: var(--text-light);">
                    Sign in to continue your culinary journey
                </p>

                <% if (request.getAttribute("loginError") != null) { %>
                    <div class="alert alert-error">
                        ${loginError}
                    </div>
                <% } %>

                <form action="auth" method="post">
                    <input type="hidden" name="action" value="login">
                    
                    <div class="form-group">
                        <label for="username" class="form-label">Username or Email</label>
                        <input type="text" 
                               id="username" 
                               name="username" 
                               class="form-input" 
                               required 
                               placeholder="Enter your username or email">
                    </div>

                    <div class="form-group">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               class="form-input" 
                               required 
                               placeholder="Enter your password">
                    </div>

                    <button type="submit" class="btn" style="width: 100%; margin-bottom: 1rem;">
                        Sign In
                    </button>
                </form>

                <div style="text-align: center; margin-top: 1.5rem;">
                    <p style="color: var(--text-light); margin: 0;">
                        Don't have an account? 
                        <a href="register.jsp" style="color: var(--primary-gold); font-weight: 600; text-decoration: none;">
                            Create Account
                        </a>
                    </p>
                </div>

                <div style="text-align: center; margin-top: 2rem; padding-top: 2rem; border-top: 1px solid #eee;">
                    <h4 style="color: var(--primary-dark); margin-bottom: 1rem;">Quick Demo Access</h4>
                    <div style="background: var(--primary-cream); padding: 1rem; border-radius: var(--border-radius-small); font-size: 0.9rem; color: var(--text-dark);">
                        <p style="margin-bottom: 0.5rem;"><strong>Demo Credentials:</strong></p>
                        <p style="margin: 0.25rem 0;">Username: <code>john_doe</code></p>
                        <p style="margin: 0.25rem 0;">Password: <code>password123</code></p>
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
        // Add form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (!username || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
                return false;
            }
        });

        // Auto-focus first input
        document.getElementById('username').focus();
    </script>
</body>
</html>