import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class JobDetailsModal extends StatelessWidget {
  
  String title = "";
  String desc = "";
  String company = "";
  String applyLink = "";
  String experience = "";
  String location = "";
  String moreInfoLink = "";

  JobDetailsModal(dynamic job, {super.key}) {
    title = job["title"];
    desc = job["desc"];
    company = job["company"];
    applyLink = job["apply-link"];
    experience = job["experience"];
    location = job["location"];
    moreInfoLink = job["moreInfoLink"];
  }
  
  Future<void> _onOpen(LinkableElement link) async {
    print("Linking!!!");
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(company,style: TextStyle(fontSize: 30, color: Colors.blueGrey),),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),

            Text(
              desc,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            Linkify(
              onOpen: _onOpen,
              text: applyLink,
              options: const LinkifyOptions(
                humanize: true,
              ),
            ),
            const SizedBox(height: 24),
      Text(
        "Experience: $experience",
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
            const SizedBox(height: 24),
            Text(
              "At: $location",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Text("More Info: $moreInfoLink"),
          ],
        ),
    );
  }
}