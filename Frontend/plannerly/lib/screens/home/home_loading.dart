import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plannerly/utils/colors/colors.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: Container(
          height: size.height * 0.16,
          width: size.width * 0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.backgroundLight),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  'Please wait...!!',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                LoadingAnimationWidget.fourRotatingDots(
                  color: AppColors.buttonBlue,
                  size: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
