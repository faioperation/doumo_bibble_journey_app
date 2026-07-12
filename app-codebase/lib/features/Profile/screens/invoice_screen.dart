import 'package:flutter/material.dart';
import '../../../app/constants.dart';
import '../../../widgets/appbars/custom_appbar.dart';
import '../models/invoice_model.dart';
import '../services/invoice_service.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late Future<List<InvoiceResponse>> _future;

  @override
  void initState() {
    super.initState();
    _future = InvoiceService.fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: "Invoice",
        onTap: () => Navigator.pop(context),
      ),
      body: FutureBuilder<List<InvoiceResponse>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Failed to load invoices"));
          }

          final subscriptions = snapshot.data!;

          final activePlan = subscriptions.firstWhere(
                (e) => e.isActive,
            orElse: () => subscriptions.first,
          );

          final invoices =
          subscriptions.expand((e) => e.invoices).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "CURRENT SUBSCRIPTION",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                _currentPlanCard(activePlan),

                const SizedBox(height: 32),

                const Text(
                  "INVOICE HISTORY",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),

                if (invoices.isEmpty)
                  const Text("No invoices found"),

                ...invoices.map(_invoiceCard).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _currentPlanCard(InvoiceResponse sub) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Active Plan",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  "${_capitalize(sub.currentPlan)} ",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff6BBF7A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  sub.expiredAt != null
                      ? "Renew On ${_formatDate(sub.createdAt!)}"
                      : "No renewal date",
                  style: const TextStyle(fontSize: 14),
                ),

              ],
            ),
          ),
          const CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xffEAF6ED),
            child: Icon(Icons.public, color: Color(0xff6BBF7A)),
          ),
        ],
      ),
    );
  }

  Widget _invoiceCard(InvoiceModel i) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Transaction Id: ${i.transactionId}",
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                     Text(
                      "Plan: ${i.plan}",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${i.amount}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff6BBF7A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _row("Payment Date", _formatDate(i.paymentDate)),
          _row("Period Start", _formatDate(i.startDate)),
          _row("Period End", _formatDate(i.endDate)),
        ],
      ),
    );
  }

  Widget _row(String left, String right) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: const TextStyle(color: Colors.grey)),
          Text(right),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    return "${d.day.toString().padLeft(2, '0')} "
        "${_month(d.month)} ${d.year}";
  }

  String _month(int m) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[m - 1];
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
