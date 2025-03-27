import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  testWidgets('Weather App home screen renders correctly',
      (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const WeatherApp());

    // Verify that the app title is correct
    expect(find.text('Hava Durumu Uygulaması'), findsOneWidget);

    // Verify that the home screen is displayed
    expect(find.byType(HomeScreen), findsOneWidget);

    // Verify key widgets are present
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byIcon(Icons.my_location), findsOneWidget);
  });

  testWidgets('City input field works', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const WeatherApp());

    // Find the TextField
    final cityFieldFinder = find.byType(TextField);

    // Enter a city name
    await tester.enterText(cityFieldFinder, 'Istanbul');
    await tester.pump();

    // Verify the text was entered
    expect(find.text('Istanbul'), findsOneWidget);
  });
}
