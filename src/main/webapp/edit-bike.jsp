<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Bike | Bike Rental</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script>
        function validateForm() {
            const price = document.getElementById('price').value;
            const imageUrl = document.getElementById('imageUrl').value;
            
            if (isNaN(price) || price <= 0) {
                alert('Please enter a valid price (must be greater than 0)');
                return false;
            }
            
            if (!imageUrl.match(/\.(jpeg|jpg|gif|png)$/)) {
                alert('Please enter a valid image URL (must end with .jpeg, .jpg, .gif, or .png)');
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body class="bg-gray-100">
    <div class="flex">
        <%@ include file="owner-sidebar.jsp" %>
        
        <div class="flex-1 p-8">
            <div class="max-w-3xl mx-auto">
                <div class="flex justify-between items-center mb-8">
                    <h1 class="text-2xl font-bold">Edit Bike</h1>
                    <a href="owner-dashboard.jsp" class="text-blue-600 hover:text-blue-800">
                        <i class="fas fa-arrow-left mr-1"></i> Back to Dashboard
                    </a>
                </div>
                
                <div class="bg-white rounded-lg shadow-md p-6">
                    <form action="bikes" method="post" onsubmit="return validateForm()">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${bike.id}">
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Bike Name</label>
                                <input type="text" id="name" name="name" value="${bike.name}" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            
                            <div>
                                <label for="price" class="block text-sm font-medium text-gray-700 mb-1">Daily Price ($)</label>
                                <input type="number" id="price" name="price" value="${bike.price}" step="0.01" min="0.01" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            
                            <div class="md:col-span-2">
                                <label for="imageUrl" class="block text-sm font-medium text-gray-700 mb-1">Image URL</label>
                                <input type="url" id="imageUrl" name="imageUrl" value="${bike.imageUrl}" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                                    placeholder="https://images.pexels.com/photos/...">
                                <div class="mt-2">
                                    <img src="${bike.imageUrl}" alt="Current bike image" class="h-32 object-cover rounded">
                                </div>
                            </div>
                            
                            <div>
                                <label for="category" class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                                <select id="category" name="category" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                                    <option value="Mountain Bike" ${bike.category == 'Mountain Bike' ? 'selected' : ''}>Mountain Bike</option>
                                    <option value="Road Bike" ${bike.category == 'Road Bike' ? 'selected' : ''}>Road Bike</option>
                                    <option value="Hybrid Bike" ${bike.category == 'Hybrid Bike' ? 'selected' : ''}>Hybrid Bike</option>
                                    <option value="Electric Bike" ${bike.category == 'Electric Bike' ? 'selected' : ''}>Electric Bike</option>
                                </select>
                            </div>
                            
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Availability</label>
                                <div class="flex items-center space-x-4">
                                    <label class="inline-flex items-center">
                                        <input type="radio" name="available" value="true" ${bike.available ? 'checked' : ''}
                                            class="h-4 w-4 text-blue-600 focus:ring-blue-500">
                                        <span class="ml-2">Available</span>
                                    </label>
                                    <label class="inline-flex items-center">
                                        <input type="radio" name="available" value="false" ${!bike.available ? 'checked' : ''}
                                            class="h-4 w-4 text-blue-600 focus:ring-blue-500">
                                        <span class="ml-2">Unavailable</span>
                                    </label>
                                </div>
                            </div>
                            
                            <div class="md:col-span-2">
                                <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                                <textarea id="description" name="description" rows="3"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">${bike.description}</textarea>
                            </div>
                        </div>
                        
                        <div class="mt-6 flex justify-between">
                            <button type="button" onclick="confirmDelete()"
                                class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                                <i class="fas fa-trash mr-2"></i>Delete Bike
                            </button>
                            <button type="submit"
                                class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                <i class="fas fa-save mr-2"></i>Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmDelete() {
            if (confirm('Are you sure you want to delete this bike?')) {
                window.location.href = 'bikes?action=delete&id=${bike.id}';
            }
        }
    </script>
</body>
</html>