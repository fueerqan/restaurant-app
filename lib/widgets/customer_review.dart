import 'package:flutter/material.dart';

class CustomerReview extends StatelessWidget {
  const CustomerReview(
      {Key? key, required this.name, required this.date, required this.review})
      : super(key: key);

  final String name;
  final String date;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )),
            Expanded(
                child: Text(
              date,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 12,
              ),
            )),
          ],
        ),
        const SizedBox(height: 8),
        Text(review),
      ]),
    );
  }
}
