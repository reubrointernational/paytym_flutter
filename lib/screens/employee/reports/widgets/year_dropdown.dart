import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';

class CustomDropdownYearButton extends StatelessWidget {
  final String? value;
  final AlignmentGeometry alignment;
  final String? hint;
  final bool isIconPresent;
  final void Function(String?)? onChanged;
  final List<String> lists;
  const CustomDropdownYearButton(
      {super.key,
      this.value,
      this.onChanged,
      required this.lists,
      this.hint,
      this.isIconPresent = true, this.alignment = AlignmentDirectional.center});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          alignment: alignment,
          value: value,
          onChanged: onChanged,
          hint: Text(hint!),
          icon: isIconPresent
              ? const Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: CircleAvatar(
                      radius: 10,
                      backgroundColor: CustomColors.blueCardColor,
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 20,
                      )),
                )
              : const SizedBox(),
          items: lists.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}
