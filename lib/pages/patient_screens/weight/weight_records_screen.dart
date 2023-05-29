// import 'package:bpcheck/pages/patient_screens/weight/weight_screen.dart';
// import 'package:flutter/material.dart';
// class WeightRecordsScreen extends StatefulWidget {
//   const WeightRecordsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WeightRecordsScreen> createState() => _WeightRecordsScreenState();
// }
//
// class _WeightRecordsScreenState extends State<WeightRecordsScreen> {
//   List<Record> records = [
//     Record(sugarLevel: 5.5, notes: 'Feeling good'),
//     Record(sugarLevel: 6.0, notes: 'Had a light breakfast'),
//     Record(sugarLevel: 4.8, notes: 'Morning walk'),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weight Records'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(20),
//         itemCount: records.length,
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
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeightScreen()));
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

import 'package:bpcheck/pages/patient_screens/weight/weight_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../login/database_service.dart';

class WeightRecords extends StatefulWidget {
  @override
  _WeightRecordsState createState() => _WeightRecordsState();
}

class _WeightRecordsState extends State<WeightRecords > {
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
        title: Text('Weight Records'),
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
                        MaterialPageRoute(builder: (context) => WeightScreen())
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
   /*   floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WeightScreen()));

        },
        child: Icon(Icons.add),
        backgroundColor: AppColors.primaryColor,
      ),*/
      body: StreamBuilder(
        stream: _databaseService.getUserRecords("weight"),
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic>? weightData =
            snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
            if (weightData != null && weightData.isNotEmpty) {
              List<dynamic> weightRecords = weightData.values.toList();
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: weightRecords.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          'Weight: ${weightRecords[index]['weight']} KG'),
                      subtitle: Text(
                          'Notes: ${weightRecords[index]['notes']}'),
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
