class WeightRecordModel{
  String weight;
  String notes;

  WeightRecordModel({
    required this.weight,
    required this.notes,
  });
  Map<String, dynamic> toJson() => {
    'weight': weight,
    'notes': notes,

  };
}