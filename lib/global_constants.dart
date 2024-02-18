import 'package:flutter/material.dart';

import 'datatypes/onboard_model.dart';

Color kblue = const Color(0xFF4756DF);
Color kwhite = const Color(0xFFFFFFFF);
Color kblack = const Color(0xFF000000);
Color kbrown300 = const Color(0xFF8D6E63);
Color kbrown = const Color(0xFF795548);
Color kgrey = const Color(0xFFC0C0C0);

List<OnboardModel> onBoardingScreens = <OnboardModel>[
    OnboardModel(
      img: 'assets/img/onboard1.jpg',
      text: "Welcome to Harbour",
      desc:
      "Your gateway to off-campus job opportunities and more!",
      bg: Colors.white,
      button: const Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/img/onboard2.jpg',
      text: "Challenges in Today's Job Market",
      desc:
      "Facing difficulties in job search? Explore new opportunities and overcome challenges with Harbour. ",
      bg: Colors.white,
      button: const Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/img/onboard3.jpg',
      text: "How Harbour Helps You",
      desc:
      "Harbour provides job links, a resume maker, and study content to make you job-ready. Get started now!",
      bg: Colors.white,
      button: const Color(0xFF4756DF),
    ),
  ];

const devs = [
  {
    "name": "Mudit Garg",
    "drawer-pic-url": "https://lh3.googleusercontent.com/a/ACg8ocIVcgin3A99fK8VigTnG8GCnRSZDduL6ZLobV_wZtCTY4Q=s96-c",
    "life-quote": "It is what it is !",
    "linkedin-url": "https://www.linkedin.com/in/muditgarg48",
    "github-url": "https://www.github.com/muditgarg48",
    "email": "gargmu@tcd.ie",
    "profile-pic": "",
    "bye-quote": "Adios amigo!",
  },
  {
    "name": "Rajat Verma",
    "drawer-pic-url": "https://lh3.googleusercontent.com/a/ACg8ocLN7LNv35v37V7BQKYKTCyvfCgKoi1n5iRi65sH80DHotc=s96-c",
    "life-quote": "Life is a virtual mess we weave",
    "linkedin-url": "https://www.linkedin.com/in/rajat-verma-321336224/",
    "github-url": "https://github.com/RajatVerma099",
    "email": "rv5393982@gmail.com",
    "profile-pic": "",
    "bye-quote": "That's it. Bye!",
  },
];

const resumeThumbnails = [
    'https://drive.google.com/uc?export=view&id=1sTfin3hQVKT2WKFpSHaCznt-W-f8XGnA',
    'https://drive.google.com/uc?export=view&id=1sU1sa4NThCu4Z6FiGKb5K7p09TYS12TW',
    'https://drive.google.com/uc?export=view&id=1sWC99OshB4y9wpPKAzEu9UzMumjD4lnh',
    'https://drive.google.com/uc?export=view&id=1sXBpJ1LdkgWVDSC6gS4IiJXxkgbOtLNF',
    'https://drive.google.com/uc?export=view&id=1sYW0lpg2VTZhPEOhewPaQ2XalbLiy4lo',
    'https://drive.google.com/uc?export=view&id=1shuH_nAqYWK3BEJVC-SlYuP1IQYE4t4U',
    'https://drive.google.com/uc?export=view&id=1siM83IfgqvEyLCORwMHQ0-umyJaVfy29',
    'https://drive.google.com/uc?export=view&id=1siOWo9qv4Z8uFw0el9ZIrXgFSzu_s-ms',
    'https://drive.google.com/uc?export=view&id=1sjUGrZIgLbiOoyVruoIjFSb2JEa6OrXj',
    'https://drive.google.com/uc?export=view&id=1slROfIV1XJU5iRrSumYVao2iwiS9c2pn',
  ];

const resumeLinks = [
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/1-Black%20White%20Minimalist%20CV%20Resume.pdf?alt=media&token=0cee7f98-2d34-4e96-885f-4ab6b4d4e65e',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/2-Blue%20And%20Pink%20Modern%20Graphic%20Designer%20Resume%20(1).pdf?alt=media&token=f909ef82-e0f1-4550-b897-0ac006c97d12',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/3-Blue%20Lines%20Marketing%20Manager%20Professional%20Simple%20CV%20Resume.pdf?alt=media&token=39659117-297e-4a82-947f-8b6f66656b44',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/4-dark%20blue%20and%20black%20cv%20resume.pdf?alt=media&token=bc64cc3e-7f8b-49c5-8f93-6b7c2fe36425',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/5-%20Entry%20Level%20Fresher%20Resume%20in%20Black%20and%20White%20Simple%20Style.pdf?alt=media&token=5e927d54-4831-4266-bfcb-5c7289e8c683',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/6-Gold%20Minimalist%20Professional%20Work%20Data%20Analyst%20Friendly%20Resume.pdf?alt=media&token=e5761103-9852-46df-939f-a9cd02e5a1f2',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/7-Gray%20Green%20Neutral%20Minimalist%20Corporate%20Professional%20Web%20Developer%20Resume.pdf?alt=media&token=adf3f7cc-5b68-45ea-b13c-26157133246d',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/8-Light%20Grey%20Minimalist%20resume.pdf?alt=media&token=15ccd06c-acc1-4d11-abd9-5abcec1a49b5',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/9-Minimalist%20White%20and%20Grey%20Professional%20Resume.pdf?alt=media&token=3e46e640-e632-4ae9-b003-d4a151ab3fe5',
  'https://firebasestorage.googleapis.com/v0/b/harbour-39025.appspot.com/o/10-Simple%20Resume%20in%20White%20and%20Pastel%20Blue%20Minimalist%20Style.pdf?alt=media&token=8d787741-37bb-440a-b6c9-c1fd3664bdba',
];