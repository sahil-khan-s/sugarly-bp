import 'package:bpcheck/config/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../login/database_service.dart';

class SelectCaretaker extends StatefulWidget {



  @override
  _SelectCaretakerState createState() => _SelectCaretakerState();
}
class _SelectCaretakerState extends State<SelectCaretaker> {
  final DatabaseService _databaseService = DatabaseService();
  String filter = '';
  List<Caretaker> filteredCaretakers = [];

  Future<void> _selectCaretaker(String caretakerId) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    await _databaseService.assignCaretaker(currentUser!.uid, caretakerId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Caretaker'),backgroundColor: AppColors.primaryColor,),
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
              stream: _databaseService.caretakersStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  final caretakers = snapshot.data!;
                  filteredCaretakers = caretakers.where((caretaker) =>
                  caretaker.name.toLowerCase().contains(filter.toLowerCase()) ||
                      caretaker.email.toLowerCase().contains(filter.toLowerCase())).toList();

                  return ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: filteredCaretakers.length,
                    itemBuilder: (context, index) {
                      final caretaker = filteredCaretakers[index];
                      return Card(
                        child: ListTile(
                          title: Text(caretaker.name),
                          subtitle: Text('${caretaker.email}'),
                          isThreeLine: true,
                          onTap: () => _selectCaretaker(caretaker.uid),
                        ),
                      );
                    },
                  );
                }

                return Center(child: Text('No caretakers found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}