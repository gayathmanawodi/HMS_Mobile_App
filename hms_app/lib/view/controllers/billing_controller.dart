import 'package:flutter/material.dart';
import 'package:hospitrack/app/constants.dart';
import 'package:hospitrack/models/bed_model.dart';
import 'package:hospitrack/models/payment_model.dart';
import 'package:hospitrack/services/mock_data_service.dart';
import 'package:uuid/uuid.dart';

class BillingController extends ChangeNotifier {
  final MockDataService _db = MockDataService();
  final _uuid = const Uuid();

  List<PaymentModel> get all => List.unmodifiable(_db.payments);
  List<BedModel> get beds => List.unmodifiable(_db.beds);
  List<BedModel> get availableBeds => _db.getAvailableBeds();

  List<PaymentModel> get unpaidBills =>
      _db.payments.where((p) => !p.isPaid).toList();

  List<PaymentModel> forPatient(String patientId) =>
      _db.payments.where((p) => p.patientId == patientId).toList();

  void generateBill({
    required String patientId,
    required String patientName,
    required List<BillItem> items,
    required String paymentMethod,
  }) {
    final total = items.fold<double>(0, (sum, i) => sum + i.total);
    final payment = PaymentModel(
      id: _uuid.v4(),
      patientId: patientId,
      patientName: patientName,
      billNumber: _db.nextBillNumber(),
      items: items,
      totalAmount: total,
      paymentMethod: paymentMethod,
      createdAt: DateTime.now(),
    );
    _db.addPayment(payment);
    notifyListeners();
  }

  void payBill(String id) {
    final idx = _db.payments.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final p = _db.payments[idx];
      _db.payments[idx] = PaymentModel(
        id: p.id,
        patientId: p.patientId,
        patientName: p.patientName,
        billNumber: p.billNumber,
        items: p.items,
        totalAmount: p.totalAmount,
        paidAmount: p.totalAmount,
        paymentMethod: p.paymentMethod,
        isPaid: true,
        createdAt: p.createdAt,
        paidAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  void assignBed({
    required String bedId,
    required String patientId,
    required String patientName,
    String? notes,
  }) {
    final bed = _db.beds.firstWhere((b) => b.id == bedId);
    _db.updateBed(
      bed.copyWith(
        status: BedStatus.occupied,
        patientId: patientId,
        patientName: patientName,
        admittedAt: DateTime.now(),
        notes: notes,
      ),
    );
    notifyListeners();
  }

  void releaseBed(String bedId) {
    final bed = _db.beds.firstWhere((b) => b.id == bedId);
    _db.updateBed(
      BedModel(
        id: bed.id,
        bedNumber: bed.bedNumber,
        ward: bed.ward,
        status: BedStatus.available,
      ),
    );
    notifyListeners();
  }

  void addBed({required String bedNumber, required String ward}) {
    _db.addBed(BedModel(id: _uuid.v4(), bedNumber: bedNumber, ward: ward));
    notifyListeners();
  }
}
