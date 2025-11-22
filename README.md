# Premium Food Delivery Application

A comprehensive end-to-end food delivery web application built with Jakarta EE (JSP), Servlets, JDBC, and MySQL. Features an elegant vintage-inspired UI that rivals modern food delivery platforms.

## 🚀 Features

### User Features
- **User Registration & Authentication** - Secure login/logout system
- **Restaurant Browse & Search** - Filter by cuisine, search restaurants
- **Menu Browsing** - View detailed menus with categories and items
- **Shopping Cart** - Add, update, remove items with real-time calculations
- **Secure Checkout** - Multiple payment options and delivery details
- **Order Confirmation** - Professional order receipt and tracking info

### Technical Features
- **Jakarta EE Architecture** - Modern enterprise Java web application
- **Servlet-based Controllers** - Clean separation of concerns with `@WebServlet` annotations
- **JSP with EL** - Server-side rendering with Expression Language
- **MySQL Database** - Comprehensive schema with relationships
- **Responsive Design** - Mobile-friendly vintage-elegant UI
- **JDBC Integration** - Direct database operations with connection pooling

### UI/UX Highlights
- **Vintage-Elegant Design** - Classic color palette with modern interactions
- **Smooth Animations** - CSS transitions and hover effects
- **Professional Typography** - Georgia serif and Helvetica sans-serif
- **Interactive Elements** - Engaging buttons, cards, and form controls
- **Accessibility** - Proper form labels, semantic HTML, keyboard navigation

## 🛠️ Tech Stack

- **Backend:** Java 21, Jakarta EE, Servlets, JSP, JDBC
- **Database:** MySQL 8.0+
- **Frontend:** HTML5, CSS3, Vanilla JavaScript
- **Server:** Apache Tomcat 10
- **Build Tool:** Maven
- **IDE:** Eclipse with Jakarta EE support

## 📋 Prerequisites

- **JDK 21** or later
- **Apache Tomcat 10** 
- **MySQL Server 8.0+**
- **Eclipse IDE** with Jakarta EE Developer Tools
- **Maven** (for dependency management)

## ⚡ Quick Start

### 1. Database Setup
```sql
-- Create database
CREATE DATABASE food_delivery_db;

-- Import schema and sample data
mysql -u root -p food_delivery_db < database/schema.sql
mysql -u root -p food_delivery_db < database/sample_data.sql
```

### 2. Configuration
Update database credentials in `DatabaseConnection.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/food_delivery_db";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

### 3. Build & Deploy
```bash
# Build the project
mvn clean compile war:war

# Deploy to Tomcat
# Copy target/premium-food-delivery.war to Tomcat webapps directory
cp target/premium-food-delivery.war $TOMCAT_HOME/webapps/
```

### 4. Run Application
1. Start Tomcat server
2. Open browser to `http://localhost:8080/premium-food-delivery`
3. Register new account or use demo credentials:
   - Username: `john_doe`
   - Password: `password123`

## 📁 Project Structure

```
src/main/
├── java/com/fooddelivery/
│   ├── dao/              # Data Access Objects
│   ├── model/            # Entity classes
│   ├── servlet/          # Controllers (@WebServlet)
│   └── util/             # Utilities (DB connection)
├── webapp/
│   ├── WEB-INF/
│   │   ├── views/        # JSP pages
│   │   └── web.xml       # Deployment descriptor
│   ├── css/              # Stylesheets
│   ├── index.jsp         # Landing page
│   ├── login.jsp         # Authentication
│   └── register.jsp      # User registration
└── resources/
database/
├── schema.sql            # Database structure
└── sample_data.sql       # Test data
```

## 🎨 Design System

### Color Palette
- **Primary Gold:** `#D4AF37` - Elegant accent color
- **Primary Dark:** `#2C1810` - Rich text and backgrounds  
- **Primary Cream:** `#F5F1E8` - Warm background tone
- **Accent Burgundy:** `#8B0000` - Error states and highlights
- **Accent Forest:** `#355E3B` - Success states and vegetarian tags

### Typography
- **Headers:** Georgia serif for elegance
- **Body:** Helvetica Neue for readability
- **Interactive:** Medium weight for buttons and links

### Component Library
- **Restaurant Cards** - Hover animations with image scaling
- **Menu Items** - Detailed cards with add-to-cart functionality
- **Form Controls** - Consistent styling with focus states
- **Buttons** - Multiple variants with smooth transitions

## 🗃️ Database Schema

### Core Tables
- `users` - User accounts and profiles
- `restaurants` - Restaurant information and metadata
- `menu_categories` - Organized menu sections
- `menu_items` - Food items with pricing and details
- `cart` - Temporary shopping cart storage
- `orders` - Order history and tracking
- `order_items` - Individual items per order

### Key Relationships
- Users → Cart Items (One-to-Many)
- Restaurants → Menu Items (One-to-Many) 
- Orders → Order Items (One-to-Many)
- Menu Categories → Menu Items (One-to-Many)

## 🔒 Security Features

- **Input Validation** - Server-side validation for all forms
- **SQL Injection Prevention** - Parameterized queries throughout
- **Session Management** - Secure user sessions with timeout
- **Authentication Guards** - Protected routes requiring login
- **XSS Prevention** - Proper output encoding in JSP pages

## 📱 Responsive Design

- **Mobile-First** - Optimized for all screen sizes
- **Flexible Grid** - CSS Grid and Flexbox layouts
- **Touch-Friendly** - Appropriate touch targets and gestures
- **Progressive Enhancement** - Works without JavaScript

## 🚀 Performance Optimizations

- **Database Indexing** - Optimized queries with proper indexes
- **Image Optimization** - Responsive images with proper sizing
- **CSS Minification** - Compressed stylesheets for production
- **Caching Headers** - Browser caching for static resources

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 🙏 Acknowledgments

- **Unsplash** - High-quality food photography
- **Jakarta EE Community** - Comprehensive documentation
- **MySQL** - Reliable database platform
- **Apache Tomcat** - Robust servlet container

---

**Built with ❤️ using Jakarta EE and modern web technologies**
