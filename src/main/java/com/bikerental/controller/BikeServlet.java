package com.bikerental.controller;

import com.bikerental.model.Bike;
import com.bikerental.util.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/bikes")
public class BikeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Bike> bikes = FileHandler.getAllBikes();
        request.setAttribute("bikes", bikes);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addBike(request);
        } else if ("update".equals(action)) {
            updateBike(request);
        } else if ("delete".equals(action)) {
            deleteBike(request);
        }
        response.sendRedirect("bikes");
    }

    private void addBike(HttpServletRequest request) {
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String imageUrl = request.getParameter("imageUrl");
        boolean available = Boolean.parseBoolean(request.getParameter("available"));
        String description = request.getParameter("description");
        String category = request.getParameter("category");

        Bike bike = new Bike(name, price, imageUrl, available, description, category);
        FileHandler.saveBike(bike);
        FileHandler.logAction("Owner", "Added bike: " + name);
    }

    private void updateBike(HttpServletRequest request) {
        String id = request.getParameter("id");
        Bike bike = FileHandler.getBikeById(id);
        if (bike != null) {
            bike.setName(request.getParameter("name"));
            bike.setPrice(Double.parseDouble(request.getParameter("price")));
            bike.setImageUrl(request.getParameter("imageUrl"));
            bike.setAvailable(Boolean.parseBoolean(request.getParameter("available")));
            bike.setDescription(request.getParameter("description"));
            bike.setCategory(request.getParameter("category"));
            FileHandler.updateBike(bike);
            FileHandler.logAction("Owner", "Updated bike: " + bike.getName());
        }
    }

    private void deleteBike(HttpServletRequest request) {
        String id = request.getParameter("id");
        FileHandler.deleteBike(id);
        FileHandler.logAction("Owner", "Deleted bike with ID: " + id);
    }
}