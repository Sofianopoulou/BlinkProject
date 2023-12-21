import 'package:flutter/material.dart';
import 'package:frontend/utils/customColors/custom_colors.dart';

class Section extends StatelessWidget {
  final String? text;
  final Widget widget;
  final double? paddding;
  final Color? color;
  final double? allmargin;
  final bool? greenGradient;
  final bool showSideBorder;
  const Section({
    Key? key,
    this.text,
    required this.widget,
    this.paddding,
    this.allmargin,
    this.color,
    this.greenGradient,
    this.showSideBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultpadding = 5.0;
    return Container(
      margin: EdgeInsets.only(left: allmargin ?? 0, right: allmargin ?? 0),
      child: Column(
        children: [
          Card(
            surfaceTintColor: color ?? Colors.green,
            // color: color ?? Theme.of(context).,
            shape: showSideBorder
                ? RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color.fromRGBO(231, 250, 236, 1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  )
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
            child: Container(
              decoration: greenGradient == true
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF01ee90),
                          Color(0xff1fc086),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    )
                  : const BoxDecoration(),
              padding: EdgeInsets.all(paddding ?? defaultpadding),
              child: text != null
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              text ?? "",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.verydarkgreen,
                              ),
                            ),
                          ),
                          widget,
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget,
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
