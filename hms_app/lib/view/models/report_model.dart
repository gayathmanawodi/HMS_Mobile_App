enum ReportType { investigation, birth, death }

class ReportModel {
  final String id;
  final String patientId;
  final String patientName;
  final ReportType type;
  final String title;
  final String description;
  final Map<String, String> fields;
  final String? attachmentUrl;
  final String createdBy;
  final DateTime createdAt;

  ReportModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.type,
    required this.title,
    required this.description,
    required this.fields,
    this.attachmentUrl,
    required this.createdBy,
    required this.createdAt,
  });

  factory ReportModel.fromMap(Map<String, dynamic> map, String id) {
    return ReportModel(
      id: id,
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      type: ReportType.values.firstWhere(
        (t) => t.name == map['type'],
        orElse: () => ReportType.investigation,
      ),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      fields: Map<String, String>.from(map['fields'] ?? {}),
      attachmentUrl: map['attachmentUrl'],
      createdBy: map['createdBy'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'patientName': patientName,
      'type': type.name,
      'title': title,
      'description': description,
      'fields': fields,
      'attachmentUrl': attachmentUrl,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
