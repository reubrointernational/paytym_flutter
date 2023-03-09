import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/employee/chats/chat_controller.dart';

class CustomSearchTextField extends StatelessWidget {
  final String? hintText;
  final String iconImg;
  final dynamic controller;

  const CustomSearchTextField(
      {super.key, this.hintText, required this.iconImg, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: controller != null
            ? (value) => controller.searchKeyword.value = value
            : (value) {},
        initialValue:
            controller != null ? controller.searchKeyword.value : "",
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
