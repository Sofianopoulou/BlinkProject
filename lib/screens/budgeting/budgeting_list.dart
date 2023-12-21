import 'package:flutter/material.dart';
import 'package:frontend/models/ModelProvider.dart';
import 'package:frontend/utils/customColors/custom_colors.dart';

import 'dart:math';

// Fetching, filtering and displaying categories with names, icons
// and values inside a ListView

class BudgetingList extends StatelessWidget {
  final List<Budgeting> budgetingList;
  final Function(int weeklyExpenditure, int weeklyLimit) getColorForCount;
  final Function(String categoryName) getReadableCategoryName;

  const BudgetingList({
    super.key,
    required this.budgetingList,
    required this.getColorForCount,
    required this.getReadableCategoryName,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Calculating the number of rows needed to display
      // all the items in groups of 4
      itemCount: (budgetingList.length / 4).ceil(),
      itemBuilder: (context, rowIndex) {
        final int startIndex = rowIndex * 4;
        final int endIndex = startIndex + 4;

        // Filtering out unwanted categories
        // Uneccessary now bc I create the categories
        final List<Budgeting> validCategories = budgetingList
            .where((category) =>
                category.main_category != "fk" &&
                category.main_category != "maincategory")
            .toList();

        // Sublist of validCategories that contains the items for the current row
        final List<Budgeting> rowCategories = validCategories.sublist(
          startIndex,
          endIndex < validCategories.length ? endIndex : validCategories.length,
        );

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // Children property that takes a list of widgets generated
            // using the 'map' method on the 'rowCategories' list
            children: rowCategories.map((category) {
              double percentage =
                  category.weekly_expenditure! / category.weekly_limit!;
              Color color = getColorForCount(
                  (category.weekly_expenditure ?? 0).toInt(),
                  (category.weekly_limit ?? 1).toInt());
              // Displays the shopping cart icon if there is no association
              // between category name and 'IconData' object
              IconData iconData = categoryIconMap[category.main_category] ??
                  Icons.shopping_cart;
              return Padding(
                //padding: const EdgeInsets.symmetric(horizontal: 8.0), //2
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.006,
                ),
                child: Column(
                  children: [
                    // Displays the category "box"
                    SizedBox(
                      width: 65, //70
                      height: 65,
                      child: CustomPaint(
                        painter: CustomBorderPainter(
                          percentage,
                          color,
                          iconData,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              iconData,
                              size: 26, //28
                              color: CustomColors.verydarkgreen,
                            ),
                            const SizedBox(
                                height: 1), // Adjust spacing as needed
                            // Displays the count and average values of the category
                            Text(
                              '${category.weekly_expenditure}/${category.weekly_limit != null ? category.weekly_limit!.toInt() : 0}€',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CustomColors.verydarkgreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 11, //12
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8), // to add spacing
                    // Displays the readable category name
                    Text(
                      getReadableCategoryName(
                          category.main_category.toString()),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.verydarkgreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

// Associating category names with corresponding 'IconData' objects
final Map<String, IconData> categoryIconMap = {
  "travel": Icons.travel_explore,
  "payment": Icons.attach_money,
  "food_and_drink": Icons.fastfood_rounded,
  "transfer": Icons.directions_bus_filled_rounded,
  "shops": Icons.shopping_cart,
  "Restaurant": Icons.fastfood,
  "Shopping": Icons.shopping_bag_rounded
};

// Custom painter class responsible for painting the
// border with a progress arc, based on the percentage property
class CustomBorderPainter extends CustomPainter {
  final double percentage;
  final Color color;
  final IconData iconData;

  CustomBorderPainter(this.percentage, this.color, this.iconData);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey // Grey color for the border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    double progressAngle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      -pi / 2, // Start angle
      progressAngle, // Sweep angle
      false,
      paint,
    );

    Paint coloredPaint = Paint()
      ..color = color // Color for the percentage of the border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      -pi / 2, // Start angle
      progressAngle, // Sweep angle
      false,
      coloredPaint,
    );

    // Calculate the faded color
    Color fadedColor = color.withOpacity(0.07);

    Paint remainingPaint = Paint()
      ..color = fadedColor // Faded color for the remaining part of the border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -pi / 2 + progressAngle, // Start angle for the remaining part
      2 * pi - progressAngle, // Sweep angle for the remaining part
      false,
      remainingPaint,
    );
  }

  @override
  bool shouldRepaint(CustomBorderPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.color != color ||
        oldDelegate.iconData != iconData;
  }
}
