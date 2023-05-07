import 'dart:convert';
import 'dart:io';
import 'package:classico/utilities/generics/get_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:classico/services/auth/auth_service.dart';
import 'package:classico/services/cloud/cloud_note.dart';
import 'package:classico/services/cloud/firebase_cloud_storage.dart';
import 'package:classico/utilities/dialogs/cannot_share_empty_note_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../mainscreen.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? URL;

  Future uploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print("Download Link: $urlDownload");

    setState(() {
      URL = urlDownload;
      uploadTask = null;
    });
  }

  CloudNote? _note;
  /*File? _image;
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }*/

  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textController;
  late final TextEditingController _textController1;
  late final TextEditingController _textController2;
  late final TextEditingController _textController3;

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      _textController1.text = widgetNote.text1;
      _textController2.text = widgetNote.text2;
      _textController3.text = widgetNote.text3;
      return widgetNote;
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    final currentUser = AuthService.firebase().currentUser!;
    final userId = currentUser.id;
    final newNote = await _notesService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty &&
        _textController1.text.isEmpty &&
        _textController2.text.isEmpty &&
        _textController3.text.isEmpty &&
        note != null) {
      _notesService.deleteNotes(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    final text1 = _textController1.text;
    final text2 = _textController2.text;
    final text3 = _textController3.text;

    if (note != null &&
        (text.isNotEmpty ||
            text1.isNotEmpty ||
            text2.isNotEmpty ||
            text3.isNotEmpty)) {
      await _notesService.updateNote(
        documentId: note.documentId,
        text: text,
        text1: text1,
        text2: text2,
        text3: text3,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIfTextNotEmpty();
    _textController.dispose();
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _textController = TextEditingController();
    _textController1 = TextEditingController();
    _textController2 = TextEditingController();
    _textController3 = TextEditingController();

    super.initState();
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    final text1 = _textController1.text;
    final text2 = _textController2.text;
    final text3 = _textController3.text;

    await _notesService.updateNote(
      documentId: note.documentId,
      text: text,
      text1: text1,
      text2: text2,
      text3: text3,
    );
  }

  void _setupTextControllerListener() async {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Medical History'),
        actions: [
          IconButton(
            onPressed: () async {
              final text = _textController.text;
              final text1 = _textController1.text;
              final text2 = _textController2.text;
              final text3 = _textController3.text;
              if (_note == null ||
                  (text.isEmpty &&
                      text1.isEmpty &&
                      text2.isEmpty &&
                      text3.isEmpty)) {
                await showCannotShareEmptyNoteDialog(context);
              } else {
                final texts = [text, text1, text2, text3];
                Share.share(texts.join('\n'));
              }
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icon/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: createOrGetExistingNote(context),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  _setupTextControllerListener();
                  return Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      const Text(
                        "Enter the Medical information of the patient",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        controller: _textController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Enter diagnosis",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _textController1,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Enter date of diagnosis",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _textController2,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Enter prescriptions",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _textController3,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Any additional useful remark",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      /*const SizedBox(height: 20),
                      if (_image != null) ...[
                        Image.file(_image!),
                      ] else ...[
                        const Text('No image selected.'),
                      ],
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Select Image'),
                      ),
                      const SizedBox(
                        height: 310,
                      ),*/
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (URL != null)
                            Flexible(
                              child: Container(
                                color: Colors.blue[100],
                                child: Center(
                                  child: Image.network(URL!, height: 300),
                                ),
                              ),
                            ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: uploadFile,
                            child: const Text("Upload File"),
                          ),
                          const SizedBox(height: 32),
                          buildProgress(),
                        ],
                      ),
                    ],
                  );
                default:
                  return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox(height: 50);
        }
      });
}
