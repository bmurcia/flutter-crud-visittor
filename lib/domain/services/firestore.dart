import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _visitsCollection = FirebaseFirestore.instance.collection('visits');

  //CREATE
  Future<void> addVisit(String name, String dni, String visitReason, String personToVisit, String vehicle, String entryTime, String companions) {
      return _visitsCollection.add({
        'name': name,
        'identification': dni,
        'visitReason': visitReason,
        'personToVisit': personToVisit,
        'transportation': vehicle,
        'entryTime': Timestamp.now(),
        'companions': companions,
      });    
  }

  //READ
  Stream<QuerySnapshot> getVisits() {
    final visitsStream = _visitsCollection.orderBy('entryTime', descending: true).snapshots();
    return visitsStream;
  }

  //UPDATE
  Future<void> updateVisit(String name, String dni, String visitReason, String personToVisit, String vehicle, String entryTime, String companions, String docId) {
    return _visitsCollection.doc(docId).update({
      'name': name,
      'identification': dni,
      'visitReason': visitReason,
      'personToVisit': personToVisit,
      'transportation': vehicle,
      'entryTime': Timestamp.now(),
      'companions': companions,
    });
  }

  //DELETE
  Future<void> deleteVisit(String docId) {
    return _visitsCollection.doc(docId).delete();
  }


}