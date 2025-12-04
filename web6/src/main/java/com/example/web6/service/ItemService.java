package com.example.web6.service;

import com.example.web6.dao.ItemDao;
import com.example.web6.model.Item;

import java.util.List;

public class ItemService {
    private ItemDao itemDao = new ItemDao();

    public boolean addItem(Item item) {
        return itemDao.addItem(item);
    }

    public boolean updateItem(Item item) {
        return itemDao.updateItem(item);
    }

    public boolean deleteItem(int id, int userId) {
        return itemDao.deleteItem(id, userId);
    }

    public Item getItemById(int id) {
        return itemDao.getItemById(id);
    }

    public List<Item> getAllItems() {
        return itemDao.getAllItems();
    }

    public List<Item> searchItems(String keyword) {
        return itemDao.searchItems(keyword);
    }

    public List<Item> getItemsByUser(int userId) {
        return itemDao.getItemsByUser(userId);
    }
}