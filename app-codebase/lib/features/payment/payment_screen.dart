import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/features/payment/payment_input_field.dart';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final cardNumber = TextEditingController();
  final cardName = TextEditingController();
  final expiry = TextEditingController();
  final cvc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(title: "payment".tr(), onTap: (){
        Navigator.pop(context);
      }),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Top Premium Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffF8F5F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xff83BF8B), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yearly Premium",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Total amount to be charged",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$39.99/year",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4A6F4F),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Row(
              children: [
                Icon(Icons.lock_outline, size: 18),
                SizedBox(width: 6),
                Text(
                  "Pay by Credit Card",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Image.asset("assets/images/Visa.png", height: 36),
                const SizedBox(width: 10),
                Image.asset("assets/images/Possible payments.png", height: 36),
                const SizedBox(width: 10),
                Image.asset("assets/images/Possible payments (1).png", height: 36),
                const SizedBox(width: 10),
                Image.asset("assets/images/Possible payments (2).png", height: 36),
              ],
            ),

            const SizedBox(height: 20),

            const Row(
              children: [
                Expanded(child: Divider(color: Colors.black26)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("Or"),
                ),
                Expanded(child: Divider(color: Colors.black26)),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xffE6EFE1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [

                  Row(
                    children: const [
                      Icon(Icons.credit_card_rounded, color: Colors.black87),
                      SizedBox(width: 6),
                      Text(
                        "Credit or Debit Card",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  PremiumInputField(
                    label: "Card Number",
                    hint: "0000 0000 0000 0000",
                    controller: cardNumber,
                    inputType: TextInputType.number,
                  ),

                  const SizedBox(height: 14),

                  PremiumInputField(
                    label: "Name on Card",
                    hint: "John Doe",
                    controller: cardName,
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: PremiumInputField(
                          label: "Expiry Date",
                          hint: "MM/YY",
                          controller: expiry,
                          inputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PremiumInputField(
                          label: "CVC",
                          hint: "123",
                          controller: cvc,
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff83BF8B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Pay \$39.99",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Row(
              children: [
                Icon(Icons.lock_outline, size: 18),
                SizedBox(width: 6),
                Text(
                  "Your payment is safe and secure",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
