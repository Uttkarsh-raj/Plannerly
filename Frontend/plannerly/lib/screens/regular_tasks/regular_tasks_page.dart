import 'package:flutter/material.dart';
import 'package:plannerly/screens/widgets/task.dart';
import 'package:plannerly/utils/colors/colors.dart';

class RegularTasks extends StatelessWidget {
  const RegularTasks({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: AppColors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: size.width * 0.2),
                  const Text(
                    "Regular Tasks",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.045),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "REgular Task Progress",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "5/10 task completed.",
                                style: TextStyle(
                                  color: AppColors.white.withOpacity(0.4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              height: size.height * 0.07,
                              width: size.height * 0.07,
                              child: CircularProgressIndicator(
                                value: 0.5,
                                strokeWidth: 7,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.green[400]),
                                backgroundColor:
                                    AppColors.white.withOpacity(0.2),
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.07,
                              width: size.height * 0.07,
                              child: Center(
                                child: Text(
                                  "50%",
                                  style: TextStyle(
                                    color: AppColors.white.withOpacity(0.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              const Text(
                "Urgent Tasks",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // ListView.separated(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) => Task(),
              //   itemCount: 5,
              //   separatorBuilder: (BuildContext context, int index) {
              //     return SizedBox(height: 15);
              //   },
              // ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
