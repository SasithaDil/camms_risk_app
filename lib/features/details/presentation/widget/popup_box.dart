import 'package:flutter/material.dart';
import 'package:risk_sample/core/screen_utils.dart';
import 'package:risk_sample/core/theme.dart';
import 'package:risk_sample/utils/assets.dart';



class PopUpBox extends StatefulWidget {
  final TextEditingController searchBarController;
  final TextEditingController textEditingController;
  final String title;
  final List<String> radioBtnItems;


  const PopUpBox({
    Key? key,
    required this.searchBarController,
    required this.title,
    required this.textEditingController,
    required this.radioBtnItems
  }) : super(key: key);
  
  @override
  State<PopUpBox> createState() => _PopUpBoxState();
  
}

class _PopUpBoxState extends State<PopUpBox> {
  List<String> radioBtnFilterdData = <String>[];
  TextEditingController get searchBarController => widget.searchBarController;
  TextEditingController get textEditingController => widget.textEditingController;
  List<String> get radioBtnItems => widget.radioBtnItems;
  String get title => widget.title;

  var radiobutton;

  @override
  void initState() {
    super.initState();
    radioBtnFilterdData.addAll(radioBtnItems);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(chevronRightIcon), 
      onPressed: () {
        showGeneralDialog(       
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return  Center(
            child: Card(
              margin: EdgeInsets.zero,
              child: Container(
                decoration:const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                width:  context.mQWidth * 0.85,
                height: context.mQHeight * 0.46,
                child: Column(
                  children: [
                      Container(
                        decoration:const BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                          color:mainBlue,
                        ),
                      
                        child: SizedBox(width: context.mQWidth * 0.85, 
                          child: Padding(
                            padding: EdgeInsets.all(context.mQWidth * 0.05,),
                            child: Text(title,style: const TextStyle(color: Colors.white,fontSize: 20, decoration: TextDecoration.none),),
                          ),
                        ),
                      ),
            
                      TextField(
                        controller: searchBarController,
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search items",
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Image.asset(popUpSearsh),
                          border: InputBorder.none
                        ),
                      ),

                      StatefulBuilder(
                        builder: (context, setState) {
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: radioBtnFilterdData.length,
                                  itemBuilder: (BuildContext context, int index) { 
                                    return RadioListTile(
                                              title: Text(radioBtnFilterdData[index]),
                                              value: radioBtnFilterdData[index], 
                                              groupValue: radiobutton,
                                              controlAffinity: ListTileControlAffinity.trailing, 
                                              onChanged: (value){
                                                setState(() {
                                                    radiobutton = value;
                                                });
                                              },
                                            );
                                  },
                                ),
                          );
                          
                        }
                      ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'CANCEL');
                                // to reset radio btn list
                                radioBtnFilterdData.clear();
                                radioBtnFilterdData.addAll(radioBtnItems);
                              } ,
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                                textEditingController.text = radiobutton.toString();
                                // to reset radio btn list
                                radioBtnFilterdData.clear();
                                radioBtnFilterdData.addAll(radioBtnItems);
                              } ,
                              child: const Text('OK'),
                            ),
                        ],)

                  ],
                ),
                
              ),
            ),
          );
        });
      }
    );
  }

  void filterSearchResults(String query) {
    List<String> tempList = <String>[];
    tempList.addAll(radioBtnItems);
    if(query.isNotEmpty) {
      List<String> listData = <String>[];
      for (var item in tempList) {
        if(item.toLowerCase().contains(query.toLowerCase())) {
          listData.add(item);
        }
      }
      setState(() {
        radioBtnFilterdData.clear();
        radioBtnFilterdData.addAll(listData);
      });
      return;
    } else {
      setState(() {
        radioBtnFilterdData.clear();
        radioBtnFilterdData.addAll(radioBtnItems);
      });
    }
  }


}
