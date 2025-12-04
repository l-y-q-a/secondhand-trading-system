package com.example.web6.controller;

import com.example.web6.model.Item;
import com.example.web6.model.User;
import com.example.web6.service.ItemService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ItemServlet", value = "/item/*")
public class ItemServlet extends HttpServlet {
    private ItemService itemService = new ItemService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }

        switch (action) {
            case "/list":
                listItems(request, response);
                break;
            case "/search":
                searchItems(request, response);
                break;
            case "/myItems":
                myItems(request, response, user);
                break;
            case "/delete":
                deleteItem(request, response, user);
                break;
            case "/edit":
                showEditForm(request, response, user);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/index.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }

        switch (action) {
            case "/add":
                addItem(request, response, user);
                break;
            case "/update":
                updateItem(request, response, user);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/index.jsp");
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> items = itemService.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("/views/itemList.jsp").forward(request, response);
    }

    private void searchItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Item> items;

        if (keyword == null || keyword.trim().isEmpty()) {
            items = itemService.getAllItems();
        } else {
            items = itemService.searchItems(keyword);
        }

        request.setAttribute("items", items);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/views/itemList.jsp").forward(request, response);
    }

    private void myItems(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        List<Item> items = itemService.getItemsByUser(user.getId());
        request.setAttribute("items", items);
        request.getRequestDispatcher("/views/itemList.jsp").forward(request, response);
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");

        if (title == null || title.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            request.setAttribute("error", "标题和描述不能为空！");
            request.getRequestDispatcher("/views/publish.jsp").forward(request, response);
            return;
        }

        double price = 0;
        try {
            price = Double.parseDouble(priceStr);
            if (price < 0) {
                request.setAttribute("error", "价格不能为负数！");
                request.getRequestDispatcher("/views/publish.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            request.setAttribute("error", "价格格式不正确！");
            request.getRequestDispatcher("/views/publish.jsp").forward(request, response);
            return;
        }

        Item item = new Item(user.getId(), title, description, category, price);
        item.setImageUrl(imageUrl);

        if (itemService.addItem(item)) {
            response.sendRedirect(request.getContextPath() + "/item/myItems");
        } else {
            request.setAttribute("error", "发布失败！");
            request.getRequestDispatcher("/views/publish.jsp").forward(request, response);
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");

        int id = 0;
        double price = 0;
        try {
            id = Integer.parseInt(idStr);
            price = Double.parseDouble(priceStr);
            if (price < 0) {
                request.setAttribute("error", "价格不能为负数！");
                response.sendRedirect(request.getContextPath() + "/item/myItems");
                return;
            }
        } catch (Exception e) {
            request.setAttribute("error", "参数格式不正确！");
            response.sendRedirect(request.getContextPath() + "/item/myItems");
            return;
        }

        Item item = itemService.getItemById(id);
        if (item == null || item.getUserId() != user.getId()) {
            request.setAttribute("error", "无权修改此物品！");
            response.sendRedirect(request.getContextPath() + "/item/myItems");
            return;
        }

        item.setTitle(title);
        item.setDescription(description);
        item.setCategory(category);
        item.setPrice(price);
        item.setImageUrl(imageUrl);

        if (itemService.updateItem(item)) {
            response.sendRedirect(request.getContextPath() + "/item/myItems");
        } else {
            request.setAttribute("error", "更新失败！");
            request.setAttribute("item", item);
            request.setAttribute("edit", true);
            request.getRequestDispatcher("/views/publish.jsp").forward(request, response);
        }
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            if (itemService.deleteItem(id, user.getId())) {
                request.getSession().setAttribute("message", "删除成功！");
            } else {
                request.getSession().setAttribute("error", "删除失败！");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "参数错误！");
        }

        response.sendRedirect(request.getContextPath() + "/item/myItems");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            Item item = itemService.getItemById(id);

            if (item != null && item.getUserId() == user.getId()) {
                request.setAttribute("item", item);
                request.setAttribute("edit", true);
                request.getRequestDispatcher("/views/publish.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/item/myItems");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/item/myItems");
        }
    }
}