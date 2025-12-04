# 简易二手交易系统 - 项目文档

## 📋 项目简介
**简易二手交易系统**是一个基于Java Web技术实现的校园二手物品交易平台。系统采用经典的MVC架构，实现了用户注册登录、二手物品发布、模糊搜索、物品管理等核心功能。

## ✨ 主要特性
- ✅ 用户注册登录（密码MD5加密存储）
- ✅ 二手物品发布与管理
- ✅ 支持模糊搜索（标题/描述）
- ✅ 权限控制（只能操作自己的物品）
- ✅ 响应式网页设计
- ✅ 完整的MVC架构实现

## 🏗️ 系统架构设计

### MVC架构图：

```
┌─────────────────────────────────────────────────────┐
│                    View (JSP)                       │
│    ┌────────────┬────────────┬──────────────┐      │
│    │ index.jsp  │ login.jsp  │ publish.jsp  │ ...  │
│    └────────────┴────────────┴──────────────┘      │
└─────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────┐
│                Controller (Servlet)                  │
│    ┌──────────────┬────────────────┐                │
│    │ UserServlet  │   ItemServlet  │                │
│    └──────────────┴────────────────┘                │
└─────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────┐
│              Service (业务逻辑层)                    │
│    ┌──────────────┬────────────────┐                │
│    │ UserService  │   ItemService  │                │
│    └──────────────┴────────────────┘                │
└─────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────┐
│                DAO (数据访问层)                      │
│    ┌──────────────┬────────────────┐                │
│    │   UserDao    │    ItemDao     │                │
│    └──────────────┴────────────────┘                │
└─────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────┐
│               Database (MySQL)                       │
│    ┌──────────────────────────────────────┐         │
│    │         secondhand_db                │         │
│    │  ┌─────────────┬──────────────┐     │         │
│    │  │   users     │    items     │     │         │
│    │  └─────────────┴──────────────┘     │         │
│    └──────────────────────────────────────┘         │
└─────────────────────────────────────────────────────┘
```

## 📁 项目目录结构

```
web6/
├── src/main/java/com/example/web6/
│   ├── controller/           # Servlet控制器
│   │   ├── UserServlet.java  # 用户相关控制器
│   │   └── ItemServlet.java  # 物品相关控制器
│   ├── dao/                  # 数据访问层
│   │   ├── UserDao.java      # 用户数据访问
│   │   └── ItemDao.java      # 物品数据访问
│   ├── service/              # 业务逻辑层
│   │   ├── UserService.java  # 用户业务逻辑
│   │   └── ItemService.java  # 物品业务逻辑
│   ├── model/                # 实体类
│   │   ├── User.java         # 用户实体
│   │   └── Item.java         # 物品实体
│   └── util/                 # 工具类
│       ├── DBUtil.java       # 数据库连接工具
│       └── PasswordUtil.java # 密码加密工具
├── src/main/webapp/          # Web资源文件
│   ├── WEB-INF/
│   │   └── web.xml           # 部署描述符
│   ├── views/                # JSP视图文件
│   │   ├── index.jsp         # 首页
│   │   ├── login.jsp         # 登录页
│   │   ├── register.jsp      # 注册页
│   │   ├── publish.jsp       # 发布页
│   │   ├── search.jsp        # 搜索页
│   │   ├── itemList.jsp      # 物品列表页
│   │   ├── header.jsp        # 公共头部
│   │   └── footer.jsp        # 公共底部
│   ├── css/                  # 样式文件
│   │   └── style.css         # 主样式表
│   └── index.jsp             # 欢迎页
├── pom.xml                   # Maven配置文件
└── README.md                 # 项目说明文档
```

## 🗄️ 数据库设计

### 1. 数据库表结构

#### 用户表 (users)
| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| id | INT | PRIMARY KEY AUTO_INCREMENT | 用户ID |
| username | VARCHAR(50) | NOT NULL UNIQUE | 用户名（唯一） |
| password | VARCHAR(100) | NOT NULL | 密码（MD5加密） |
| email | VARCHAR(100) | - | 邮箱 |
| phone | VARCHAR(20) | - | 电话 |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

#### 物品表 (items)
| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| id | INT | PRIMARY KEY AUTO_INCREMENT | 物品ID |
| user_id | INT | NOT NULL, FOREIGN KEY | 发布者ID |
| title | VARCHAR(100) | NOT NULL | 物品标题 |
| description | TEXT | - | 物品描述 |
| category | VARCHAR(50) | - | 物品分类 |
| price | DECIMAL(10,2) | - | 价格 |
| status | VARCHAR(20) | DEFAULT 'available' | 状态：available/sold |
| image_url | VARCHAR(200) | - | 图片URL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | 发布时间 |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

### 2. 表关系说明
- **主外键关系**：items.user_id → users.id
- **级联删除**：删除用户时自动删除其发布的物品
- **一对多关系**：一个用户可以发布多个物品

### 3. 数据库初始化脚本

```sql
-- 创建数据库
CREATE DATABASE IF NOT EXISTS secondhand_db;

USE secondhand_db;

-- 创建用户表
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建物品表
CREATE TABLE items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    price DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'available',
    image_url VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 插入测试用户（密码均为123456的MD5加密）
INSERT INTO users (username, password, email, phone) VALUES
('user1', 'e10adc3949ba59abbe56e057f20f883e', 'user1@example.com', '13800138001'),
('user2', 'e10adc3949ba59abbe56e057f20f883e', 'user2@example.com', '13800138002'),
('admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin@example.com', '13800138003');

-- 插入测试物品
INSERT INTO items (user_id, title, description, category, price, image_url) VALUES
(1, '二手iPhone 12', '99新，使用一年，功能完好，电池健康度88%', '电子数码', 2999.00, 'https://picsum.photos/300/200?random=1'),
(2, 'Java编程技术教材', '第三版，微课版，有少量笔记', '图书教材', 45.00, 'https://picsum.photos/300/200?random=2'),
(1, '运动自行车', '山地车，24速，适合校园骑行', '运动器材', 350.00, 'https://picsum.photos/300/200?random=3'),
(3, '笔记本电脑包', '几乎全新，保护效果好', '生活用品', 50.00, 'https://picsum.photos/300/200?random=4'),
(2, '冬季外套', 'L码，只穿过几次，保暖性好', '服饰鞋包', 120.00, 'https://picsum.photos/300/200?random=5'),
(1, 'Kindle电子书阅读器', 'PaperWhite 4，带保护套', '电子数码', 450.00, 'https://picsum.photos/300/200?random=6'),
(3, '高级计算器', '科学计算器，考试用', '生活用品', 35.00, 'https://picsum.photos/300/200?random=7'),
(2, '篮球', '斯伯丁篮球，7成新', '运动器材', 60.00, 'https://picsum.photos/300/200?random=8');
```

## 🔑 测试账号

| 用户名 | 密码 |
|--------|------|
| user1 | 123456 |
| user2 | 123456 |
| admin | 123456 |

**密码说明**：所有密码使用MD5加密存储，123456对应的MD5值为：`e10adc3949ba59abbe56e057f20f883e`

## 🎯 功能模块

### 1. 用户模块
- **用户注册**：新用户填写用户名、密码等信息注册账号
- **用户登录**：已注册用户使用用户名密码登录
- **密码安全**：所有密码使用MD5算法加密存储
- **会话管理**：使用HttpSession管理用户登录状态

### 2. 物品发布模块
- **发布物品**：登录用户可以发布二手物品
- **物品信息**：包括标题、描述、分类、价格、图片等（上传图片时使用该免费图片网址，随机生成图片: https://picsum.photos/300/200?random=）
- **实时预览**：发布前可预览物品信息

### 3. 搜索模块
- **模糊搜索**：支持对物品标题和描述的模糊匹配
- **分类筛选**：可按电子数码、图书教材、服饰鞋包等分类筛选
- **实时显示**：搜索结果实时显示匹配数量

### 4. 管理模块
- **我的发布**：查看自己发布的所有物品
- **编辑物品**：修改已发布物品的信息
- **删除物品**：删除不再出售的物品
- **权限控制**：只能操作自己发布的物品

## 🌐 访问路径
- `http://localhost:8080/web6_war_exploded/`
- `http://localhost:8080/web6_war_exploded/views/login.jsp`
- `http://localhost:8080/web6_war_exploded/views/index.jsp`

## 🔒 安全特性
- **密码加密**：使用MD5算法加密存储用户密码
- **输入验证**：所有用户输入都进行基本验证
- **会话管理**：使用HttpSession防止未授权访问
- **权限控制**：严格检查操作权限，防止越权操作

## 🗄️ 数据库连接

```java
// 连接池配置
public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/secondhand_db?useUnicode=true&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Shanghai";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";
    
    // 使用JDBC连接MySQL
}
```

## 💻 前端技术
- **响应式设计**：适配不同屏幕尺寸
- **CSS样式**：自定义样式表，美观简洁
- **JavaScript**：表单验证、图片预览等功能
- **JSTL标签**：简化JSP页面逻辑
