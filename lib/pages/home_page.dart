import 'package:flutter/material.dart';
import 'package:harbour/pages/future_trends.dart';
import 'package:harbour/pages/sample_resume_page.dart';
import 'package:harbour/pages/show_data.dart';

import '../drawer/main_drawer.dart';
import '../tools/navigation.dart';
import 'GetJobReady.dart';
import 'TechnologiesPage.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = MediaQuery.of(context).size.width * 0.3;
    double containerSize = MediaQuery.of(context).size.width * 0.65;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          _buildBackgroundImage(context),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Positioned(
                          top: -40,
                          left: 0,
                          right: 0,
                          child: ClipPath(
                            clipper: CurvedBackgroundClipper(),
                            child: Transform(
                              alignment: Alignment.center,
                              transform:
                              Matrix4.rotationY(_controller.value * 0.8),
                              child: Image.asset(
                                "assets/launch/logo_launch.jpg",
                                height:
                                MediaQuery.of(context).size.height * 0.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: containerSize,
        width: containerSize,
        padding: const EdgeInsets.only(bottom: 1.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          children: [
            _buildButton(
              const ShowData(),
              Icons.list,
              "Show Jobs",
              buttonSize,
            ),
            _buildButton(
              const Resume(),
              Icons.document_scanner_rounded,
              "Resume Maker",
              buttonSize,
            ),
            _buildButton(
              const future_trends(),
              Icons.document_scanner_rounded,
              "Future Trends",
              buttonSize,
            ),
            _buildButton(
              const GetJobReady(),
              Icons.document_scanner_rounded,
              "Get Job Ready",
              buttonSize,
            ),
          ],
        ),
      ),
      drawer: const MainDrawer(),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height * 3 / 5;

    return ClipPath(
      clipper: CurvedBackgroundClipper(),
      child: Container(
        height: imageHeight + 20,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildButton(
      Widget page,
      IconData icon,
      String label,
      double size,
      ) {
    return ElevatedButton(
      onPressed: () => goTo(page, context),
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5.0,
        shadowColor: Colors.black,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Ink(
          child: InkWell(
            onTap: () => goTo(page, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurvedBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
