import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:risk_sample/core/logger.dart';
import 'package:risk_sample/core/screen_utils.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/features/details/data/db_helpers.dart';
import 'package:risk_sample/features/details/domain/detail_model.dart';
import 'package:risk_sample/features/details/presentation/widget/combo_buttons.dart';
import 'package:risk_sample/features/details/presentation/widget/date_picker.dart';
import 'package:risk_sample/features/details/presentation/widget/details_text_form_field.dart';
import 'package:risk_sample/features/details/presentation/widget/popup_box.dart';
import 'package:risk_sample/features/details/presentation/widget/time_picker.dart';
import 'package:risk_sample/routes/routes.dart';
import 'package:risk_sample/routes/routes_extension.dart';
import 'package:risk_sample/utils/assets.dart';
import 'package:risk_sample/utils/constants.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ImagePicker _picker = ImagePicker();
  final recordType = TextEditingController();
  final recordCode = TextEditingController();
  final recordTitle = TextEditingController();
  final reportedBy = TextEditingController();
  final dateReported = TextEditingController();
  final dateOccurred = TextEditingController();
  late List availableData;
  var radiobutton;

  List<String> radioBtnItems = [
    "Vehicle Inspection",
    "Network risk",
    "Site Record",
    "Product Enquiry"
  ];
  List<String> radioBtnFilterdData = <String>[];

  XFile? _imageFile;
  late String imagePath;

  @override
  void initState() {
    availableData = [];
    imagePath = "";
    super.initState();
    getData();
    radioBtnFilterdData.addAll(radioBtnItems);
  }

  Future getData() async {
    availableData = await DatabaseHelper.instance.getDetails();

    if (availableData.isNotEmpty) {
      printLog("Data available------------>${availableData.last.reportedDate}");
      recordType.text = availableData.last.recordType;
      recordCode.text = availableData.last.recordCode;
      recordTitle.text = availableData.last.recordTitle;
      reportedBy.text = availableData.last.reportedBy;
      dateReported.text = availableData.last.reportedDate;
      dateOccurred.text = availableData.last.dateOccurred;
      imagePath = availableData.last.image;

      setState(() {
        imagePath = imagePath;
      });
    } else {
      printLog("Data NOT available------------>");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Camms Risk"),
              trailing: Image.asset(
                appbarTickIcon,
                color: mainBlue,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: context.mQHeight * 0.03,
                            bottom: context.mQHeight * 0.015),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                              child: Text(
                                'View Content',
                              ),
                            ),
                            SizedBox(
                              width: context.mQHeight * 0.015,
                            ),
                            const Icon(
                              Icons.open_in_new,
                              color: mainBlue,
                              size: UI.padding2x,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mQWidth * 0.05,
                        vertical: context.mQWidth * 0.02,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: context.mQWidth * 0.3,
                            child: const DefaultTextStyle(
                                style: TextStyles.boldTextStyle,
                                child: Text('Record Type')),
                          ),
                          SizedBox(
                            width: context.mQWidth * 0.4,
                            child: const DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                              child: Text('Vehicle Inspection'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showPopup();
                            },
                            child: SizedBox(
                              width: context.mQWidth * 0.2,
                              child: const Padding(
                                padding: EdgeInsets.only(left: UI.padding4x),
                                child:
                                    Icon(Icons.keyboard_arrow_right_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: UI.padding2x, right: UI.padding2x),
                      child: Divider(
                        height: 4.0,
                        color: grey,
                      ),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Padding(
                        padding: EdgeInsets.only(right: context.mQWidth * 0.08),
                        child: const Text('Record Code',
                            style: TextStyles.boldTextStyle),
                      ),
                      placeholder: 'II - 2287',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      readOnly: false,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: UI.padding2x, right: UI.padding2x),
                      child: Divider(
                        height: 4.0,
                        color: grey,
                      ),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Padding(
                        padding: EdgeInsets.only(right: context.mQWidth * 0.08),
                        child: const Text('Record Title',
                            style: TextStyles.boldTextStyle),
                      ),
                      placeholder: 'Avoid using identifiable names',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      readOnly: false,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: UI.padding2x, right: UI.padding2x),
                      child: Divider(
                        height: 4.0,
                        color: grey,
                      ),
                    ),
                    CupertinoTextFormFieldRow(
                      prefix: Padding(
                        padding: EdgeInsets.only(right: context.mQWidth * 0.08),
                        child: const Text('Reported By',
                            style: TextStyles.boldTextStyle),
                      ),
                      placeholder: 'Camms System',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      readOnly: false,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: UI.padding2x, right: UI.padding2x),
                      child: Divider(
                        height: 4.0,
                        color: grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mQWidth * 0.05,
                        vertical: context.mQWidth * 0.02,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: context.mQWidth * 0.3,
                            child: const DefaultTextStyle(
                                style: TextStyles.boldTextStyle,
                                child: Text('Date reported')),
                          ),
                          SizedBox(
                            width: context.mQWidth * 0.4,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                              child: Text(
                                DateFormat('MM/dd/yyyy hh:mm a').format(
                                  DateTime.now(),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showDatePicker(context, true);
                                },
                                child: SizedBox(
                                  width: context.mQWidth * 0.1,
                                  child: Image.asset(dateIcon),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showDatePicker(context, false);
                                },
                                child: SizedBox(
                                  width: context.mQWidth * 0.1,
                                  child: Image.asset(timeIcon),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: UI.padding2x, right: UI.padding2x),
                      child: Divider(
                        height: 4.0,
                        color: grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mQWidth * 0.05,
                        vertical: context.mQWidth * 0.02,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: context.mQWidth * 0.3,
                            child: const DefaultTextStyle(
                                style: TextStyles.boldTextStyle,
                                child: Text('Date occured')),
                          ),
                          SizedBox(
                            width: context.mQWidth * 0.4,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                              child: Text(
                                DateFormat('MM/dd/yyyy hh:mm a').format(
                                  DateTime.now(),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showDatePicker(context, true);
                                },
                                child: SizedBox(
                                  width: context.mQWidth * 0.1,
                                  child: Image.asset(dateIcon),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showDatePicker(context, false);
                                },
                                child: SizedBox(
                                  width: context.mQWidth * 0.1,
                                  child: Image.asset(timeIcon),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: UI.padding4x,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ComboButtons(
                          onPressed: () {
                            // try {
                            //   _imageFile = await _picker.pickImage(
                            //       source: ImageSource.camera);
                            //   if (_imageFile != null) {
                            //     final File imageTemp = File(_imageFile!.path);
                            //     printLog(imageTemp);
                            //     setState(() {
                            //       imagePath = imageTemp.path;
                            //     });
                            //   } else {
                            //     printLog("No image picked..");
                            //   }
                            // } catch (e) {
                            //   printLog("Error $e");
                            // }
                          },
                          icon: Icons.camera_alt_outlined,
                          buttonText: 'Camera',
                        ),
                        ComboButtons(
                          onPressed: () {
                            // try {
                            //   _imageFile = await _picker.pickImage(
                            //       source: ImageSource.gallery);
                            //   final imageTemp = File(_imageFile!.path);
                            //   printLog(imageTemp);
                            //   if (_imageFile != null) {
                            //     final File imageTemp = File(_imageFile!.path);
                            //     printLog(imageTemp);
                            //     setState(() {
                            //       imagePath = imageTemp.path;
                            //     });
                            //   } else {
                            //     printLog("No image picked..");
                            //   }
                            // } catch (e) {
                            //   printLog("error $e");
                            // }
                          },
                          icon: Icons.upload_file_outlined,
                          buttonText: 'Upload',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: UI.padding2x,
                    ),
                    imagePath.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(UI.padding3x),
                            child: InkWell(
                              onTap: () {
                                context.toNamed(
                                    ScreenRoutes.toImagePreviewScreen,
                                    args: imagePath);
                              },
                              child: Text(imagePath),
                            ),
                          ),
                    const SizedBox(
                      height: UI.padding2x,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Camms Risk'),
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(appbarChevronLeftIcon)),
              actions: [
                IconButton(onPressed: () {}, icon: Image.asset(appbarPencil)),
                IconButton(
                    onPressed: () async {
                      var data = Detail(
                        recordType: recordType.text.toString(),
                        recordCode: recordCode.text.toString(),
                        recordTitle: recordTitle.text.toString(),
                        reportedBy: reportedBy.text.toString(),
                        reportedDate: dateReported.text.toString(),
                        dateOccurred: dateOccurred.text.toString(),
                        image: imagePath.toString(),
                      );

                      await DatabaseHelper.instance.add(data);
                    },
                    icon: Image.asset(appbarTickIcon)),
              ],
            ),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: context.mQHeight * 0.03,
                          bottom: context.mQHeight * 0.015),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('View Content'),
                          SizedBox(
                            width: context.mQHeight * 0.015,
                          ),
                          Icon(
                            Icons.open_in_new,
                            color: mainBlue,
                            size: context.mQHeight * 0.035,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildForm(),
                  const SizedBox(
                    height: UI.padding2x,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ComboButtons(
                        onPressed: () async {
                          try {
                            _imageFile = await _picker.pickImage(
                                source: ImageSource.camera);
                            if (_imageFile != null) {
                              final File imageTemp = File(_imageFile!.path);
                              printLog(imageTemp);
                              setState(() {
                                imagePath = imageTemp.path;
                              });
                            } else {
                              printLog("No image picked..");
                            }
                          } catch (e) {
                            printLog("Error $e");
                          }
                        },
                        icon: Icons.camera_alt_outlined,
                        buttonText: 'Camera',
                      ),
                      ComboButtons(
                        onPressed: () async {
                          try {
                            _imageFile = await _picker.pickImage(
                                source: ImageSource.gallery);
                            final imageTemp = File(_imageFile!.path);
                            printLog(imageTemp);
                            if (_imageFile != null) {
                              final File imageTemp = File(_imageFile!.path);
                              printLog(imageTemp);
                              setState(() {
                                imagePath = imageTemp.path;
                              });
                            } else {
                              printLog("No image picked..");
                            }
                          } catch (e) {
                            printLog("error $e");
                          }
                        },
                        icon: Icons.upload_file_outlined,
                        buttonText: 'Upload',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: UI.padding2x,
                  ),
                  imagePath.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(UI.padding3x),
                          child: InkWell(
                            onTap: () {
                             context.toNamed(
                                    ScreenRoutes.toImagePreviewScreen,
                                    args: imagePath);
                            },
                            child: Text(imagePath),
                          ),
                        ),
                  const SizedBox(
                    height: UI.padding2x,
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildForm() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');
    final String dateTimeNow = formatter.format(now);

    if (dateReported.text == '') {
      dateReported.text = dateTimeNow;
    }
    if (dateOccurred.text == '') {
      dateOccurred.text = dateTimeNow;
    }

    return Form(
      child: Column(
        children: [
          DetailsTextFormField(
              label: 'Record Type',
              validationMsg: 'Record Type can\'t be empty',
              formFieldhint: 'inquiry / illness',
              textEditingController: recordType,
              trailingIcons: _buildTailingIconArrow(),
              textFormEnabled: false),
          DetailsTextFormField(
              label: 'Record Code',
              validationMsg: 'Record Code can\'t be empty',
              formFieldhint: 'll - 2287',
              textEditingController: recordCode),
          DetailsTextFormField(
              label: 'Record Title',
              validationMsg: 'Record Title can\'t be empty',
              formFieldhint: 'Avoid using identifiable names in this field',
              textEditingController: recordTitle),
          DetailsTextFormField(
              label: 'Reported By',
              validationMsg: 'Reported By can\'t be empty',
              formFieldhint: 'Camms System',
              textEditingController: reportedBy),
          DetailsTextFormField(
              label: 'Date Reported',
              validationMsg: 'Date Reported can\'t be empty',
              textEditingController: dateReported,
              trailingIcons: _buildTailingIconDateTime(dateReported, context),
              textFormEnabled: false),
          DetailsTextFormField(
              label: 'Date Occurred',
              validationMsg: 'Date Reported can\'t be empty',
              textEditingController: dateOccurred,
              trailingIcons: _buildTailingIconDateTime(dateOccurred, context),
              textFormEnabled: false),
        ],
      ),
    );
  }

  Widget _buildTailingIconArrow() {
    final searchBarController = TextEditingController();
    return Platform.isAndroid
        ? PopUpBox(
            searchBarController: searchBarController,
            title: 'Notification Type',
            textEditingController: recordType,
            radioBtnItems: radioBtnItems)
        : IconButton(
            onPressed: () {
              showPopup();
            },
            icon: Image.asset(chevronRightIcon),
          );
  }

  Widget _buildTailingIconDateTime(controller, c) {
    return Row(
      children: [
        DatePickerWidget(
          controller: controller,
        ),
        TimePickerWidget(
          controller: controller,
        )
      ],
    );
  }

  void showPopup() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) {
          return CupertinoPopupSurface(
            isSurfacePainted: true,
            child: SafeArea(
              child: Container(
                color: lightGrey,
                alignment: Alignment.center,
                width: context.mQWidth,
                height: context.mQHeight * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: UI.padding2x,
                    ),
                    SizedBox(
                      height: context.appBarHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(UI.padding),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: mainBlue,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: context.mQWidth * 0.3),
                              child: const DefaultTextStyle(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  child: Text('Record Type')),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(UI.padding),
                        child: CupertinoSearchTextField(
                          controller: TextEditingController(),
                          placeholder: 'Search items',
                        ),
                      ),
                    ),
                    BottomModalTile(
                      onPressed: () {},
                      context: context,
                      text: 'Vehicle Inspection',
                      visibility: true,
                    ),
                    BottomModalTile(
                      onPressed: () {},
                      context: context,
                      text: 'Network risk',
                    ),
                    BottomModalTile(
                      onPressed: () {},
                      context: context,
                      text: 'Site Record',
                    ),
                    BottomModalTile(
                      onPressed: () {},
                      context: context,
                      text: 'Product Enquiry',
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showDatePicker(ctx, isDate) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: isDate
                            ? CupertinoDatePickerMode.date
                            : CupertinoDatePickerMode.time,
                        onDateTimeChanged: (val) {
                          // _setDatetimeOnClick(val);
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }
}

class BottomModalTile extends StatelessWidget {
  const BottomModalTile({
    super.key,
    required this.context,
    required this.text,
    this.visibility = false,
    required this.onPressed,
  });

  final BuildContext context;
  final String text;
  final bool visibility;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: context.mQHeight * 0.07,
        width: double.infinity,
        color: lightGrey,
        child: Padding(
          padding: const EdgeInsets.only(
            top: UI.padding2x,
            left: UI.padding3x,
            right: UI.padding3x,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text),
                    Visibility(
                      visible: visibility,
                      child: const Icon(
                        CupertinoIcons.check_mark,
                        color: Color.fromARGB(255, 45, 118, 234),
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: UI.padding2x,
                ),
                child: Divider(
                  color: grey,
                  height: 2.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}





// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:risk_sample/core/logger.dart';
// import 'package:risk_sample/core/screen_utils.dart';
// import 'package:risk_sample/core/theme.dart';
// import 'package:risk_sample/features/details/data/db_helpers.dart';
// import 'package:risk_sample/features/details/domain/detail_model.dart';
// import 'package:risk_sample/features/details/presentation/widget/bottom_modal_tile.dart';
// import 'package:risk_sample/features/details/presentation/widget/combo_buttons.dart';
// import 'package:risk_sample/features/details/presentation/widget/date_picker.dart';
// import 'package:risk_sample/features/details/presentation/widget/details_text_form_field.dart';
// import 'package:risk_sample/features/details/presentation/widget/popup_box.dart';
// import 'package:risk_sample/features/details/presentation/widget/time_picker.dart';
// import 'package:risk_sample/routes/routes.dart';
// import 'package:risk_sample/utils/assets.dart';
// import 'package:risk_sample/utils/constants.dart';

// class DetailsScreen extends StatefulWidget {
//   const DetailsScreen({super.key});

//   @override
//   State<DetailsScreen> createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   final ImagePicker _picker = ImagePicker();
//   final recordType = TextEditingController();
//   final recordCode = TextEditingController();
//   final recordTitle = TextEditingController();
//   final reportedBy = TextEditingController();
//   final dateReported = TextEditingController();
//   final dateOccurred = TextEditingController();
//   late List availableData;
//   var radiobutton;

//   List<String> radioBtnItems = [
//     "Vehicle Inspection",
//     "Network risk",
//     "Site Record",
//     "Product Enquiry"
//   ];
//   List<String> radioBtnFilterdData = <String>[];

//   XFile? _imageFile;
//   late String imagePath;

//   @override
//   void initState() {
//     availableData = [];
//     imagePath = "";
//     super.initState();
//     getData();
//     radioBtnFilterdData.addAll(radioBtnItems);
//   }

//   Future getData() async {
//     availableData = await DatabaseHelper.instance.getDetails();

//     if (availableData.isNotEmpty) {
//       printLog("Data available------------>${availableData.last.reportedDate}");
//       recordType.text = availableData.last.recordType;
//       recordCode.text = availableData.last.recordCode;
//       recordTitle.text = availableData.last.recordTitle;
//       reportedBy.text = availableData.last.reportedBy;
//       dateReported.text = availableData.last.reportedDate;
//       dateOccurred.text = availableData.last.dateOccurred;
//       imagePath = availableData.last.image;

//       setState(() {
//         imagePath = imagePath;
//       });
//     } else {
//       printLog("Data NOT available------------>");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Platform.isIOS
//         ? CupertinoPageScaffold(
//             navigationBar: CupertinoNavigationBar(
//               middle: const Text("Camms Risk"),
//               trailing: Image.asset(
//                 appbarTickIcon,
//                 color: mainBlue,
//               ),
//             ),
//             child: SafeArea(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {},
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           top: context.mQHeight * 0.03,
//                           bottom: context.mQHeight * 0.015),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const DefaultTextStyle(
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.normal,
//                             ),
//                             child: Text(
//                               'View Content',
//                             ),
//                           ),
//                           SizedBox(
//                             width: context.mQHeight * 0.015,
//                           ),
//                           const Icon(
//                             Icons.open_in_new,
//                             color: mainBlue,
//                             size: UI.padding2x,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: context.mQWidth * 0.05,
//                       vertical: context.mQWidth * 0.02,
//                     ),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: context.mQWidth * 0.3,
//                           child: const DefaultTextStyle(
//                               style: TextStyles.boldTextStyle,
//                               child: Text('Record Type')),
//                         ),
//                         SizedBox(
//                           width: context.mQWidth * 0.4,
//                           child: const DefaultTextStyle(
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.normal,
//                             ),
//                             child: Text('Vehicle Inspection'),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             showPopup();
//                           },
//                           child: SizedBox(
//                             width: context.mQWidth * 0.2,
//                             child: const Padding(
//                               padding: EdgeInsets.only(left: UI.padding4x),
//                               child: Icon(Icons.keyboard_arrow_right_outlined),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(
//                         left: UI.padding2x, right: UI.padding2x),
//                     child: Divider(
//                       height: 4.0,
//                       color: grey,
//                     ),
//                   ),
//                   CupertinoTextFormFieldRow(
//                     prefix: Padding(
//                       padding: EdgeInsets.only(right: context.mQWidth * 0.08),
//                       child: const Text('Record Code',
//                           style: TextStyles.boldTextStyle),
//                     ),
//                     placeholder: 'II - 2287',
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a value';
//                       }
//                       return null;
//                     },
//                     readOnly: false,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(
//                         left: UI.padding2x, right: UI.padding2x),
//                     child: Divider(
//                       height: 4.0,
//                       color: grey,
//                     ),
//                   ),
//                   CupertinoTextFormFieldRow(
//                     prefix: Padding(
//                       padding: EdgeInsets.only(right: context.mQWidth * 0.08),
//                       child: const Text('Record Title',
//                           style: TextStyles.boldTextStyle),
//                     ),
//                     placeholder: 'Avoid using identifiable names',
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a value';
//                       }
//                       return null;
//                     },
//                     readOnly: false,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(
//                         left: UI.padding2x, right: UI.padding2x),
//                     child: Divider(
//                       height: 4.0,
//                       color: grey,
//                     ),
//                   ),
//                   CupertinoTextFormFieldRow(
//                     prefix: Padding(
//                       padding: EdgeInsets.only(right: context.mQWidth * 0.08),
//                       child: const Text('Reported By',
//                           style: TextStyles.boldTextStyle),
//                     ),
//                     placeholder: 'Camms System',
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a value';
//                       }
//                       return null;
//                     },
//                     readOnly: false,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(
//                         left: UI.padding2x, right: UI.padding2x),
//                     child: Divider(
//                       height: 4.0,
//                       color: grey,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: context.mQWidth * 0.05,
//                       vertical: context.mQWidth * 0.02,
//                     ),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: context.mQWidth * 0.3,
//                           child: const DefaultTextStyle(
//                               style: TextStyles.boldTextStyle,
//                               child: Text('Date reported')),
//                         ),
//                         SizedBox(
//                           width: context.mQWidth * 0.4,
//                           child: DefaultTextStyle(
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.normal,
//                             ),
//                             child: Text(
//                               DateFormat('MM/dd/yyyy hh:mm a').format(
//                                 DateTime.now(),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 _showDatePicker(context, true);
//                               },
//                               child: SizedBox(
//                                 width: context.mQWidth * 0.1,
//                                 child: Image.asset(dateIcon),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 _showDatePicker(context, false);
//                               },
//                               child: SizedBox(
//                                 width: context.mQWidth * 0.1,
//                                 child: Image.asset(timeIcon),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(
//                         left: UI.padding2x, right: UI.padding2x),
//                     child: Divider(
//                       height: 4.0,
//                       color: grey,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: context.mQWidth * 0.05,
//                       vertical: context.mQWidth * 0.02,
//                     ),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: context.mQWidth * 0.3,
//                           child: const DefaultTextStyle(
//                               style: TextStyles.boldTextStyle,
//                               child: Text('Date occured')),
//                         ),
//                         SizedBox(
//                           width: context.mQWidth * 0.4,
//                           child: DefaultTextStyle(
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.normal,
//                             ),
//                             child: Text(
//                               DateFormat('MM/dd/yyyy hh:mm a').format(
//                                 DateTime.now(),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 _showDatePicker(context, true);
//                               },
//                               child: SizedBox(
//                                 width: context.mQWidth * 0.1,
//                                 child: Image.asset(dateIcon),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 _showDatePicker(context, false);
//                               },
//                               child: SizedBox(
//                                 width: context.mQWidth * 0.1,
//                                 child: Image.asset(timeIcon),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: UI.padding2x,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ComboButtons(
//                         onPressed: () {
//                           // try {
//                           //   _imageFile = await _picker.pickImage(
//                           //       source: ImageSource.camera);
//                           //   if (_imageFile != null) {
//                           //     final File imageTemp = File(_imageFile!.path);
//                           //     printLog(imageTemp);
//                           //     setState(() {
//                           //       imagePath = imageTemp.path;
//                           //     });
//                           //   } else {
//                           //     printLog("No image picked..");
//                           //   }
//                           // } catch (e) {
//                           //   printLog("Error $e");
//                           // }
//                         },
//                         icon: Icons.camera_alt_outlined,
//                         buttonText: 'Camera',
//                       ),
//                       ComboButtons(
//                         onPressed: () {
//                           // try {
//                           //   _imageFile = await _picker.pickImage(
//                           //       source: ImageSource.gallery);
//                           //   final imageTemp = File(_imageFile!.path);
//                           //   printLog(imageTemp);
//                           //   if (_imageFile != null) {
//                           //     final File imageTemp = File(_imageFile!.path);
//                           //     printLog(imageTemp);
//                           //     setState(() {
//                           //       imagePath = imageTemp.path;
//                           //     });
//                           //   } else {
//                           //     printLog("No image picked..");
//                           //   }
//                           // } catch (e) {
//                           //   printLog("error $e");
//                           // }
//                         },
//                         icon: Icons.upload_file_outlined,
//                         buttonText: 'Upload',
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: UI.padding2x,
//                   ),
//                   imagePath.isEmpty
//                       ? Container()
//                       : Padding(
//                           padding: const EdgeInsets.all(UI.padding3x),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(
//                                   context, ScreenRoutes.toImagePreviewScreen,
//                                   arguments: imagePath);
//                             },
//                             child: Text(imagePath),
//                           ),
//                         ),
//                   const SizedBox(
//                     height: UI.padding2x,
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               title: const Text('Camms Risk'),
//               automaticallyImplyLeading: false,
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Image.asset(appbarChevronLeftIcon)),
//               actions: [
//                 IconButton(onPressed: () {}, icon: Image.asset(appbarPencil)),
//                 IconButton(
//                     onPressed: () async {
//                       var data = Detail(
//                         recordType: recordType.text.toString(),
//                         recordCode: recordCode.text.toString(),
//                         recordTitle: recordTitle.text.toString(),
//                         reportedBy: reportedBy.text.toString(),
//                         reportedDate: dateReported.text.toString(),
//                         dateOccurred: dateOccurred.text.toString(),
//                         image: imagePath.toString(),
//                       );

//                       await DatabaseHelper.instance.add(data);
//                     },
//                     icon: Image.asset(appbarTickIcon)),
//               ],
//             ),
//             body: SingleChildScrollView(
//               reverse: true,
//               child: Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () {},
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           top: context.mQHeight * 0.03,
//                           bottom: context.mQHeight * 0.015),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text('View Content'),
//                           SizedBox(
//                             width: context.mQHeight * 0.015,
//                           ),
//                           Icon(
//                             Icons.open_in_new,
//                             color: mainBlue,
//                             size: context.mQHeight * 0.035,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   _buildForm(),
//                   const SizedBox(
//                     height: UI.padding2x,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ComboButtons(
//                         onPressed: () async {
//                           try {
//                             _imageFile = await _picker.pickImage(
//                                 source: ImageSource.camera);
//                             if (_imageFile != null) {
//                               final File imageTemp = File(_imageFile!.path);
//                               printLog(imageTemp);
//                               setState(() {
//                                 imagePath = imageTemp.path;
//                               });
//                             } else {
//                               printLog("No image picked..");
//                             }
//                           } catch (e) {
//                             printLog("Error $e");
//                           }
//                         },
//                         icon: Icons.camera_alt_outlined,
//                         buttonText: 'Camera',
//                       ),
//                       ComboButtons(
//                         onPressed: () async {
//                           try {
//                             _imageFile = await _picker.pickImage(
//                                 source: ImageSource.gallery);
//                             final imageTemp = File(_imageFile!.path);
//                             printLog(imageTemp);
//                             if (_imageFile != null) {
//                               final File imageTemp = File(_imageFile!.path);
//                               printLog(imageTemp);
//                               setState(() {
//                                 imagePath = imageTemp.path;
//                               });
//                             } else {
//                               printLog("No image picked..");
//                             }
//                           } catch (e) {
//                             printLog("error $e");
//                           }
//                         },
//                         icon: Icons.upload_file_outlined,
//                         buttonText: 'Upload',
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: UI.padding2x,
//                   ),
//                   imagePath.isEmpty
//                       ? Container()
//                       : Padding(
//                           padding: const EdgeInsets.all(UI.padding3x),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(
//                                   context, ScreenRoutes.toImagePreviewScreen,
//                                   arguments: imagePath);
//                             },
//                             child: Text(imagePath),
//                           ),
//                         ),
//                   // SizedBox(
//                   //     height: context.mQHeight * 0.3,
//                   //     width: context.mQHeight * 0.3,
//                   //     child: Image.file(File(imagePath)),
//                   //   ),
//                   const SizedBox(
//                     height: UI.padding2x,
//                   ),
//                 ],
//               ),
//             ));
//   }

//   Widget _buildForm() {
//     final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');
//     final String dateTimeNow = formatter.format(now);

//     if (dateReported.text == '') {
//       dateReported.text = dateTimeNow;
//     }
//     if (dateOccurred.text == '') {
//       dateOccurred.text = dateTimeNow;
//     }

//     return Form(
//       child: Column(
//         children: [
//           DetailsTextFormField(
//               label: 'Record Type',
//               validationMsg: 'Record Type can\'t be empty',
//               formFieldhint: 'inquiry / illness',
//               textEditingController: recordType,
//               trailingIcons: _buildTailingIconArrow(),
//               textFormEnabled: false),
//           DetailsTextFormField(
//               label: 'Record Code',
//               validationMsg: 'Record Code can\'t be empty',
//               formFieldhint: 'll - 2287',
//               textEditingController: recordCode),
//           DetailsTextFormField(
//               label: 'Record Title',
//               validationMsg: 'Record Title can\'t be empty',
//               formFieldhint: 'Avoid using identifiable names in this field',
//               textEditingController: recordTitle),
//           DetailsTextFormField(
//               label: 'Reported By',
//               validationMsg: 'Reported By can\'t be empty',
//               formFieldhint: 'Camms System',
//               textEditingController: reportedBy),
//           DetailsTextFormField(
//               label: 'Date Reported',
//               validationMsg: 'Date Reported can\'t be empty',
//               textEditingController: dateReported,
//               trailingIcons: _buildTailingIconDateTime(dateReported),
//               textFormEnabled: false),
//           DetailsTextFormField(
//               label: 'Date Occurred',
//               validationMsg: 'Date Reported can\'t be empty',
//               textEditingController: dateOccurred,
//               trailingIcons: _buildTailingIconDateTime(dateOccurred),
//               textFormEnabled: false),
//         ],
//       ),
//     );
//   }

//   Widget _buildTailingIconArrow() {
//     final searchBarController = TextEditingController();
//     return PopUpBox(
//         searchBarController: searchBarController,
//         title: 'Notification Type',
//         textEditingController: recordType,
//         radioBtnItems: radioBtnItems);
//   }

//   Widget _buildTailingIconDateTime(controller) {
//     return Row(
//       children: [
//         DatePickerWidget(
//           controller: controller,
//         ),
//         TimePickerWidget(
//           controller: controller,
//         )
//       ],
//     );
//   }

//   void showPopup() {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         builder: (BuildContext builder) {
//           return CupertinoPopupSurface(
//             isSurfacePainted: true,
//             child: SafeArea(
//               child: Container(
//                 color: lightGrey,
//                 alignment: Alignment.center,
//                 width: context.mQWidth,
//                 height: context.mQHeight * 0.9,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: UI.padding2x,
//                     ),
//                     SizedBox(
//                       height: context.appBarHeight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(UI.padding),
//                         child: Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {},
//                               child: const Icon(
//                                 Icons.arrow_back_ios_new_outlined,
//                                 color: mainBlue,
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsets.only(left: context.mQWidth * 0.3),
//                               child: const DefaultTextStyle(
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18.0,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                   child: Text('Record Type')),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(UI.padding),
//                         child: CupertinoSearchTextField(
//                           controller: TextEditingController(),
//                           placeholder: 'Search items',
//                         ),
//                       ),
//                     ),
//                     BottomModalTile(
//                       onPressed: () {},
//                       context: context,
//                       text: 'Vehicle Inspection',
//                       visibility: true,
//                     ),
//                     BottomModalTile(
//                       onPressed: () {},
//                       context: context,
//                       text: 'Network risk',
//                     ),
//                     BottomModalTile(
//                       onPressed: () {},
//                       context: context,
//                       text: 'Site Record',
//                     ),
//                     BottomModalTile(
//                       onPressed: () {},
//                       context: context,
//                       text: 'Product Enquiry',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   void _showDatePicker(ctx, isDate) {
//     // showCupertinoModalPopup is a built-in function of the cupertino library
//     showCupertinoModalPopup(
//       context: ctx,
//       builder: (_) => Container(
//         height: 500,
//         color: const Color.fromARGB(255, 255, 255, 255),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 400,
//               child: CupertinoDatePicker(
//                   initialDateTime: DateTime.now(),
//                   mode: isDate
//                       ? CupertinoDatePickerMode.date
//                       : CupertinoDatePickerMode.time,
//                   onDateTimeChanged: (val) {
//                     // _setDatetimeOnClick(val);
//                   }),
//             ),

//             // Close the modal
//             CupertinoButton(
//               child: const Text('OK'),
//               onPressed: () => Navigator.of(ctx).pop(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
