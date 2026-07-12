class InvoiceResponse {
  final int id;
  final String currentPlan;
  final DateTime? expiredAt;
  final bool isActive;
  final DateTime createdAt;
  final List<InvoiceModel> invoices;

  InvoiceResponse({
    required this.id,
    required this.currentPlan,
    required this.expiredAt,
    required this.isActive,
    required this.createdAt,
    required this.invoices,
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse(
      id: json['id'],
      currentPlan: json['current_plan'],
      expiredAt: json['expired_at'] != null
          ? DateTime.parse(json['expired_at'])
          : null,
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      invoices: (json['invoices'] as List)
          .map((e) => InvoiceModel.fromJson(e))
          .toList(),
    );
  }
}

class InvoiceModel {
  final String transactionId;
  final String amount;
  final String plan;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime paymentDate;

  InvoiceModel({
    required this.transactionId,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.paymentDate,
    required this.plan,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      transactionId: json['transaction_id'],
      amount: json['amount'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      paymentDate: DateTime.parse(json['payment_date']),
      plan: json['plan'],
    );
  }
}
