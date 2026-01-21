import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:edochub_b2b/widgets/modular_button.dart';

class DocumentUploadScreen extends StatefulWidget {
  final String serviceType;

  const DocumentUploadScreen({super.key, required this.serviceType});

  @override
  DocumentUploadScreenState createState() => DocumentUploadScreenState();
}

class DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final Map<String, File?> _documents = {};

  Future<void> _pickFile(String documentName) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      if (file.lengthSync() > 2 * 1024 * 1024) {
        if (!mounted) return;
        // Show error message for file size
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File size should not exceed 2MB')),
        );
        return;
      }
      setState(() {
        _documents[documentName] = file;
      });
    }
  }

  List<Widget> _buildDocumentUploaders() {
    List<String> requiredDocuments = [
      'PAN Card',
      'Aadhaar Card (Front)',
      'Aadhaar Card (Back)',
      'Voter Card',
      'Signature'
    ];

    switch (widget.serviceType) {
      case 'Doctor':
      case 'Nurse':
      case 'Paramedical Staff':
        requiredDocuments.addAll(['12th Marksheet', 'Degree Certificate']);
        break;
      case 'Ambulance':
        requiredDocuments.addAll(['Driving License', '10th/12th Marksheet']);
        break;
    }

    return requiredDocuments.map((docName) {
      return Column(
        children: [
          ListTile(
            title: Text(docName),
            subtitle: _documents[docName] != null ? Text(_documents[docName]!.path.split('/').last) : null,
            trailing: const Icon(Icons.upload_file),
            onTap: () => _pickFile(docName),
          ),
          const Divider(),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Documents'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ..._buildDocumentUploaders(),
            const SizedBox(height: 32),
            ModularButton(
              onPressed: () {
                // Handle document submission
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
