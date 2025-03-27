# Location and QR Code based Smart Attendance App
## Team VIT Visionaries

=> Overview
This project is a simple and secure mobile app that marks attendance by verifying the user's location and scanning a class-specific QR code.

=> How It Works
1) Login: User logs into the app securely using Firebase Authentication.

2) Fetch Location: The app fetches the user's current location.

3) Scan QR Code: User scans the QR code provided in the class.

4) Compare Coordinates: The scanned QR code and location are compared.

5) Mark Attendance: If the details match, attendance is recorded in Firebase Firestore.

=> Tech Stack
1) Flutter: Framework for building the mobile application.

2) Dart: Programming language used for Flutter app development.

3) Firebase Authentication: For secure user login and authentication.

4) Firebase Firestore: To store and manage attendance data efficiently.

5) Google Maps API: To fetch and validate the user's current location.

6) Kotlin: For managing native Android configurations in the app.

=> Key Dependencies
1) firebase_core: Integrates Firebase services into the app.

2) firebase_auth: Provides secure authentication methods.

3) cloud_firestore: Stores and retrieves data from Firestore.

4) google_maps_flutter: Embeds Google Maps and fetches user location.

5) geolocator: Retrieves and updates the device’s location.

6) qr_code_scanner: Enables scanning of QR codes.

7) flutter_polyline_points: For drawing routes and handling map-related tasks.

8) permission_handler: Manages app permissions for camera and location.

=> Future Scope
1) Adding offline attendance functionality.

2) Sending notifications after attendance.

3) Providing admin-level controls for better monitoring.

=> Note
This system prevents proxy attendance and ensures accurate attendance tracking with minimal effort.
