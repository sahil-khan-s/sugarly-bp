import 'dart:async';

import 'package:bpcheck/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../shared/custom_loading.dart';
import '../../utils/toasty.dart';
import 'package:intl/intl.dart';

import '../patient_screens/models/dashboard_card_data.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<DatabaseEvent> getUserRecords(String record) {
    return _dbRef.child("users")
        .child(getIdForRequest())
        .child('record')
        .child(record)
        .onValue;
  }
  Future<void> createUser(
      String uid,
      String role,
      String name,
      String email,
      String phoneNumber,
      String tfAddress) async {
    try {
      await _dbRef.child('users').child(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'role': role,
        'address': tfAddress,
      });
    } catch (e) {
      Toasty.error(e.toString());
      print(e.toString());
      return null;
    }
  }

  Future<void> getUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;
      DatabaseReference userRef = _dbRef.child('users').child(userId);

      try {
        DataSnapshot dataSnapshot = await userRef.get();
        Map<dynamic, dynamic>? userData =
            dataSnapshot.value as Map<dynamic, dynamic>?;
        if (userData != null) {
          UserData.fromJson(userData);
          print('User data: $userData');
        } else {
          Toasty.error('User data not found.');
        }
      } catch (e) {
        Toasty.error('Error fetching user data: $e');
      }
    } else {
      Toasty.error('No user is currently signed in.');
    }
  }

  void updateUserData(String name, String phNo, String address) async {
    SmartDialog.showLoading(
        msg: "please wait...",
        builder: (_) => const CustomLoading(
          type: 2,
        ));
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;
      DatabaseReference userRef = _dbRef.child('users').child(userId);

      Map<String, dynamic> updates = {};

      updates['address'] = address;
      updates['name'] = name;
      updates['phone_number'] = phNo;

      try {
        await userRef.update(updates);
        Toasty.success('User data updated successfully.');
        SmartDialog.dismiss();
      } catch (e) {
        SmartDialog.dismiss();
        Toasty.error('Error updating user data: $e');
      }
    } else {
      SmartDialog.dismiss();
      Toasty.error('No user is currently signed in.');
    }
  }

  Future<List<Map<String, dynamic>>> getUsersByRole(String role) async {
    await Firebase.initializeApp();
    DatabaseReference usersRef = FirebaseDatabase.instance.reference().child('users');
    List<Map<String, dynamic>> usersList = [];

    DataSnapshot dataSnapshot = await usersRef
        .orderByChild('role')
        .equalTo(role)
        .get();

    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic> usersMap = dataSnapshot.value as Map<dynamic, dynamic>;
      usersMap.entries.forEach((entry) {
        Map<String, dynamic> user = {
          'key': entry.key.toString(),
          ...entry.value,
        };
        usersList.add(user);
      });
    }

    print(usersList);
    return usersList;
  }

  Future<void> addRecord(String recordType,Map<String,dynamic> record) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    SmartDialog.showLoading(
        msg: "please wait...",
        builder: (_) => const CustomLoading(
          type: 2,
        ));
    try {
      await databaseReference
          .child('users')
          .child(getIdForRequest())
          .child("record")
          .child(recordType)
          .push()
          .set(record);
      Toasty.success('Record added successfully');
      SmartDialog.dismiss();
    } catch (e) {
      SmartDialog.dismiss();
      Toasty.error('Error: $e');
    }
  }
  String getIdForRequest(){
    if(DashboardCardData.patientId!=""){
      return DashboardCardData.patientId;
    }else{
      return _auth.currentUser!.uid;
    }
  }
  Stream<List<BloodSugarRecord>> getBloodSugarRecords() {
    return _dbRef
        .child('users')
        .child(getIdForRequest())
        .child('record')
        .child('bloodSugar')
        .onValue
        .map((event) {
      Map<dynamic, dynamic>? bloodSugarData =
      event.snapshot.value as Map<dynamic, dynamic>?;
      if (bloodSugarData != null && bloodSugarData.isNotEmpty) {
        List<dynamic> bloodSugarRecords = bloodSugarData.values.toList();
        return bloodSugarRecords.map((record) => BloodSugarRecord(
          date: DateFormat("MMM d, yyyy").parse(record['date']),
          sugarConcentration: double.parse(record['sugarConcentration']),
        )).toList();
      } else {
        return [];
      }
    });
  }

  Stream<List<Caretaker>> caretakersStream() {
    return _dbRef
        .child('users')
        .orderByChild('role')
        .equalTo('caretaker')
        .onValue
        .map((event) {
      List<Caretaker> caretakers = [];
      if (event.snapshot.value != null) {
        Map<String, dynamic> usersData = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
        usersData.forEach((key, value) {
          caretakers.add(Caretaker.fromSnapshot(key, Map<String, dynamic>.from(value as Map<dynamic, dynamic>)));
        });
      }
      return caretakers;
    });
  }

  Stream<List<Caretaker>> doctorsStream() {
    return _dbRef
        .child('users')
        .orderByChild('role')
        .equalTo('doctor')
        .onValue
        .map((event) {
      List<Caretaker> caretakers = [];
      if (event.snapshot.value != null) {
        Map<String, dynamic> usersData = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
        usersData.forEach((key, value) {
          caretakers.add(Caretaker.fromSnapshot(key, Map<String, dynamic>.from(value as Map<dynamic, dynamic>)));
        });
      }
      return caretakers;
    });
  }

  Future<void> assignCaretaker(String patientId, String caretakerId) async {
    await _dbRef.child('users/$patientId/caretaker_id').set(caretakerId);
  }
  Future<void> assignDoctor(String patientId, String caretakerId) async {
    await _dbRef.child('users/$patientId/doctor_id').set(caretakerId);
  }
  Stream<String?> assignedPatientIdStream() {
    return _dbRef
        .child('users')
        .orderByChild('caretaker_id')
        .equalTo(_auth.currentUser!.uid)
        .onValue
        .map((event) {
      if (event.snapshot.value != null) {
        Map<String, dynamic> usersData = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
        String? patientId;
        usersData.forEach((key, value) {
          // As there should be only one patient assigned to a caretaker, we take the first one
          patientId = key;
        });
        return patientId;
      }
      return null;
    });
  }
  Future<Map<String, dynamic>?> getPatient(String patientId) async {
    DatabaseReference patientRef = _dbRef.child("users").child(patientId);
    DataSnapshot dataSnapshot = await patientRef.get();
    return (dataSnapshot.value as Map<dynamic, dynamic>?)?.cast<String, dynamic>();
  }

  Future<List<Map<String, dynamic>>> getAllPatients() async {
    List<Map<String, dynamic>> patients = [];

    DataSnapshot dataSnapshot = await _dbRef.child("users").get();

    if (dataSnapshot.value != null) {
      Map<String, dynamic> usersMap = dataSnapshot.value as Map<String, dynamic>;
      usersMap.forEach((key, value) {
        if (value['role'] == 'patient') {
          Map<String, dynamic> patient = value as Map<String, dynamic>;
          patient['uid'] = key;
          patients.add(patient);
        }
      });
    }

    return patients;
  }

  Future<List<Map<String, dynamic>>> getPatients() async {
    List<Map<String, dynamic>> patientsList = [];

    DataSnapshot snapshot = await _dbRef.child('users').get(); // Changed to `get()`
    if (snapshot.value is Map) {
      Map<dynamic, dynamic> usersMap = snapshot.value as Map<dynamic, dynamic>;

      usersMap.forEach((userId, userData) {
        if (userData["role"] == "patient") {
          Map<String, dynamic> patientData = Map<String, dynamic>.from(userData as Map);
          patientData["uid"] = userId;
          patientsList.add(patientData);
        }
      });
    }

    return patientsList;
  }
}

class Caretaker {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;

  Caretaker({required this.uid, required this.name, required this.email, required this.phoneNumber});

  factory Caretaker.fromSnapshot(String key, Map<String, dynamic> data) {
    return Caretaker(
      uid: key,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
    );
  }
}




class BloodSugarRecord {
  final DateTime date;
  final double sugarConcentration;

  BloodSugarRecord({required this.date, required this.sugarConcentration});

  @override
  String toString() {
    return 'BloodSugarRecord{date: $date, sugarConcentration: $sugarConcentration}';
  }
}
