// import 'package:bpcheck/pages/patient_screens/medication/medication_screen.dart';
// import 'package:flutter/material.dart';
// class MedicationRecordsScreen extends StatefulWidget {
//   const MedicationRecordsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MedicationRecordsScreen> createState() => _MedicationRecordsScreenState();
// }
//
// class _MedicationRecordsScreenState extends State<MedicationRecordsScreen> {
//   List<Record> records = [
//     Record(sugarLevel: 5.5, notes: 'Feeling good'),
//     Record(sugarLevel: 6.0, notes: 'Had a light breakfast'),
//     Record(sugarLevel: 4.8, notes: 'Morning walk'),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Medication Records'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: records.length,
//         padding: EdgeInsets.all(20),
//         itemBuilder: (context, index) {
//           final record = records[index];
//           return Card(
//             child: ListTile(
//               title: Text('Sugar Level: ${record.sugarLevel}'),
//               subtitle: Text('Notes: ${record.notes}'),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicationScreen()));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
// class Record {
//   final double sugarLevel;
//   final String notes;
//
//   Record({required this.sugarLevel, required this.notes});
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../login/database_service.dart';
import 'medication_screen.dart';

class MedicationRecords extends StatefulWidget {
  @override
  _MedicationRecordsState createState() => _MedicationRecordsState();
}

class _MedicationRecordsState extends State<MedicationRecords > {
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
        title: Text('Medication Records'),
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
                        MaterialPageRoute(builder: (context) => MedicationScreen())
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
    /*  floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MedicationScreen()));

        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.primaryColor,
      ),*/
      body: StreamBuilder(
        stream: _databaseService.getUserRecords("medication"),
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic>? medicationData =
            snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
            if (medicationData != null && medicationData.isNotEmpty) {
              List<dynamic> medicationRecords =
              medicationData.values.toList();
              return ListView.builder(
                itemCount: medicationRecords.length,
                padding: EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          'Medication: ${medicationRecords[index]['medication']}'),
                      subtitle: Text(
                          'Dosage: ${medicationRecords[index]['dosage']} ${medicationRecords[index]['unit']}, Notes: ${medicationRecords[index]['notes']}'),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No records found.'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


