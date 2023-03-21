// enum TeplateTypeString {
//   textBoxString,
//   textBoxRichText,
//   dropDownList,
//   textBoxDecimal,
//   dateTimePicker,
//   dropdownList,
//   groupHeader
// }

class FormControl {
  final int? objectDefinitionId;
  final String? name;
  final String? textValue;
  final String? displayName;
  final int? templateType;
  final String? templateTypeString;
  // final List? selectListItem;
  final bool? isEnable;
  final String? modiFiedDate;

  FormControl({
    this.objectDefinitionId,
    this.name,
    this.textValue,
    this.displayName,
    this.templateType,
    this.templateTypeString,
    //  this.selectListItem,
    this.isEnable,
    this.modiFiedDate,
  });

  factory FormControl.fromMap(Map<String, dynamic> parseJSON) => FormControl(
        objectDefinitionId: parseJSON['ObjectDefinitionId'],
        name: parseJSON['Name'],
        textValue: parseJSON['TextValue'],
        displayName: parseJSON['DisplayName'],
        templateType: parseJSON['TemplateType'],
        templateTypeString: parseJSON['TemplateTypeString'],
        // selectListItem: parseJSON['SelectListItem'],
        isEnable: parseJSON['IsEnable'],
        modiFiedDate: parseJSON['ModifiedDate'],
      );

  Map<String, dynamic> toMap() => {
        'ObjectDefinitionId': objectDefinitionId,
        'Name': name,
        'TextValue': textValue,
        'DisplayName': displayName,
        'TemplateType': templateType,
        'TemplateTypeString': templateTypeString,
        // 'SelectListItem': selectListItem,
        'IsEnable': isEnable,
        'ModifiedDate': modiFiedDate,
      };
}
