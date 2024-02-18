import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';


class future_trends extends StatefulWidget {
  const future_trends({Key? key}) : super(key: key);

  @override
  _TechnologiesPageState createState() => _TechnologiesPageState();
}

class _TechnologiesPageState extends State<future_trends> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Trends '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TechnologiesList(
              onIndexChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              onCardTapped: (index) {
                _launchWebsite(technologies[index].websiteUrl);
              },
            ),
            const SizedBox(height: 46),
            PageIndicator(currentIndex: _currentIndex),
          ],
        ),
      ),
    );
  }

  void _launchWebsite(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class TechnologiesList extends StatefulWidget {
  final ValueChanged<int> onIndexChanged;
  final ValueChanged<int> onCardTapped;

  const TechnologiesList({Key? key, required this.onIndexChanged, required this.onCardTapped})
      : super(key: key);

  @override
  _TechnologiesListState createState() => _TechnologiesListState();
}

class _TechnologiesListState extends State<TechnologiesList> {
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemCount: technologies.length,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 0.5,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          widget.onIndexChanged(index);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () {
            widget.onCardTapped(index);
          },
          child: Center(
            child: TechnologyCard(
              technology: technologies[index],
            ),
          ),
        );
      },
    );
  }
}

class TechnologyCard extends StatelessWidget {
  final Technology technology;

  const TechnologyCard({
    required this.technology,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shadowColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
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
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currentIndex;

  const PageIndicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        technologies.length,
            (index) => Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(
              index == currentIndex ? 1.0 : 0.4,
            ),
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


// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: future_trends(),
//     );
//   }
// }
//
// class future_trends extends StatefulWidget {
//   const future_trends({Key? key}) : super(key: key);
//
//   @override
//   _TechnologiesPageState createState() => _TechnologiesPageState();
// }
//
// class _TechnologiesPageState extends State<future_trends> {
//   int _currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Future Trends '),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TechnologiesList(
//               onIndexChanged: (index) {
//                 setState(() {
//                   _currentIndex = index;
//                 });
//               },
//             ),
//             const SizedBox(height: 46),
//             PageIndicator(currentIndex: _currentIndex),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TechnologiesList extends StatefulWidget {
//   final ValueChanged<int> onIndexChanged;
//
//   const TechnologiesList({Key? key, required this.onIndexChanged})
//       : super(key: key);
//
//   @override
//   _TechnologiesListState createState() => _TechnologiesListState();
// }
//
// class _TechnologiesListState extends State<TechnologiesList> {
//   final CarouselController _carouselController = CarouselController();
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider.builder(
//       carouselController: _carouselController,
//       itemCount: technologies.length,
//       options: CarouselOptions(
//         enableInfiniteScroll: false,
//         viewportFraction: 0.5,
//         enlargeCenterPage: true,
//         onPageChanged: (index, reason) {
//           widget.onIndexChanged(index);
//         },
//       ),
//       itemBuilder: (context, index, realIndex) {
//         return Center(
//           child: TechnologyCard(
//             technology: technologies[index],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class TechnologyCard extends StatelessWidget {
//   final Technology technology;
//
//   const TechnologyCard({
//     required this.technology,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 9,
//       shadowColor: Colors.grey[300],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.9,
//         height: MediaQuery.of(context).size.height * 0.9,
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width * 0.7,
//               height: MediaQuery.of(context).size.height * 0.1,
//               child: Image.network(
//                 technology.imageUrl,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               technology.technologyName,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PageIndicator extends StatelessWidget {
//   final int currentIndex;
//
//   const PageIndicator({required this.currentIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         technologies.length,
//             (index) => Container(
//           width: 8.0,
//           height: 8.0,
//           margin: const EdgeInsets.symmetric(horizontal: 4.0),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.grey.withOpacity(
//               index == currentIndex ? 1.0 : 0.4,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Technology {
//   final String technologyName;
//   final String imageUrl;
//
//   Technology({
//     required this.technologyName,
//     required this.imageUrl,
//   });
// }
//
// final List<Technology> technologies = [
//   Technology(
//     technologyName: 'A.I.',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1vVOuy97M9k865N4LBlcjQnPjkw2B6hi5',
//   ),
//   Technology(
//     technologyName: 'Data Science',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1v_78ZR0xc4DBmfTbk25Mwny7OWU3P3fM',
//   ),
//   Technology(
//     technologyName: 'Angular and React',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1vh-Lu9RlM-zGO5ecuKH1uY4-XG1GqY4Y',
//   ),
//   Technology(
//     technologyName: 'DevOps',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1vjdWNZ2a5YMzZeAZb8119XElyoLHyZEn',
//   ),
//   Technology(
//     technologyName: 'Cloud Computing',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1vjmaFK_RKSNfffajOugaXZ9K_CJABSDQ',
//   ),
//   Technology(
//     technologyName: 'Blockchain',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1vjz2xw6hHpCE2kdYf_1Ms8s1hOIoDn0u',
//   ),
//   Technology(
//     technologyName: 'RPA',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1vk5_IMvPNyKcuQ2avAUkx_KxDtLPw8Rz',
//   ),
//   Technology(
//     technologyName: 'Data Integration',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1vrhfRwSxK3SFExsB4OmTNoMSh87P_w0W',
//   ),
//   Technology(
//     technologyName: 'Big Data',
//     imageUrl:    'https://drive.google.com/uc?export=download&id=1vuqR8IOlkl8J3SX95pNYtz9IoKKVYNHo',
//   ),
//   Technology(
//     technologyName: 'IoT',
//     imageUrl: 'https://drive.google.com/uc?export=download&id=1vw3IIMB7VQFB7f6TtFYQMho9DL9TxjoZ',
//   ),
// ];
//
