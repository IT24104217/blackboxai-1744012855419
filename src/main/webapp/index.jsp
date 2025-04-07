<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bike Rental System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="bg-gray-100">
    <header class="bg-white shadow-sm">
        <div class="container mx-auto px-4 py-4 flex justify-between items-center">
            <h1 class="text-2xl font-bold text-blue-600">BikeRental</h1>
            <nav>
                <a href="#" class="px-4 py-2 text-gray-700 hover:text-blue-600">Home</a>
                <a href="#" class="px-4 py-2 text-gray-700 hover:text-blue-600">Bikes</a>
                <a href="#" class="px-4 py-2 text-gray-700 hover:text-blue-600">About</a>
                <a href="/owners?action=login" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
                    Owner Login
                </a>
            </nav>
        </div>
    </header>

    <main class="container mx-auto px-4 py-8">
        <section class="mb-12">
            <div class="bg-blue-600 text-white rounded-lg p-8">
                <h2 class="text-3xl font-bold mb-4">Find Your Perfect Ride</h2>
                <p class="text-xl mb-6">Explore our collection of high-quality bikes for your next adventure</p>
                <button class="bg-white text-blue-600 px-6 py-3 rounded-lg font-semibold hover:bg-gray-100">
                    Browse Bikes
                </button>
            </div>
        </section>

        <section>
            <h2 class="text-2xl font-bold mb-6">Available Bikes</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach items="${bikes}" var="bike">
                    <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
                        <img src="${bike.imageUrl}" alt="${bike.name}" 
                             class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3 class="text-xl font-semibold">${bike.name}</h3>
                            <p class="text-gray-600 mt-2">$${bike.price}/day</p>
                            <div class="mt-4 flex justify-between items-center">
                                <span class="inline-block px-3 py-1 rounded-full text-sm font-medium 
                                    ${bike.available ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                    ${bike.available ? 'Available' : 'Unavailable'}
                                </span>
                                <button class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 
                                    ${!bike.available ? 'opacity-50 cursor-not-allowed' : ''}"
                                    ${!bike.available ? 'disabled' : ''}>
                                    Rent Now
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </main>

    <footer class="bg-gray-800 text-white py-8 mt-12">
        <div class="container mx-auto px-4">
            <div class="flex flex-col md:flex-row justify-between">
                <div class="mb-6 md:mb-0">
                    <h3 class="text-xl font-bold mb-4">BikeRental</h3>
                    <p>Your trusted bike rental service</p>
                </div>
                <div class="flex space-x-6">
                    <a href="#" class="hover:text-blue-400"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="hover:text-blue-400"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="hover:text-blue-400"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="border-t border-gray-700 mt-8 pt-8 text-center">
                <p>&copy; 2023 BikeRental. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>