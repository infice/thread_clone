# Threads Clone - Flutter App

A beautiful Threads clone built with Flutter and GetX, featuring a modern UI that closely resembles the original Threads app.

## Features

- 🏠 **Feed View**: Display posts with like, repost, and reply functionality
- 👤 **User Profiles**: Mock user data with verified badges
- 💬 **Post Interactions**: Like, repost, and reply to posts
- 🎨 **Modern UI**: Clean design matching Threads app aesthetics
- 📱 **Responsive Design**: Works on different screen sizes
- 🔄 **Pull to Refresh**: Refresh feed by pulling down
- 🎯 **GetX State Management**: Efficient state management with GetX

## Screenshots

The app includes:
- Splash screen with Threads branding
- Main feed with posts
- Bottom navigation (Home, Search, Activity, Profile)
- Post cards with user avatars, content, and interaction buttons

## Getting Started

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd thread_clone_ice
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── controllers/          # GetX controllers
│   ├── auth_controller.dart
│   └── feed_controller.dart
├── models/              # Data models
│   ├── user_model.dart
│   └── post_model.dart
├── services/            # Data services
│   └── mock_data_service.dart
├── utils/               # Utilities
│   ├── constants.dart
│   └── formatters.dart
├── views/               # UI screens
│   ├── feed_view.dart
│   └── main_navigation.dart
├── widgets/             # Reusable widgets
│   └── post_card.dart
└── main.dart           # App entry point
```

## Dependencies

- **get**: State management and navigation
- **cached_network_image**: Image caching for better performance
- **flutter_svg**: SVG support
- **image_picker**: Image selection functionality
- **intl**: Internationalization and formatting
- **timeago**: Time formatting utilities

## Mock Data

The app includes mock data featuring:
- **Users**: Mark Zuckerberg, Elon Musk, Sundar Pichai, Satya Nadella, Tim Cook
- **Posts**: Sample posts with realistic content and engagement metrics
- **Interactions**: Like, repost, and reply functionality

## Features Implemented

### ✅ Completed
- [x] Splash screen with branding
- [x] Main feed with posts
- [x] Post interactions (like, repost)
- [x] User avatars and verified badges
- [x] Pull to refresh functionality
- [x] Bottom navigation
- [x] Modern UI design
- [x] GetX state management
- [x] Mock data service

### 🚧 Planned Features
- [ ] Search functionality
- [ ] Activity feed
- [ ] User profiles
- [ ] Post creation
- [ ] Image upload
- [ ] Real-time updates
- [ ] Push notifications

## UI/UX Design

The app follows Threads' design principles:
- **Clean Layout**: Minimalist design with proper spacing
- **Typography**: Clear hierarchy with appropriate font sizes
- **Colors**: Black and white theme with accent colors
- **Icons**: Material Design icons for consistency
- **Animations**: Smooth transitions and interactions

## State Management

The app uses GetX for state management:
- **Controllers**: Handle business logic and state
- **Reactive Programming**: Automatic UI updates
- **Dependency Injection**: Easy controller access
- **Navigation**: Simple routing with GetX

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is for educational purposes only. Threads is a trademark of Meta Platforms, Inc.

## Acknowledgments

- Inspired by the Threads app by Meta
- Built with Flutter and GetX
- Icons from Material Design
- Mock data for demonstration purposes
