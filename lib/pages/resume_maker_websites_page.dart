import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebsitePage extends StatelessWidget {
  final List<String> websiteNames = [
    'Zety',
    'Resume.com',
    'Canva',
    'Novo Resume',
    'Visual CV',
    'Resume Genius',
    'Kick Resume',
    'Resume Builder',
    'cv maker',
    'ResumeMaker',
  ];

  final List<String> websiteUrls = [
    'https://zety.com/resume-builder',
    'https://www.resume.com/',
    'https://www.canva.com/en_gb/',
    'https://novoresume.com/',
    'https://www.visualcv.com/',
    'https://resumegenius.com/',
    'https://www.kickresume.com/en/',
    'https://www.resumebuilder.com/',
    'https://cvmkr.com/',
    'https://www.resume-now.com/',
  ];

  final List<Map<String, String>> iconData = [
    {'name': 'Icon1', 'path': 'assets/icons/zety.png'},
    {'name': 'Icon2', 'path': 'assets/icons/resumedotcom.png'},
    {'name': 'Icon3', 'path': 'assets/icons/canva.png'},
    {'name': 'Icon4', 'path': 'assets/icons/novoresume.png'},
    {'name': 'Icon5', 'path': 'assets/icons/visualcv.png'},
    {'name': 'Icon6', 'path': 'assets/icons/resumegenius.png'},
    {'name': 'Icon7', 'path': 'assets/icons/kickresume.png'},
    {'name': 'Icon8', 'path': 'assets/icons/resumebuilder.png'},
    {'name': 'Icon9', 'path': 'assets/icons/cvmaker.png'},
    {'name': 'Icon10', 'path': 'assets/icons/resumemaker.png'},
    // Add paths for other icons
  ];

   WebsitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Select Resume Builder Site'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: websiteNames.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => _launchWebsite(websiteUrls[index]),
            child: Card(
              // elevation: 8.0, // Increased elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0), // More curved edges
              ),
              color: Colors.white, // Set the background color of the tile to white
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconData[index]['path']!, // Access the path from the list
                    width: 80.0, // Larger icon size
                    height: 80.0,
                  ),
                  const SizedBox(height: 12.0), // Increased spacing
                  Text(
                    websiteNames[index],
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _launchWebsite(String url) async {
    await launchUrlString(url);
  }
}

void main() {
  runApp(MaterialApp(
    home: WebsitePage(),
  ));
}
