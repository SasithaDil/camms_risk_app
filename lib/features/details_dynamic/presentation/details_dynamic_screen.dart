import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:risk_sample/core/logger.dart';
import 'package:risk_sample/core/screen_utils.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/features/details/presentation/widget/combo_buttons.dart';
import 'package:risk_sample/features/details/presentation/widget/date_picker.dart';
import 'package:risk_sample/features/details/presentation/widget/time_picker.dart';
import 'package:risk_sample/features/details_dynamic/logic/bloc/incident_detail_bloc.dart';
import 'package:risk_sample/features/details_dynamic/presentation/widget/incident_label.dart';
import 'package:risk_sample/features/details_dynamic/presentation/widget/incident_text_field.dart';
import 'package:risk_sample/routes/routes.dart';
import 'package:risk_sample/routes/routes_extension.dart';
import 'package:risk_sample/utils/assets.dart';
import 'package:risk_sample/utils/constants.dart';

class InsidentDetailScreen extends StatefulWidget {
  const InsidentDetailScreen({super.key});

  @override
  State<InsidentDetailScreen> createState() => _InsidentDetailScreenState();
}

class _InsidentDetailScreenState extends State<InsidentDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isDatePicker = true;
  // bool isGroupHeader = false;

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  late String imagePath;
  List<TextEditingController> textEditingControllers = [];
  var controllers = {};

  @override
  void initState() {
    BlocProvider.of<IncidentDetailBloc>(context).add(IncidentDetail());
    imagePath = '';
    super.initState();
  }

  // void getType(TeplateTypeString templateTypeString) {
  //   switch (templateTypeString) {
  //     case TeplateTypeString.dateTimePicker:
  //       isDatePicker = true;
  //       break;
  //     case TeplateTypeString.groupHeader:
  //       isGroupHeader = true;
  //       break;
  //     default:
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camms Risk'),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(appbarChevronLeftIcon)),
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset(appbarPencil)),
          IconButton(
              onPressed: () async {
                // var data = Detail(
                //   recordType: recordType.text.toString(),
                //   recordCode: recordCode.text.toString(),
                //   recordTitle: recordTitle.text.toString(),
                //   reportedBy: reportedBy.text.toString(),
                //   reportedDate: dateReported.text.toString(),
                //   dateOccurred: dateOccurred.text.toString(),
                //   image: imagePath.toString(),
                // );

                // await DatabaseHelper.instance.add(data);
              },
              icon: Image.asset(appbarTickIcon)),
        ],
      ),
      body: FocusTraversalGroup(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.mQWidth * 0.01),
              //! enable when we are using api call

              child: BlocBuilder<IncidentDetailBloc, IncidentDetailState>(
                builder: (context, state) {
                  printLog(state);
                  if (state is IncidentDetailLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is IncidentDetailLoaded) {
                    return ListView.builder(
                      itemCount: state.formCon.length,
                      itemBuilder: (context, index) {
                        if (state.formCon[index].templateTypeString ==
                            TextStrings.dateTime) {
                          final DateTime now = DateTime.now();
                          final DateFormat formatter =
                              DateFormat('MM/dd/yyyy hh:mm a');
                          final String dateTimeNow = formatter.format(now);

                          if (state
                                  .textControllers[
                                      '${state.formCon[index].objectDefinitionId}']
                                  .text ==
                              '') {
                            state
                                .textControllers[
                                    '${state.formCon[index].objectDefinitionId}']
                                .text = dateTimeNow;
                          }
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible:
                                  state.formCon[index].templateTypeString ==
                                      TextStrings.textBoxString,
                              child: Padding(
                                padding: const EdgeInsets.all(UI.padding),
                                child: Text(
                                  state.formCon[index].name,
                                  style: const TextStyle(
                                    color: mainBlue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(context.mQWidth * 0.01),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: context.mQWidth * 0.75,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: context.mQWidth * 0.2,
                                          child: InsidentLabel(
                                              label: state
                                                  .formCon[index].displayName),
                                        ),
                                        SizedBox(
                                          width: context.mQWidth * 0.5,
                                          child: InsidentTextFormField(
                                              textEditingController: state
                                                      .textControllers[
                                                  '${state.formCon[index].objectDefinitionId}'],
                                              textFormEnabled:
                                                  state.formCon[index].isEnable,
                                              validationMsg: '',
                                              formFieldhint: state
                                                  .formCon[index].textValue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.mQWidth * 0.2,
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: state.formCon[index]
                                                  .templateTypeString ==
                                              TextStrings.dateTime,
                                          child: SizedBox(
                                            width: context.mQWidth * 0.1,
                                            child: DatePickerWidget(
                                                controller: state
                                                        .textControllers[
                                                    '${state.formCon[index].objectDefinitionId}']),
                                          ),
                                        ),
                                        Visibility(
                                          visible: state.formCon[index]
                                                  .templateTypeString ==
                                              TextStrings.dateTime,
                                          child: SizedBox(
                                            width: context.mQWidth * 0.1,
                                            child: TimePickerWidget(
                                                controller: state
                                                        .textControllers[
                                                    '${state.formCon[index].objectDefinitionId}']),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible:
                                  state.formCon[index].templateTypeString !=
                                      TextStrings.comboButtons,
                              child: const Divider(
                                color: grey,
                                thickness: 1.0,
                              ),
                            ),
                            Visibility(
                              visible:
                                  state.formCon[index].templateTypeString ==
                                      TextStrings.comboButtons,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ComboButtons(
                                    onPressed: () async {
                                      try {
                                        _imageFile = await _picker.pickImage(
                                            source: ImageSource.camera);
                                        if (_imageFile != null) {
                                          final File imageTemp =
                                              File(_imageFile!.path);
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
                                        final imageTemp =
                                            File(_imageFile!.path);
                                        printLog(imageTemp);
                                        if (_imageFile != null) {
                                          final File imageTemp =
                                              File(_imageFile!.path);
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
                            ),
                            imagePath.isEmpty
                                ? Container()
                                : Visibility(
                                    visible: state.formCon[index]
                                            .templateTypeString ==
                                        TextStrings.comboButtons,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.all(UI.padding3x),
                                      child: InkWell(
                                        onTap: () {
                                          context.toNamed(
                                              ScreenRoutes.toImagePreviewScreen,
                                              args: imagePath);
                                        },
                                        child: Text(imagePath),
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      },
                    );
                  }
                  if (state is IncidentDetailFailed) {
                    return Center(child: Text(state.error.toString()));
                  }
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                },
              )),
        ),
      ),
    );
  }
}
