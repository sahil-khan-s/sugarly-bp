import 'package:bpcheck/config/app_colors.dart';
import 'package:flutter/material.dart';
import '../login/database_service.dart';

class PatientsRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients Records'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseService().getPatients(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('An error occurred'));
          }

          List<Map<String, dynamic>> patients = snapshot.data!;
          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Patient Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Name: ${patient['name']}'),
                      Text('Email: ${patient['email']}'),
                      Text('Phone: ${patient['phone_number']}'),
                      SizedBox(height: 20),
                      Text('Records', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      ...buildRecordWidgets(patient['record']),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
  List<Widget> buildRecordWidgets(Map<Object?, Object?>? records) {
    List<Widget> recordWidgets = [];

    if (records == null) {
      recordWidgets.add(Text('No records available'));
      return recordWidgets;
    }

    records.forEach((recordType, recordData) {
      recordWidgets.add(Text('$recordType:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
      var recordMap = recordData;
      int recordCount = 1;
      if (recordMap is Map) {
        recordMap.forEach((recordId, data) {
          recordWidgets.add(Text('Record #$recordCount'));
          var dataMap = data;
          if (dataMap is Map) {
            dataMap.forEach((key, value) {
              recordWidgets.add(Text('$key: $value'));
            });
          }
          recordCount++;
          recordWidgets.add(SizedBox(height: 10));
        });
      }
    });

    return recordWidgets;
  }
}