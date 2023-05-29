class BpRecord{
  final String sysPressure;
  final String diaPressure;
  final String pulse;
  final String arm;
  final String notes;

  BpRecord({
    required this.sysPressure,
    required this.diaPressure,
    required this.pulse,
    required this.arm,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
    'sysPressure': sysPressure,
    'diaPressure': diaPressure,
    'pulse': pulse,
    'arm': arm,
    'notes': notes,
  };
}