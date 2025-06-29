// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:thread_clone_ice/controllers/auth_controller.dart';
import 'package:thread_clone_ice/controllers/feed_controller.dart';
import 'package:thread_clone_ice/main.dart';
import 'package:thread_clone_ice/views/create_post_view.dart';
import 'package:thread_clone_ice/views/main_navigation.dart';

// A helper function to wrap widgets for testing, providing necessary controllers.
Widget createTestableWidget({required Widget child}) {
  Get.put(AuthController());
  Get.put(FeedController());
  return GetMaterialApp(home: child);
}

void main() {
  // Reset GetX bindings after each test to ensure a clean state.
  tearDown(() {
    Get.reset();
  });

  group('Widget Tests', () {
    testWidgets('SplashScreen shows logo and navigates to MainNavigation', (
      WidgetTester tester,
    ) async {
      // Build the app starting from SplashScreen.
      await tester.pumpWidget(createTestableWidget(child: SplashScreen()));

      // Verify SplashScreen shows the logo icon and app name.
      expect(
        find.byIcon(const IconData(0xe35e, fontFamily: 'MaterialIcons')),
        findsOneWidget,
      );
      expect(find.text('Threads'), findsOneWidget);

      // pumpAndSettle will wait for all animations and futures to complete.
      await tester.pumpAndSettle();

      // Verify that we have navigated to the MainNavigation screen.
      expect(find.byType(MainNavigation), findsOneWidget);
      // And FeedView is visible
      expect(find.text("What's new?"), findsOneWidget);
    });

    testWidgets('MainNavigation displays BottomNavigationBar with 5 items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(child: MainNavigation()));

      // Verify that the bottom navigation bar is present.
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Verify it has 5 items.
      expect(find.byType(BottomNavigationBarItem), findsNWidgets(5));
      expect(
        find.byType(SvgPicture),
        findsOneWidget,
      ); // Checks for the SVG icon
    });

    testWidgets('Tapping on create post tile navigates to CreatePostView', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(child: MainNavigation()));

      // Tap the "What's new?" tile in the FeedView.
      await tester.tap(find.text("What's new?"));
      await tester.pumpAndSettle(); // Wait for navigation to complete.

      // Verify we are on the CreatePostView screen.
      expect(find.byType(CreatePostView), findsOneWidget);
      expect(find.text('New thread'), findsOneWidget);
    });

    testWidgets('Tapping on profile icon navigates to ProfileView', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestableWidget(child: MainNavigation()));

      // Find and tap the profile icon in the bottom navigation bar.
      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pumpAndSettle(); // Wait for state change and animations.

      // Verify that ProfileView is displayed.
      expect(find.text('Edit Profile'), findsOneWidget);
    });
  });
}
