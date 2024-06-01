import 'package:facs_mobile/pages/home_page.dart';
import 'package:facs_mobile/pages/NavigationBar/SubPage/action_page.test.dart';
import 'package:facs_mobile/services/user_services.dart';
import 'package:facs_mobile/themes/custom_bottom_style.dart';
import 'package:facs_mobile/widgets/custom_evulated_bottom.test.dart';
import 'package:flutter/material.dart';

/// Record detail when status == "InVote", usually after user assign action to a record or AI detect a fire

Widget _buildActionFunction(BuildContext context,
    {required String recordIdAdding}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.h),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Action",
            style: CustomTextStyles.titleLargeBluegray300,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: recordDetailResponse['userVoting'].length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                left: 15.h,
                right: 31.h,
              ),
              child: _buildColorwhite(
                context,
                typesomething: recordDetailResponse['userVoting'][index]
                    ['securityCode'],
                typesomething1: recordDetailResponse['userVoting'][index]
                    ['voteType'],
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.h, right: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomEvulatedBottom(
                  onPressed: () async {
                    bool confirmed = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm"),
                          content: Text(
                              "Are you sure you want to set status to false alarm?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Navigate back to previous page
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.black),
                                ),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                side: MaterialStateProperty.all(
                                  BorderSide(color: Colors.black87),
                                ),
                                textStyle: MaterialStateProperty.all(
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmed != null && confirmed) {
                      bool setStatus = await RecordService.actionAlarm(
                          recordId: recordIdAdding, alarmLevel: 7);
                      if (setStatus) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Successfully set status to false alarm'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Failed to set status to false alarm'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  text: "Fake Alarm",
                  buttonStyle: CustomBottomStyle.fillYellow,
                  margin: EdgeInsets.only(right: 22.h),
                  buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Record detail when status == "InAlarm", usually cause by user using AlertByHand

Widget _confirmButton(BuildContext context, {required String recordIdAdding}) {
  return Padding(
    padding: EdgeInsets.only(left: 25.h, right: 15.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomEvulatedBottom(
            onPressed: () async {
              bool confirmed = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm"),
                    content: Text(
                        "Are you sure you want to set status to false alarm?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          side: MaterialStateProperty.all(
                            BorderSide(color: Colors.black),
                          ),
                          textStyle: MaterialStateProperty.all(
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          side: MaterialStateProperty.all(
                            BorderSide(color: Colors.black87),
                          ),
                          textStyle: MaterialStateProperty.all(
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );

              if (confirmed != null && confirmed) {
                bool setStatus = await RecordService.actionAlarm(
                    recordId: recordIdAdding, alarmLevel: 7);
                if (setStatus) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully set status to false alarm'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to set status to false alarm'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            text: "Fake Alarm",
            buttonStyle: CustomBottomStyle.fillYellow,
            margin: EdgeInsets.only(right: 22.h),
            buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
          ),
        ),
        Expanded(
          child: CustomEvulatedBottom(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlarmPage(
                    recordId: recordIdAdding,
                  ),
                ),
              );
            },
            text: "Action",
            buttonStyle: CustomBottomStyle.fillGreen,
            margin: EdgeInsets.only(right: 22.h),
            buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
          ),
        )
      ],
    ),
  );
}

Widget _confirmActionButton(BuildContext context,
    {required String recordIdAdding}) {
  bool shouldHideAlertAll = recordDetailResponse['userVoting'].any((vote) =>
      vote['userId'] == UserServices.userId && vote['voteLevel'] == 5);
  return Padding(
    padding: EdgeInsets.only(left: 25.h, right: 15.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomEvulatedBottom(
            onPressed: () {
              RecordService.finishActionPhase(recordId: recordIdAdding);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            text: "Finish",
            buttonStyle: CustomBottomStyle.fillGreen,
            margin: EdgeInsets.only(right: 22.h),
            buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
          ),
        ),
        if (!shouldHideAlertAll)
          Expanded(
            child: CustomEvulatedBottom(
              onPressed: () {
                RecordService.actionAlarm(
                    recordId: recordIdAdding, alarmLevel: 5);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              text: "Alert All",
              buttonStyle: CustomBottomStyle.fillRed,
              margin: EdgeInsets.only(right: 22.h),
              buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
            ),
          )
      ],
    ),
  );
}
