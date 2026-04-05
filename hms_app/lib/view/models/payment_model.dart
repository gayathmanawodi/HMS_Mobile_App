class PaymentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String billNumber;
  final List<BillItem> items;
  final double totalAmount;
  final double paidAmount;
  final String paymentMethod;
  final bool isPaid;
  final DateTime createdAt;
  final DateTime? paidAt;

  PaymentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.billNumber,
    required this.items,
    required this.totalAmount,
    this.paidAmount = 0,
    required this.paymentMethod,
    this.isPaid = false,
    required this.createdAt,
    this.paidAt,
  });

  double get balance => totalAmount - paidAmount;

  factory PaymentModel.fromMap(Map<String, dynamic> map, String id) {
    return PaymentModel(
      id: id,
      patientId: map['patientId'] ?? '',
      patientName: map['patientName'] ?? '',
      billNumber: map['billNumber'] ?? '',
      items: (map['items'] as List<dynamic>? ?? [])
          .map((i) => BillItem.fromMap(i as Map<String, dynamic>))
          .toList(),
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      paidAmount: (map['paidAmount'] ?? 0).toDouble(),
      paymentMethod: map['paymentMethod'] ?? 'Cash',
      isPaid: map['isPaid'] ?? false,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      paidAt: map['paidAt'] != null ? DateTime.tryParse(map['paidAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'patientName': patientName,
      'billNumber': billNumber,
      'items': items.map((i) => i.toMap()).toList(),
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'paymentMethod': paymentMethod,
      'isPaid': isPaid,
      'createdAt': createdAt.toIso8601String(),
      'paidAt': paidAt?.toIso8601String(),
    };
  }
}

class BillItem {
  final String description;
  final int quantity;
  final double unitPrice;

  BillItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get total => quantity * unitPrice;

  factory BillItem.fromMap(Map<String, dynamic> map) {
    return BillItem(
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 1,
      unitPrice: (map['unitPrice'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }
}
