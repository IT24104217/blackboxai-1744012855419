<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Owner Dashboard | Bike Rental</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100">
    <div class="flex h-screen">
        <!-- Sidebar -->
        <div class="w-64 bg-blue-800 text-white p-4">
            <div class="flex items-center space-x-2 mb-8 p-2">
                <i class="fas fa-bicycle text-2xl"></i>
                <h1 class="text-xl font-bold">BikeRental</h1>
            </div>
            <nav>
                <a href="owner-dashboard.jsp" class="flex items-center space-x-2 p-2 rounded hover:bg-blue-700 mb-2">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
                <a href="add-bike.jsp" class="flex items-center space-x-2 p-2 rounded hover:bg-blue-700 mb-2">
                    <i class="fas fa-plus-circle"></i>
                    <span>Add Bike</span>
                </a>
                <a href="bikes" class="flex items-center space-x-2 p-2 rounded hover:bg-blue-700 mb-2">
                    <i class="fas fa-bicycle"></i>
                    <span>Manage Bikes</span>
                </a>
                <a href="owners?action=logout" class="flex items-center space-x-2 p-2 rounded hover:bg-blue-700 mt-8">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="flex-1 overflow-auto">
            <header class="bg-white shadow-sm p-4">
                <div class="flex justify-between items-center">
                    <h2 class="text-xl font-semibold">Owner Dashboard</h2>
                    <div class="flex items-center space-x-2">
                        <i class="fas fa-user-circle"></i>
                        <span>${sessionScope.username}</span>
                    </div>
                </div>
            </header>

            <main class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                    <!-- Stats Cards -->
                    <div class="bg-white rounded-lg shadow p-4">
                        <div class="flex justify-between items-center">
                            <div>
                                <p class="text-gray-500">Total Bikes</p>
                                <h3 class="text-2xl font-bold">${requestScope.totalBikes}</h3>
                            </div>
                            <i class="fas fa-bicycle text-blue-500 text-2xl"></i>
                        </div>
                    </div>
                    <div class="bg-white rounded-lg shadow p-4">
                        <div class="flex justify-between items-center">
                            <div>
                                <p class="text-gray-500">Available Bikes</p>
                                <h3 class="text-2xl font-bold">${requestScope.availableBikes}</h3>
                            </div>
                            <i class="fas fa-check-circle text-green-500 text-2xl"></i>
                        </div>
                    </div>
                    <div class="bg-white rounded-lg shadow p-4">
                        <div class="flex justify-between items-center">
                            <div>
                                <p class="text-gray-500">Rented Bikes</p>
                                <h3 class="text-2xl font-bold">${requestScope.rentedBikes}</h3>
                            </div>
                            <i class="fas fa-times-circle text-red-500 text-2xl"></i>
                        </div>
                    </div>
                </div>

                <!-- Recent Activities -->
                <div class="bg-white rounded-lg shadow p-4">
                    <h3 class="text-lg font-semibold mb-4">Recent Activities</h3>
                    <div class="space-y-2">
                        <c:forEach items="${requestScope.activities}" var="activity" end="4">
                            <div class="border-b pb-2">
                                <p class="text-sm text-gray-600">${activity}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Bike Management Table -->
                <div class="mt-6 bg-white rounded-lg shadow overflow-hidden">
                    <div class="p-4 flex justify-between items-center border-b">
                        <h3 class="text-lg font-semibold">Bike Inventory</h3>
                        <a href="add-bike.jsp" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                            <i class="fas fa-plus mr-2"></i>Add New Bike
                        </a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Last Updated</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach items="${requestScope.bikes}" var="bike">
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="flex-shrink-0 h-10 w-10">
                                                    <img class="h-10 w-10 rounded-full" src="${bike.imageUrl}" alt="${bike.name}">
                                                </div>
                                                <div class="ml-4">
                                                    <div class="text-sm font-medium text-gray-900">${bike.name}</div>
                                                    <div class="text-sm text-gray-500">${bike.category}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            $${bike.price}/day
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                ${bike.available ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                                ${bike.available ? 'Available' : 'Rented'}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            ${bike.lastUpdated}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <a href="edit-bike.jsp?id=${bike.id}" class="text-blue-600 hover:text-blue-900 mr-3">Edit</a>
                                            <a href="bikes?action=delete&id=${bike.id}" class="text-red-600 hover:text-red-900">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>