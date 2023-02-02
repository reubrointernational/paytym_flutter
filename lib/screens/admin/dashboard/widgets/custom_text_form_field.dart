import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  final String? hintText;
  final String iconImg;
  const CustomSearchTextField(
      {super.key, this.hintText, required this.iconImg});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: Image.asset(
            iconImg,
            height: 20,
            width: 20,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(50),
                right: Radius.circular(50),
              ),
              borderSide: BorderSide(
                  width: 1.2, color: Color.fromRGBO(182, 182, 182, 1))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(50),
                right: Radius.circular(50),
              ),
              borderSide: BorderSide(
                  width: 1.2, color: Color.fromRGBO(182, 182, 182, 1))),
        ),
      ),
    );
  }
}
