import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class DataQuery {
  bool isLoggedIn() {
    print("--------------------");
    print(FirebaseAuth.instance.currentUser());
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createEvent(eventData) async {
    await Firestore.instance.collection("events").add(eventData).catchError((e) {
      print(e);
    });
    if (isLoggedIn()) {
      Firestore.instance.collection("events").add(eventData).catchError((e) {
        print(e);
      });
    } else {
      print("You need to log in");
    }
  }

  Future<void> createUser(userData) async {
    if (!isLoggedIn()) {
      Firestore.instance.collection("users").add(userData).catchError((e) {
        print(e);
      });
    }
  }

  getEventDataByLocation(locationData) async {
    return await Firestore.instance.collection("events").getDocuments();
  }

  getEventDataByPopularity(locationData) async {
    return await Firestore.instance.collection("events").getDocuments();
  }
}
