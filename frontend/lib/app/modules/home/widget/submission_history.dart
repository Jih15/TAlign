import 'package:flutter/material.dart';
import 'package:frontend/app/modules/home/controllers/home_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SubmissionHistory extends GetView<HomeController>{
  const SubmissionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: Color(0xFFFFEEED),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 36,
                decoration: BoxDecoration(
                  color: Color(0xFFC64B4B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Waiting',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(12),
          Text(
            'Your Submission is Rejected',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            'Your submission is Rejected',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          Gap(8)
        ],
      ),
    );
  }
}