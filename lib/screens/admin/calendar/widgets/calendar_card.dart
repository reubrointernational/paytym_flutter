import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/extensions/camelcase.dart';
import 'package:paytym/screens/employee/calendar/widgets/custom_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../../login/widgets/custom_text_form_field.dart';
import '../../../widgets/bordered_text_form_field.dart';
import '../calendar_controller.dart';

class CalendarCardAdmin extends StatelessWidget {
  const CalendarCardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.lightBlueColor,
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      child: Column(
        children: [
          Obx(() {
            DateTime selectedDay =
                Get.find<CalendarControllerAdmin>().selectedDay.value;
            return TableCalendar(
              eventLoader: (day) {
                return Get.find<CalendarControllerAdmin>().getEventsForDay(day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                Get.find<CalendarControllerAdmin>().selectedDay.value =
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
                            child: Form(
                              key: Get.find<CalendarControllerAdmin>().formKey,
                              child: Obx(
                                () => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Add to Calendar',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1),
                                    ),
                                    kSizedBoxH20,
                                    Obx(() {
                                      return Container(
                                        height: 60,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              width: 1.2,
                                              color: CustomColors
                                                  .lightBlueCardBorderColor),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: Get.find<
                                                    CalendarControllerAdmin>()
                                                .selectedCalendarDropdown
                                                .value,
                                            onChanged: (String? value) {
                                              Get.find<
                                                      CalendarControllerAdmin>()
                                                  .selectedCalendarDropdown
                                                  .value = value!;
                                            },
                                            items: calendarTabList
                                                .map<DropdownMenuItem<String>>(
                                                    (String? value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value!.toCamelCase(),
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    }),
                                    kSizedBoxH6,
                                    CustomTextFormField(
                                      hintText: 'Subject',
                                      onSaved: (value) =>
                                          Get.find<CalendarControllerAdmin>()
                                              .createCalendarRequestModel
                                              .description = value!,
                                      inputAction: TextInputAction.next,
                                      inputType: TextInputType.emailAddress,
                                      validator: (value) =>
                                          Get.find<CalendarControllerAdmin>()
                                              .subjectValidator(
                                                  value!, 'Subject'),
                                    ),
                                    kSizedBoxH6,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: BorderedTextFormField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9-]')),
                                            ],
                                            controller: Get.find<
                                                    CalendarControllerAdmin>()
                                                .startDateController,
                                            onSaved: (value) => Get.find<
                                                    CalendarControllerAdmin>()
                                                .createCalendarRequestModel
                                                .startDate = value!,
                                            hintText: Get.find<
                                                            CalendarControllerAdmin>()
                                                        .selectedCalendarDropdown
                                                        .value !=
                                                    calendarTabList[1]
                                                ? kDateString.substring(0, 4)
                                                : kStartDateString,
                                            keyboardType:
                                                TextInputType.datetime,
                                            suffixIcon: GestureDetector(
                                              onTap: () => Get.find<
                                                      CalendarControllerAdmin>()
                                                  .selectDateTime(
                                                      context, true),
                                              child: const Icon(
                                                  Icons.calendar_month,
                                                  size: 18),
                                            ),
                                            validator: (value) => Get.find<
                                                    CalendarControllerAdmin>()
                                                .dateValidator(value!),
                                          ),
                                        ),
                                        kSizedBoxW4,
                                        Get.find<CalendarControllerAdmin>()
                                                    .selectedCalendarDropdown
                                                    .value !=
                                                calendarTabList[1]
                                            ? const SizedBox()
                                            : Expanded(
                                                child: BorderedTextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9-]')),
                                                  ],
                                                  controller: Get.find<
                                                          CalendarControllerAdmin>()
                                                      .endDateController,
                                                  onSaved: (value) => Get.find<
                                                          CalendarControllerAdmin>()
                                                      .createCalendarRequestModel
                                                      .endDate = value!,
                                                  hintText: kEndDateString,
                                                  keyboardType:
                                                      TextInputType.datetime,
                                                  suffixIcon: GestureDetector(
                                                    onTap: () => Get.find<
                                                            CalendarControllerAdmin>()
                                                        .selectDateTime(
                                                            context, true),
                                                    child: const Icon(
                                                        Icons.calendar_month,
                                                        size: 18),
                                                  ),
                                                  validator: (value) => Get.find<
                                                          CalendarControllerAdmin>()
                                                      .dateValidator(value!),
                                                ),
                                              ),
                                      ],
                                    ),
                                    kSizedBoxH6,
                                    Get.find<CalendarControllerAdmin>()
                                                .selectedCalendarDropdown
                                                .value ==
                                            calendarTabList[2]
                                        ? const SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: (() async {
                                                  TimeOfDay? selectedTime =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now());
                                                  Get.find<CalendarControllerAdmin>()
                                                          .createCalendarRequestModel
                                                          .startTime =
                                                      selectedTime.toString();
                                                }),
                                                child: SizedBox(
                                                  width: w * 0.45,
                                                  child: BorderedTextFormField(
                                                    enabled: false,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(r'[0-9-]'),
                                                      ),
                                                    ],
                                                    onSaved: (value) => Get.find<
                                                            CalendarControllerAdmin>()
                                                        .createCalendarRequestModel
                                                        .startTime = value.toString(),
                                                    hintText: kStartTimeString,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    suffixIcon: const Icon(
                                                      Icons.access_time,
                                                      size: 18,
                                                    ),
                                                    validator: (value) =>
                                                        value == null ||
                                                                value.isEmpty
                                                            ? 'Enter a valid time'
                                                            : null,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (() async {
                                                  TimeOfDay? selectedTime =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now());
                                                  Get.find<CalendarControllerAdmin>()
                                                          .createCalendarRequestModel
                                                          .startTime =
                                                      selectedTime.toString();
                                                }),
                                                child: SizedBox(
                                                  width: w * 0.45,
                                                  child: BorderedTextFormField(
                                                    enabled: false,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(r'[0-9-]'),
                                                      ),
                                                    ],
                                                    onSaved: (value) => Get.find<
                                                            CalendarControllerAdmin>()
                                                        .createCalendarRequestModel
                                                        .endTime = value.toString(),
                                                    hintText: kEndTimeString,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    suffixIcon: const Icon(
                                                      Icons.access_time,
                                                      size: 18,
                                                    ),
                                                    validator: (value) =>
                                                        value == null ||
                                                                value.isEmpty
                                                            ? 'Enter a valid time'
                                                            : null,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    kSizedBoxH6,
                                    Get.find<CalendarControllerAdmin>()
                                                .selectedCalendarDropdown
                                                .value ==
                                            calendarTabList[1]
                                        ? CustomTextFormField(
                                            hintText: 'Location',
                                            onSaved: (value) => Get.find<
                                                    CalendarControllerAdmin>()
                                                .createCalendarRequestModel
                                                .description = value!,
                                            inputAction: TextInputAction.next,
                                            inputType:
                                                TextInputType.emailAddress,
                                            validator: (value) => Get.find<
                                                    CalendarControllerAdmin>()
                                                .subjectValidator(
                                                    value!, 'Location'),
                                          )
                                        : const SizedBox(),
                                    kSizedBoxH15,
                                    SizedBox(
                                      height: h * 0.06,
                                      width: w,
                                      child: ElevatedButton(
                                          onPressed: () => Get.find<
                                                  CalendarControllerAdmin>()
                                              .createCalendarItems(),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                CustomColors.blueTextColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text(
                                            'Submit',
                                            style: TextStyle(
                                              color:
                                                  CustomColors.whiteCardColor,
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    );
                  },
                );
              },
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              rowHeight: 65,
              daysOfWeekHeight: 20,
              firstDay: DateTime.utc(2022, 12, 12),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: Get.find<CalendarControllerAdmin>().selectedDay.value,
              calendarFormat: CalendarFormat.week,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: kCalendarCard,
                weekendStyle: kCalendarCard,
              ),
              headerStyle: HeaderStyle(
                headerPadding: const EdgeInsets.only(bottom: 8),
                titleCentered: true,
                formatButtonVisible: false,
                rightChevronIcon:
                    const CustomSVG(IconPath.forwardArrowSvg, size: 25),
                leftChevronIcon:
                    const CustomSVG(IconPath.backArrowSvg, size: 25),
                titleTextStyle: const TextStyle(
                  color: CustomColors.whiteTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                titleTextFormatter: (date, locale) =>
                    DateFormat('MMMM, yyyy').format(date),
              ),
              calendarStyle: const CalendarStyle(
                weekendTextStyle: kCalendarCard,
                defaultTextStyle: kCalendarCard,
              ),
            );
          }),
        ],
      ),
    );
  }
}
