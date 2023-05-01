import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:classico/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/material.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;
  final String text1;
  final String text2;
  final String text3;
  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName],
        text1 = snapshot.data()[textFieldName1],
        text2 = snapshot.data()[textFieldName2],
        text3 = snapshot.data()[textFieldName3];
}
