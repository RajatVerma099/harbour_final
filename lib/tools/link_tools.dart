import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      print("Error launching Link: $e");
    }
  }