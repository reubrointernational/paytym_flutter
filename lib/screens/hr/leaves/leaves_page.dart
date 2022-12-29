import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/hr/leaves/leaves_tabs.dart';

import 'leaves_tab_container.dart';

class LeavesPage extends StatefulWidget {
  const LeavesPage({super.key});

  @override
  State<LeavesPage> createState() => _LeavesPageState();
}

class _LeavesPageState extends State<LeavesPage> with TickerProviderStateMixin {
  late TabController controller = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: CustomColors.blueCardColor,
        child: Image.asset(
          'assets/png/filter_icon.png',
          height: 25,
          width: 25,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leaves',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TabBar(
              controller: controller,
              labelColor: Colors.black,
              padding: EdgeInsets.zero,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.transparent,
              labelPadding: const EdgeInsets.symmetric(horizontal: 2),
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                LeavesTabContainer(text: 'Today'),
                LeavesTabContainer(text: 'Yesterday'),
                LeavesTabContainer(text: 'Pending'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(controller: controller, children: const [
               LeavesTabDetails(),
                LeavesTabDetails(),
                LeavesTabDetails(),
              ]),
            ),
          ],
        ),
      )),
    );
  }

}
