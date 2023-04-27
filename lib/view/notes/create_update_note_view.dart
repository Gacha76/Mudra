import 'package:classico/utilities/generics/get_arguments.dart';
import 'package:flutter/material.dart';
import 'package:classico/services/auth/auth_service.dart';
import 'package:classico/services/cloud/cloud_note.dart';
import 'package:classico/services/cloud/firebase_cloud_storage.dart';
import 'package:classico/utilities/dialogs/cannot_share_empty_note_dialog.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
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
      _textController1.text = widgetNote.text;
      _textController2.text = widgetNote.text;
      _textController3.text = widgetNote.text;
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
    await _notesService
        .updateNote(documentId: note.documentId, 
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
                Share.share(text);
                Share.share(text1);
                Share.share(text2);
                Share.share(text3);
              }
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: FutureBuilder(
        future: createOrGetExistingNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return Column(
                children: [
                  TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Enter diagnosis",
                    ),
                  ),
                  TextField(
                    controller: _textController1,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Enter date of diagnosis",
                    ),
                  ),
                  TextField(
                    controller: _textController2,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Enter prescriptions",
                    ),
                  ),
                  TextField(
                    controller: _textController3,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: "Any additional useful remark",
                    ),
                  ),
                ],
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
