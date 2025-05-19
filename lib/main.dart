import 'package:flutter/material.dart';
import 'package:flutter_application_1/note_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://xwmyixpefxtpbhdnslru.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh3bXlpeHBlZnh0cGJoZG5zbHJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxNTY3MzUsImV4cCI6MjA2MTczMjczNX0.DrMZBY_4M3uuYQVr20YJARYMqhcLYyZLrqhM8cqPx7M",
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotePage(),
    );
  }
}
