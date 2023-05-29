import 'package:bpcheck/config/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../login/database_service.dart';

class SelectDoctor extends StatefulWidget {

  @override
  _SelectDoctorState createState() => _SelectDoctorState();
}
class _SelectDoctorState extends State<SelectDoctor> {
  final DatabaseService _databaseService = DatabaseService();
  String filter = '';
  List<Caretaker> filteredCaretakers = [];

  Future<void> _selectDoctor(String doctorId) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    await _databaseService.assignDoctor(currentUser!.uid, doctorId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select A Doctor'),backgroundColor: AppColors.primaryColor,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
              },
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  )
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Caretaker>>(
              stream: _databaseService.doctorsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  final doctors = snapshot.data!;
                  filteredCaretakers = doctors.where((doctor) =>
                  doctor.name.toLowerCase().contains(filter.toLowerCase()) ||
                      doctor.email.toLowerCase().contains(filter.toLowerCase())).toList();

                  return ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: filteredCaretakers.length,
                    itemBuilder: (context, index) {
                      final doctor = filteredCaretakers[index];
                      return Card(
                        child: ListTile(
                          title: Text(doctor.name),
                          subtitle: Text('${doctor.email}'),
                          isThreeLine: true,
                          onTap: () => _selectDoctor(doctor.uid),
                        ),
                      );
                    },
                  );
                }

                return Center(child: Text('No doctors found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}