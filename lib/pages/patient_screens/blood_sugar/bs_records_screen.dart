
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../login/database_service.dart';
import 'blood_sugar_screen.dart';

class BloodSugarRecords extends StatefulWidget {
  @override
  _BloodSugarRecordsState createState() => _BloodSugarRecordsState();
}

class _BloodSugarRecordsState extends State<BloodSugarRecords> {
  final DatabaseService _databaseService = DatabaseService();
  late Future<DataSnapshot> _userDataFuture;

  Future<DataSnapshot> getCurrentUserData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    final User? user = auth.currentUser;

    if (user == null) {
      throw Exception("No user is currently signed in.");
    }

    return dbRef.child("users").child(user.uid).get();
  }

  @override
  void initState() {
    super.initState();
    _userDataFuture = getCurrentUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Blood Sugar Records'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FutureBuilder<DataSnapshot>(
        future: _userDataFuture,
        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // show nothing while loading
          }
          if (snapshot.hasError) {
            return Container(); // don't show the button if there's an error
          }
          if (snapshot.hasData) {
            if (snapshot.data!.value is Map) {
              Map<dynamic, dynamic> userData = snapshot.data!.value as Map<dynamic, dynamic>;
              String? caretakerId = userData['caretaker_id'];
              if (caretakerId != null && caretakerId.isNotEmpty) {
                return Container(); // don't show the button if the user has a caretaker
              } else {
                return FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BloodSugarScreen())
                    );
                  },
                  child: Icon(Icons.add),
                  backgroundColor: AppColors.primaryColor,
                );
              }
            }
          }
          return Container(); // don't show the button if there's no data
        },
      ),
  /*    floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BloodSugarScreen()));
        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.primaryColor,
      ),*/
      body: StreamBuilder(
        stream: _databaseService.getUserRecords('bloodSugar'),
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic>? bloodSugarData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?; // Update this line
            if (bloodSugarData != null && bloodSugarData.isNotEmpty) {
              List<dynamic> bloodSugarRecords = bloodSugarData.values.toList();
              return ListView.builder(
                padding: EdgeInsets.all(20),
              itemCount: bloodSugarRecords.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          'Sugar Concentration: ${bloodSugarRecords[index]['sugarConcentration']}'),
                      subtitle: Text(
                          'Measured: ${bloodSugarRecords[index]['measured']}, Notes: ${bloodSugarRecords[index]['notes']}'),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No records found.'));
            }
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
