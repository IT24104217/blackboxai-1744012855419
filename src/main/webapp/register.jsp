<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Owner Registration | Bike Rental</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #2563eb 0%, #1e40af 100%);
        }
    </style>
    <script>
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }
            
            if (password.length < 6) {
                alert('Password must be at least 6 characters long');
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body class="gradient-bg min-h-screen flex items-center justify-center">
    <div class="w-full max-w-md">
        <div class="bg-white rounded-lg shadow-xl overflow-hidden">
            <div class="p-8">
                <div class="flex justify-center mb-8">
                    <div class="bg-blue-100 p-4 rounded-full">
                        <i class="fas fa-user-plus text-blue-600 text-3xl"></i>
                    </div>
                </div>
                
                <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">Owner Registration</h2>
                
                <c:if test="${not empty error}">
                    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
                        <p>${error}</p>
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4" role="alert">
                        <p>${success}</p>
                    </div>
                </c:if>
                
                <form action="owners" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="register">
                    
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="username">
                            Username
                        </label>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                                <i class="fas fa-user text-gray-400"></i>
                            </span>
                            <input class="shadow appearance-none border rounded w-full py-2 pl-10 pr-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                                id="username" name="username" type="text" placeholder="Username" required minlength="4">
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="password">
                            Password
                        </label>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                                <i class="fas fa-lock text-gray-400"></i>
                            </span>
                            <input class="shadow appearance-none border rounded w-full py-2 pl-10 pr-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                                id="password" name="password" type="password" placeholder="Password" required minlength="6">
                        </div>
                    </div>
                    
                    <div class="mb-6">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="confirmPassword">
                            Confirm Password
                        </label>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                                <i class="fas fa-lock text-gray-400"></i>
                            </span>
                            <input class="shadow appearance-none border rounded w-full py-2 pl-10 pr-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                                id="confirmPassword" name="confirmPassword" type="password" placeholder="Confirm Password" required minlength="6">
                        </div>
                    </div>
                    
                    <div class="flex items-center justify-between mb-4">
                        <button class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" 
                            type="submit">
                            <i class="fas fa-user-plus mr-2"></i>Register
                        </button>
                    </div>
                </form>
            </div>
            
            <div class="bg-gray-50 px-8 py-4">
                <div class="text-center text-sm text-gray-600">
                    Already have an account? 
                    <a class="font-bold text-blue-600 hover:text-blue-800" href="login.jsp">
                        Login here
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>