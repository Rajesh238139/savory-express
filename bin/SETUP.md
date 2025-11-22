# Setup Instructions for Premium Food Delivery Application

This guide provides step-by-step instructions to set up and run the Premium Food Delivery application locally.

## Prerequisites

Before starting, ensure you have the following installed:

### Required Software
1. **JDK 21 or later**
   - Download from [Oracle](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://openjdk.org/)
   - Verify installation: `java -version`

2. **Apache Tomcat 10**
   - Download from [Apache Tomcat](https://tomcat.apache.org/download-10.cgi)
   - Extract to a directory (e.g., `/opt/tomcat` or `C:\tomcat`)
   - Set `CATALINA_HOME` environment variable

3. **MySQL Server 8.0+**
   - Download from [MySQL Community Server](https://dev.mysql.com/downloads/mysql/)
   - Install and start the MySQL service
   - Note the root password for later use

4. **Eclipse IDE for Enterprise Java and Web Developers**
   - Download from [Eclipse IDE](https://www.eclipse.org/downloads/packages/)
   - Or use IntelliJ IDEA Ultimate with Jakarta EE support

5. **Maven** (if not included with IDE)
   - Download from [Apache Maven](https://maven.apache.org/download.cgi)
   - Verify installation: `mvn -version`

## Step 1: Database Setup

### 1.1 Create Database
Open MySQL command line or MySQL Workbench and run:

```sql
CREATE DATABASE food_delivery_db;
USE food_delivery_db;
```

### 1.2 Import Schema
Execute the schema file to create tables:

```sql
-- Copy and run the contents of database/schema.sql
-- Or import via command line:
mysql -u root -p food_delivery_db < database/schema.sql
```

### 1.3 Import Sample Data
Execute the sample data file:

```sql
-- Copy and run the contents of database/sample_data.sql
-- Or import via command line:
mysql -u root -p food_delivery_db < database/sample_data.sql
```

### 1.4 Verify Database Setup
Check if tables are created and populated:

```sql
SHOW TABLES;
SELECT COUNT(*) FROM restaurants;
SELECT COUNT(*) FROM menu_items;
SELECT COUNT(*) FROM users;
```

You should see:
- 8 tables created
- 6 restaurants
- Multiple menu items
- 2 sample users

## Step 2: Project Configuration

### 2.1 Update Database Connection
Edit `src/main/java/com/fooddelivery/util/DatabaseConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/food_delivery_db";
private static final String USERNAME = "root";  // Your MySQL username
private static final String PASSWORD = "your_password";  // Your MySQL password
```

### 2.2 Verify Maven Dependencies
Check that `pom.xml` includes all required dependencies:
- Jakarta Servlet API
- Jakarta JSP API
- JSTL
- MySQL Connector/J
- JSON Processing

## Step 3: Eclipse IDE Setup

### 3.1 Import Project
1. Open Eclipse IDE
2. Go to `File` > `Import`
3. Select `Maven` > `Existing Maven Projects`
4. Browse to your project directory
5. Select the project and click `Finish`

### 3.2 Configure Tomcat Server
1. Go to `Window` > `Preferences`
2. Navigate to `Server` > `Runtime Environments`
3. Click `Add...` and select `Apache Tomcat v10.0`
4. Set Tomcat installation directory
5. Select JDK 21 as the JRE
6. Click `Finish`

### 3.3 Add Server to Project
1. Right-click in `Servers` view
2. Select `New` > `Server`
3. Choose `Tomcat v10.0 Server`
4. Click `Next` and add your project to the server
5. Click `Finish`

## Step 4: Build and Deploy

### 4.1 Build Project
1. Right-click on project in Eclipse
2. Select `Run As` > `Maven build...`
3. Set Goals: `clean compile war:war`
4. Click `Run`

### 4.2 Deploy to Tomcat
1. Right-click on Tomcat server in `Servers` view
2. Select `Add and Remove...`
3. Move your project from `Available` to `Configured`
4. Click `Finish`

### 4.3 Start Server
1. Right-click on Tomcat server
2. Select `Start`
3. Wait for server to start (check console for "Server startup")

## Step 5: Test Application

### 5.1 Open Application
Open your browser and navigate to:
```
http://localhost:8080/premium-food-delivery
```

### 5.2 Test User Registration
1. Click "Register" in the top navigation
2. Fill out the registration form
3. Submit and verify you're logged in

### 5.3 Test Demo Login
Use the provided demo credentials:
- **Username:** `john_doe`
- **Password:** `password123`

### 5.4 Test Core Features
1. **Browse Restaurants** - View restaurant listings
2. **View Menu** - Click on a restaurant to see its menu
3. **Add to Cart** - Add menu items to your shopping cart
4. **Checkout Process** - Complete an order (test mode)

## Step 6: Troubleshooting

### Common Issues and Solutions

#### Database Connection Issues
**Error:** `Unable to connect to MySQL server`

**Solution:**
1. Verify MySQL server is running
2. Check username/password in `DatabaseConnection.java`
3. Ensure database `food_delivery_db` exists
4. Verify MySQL is listening on port 3306

#### Tomcat Startup Issues
**Error:** `Port 8080 already in use`

**Solution:**
1. Change Tomcat port in server configuration
2. Or kill process using port 8080
3. Restart Tomcat server

#### Maven Build Issues
**Error:** `Maven dependencies not resolved`

**Solution:**
1. Right-click project > `Maven` > `Reload Projects`
2. Check internet connection
3. Verify Maven settings

#### JSP Compilation Issues
**Error:** `JSP pages not compiling`

**Solution:**
1. Verify Jakarta JSP API is in dependencies
2. Check JSP syntax in error logs
3. Clean and rebuild project

### Verification Checklist

- [ ] MySQL server is running
- [ ] Database and tables are created
- [ ] Sample data is inserted
- [ ] Database connection credentials are correct
- [ ] Tomcat server starts without errors
- [ ] Application opens in browser
- [ ] Can register new user
- [ ] Can login with demo credentials
- [ ] Can browse restaurants
- [ ] Can view restaurant menus
- [ ] Can add items to cart
- [ ] Can complete checkout process

## Step 7: Optional Enhancements

### 7.1 Enable SSL (HTTPS)
Configure Tomcat for SSL by editing `server.xml` and adding SSL connector.

### 7.2 Production Database
For production, consider:
- Creating a dedicated database user
- Setting up connection pooling
- Configuring database backups

### 7.3 Logging Configuration
Add logging framework like Logback for better error tracking.

## Getting Help

If you encounter issues:

1. **Check Console Logs** - Look for error messages in Eclipse console or Tomcat logs
2. **Database Logs** - Check MySQL error logs
3. **Verify Prerequisites** - Ensure all required software versions are correct
4. **Test Components** - Test database connection, Tomcat, and Maven separately

## Success Indicators

Your setup is successful when:
- Application loads at `http://localhost:8080/premium-food-delivery`
- You can register and login
- Restaurant listings display with images
- Menu pages load with food items
- Cart functionality works
- Checkout process completes

---

**Congratulations! Your Premium Food Delivery application is now running locally.**