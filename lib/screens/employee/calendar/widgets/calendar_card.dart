import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/screens/employee/calendar/widgets/custom_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../core/dialog_helper.dart';
import '../../../login/widgets/custom_text_form_field.dart';
// import '../../leaves/widgets/time_picker.dart';
import '../../../widgets/bordered_text_form_field.dart';
import '../../leaves/leaves_controller.dart';
import '../calendar_controller.dart';
import 'upload_text_buttons.dart';

class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.whiteCardColor,
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: CustomColors.whiteTextColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Obx(() {
              DateTime selectedDay =
                  Get.find<CalendarController>().selectedDay.value;
              return TableCalendar(
                eventLoader: (day) {
                  return Get.find<CalendarController>().getEventsForDay(day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  Get.find<CalendarController>().selectedDay.value =
                      selectedDay;
                },
                onDayLongPressed: (selectedDay, focusedDay) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Add to Calendar',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                kSizedBoxH10,
                                const CustomTextFormField(hintText: 'Name'),
                                kSizedBoxH6,
                                const CustomTextFormField(
                                    hintText: 'Profession'),
                                kSizedBoxH6,
                                const CustomTextFormField(hintText: 'Location'),
                                kSizedBoxH6,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (() async {
                                        TimeOfDay? selectedTime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now());
                                        print(selectedTime.toString());
                                      }),
                                      child: SizedBox(
                                        width: w * 0.45,
                                        child: BorderedTextFormField(
                                          enabled: false,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9-]'),
                                            ),
                                          ],
                                          // onSaved: (value) => Get.find<LeavesController>()
                                          //     .leaveRequestModel
                                          //     .startDate = value,
                                          controller:
                                              Get.find<LeavesController>()
                                                  .startDateController,
                                          hintText: kStartTimeString,
                                          keyboardType: TextInputType.datetime,
                                          suffixIcon: const Icon(
                                            Icons.access_time,
                                            size: 18,
                                          ),
                                          // validator: (value) =>
                                          //     Get.find<LeavesController>()
                                          //         .dateValidator(value!),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (() async {
                                        TimeOfDay? selectedTime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now());
                                        print(selectedTime.toString());
                                      }),
                                      child: SizedBox(
                                        width: w * 0.45,
                                        child: BorderedTextFormField(
                                          enabled: false,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9-]'),
                                            ),
                                          ],
                                          // onSaved: (value) => Get.find<LeavesController>()
                                          //     .leaveRequestModel
                                          //     .startDate = value,
                                          controller:
                                              Get.find<LeavesController>()
                                                  .startDateController,
                                          hintText: kEndTimeString,
                                          keyboardType: TextInputType.datetime,
                                          suffixIcon: const Icon(
                                            Icons.access_time,
                                            size: 18,
                                          ),
                                          // validator: (value) =>
                                          //     Get.find<LeavesController>()
                                          //         .dateValidator(value!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                kSizedBoxH10,
                                DottedBorder(
                                    color: CustomColors.greyTextColor,
                                    child: SizedBox(
                                      height: h * 0.08,
                                      width: w,
                                      child: Center(
                                          child: GestureDetector(
                                        onTap: () {
                                          DialogHelper.showUploadImageDialog(
                                            content: Column(
                                              children: [
                                                UploadTextButton(
                                                  text: 'Gallery',
                                                  backgroundColor: CustomColors
                                                      .blueTextColor,
                                                  onPressed: () {
                                                    Get.find<
                                                            CalendarController>()
                                                        .uploadProfileImageFromGallery();
                                                  },
                                                ),
                                                kSizedBoxH10,
                                                UploadTextButton(
                                                  text: 'Camera',
                                                  backgroundColor: CustomColors
                                                      .blueTextColor,
                                                  onPressed: () {
                                                    Get.find<
                                                            CalendarController>()
                                                        .uploadProfileImageFromCamera();
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Upload Profile Image',
                                          style: TextStyle(
                                            color: CustomColors.greyTextColor,
                                          ),
                                        ),
                                      )),
                                    )),
                                kSizedBoxH10,
                                Obx(() {
                                  return Container(
                                    height: h * 0.2,
                                    width: w,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade400),
                                    ),
                                    child: Get.find<CalendarController>()
                                            .picker
                                            .value
                                            .isNotEmpty
                                        ? Image.file(
                                            File(Get.find<CalendarController>()
                                                .picker
                                                .value),
                                            fit: BoxFit.contain,
                                          )
                                        : const Center(
                                            child: Icon(
                                            Icons.photo_outlined,
                                            size: 60,
                                            color: Colors.grey,
                                          )),
                                  );
                                }),
                                kSizedBoxH15,
                                SizedBox(
                                  height: h * 0.06,
                                  width: w,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              CustomColors.blueTextColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: CustomColors.whiteCardColor,
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                rowHeight: 65,
                daysOfWeekHeight: 20,
                firstDay: DateTime.utc(2022, 12, 12),
                lastDay: DateTime.utc(2040, 3, 14),
                focusedDay: Get.find<CalendarController>().selectedDay.value,
                calendarFormat: CalendarFormat.week,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: kCalendarCard,
                  weekendStyle: kCalendarCard,
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  rightChevronIcon: const CustomSVG(
                    IconPath.forwardArrowSvg,
                    size: 25,
                  ),
                  leftChevronIcon: const CustomSVG(
                    IconPath.backArrowSvg,
                    size: 25,
                  ),
                  titleTextStyle: const TextStyle(
                    color: CustomColors.blackTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  titleTextFormatter: (date, locale) =>
                      DateFormat('MMMM, yyyy').format(date),
                  decoration: const BoxDecoration(
                    color: CustomColors.whiteTabColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
                calendarStyle: CalendarStyle(
                  weekendTextStyle: kCalendarCard,
                  defaultTextStyle: kCalendarCard,
                  markerDecoration: const BoxDecoration(
                      color: Colors.amber, shape: BoxShape.circle),
                  selectedDecoration: const BoxDecoration(
                    color: CustomColors.blueCardColor,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color:
                        const Color.fromRGBO(72, 13, 250, 1).withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
