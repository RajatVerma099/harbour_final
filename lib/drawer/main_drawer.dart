import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:harbour/tools/navigation.dart';
import '../pages/TechnologiesPage.dart';
import '../pages/dev_page.dart';
import '../pages/support_us.dart';

class MainDrawer extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const MainDrawer({Key? key}) : super(key: key);

  Widget intro() {
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: 20)),
        child: const Center(
          child: Text(
            'Hey Harbour Explorers,\n\n🚀 Thank you for choosing Harbour! 🚀\n\nSet sail with us on this journey that matters. 😊 Enjoyed it? Share the love! Help others navigate their career seas with Harbour.\n\nCheers,\nThe Harbour Crew',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
    required VoidCallback onClicked,
    required String imageUrl,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Colors.grey[900],
          // Dark Background Color
          child: Container(
            padding: padding.add(const EdgeInsets.symmetric(vertical: 20)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );

  List<Widget> meetTheDevs(BuildContext context) {
    const imageUrl1 =
        'https://lh3.googleusercontent.com/a/ACg8ocIVcgin3A99fK8VigTnG8GCnRSZDduL6ZLobV_wZtCTY4Q=s96-c';
    const imageUrl2 =
        'https://lh3.googleusercontent.com/a/ACg8ocLN7LNv35v37V7BQKYKTCyvfCgKoi1n5iRi65sH80DHotc=s96-c';
    return [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "MEET THE DEVS",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      buildHeader(
        imageUrl: imageUrl1,
        name: 'Mudit Garg',
        email: 'muditgarg48@gmail.com',
        onClicked: () => goTo(
          const DevPage(
            firstName: 'Mudit',
            lastName: 'Garg',
            avatarLink: 'assets/img/mg.jpg',
            lifeMotto: 'It is what it is !',
            connectionLinks: {
              'email': 'gargmu@tcd.ie',
              'linkedin': 'https://www.linkedin.com/in/muditgarg48/',
              'github': 'https://github.com/muditgarg48',
            },
            sendOffQuote: 'Adios amigo!',
          ),
          context,
        ),
      ),
      buildHeader(
        imageUrl: imageUrl2,
        name: 'Rajat Verma',
        email: 'rv5393982@gmail.com',
        onClicked: () => goTo(
          const DevPage(
            firstName: 'Rajat',
            lastName: 'Verma',
            avatarLink: 'assets/img/rv.jpg',
            lifeMotto: 'Life is a virtual mess we weave',
            connectionLinks: {
              'email': 'lostpoet099@gmail.com',
              'linkedin':
              'https://www.linkedin.com/in/rajat-verma-321336224/',
              'github': 'https://github.com/RajatVerma099',
            },
            sendOffQuote: 'Feel free to connect :)',
          ),
          context,
        ),
      ),
    ];
  }

  Widget buildSupportButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BuyUsACoffee()));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[900],
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              'Support Us :)',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget techUsedButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TechnologiesPage()));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[900],
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              'Tech Used ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget checkForUpdatesButton(BuildContext context) {
    const updatesUrl = 'https://rajatverma099.github.io/harbour_website/';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunch(updatesUrl)) {
            await launch(updatesUrl);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Could not launch the updates URL.'),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[900],
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              'Check for Updates',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget feedbackButton(BuildContext context) {
    const feedbackUrl = 'https://forms.gle/crw2cSPjd9sp8dz7A';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunch(feedbackUrl)) {
            await launch(feedbackUrl);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Could not launch the feedback URL.'),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[900],
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              'Give Feedback',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: Colors.white,
      children: [
        intro(),
        const Divider(
          indent: 30,
          endIndent: 30,
        ),
        ...meetTheDevs(context),
        const Divider(
          indent: 30,
          endIndent: 30,
        ),
        buildSupportButton(context),
        const Divider(
          indent: 30,
          endIndent: 30,
        ),
        techUsedButton(context),
        const Divider(
          indent: 30,
          endIndent: 30,
        ),
        checkForUpdatesButton(context),
        const Divider(
          indent: 30,
          endIndent: 30,
        ),
        feedbackButton(context),
      ],
    );
  }
}
