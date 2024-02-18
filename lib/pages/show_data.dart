import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../modal_sheets/show_job_details_model.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  late TextEditingController _locationController;
  late Stream<QuerySnapshot> _jobsStream;

  bool _isFilterExpanded = false; // Track if filter is expanded

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _jobsStream = FirebaseFirestore.instance.collection("Jobs").snapshots();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Widget loadingIndicator() {
    var loadingIndicators = const [
      CircularProgressIndicator(
        strokeWidth: 3,
      ),
      LinearProgressIndicator(
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
    ];
    var index = Random().nextInt(loadingIndicators.length);
    return loadingIndicators[index];
  }

  void myModalSheet(Widget content) {
    showModalBottomSheet(
      context: context,
      builder: (context) => content,
    );
  }

  void filterJobs(String location) {
    print('Filtering jobs for location: $location');
    location = location.trim();
    setState(() {
      _jobsStream = FirebaseFirestore.instance
          .collection("Jobs")
          .orderBy("location")
          .startAt([location])
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("Job Opportunities"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isFilterExpanded = !_isFilterExpanded;
              });
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _isFilterExpanded ? 100 : 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          hintText: 'Sort by location...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      String location = _locationController.text;
                      location = location.isNotEmpty
                          ? location[0].toUpperCase() + location.substring(1)
                          : location;
                      location=location.trim();
                      if (location.isNotEmpty) {
                        filterJobs(location);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please enter a location to filter.'),
                        ));
                      }
                    },
                    child: Text('Search'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _jobsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: loadingIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          onTap: () => myModalSheet(
                            JobDetailsModal(snapshot.data!.docs[index]),
                          ),
                          leading: CircleAvatar(
                            child: Text("${index + 1}"),
                          ),
                          title: Text("${snapshot.data!.docs[index]["title"]}"),
                          subtitle:
                          Text("${snapshot.data!.docs[index]["company"]}"),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                } else {
                  return const Center(
                    child: Text("No Jobs"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
