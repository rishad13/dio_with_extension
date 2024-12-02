
# 🌐 Network API Service in Flutter  

A modular and reusable **Network API Service** built with **Dio** in Flutter. This implementation emphasizes clean code, error handling, and structured responses using modern Flutter practices.

---

## 🚀 Features  
- **GET, POST, PUT, DELETE** requests handled efficiently.  
- Built with **Dio** for flexible and robust HTTP handling.  
- Error handling with Dio interceptors for logging and debugging.  
- **Records** for managing structured API responses.  
- Extensions for cleaner, scalable code.

---

## 🛠️ How to Use  

1. Clone the repository:  
   ```bash
   git clone https://github.com/rishad13/dio_with_extension
   ```  

2. Install dependencies:  
   ```bash
   flutter pub get
   ```  

3. Use the `NetworkApiService` class to handle API requests in your project:  
   ```dart
   void _getApi() async {
       NetworkApiService apiService = NetworkApiService();
       var response = await apiService.getAPIResponse(
           "https://jsonplaceholder.typicode.com/posts", {}, null);
       if (response.fail != null) {
           throw response.fail!.message;
       } else {
           log(response.success!.response.data.toString());
       }
   }
   ```

---

## 📂 Folder Structure  

```plaintext
lib/
├── extensions/
│   └── records.dart         # Extensions for structured responses
├── observers/
│   └── dio_observer.dart    # Dio interceptor for logging and debugging
├── services/
│   └── network_api_service.dart  # Core implementation of API service
├── parts_and_exceptions/
│   └── base_api_services.dart    # Abstract base class for API services
└── main.dart                # Entry point of the Flutter app
```

---

## 🔗 Links  

- 📖 [Read the Full Article Here](https://medium.com/@rishad2002/api-calls-in-flutter-using-dio-with-extensions-and-records-for-clean-code-cd4935328c98)  
- 💻 [Explore the Code on GitHub](https://github.com/rishad13/dio_with_extension)  

---

## 🤝 Contributing  

We welcome contributions! Feel free to **fork** the repository, submit a pull request, or create an issue for any bugs or improvements.  

---

💡 **Let’s create robust and scalable APIs in Flutter!**  

