import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risk_sample/core/logger.dart';
import 'package:risk_sample/utils/assets.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key, this.restorationId, required this.controller});

  final String? restorationId;
  final TextEditingController controller;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget>
    with RestorationMixin {
      
  @override
  String? get restorationId => widget.restorationId;
  TextEditingController get controller => widget.controller;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;

        DateFormat inputFormat = DateFormat('MM/dd/yyyy hh:mm a');
        DateTime dttemp = inputFormat.parse(controller.text);
        DateTime dt1 = DateTime.parse(_selectedDate.value.toString());
        
        var time = TimeOfDay(
                hour: dttemp.hour,
                minute: dttemp.minute,
              ).format(context);

        controller.text = '${dt1.month}/${dt1.day}/${dt1.year} $time ';
 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton( 
      icon: Image.asset(dateIcon),
      
      onPressed:() {
              _restorableDatePickerRouteFuture.present();
                printLog('msg>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
              
              
          }
      );
    
    // IconButton(
    //       icon: Icon(Icons.calendar_today_outlined, color: mainBlue,size:  context.mQHeight * 0.035,),
    //       onPressed:(){
    //           _restorableDatePickerRouteFuture.present();
    //       },
    //   );
  }
}