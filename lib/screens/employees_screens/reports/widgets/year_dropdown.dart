import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paytym/core/constants/icons.dart';

class CustomDropdownYearButton extends StatelessWidget {
  final String? value;
  final String? hint;
  final void Function(String?)? onChanged;
  final List<String> lists;
  const CustomDropdownYearButton(
      {super.key, this.value, this.onChanged, required this.lists, this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
          right: Radius.circular(50),
        ),
        /*border: Border.all(
              width: 1.2, color: const Color.fromRGBO(182, 182, 182, 1))*/
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          onChanged: onChanged,
          hint: Text(hint!),
          isExpanded: true,
          icon: SvgPicture.asset(
            IconPath.dropdownYearIconSvg,
            height: 20,
            width: 20,
          ),
          items: lists.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
        ),
      ),
    );
  }
}
