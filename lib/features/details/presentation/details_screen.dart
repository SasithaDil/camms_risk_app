import 'dart:io';

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
    return Scaffold(
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
                        _imageFile =
                            await _picker.pickImage(source: ImageSource.camera);
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
                          Navigator.pushNamed(
                              context, ScreenRoutes.toImagePreviewScreen,
                              arguments: imagePath);
                        },
                        child: Text(imagePath),
                      ),
                    ),
              // SizedBox(
              //     height: context.mQHeight * 0.3,
              //     width: context.mQHeight * 0.3,
              //     child: Image.file(File(imagePath)),
              //   ),
              const SizedBox(
                height: UI.padding2x,
              ),
            ],
          ),
        ));
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
              trailingIcons: _buildTailingIconDateTime(dateReported),
              textFormEnabled: false),
          DetailsTextFormField(
              label: 'Date Occurred',
              validationMsg: 'Date Reported can\'t be empty',
              textEditingController: dateOccurred,
              trailingIcons: _buildTailingIconDateTime(dateOccurred),
              textFormEnabled: false),
        ],
      ),
    );
  }

  Widget _buildTailingIconArrow() {
    final searchBarController = TextEditingController();
    return PopUpBox(
        searchBarController: searchBarController,
        title: 'Notification Type',
        textEditingController: recordType,
        radioBtnItems: radioBtnItems);
  }

  Widget _buildTailingIconDateTime(controller) {
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
}
