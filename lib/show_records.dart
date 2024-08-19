import 'package:flutter/material.dart';
import 'package:quick_reflex/card_records.dart';

class ShowRecords extends StatefulWidget {
  const ShowRecords({super.key});

  @override
  State<ShowRecords> createState() => _ShowRecordsState();
}

class _ShowRecordsState extends State<ShowRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recordes"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 17),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return const CardRecords();
            },
          ),
        ));
  }
}
