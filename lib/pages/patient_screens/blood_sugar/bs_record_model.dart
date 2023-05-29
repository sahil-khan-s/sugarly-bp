class BSRecord {
  final String sugarConcentration;
  final String measured;
  final String date;
  final String notes;

  BSRecord({required this.sugarConcentration,
    required this.measured,
    required this.date,
    required this.notes});

  Map<String, dynamic> toJson() => {
    'sugarConcentration': sugarConcentration,
    'measured': measured,
    'date': date,
    'notes': notes,
  };
}