import 'package:flutter/material.dart';
import 'package:tiklove_fe/res/images/app_images.dart';
import 'package:tiklove_fe/theme/app_colors.dart';

class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.requestDate),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80 * pix,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 16 * pix),
            child: Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 10 * pix),
                Text(
                  "Điểm danh nhận quà",
                  style: TextStyle(
                    fontSize: 18 * pix,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BeVietnamPro',
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 80 * pix,
          left: 0,
          right: 0,
          child: RewardContainer(),
        ),
      ],
    ));
  }
}

class RewardContainer extends StatefulWidget {
  const RewardContainer({super.key});

  @override
  State<RewardContainer> createState() => _RewardContainerState();
}

class _RewardContainerState extends State<RewardContainer> {
  List<bool> checkedDays = List.generate(30, (index) => false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pix = size.width / 393;
    return Container(
      height: size.height - 80 * pix,
      padding: EdgeInsets.all(16 * pix),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4 * pix,
          mainAxisSpacing: 4 * pix,
          childAspectRatio: 0.8,
        ),
        itemCount: 30,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: (index == 0 && !checkedDays[index])
                    ? Colors.white
                    : (!checkedDays[index] && index > 0)
                        ? checkedDays[index - 1]
                            ? Colors.white
                            : (index == 0 || index == 19)
                                ? Colors.orangeAccent
                                : Colors.grey[300]!.withOpacity(0.5)
                        : Colors.grey[300]!.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (index == 0 || index == 19)
                            ? Image.asset(AppImages.gau,
                                width: 60 * pix, height: 60 * pix)
                            : Image.asset(AppImages.icongift2,
                                width: 60 * pix, height: 60 * pix),
                        Text("Ngày ${index + 1}",
                            style: TextStyle(
                                color: (index == 0 && !checkedDays[index])
                                    ? AppColors.primary
                                    : (!checkedDays[index] && index > 0)
                                        ? checkedDays[index - 1]
                                            ? AppColors.primary
                                            : Colors.white
                                        : Colors.white,
                                fontSize: 14 * pix,
                                fontFamily: 'BeVietnamPro'))
                      ],
                    ),
                  ),
                  (index == 0 && !checkedDays[index])
                      ? Positioned(
                          top: 35 * pix,
                          right: 10,
                          left: 10 * pix,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                checkedDays[index] = true;
                              });
                            },
                            child: Container(
                              height: 34 * pix,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.5),
                                    offset: Offset(0, 0),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Nhận",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14 * pix,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'BeVietnamPro',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : (!checkedDays[index] && index > 0)
                          ? checkedDays[index - 1]
                              ? Positioned(
                                  top: 35 * pix,
                                  right: 10,
                                  left: 10 * pix,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        checkedDays[index] = true;
                                      });
                                    },
                                    child: Container(
                                      height: 34 * pix,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.5),
                                            offset: Offset(0, 0),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Nhận",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14 * pix,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'BeVietnamPro',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                          : Container(),
                  checkedDays[index]
                      ? Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent.withOpacity(0.5),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30 * pix,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
