# Aidea App - HandyMan Service Booking

A professional Flutter application designed for seamless on-demand service booking. Whether it's plumbing, electrical work, home appliance repair, or AC servicing, Aidea App connects customers with expert "HandyMen" quickly and efficiently.

## 🚀 Features

- **Multi-Category Bookings**: Specialized services for AC, Home Appliances, Plumbing, Electrical, and more.
- **Bi-lingual Support**: Full support for English and Arabic (RTL) locales.
- **Smart Authentication**: Secure phone-based OTP login.
- **Real-time Order Tracking**: Monitor your service progress from booking to completion.
- **Live Chat**: Directly communicate with assigned workers for better coordination.
- **Interactive Maps**: Precise location selection using Google Maps integration.
- **Automated Invoices**: Receive professional invoices (PDF) for your bookings.
- **Push Notifications**: Stay updated with real-time alerts for booking status and messages.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (3.0+)
- **Backend/Database**: [Firebase](https://firebase.google.com/) (Cloud Firestore)
- **Authentication**: Firebase Phone Auth
- **Maps**: [flutter_map](https://pub.dev/packages/flutter_map) & [geolocator](https://pub.dev/packages/geolocator)
- **Local Storage**: SharedPreferences
- **Formatting**: Intl (Date & Number formatting)

## 📦 Project Structure

```text
lib/
├── gen_l10n/       # Localized strings (Auto-generated)
├── l10n/           # ARB files for translations
├── models/         # Data models (User, Service, Order, etc.)
├── screens/        # UI Screens (Auth, Dashboard, Booking, etc.)
├── services/       # Core logic (Firebase, Firestore, Notifications)
├── utils/          # Constants, formatting, and colors
└── widget/         # Reusable UI components
```

## ⚙️ Getting Started

1. **Clone the repository**:
   ```bash
   git clone [repository-url]
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Setup Firebase**:
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
   - Ensure Firebase CLI is configured for your project.
4. **Run the app**:
   ```bash
   flutter run
   ```

## 📄 License

Created by **Uswa Muhammadii** & **Waseeq Saad**. All rights reserved.
