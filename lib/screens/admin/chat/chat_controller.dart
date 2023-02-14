import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


List<Model> dummy_data = [
  Model('Group1', '0004', 'branch1',
      'https://dummyimage.com//300/09f/fff.png&text=Group1'),
  Model('Group2', '0005', 'branch2',
      'https://dummyimage.com//300/09f/fff.png&text=Group2'),
  Model('Group3', '0006', 'branch3',
      'https://dummyimage.com//300/09f/fff.png&text=Group3'),
];

class Model {
  String name;
  String id;
  String branch;
  String image;
  bool isSelected = false;
  Model(this.name, this.id, this.branch, this.image);
}

class ChatControllerAdmin extends GetxController {
  final selectedDropdownDepartments = Rxn<String>();
  final selectedDropdownBranches = Rxn<String>();
  final chatGroupList = dummy_data.obs;
  

  final searchKeyword = ''.obs;
  List<String> dummyData = ['John Smith', 'Michael', 'Hohmin', 'Lappa'];

  
  updateChatSelection(index) {
    chatGroupList[index].isSelected = !chatGroupList[index].isSelected;
    chatGroupList.refresh();
  }

}
