import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class CodeNScope extends StatefulWidget {
  const CodeNScope({Key? key}) : super(key: key);

  @override
  _CodeNScopeState createState() => _CodeNScopeState();
}

class _CodeNScopeState extends State<CodeNScope> {
  int _techIndex = 0;
  int _codingIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code N Scope'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Coding Platforms',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider.builder(
              itemCount: codingWebsites.length,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 0.6,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _codingIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return Center(
                  child: CodingWebsiteCard(
                    website: codingWebsites[index],
                    onTap: () => _launchURL(codingWebsites[index].websiteUrl),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: PageIndicator(currentIndex: _codingIndex, totalPages: codingWebsites.length),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Future Trends',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider.builder(
              itemCount: technologies.length,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 0.6,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _techIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return Center(
                  child: TechnologyCard(
                    technology: technologies[index],
                    onTap: () => _launchURL(technologies[index].websiteUrl),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: PageIndicator(currentIndex: _techIndex, totalPages: technologies.length),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class TechnologyCard extends StatelessWidget {
  final Technology technology;
  final VoidCallback onTap;

  const TechnologyCard({
    required this.technology,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 9,
        shadowColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Image.network(
                  technology.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                technology.technologyName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CodingWebsiteCard extends StatelessWidget {
  final CodingWebsite website;
  final VoidCallback onTap;

  const CodingWebsiteCard({
    required this.website,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 9,
        shadowColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Image.network(
                  website.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                website.websiteName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalPages;

  const PageIndicator({required this.currentIndex, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
            (index) => Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.purpleAccent : Colors.grey.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}

class Technology {
  final String technologyName;
  final String imageUrl;
  final String websiteUrl;

  Technology({
    required this.technologyName,
    required this.imageUrl,
    required this.websiteUrl,
  });
}

class CodingWebsite {
  final String websiteName;
  final String imageUrl;
  final String websiteUrl;

  CodingWebsite({
    required this.websiteName,
    required this.imageUrl,
    required this.websiteUrl,
  });
}

final List<Technology> technologies = [
  Technology(
    technologyName: 'A.I.',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vVOuy97M9k865N4LBlcjQnPjkw2B6hi5',
    websiteUrl: 'https://www.geeksforgeeks.org/what-is-artificial-intelligence/',
  ),
  Technology(
    technologyName: 'Data Science',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1v_78ZR0xc4DBmfTbk25Mwny7OWU3P3fM',
    websiteUrl: 'https://www.geeksforgeeks.org/introduction-to-data-science/',
  ),
  Technology(
    technologyName: 'Angular and React',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vh-Lu9RlM-zGO5ecuKH1uY4-XG1GqY4Y',
    websiteUrl: 'https://www.geeksforgeeks.org/angular-vs-reactjs-which-one-is-most-in-demand-frontend-development-framework-in-2019/',
  ),
  Technology(
    technologyName: 'DevOps',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vjdWNZ2a5YMzZeAZb8119XElyoLHyZEn',
    websiteUrl: 'https://www.geeksforgeeks.org/devops-tutorial/',
  ),
  Technology(
    technologyName: 'Cloud Computing',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vjmaFK_RKSNfffajOugaXZ9K_CJABSDQ',
    websiteUrl: 'https://www.geeksforgeeks.org/cloud-computing/',
  ),
  Technology(
    technologyName: 'Blockchain',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vjz2xw6hHpCE2kdYf_1Ms8s1hOIoDn0u',
    websiteUrl: 'https://www.geeksforgeeks.org/blockchain/',
  ),
  Technology(
    technologyName: 'RPA',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vk5_IMvPNyKcuQ2avAUkx_KxDtLPw8Rz',
    websiteUrl: 'https://www.geeksforgeeks.org/robotics-process-automation-an-introduction/',
  ),
  Technology(
    technologyName: 'Data Integration',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vrhfRwSxK3SFExsB4OmTNoMSh87P_w0W',
    websiteUrl: 'https://www.geeksforgeeks.org/data-integration-in-data-mining/',
  ),
  Technology(
    technologyName: 'Big Data',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vuqR8IOlkl8J3SX95pNYtz9IoKKVYNHo',
    websiteUrl: 'https://www.geeksforgeeks.org/what-is-big-data/',
  ),
  Technology(
    technologyName: 'IoT',
    imageUrl: 'https://drive.google.com/uc?export=download&id=1vw3IIMB7VQFB7f6TtFYQMho9DL9TxjoZ',
    websiteUrl: 'https://www.geeksforgeeks.org/introduction-to-internet-of-things-iot-set-1/',
  ),
];

final List<CodingWebsite> codingWebsites = [
  CodingWebsite(
    websiteName: 'LeetCode',
    imageUrl: 'https://drive.google.com/file/d/1B6WI9nhDJ6-LicqMAvXwWRqjse_JtC1_/view?usp=drive_link',//'assets/coding_platform/leetcode.jpg',//'https://drive.google.com/uc?export=download&id=1aBQvJXymKtLPxgOzC57a_6ZT6Rj--I1X',
    websiteUrl: 'https://leetcode.com/',
  ),
  CodingWebsite(
    websiteName: 'GeeksforGeeks',
    // imageUrl: 'assets/coding_platform/gfg.jpg',
    imageUrl: 'https://drive.google.com/file/d/1UWLEbclmQaOQ7pvfvVSIMSV5v11PfkDm/view?usp=drive_link',//'https://drive.google.com/uc?export=download&id=1CDQ1lq1NE6z7q5XL6eE5L-HUBRM2qCXz',
    websiteUrl: 'https://www.geeksforgeeks.org/',
  ),
  CodingWebsite(
    websiteName: 'Codechef',
    imageUrl: 'https://drive.google.com/file/d/1bRTUctjx9e_eZ9oLtSOVdglGEIU8SkiX/view?usp=drive_link',//'assets/coding_platform/codechef.jpg',//'https://drive.google.com/uc?export=download&id=1C0C6PQl3QnWwHhF2XzZQZ3jqkTrNN0OM',
    websiteUrl: 'https://www.codechef.com/',
  ),
  CodingWebsite(
    websiteName: 'Hacker Rank',
    imageUrl: 'https://drive.google.com/file/d/12GEuHzlY63kiuWP15LpGIU_O3QLPl9NR/view?usp=drive_link', //'assets/coding_platform/hackerrank.jpg',
    // imageUrl: 'https://drive.google.com/uc?export=download&id=1CDkgKFJDoGw9R0ms5dAZCBF39zCakb8t',
    websiteUrl: 'https://www.hackerrank.com/',
  ),
  CodingWebsite(
    websiteName: 'HackerEarth',
    imageUrl: 'https://drive.google.com/file/d/1Nvlx6p2jbdzrGo2lcq7kGvctRA9mWYXz/view?usp=drive_link', //'assets/coding_platform/hackerearth.jpg',
    websiteUrl: 'https://www.hackerearth.com/',
  ),
];

void main() {
  runApp(MaterialApp(
    home: CodeNScope(),
  ));
}
