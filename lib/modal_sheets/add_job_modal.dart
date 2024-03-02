import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JobModal extends StatefulWidget {
  const JobModal({super.key});

  @override
  State<JobModal> createState() => _JobModalState();
}

class _JobModalState extends State<JobModal> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    "title": "",
    "desc": "",
    "company": "",
    "apply-link": "",
    "experience": "",
    "location": "",
    "moreInfoLink": "",
  };

  void addDataToFirebase() {
    FirebaseFirestore.instance.collection("Jobs").add(formData);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Title'),
                onSaved: (value) => formData['title'] = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Description'),
                onSaved: (value) => formData['desc'] = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Company'),
                onSaved: (value) => formData['company'] = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the company name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Apply Link'),
                onSaved: (value) => formData['apply-link'] = value,
                validator: (value) {
                  // Add your own validation logic if needed
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Experience Required'),
                onSaved: (value) => formData['experience'] = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                onSaved: (value) => formData['location'] = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'More Info Link'),
                onSaved: (value) => formData['moreInfoLink'] = value,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Handle the form data, for example, send it to a server
                        // print('Form data: $formData');
                        addDataToFirebase();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
