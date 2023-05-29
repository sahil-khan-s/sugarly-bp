class MedicationRecord{
  String medication;
  String dosage;
  String notes;
  String unit;

  MedicationRecord({
      required this.medication,
      required this.dosage,
      required this.notes,
      required this.unit});
  Map<String, dynamic> toJson() => {
    'medication': medication,
    'dosage': dosage,
    'notes': notes,
    'unit': unit,
  };
}