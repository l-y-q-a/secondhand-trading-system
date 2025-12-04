package com.example.web6.service;

import com.example.web6.dao.UserDao;
import com.example.web6.model.User;

public class UserService {
    private UserDao userDao = new UserDao();

    public boolean register(User user) {
        if (userDao.usernameExists(user.getUsername())) {
            return false;
        }
        return userDao.register(user);
    }

    public User login(String username, String password) {
        return userDao.login(username, password);
    }
}