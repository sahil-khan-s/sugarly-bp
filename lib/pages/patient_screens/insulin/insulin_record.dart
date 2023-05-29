class InsulinRecord{
  String insulin;
  String dosage;
  String notes;
  String unit;

  InsulinRecord({
      required this.insulin,
      required this.dosage,
      required this.notes,
      required this.unit});
  Map<String, dynamic> toJson() => {
    'insulin': insulin,
    'dosage': dosage,
    'notes': notes,
    'unit': unit,
  };
}