import 'package:flutter/material.dart';

class DeductionPage extends StatefulWidget {
  const DeductionPage({Key? key}) : super(key: key);

  @override
  State<DeductionPage> createState() => _DeductionPageState();
}

class _DeductionPageState extends State<DeductionPage> {
  Color? primaryColor = const Color.fromRGBO(75, 103, 176, 1);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "01-09-2022",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(138, 138, 138, 1),
                ),
              ),
            ),
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: Card(
                color: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deductions",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fund deductions",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(138, 138, 138, 1),
                            ),
                          ),
                          Text(
                            "\$20.00",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(138, 138, 138, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Professional Tax",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(138, 138, 138, 1),
                            ),
                          ),
                          Text(
                            "\$10.00",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(138, 138, 138, 1),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "\$30.00",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
