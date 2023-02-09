import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';

class CustomDropdownYearButton extends StatelessWidget {
  final String? value;
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
      this.isIconPresent = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          alignment: AlignmentDirectional.center,
          value: value,
          onChanged: onChanged,
          hint: Text(hint!),
          icon: isIconPresent
              ? const CircleAvatar(
                  radius: 10,
                  backgroundColor: CustomColors.blueCardColor,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                  ))
              : const SizedBox(),
          items: lists.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}
