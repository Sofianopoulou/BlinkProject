import 'package:flutter/material.dart';
import 'package:frontend/models/ModelProvider.dart';
import 'package:frontend/utils/customColors/custom_colors.dart';
import 'package:frontend/screens/budgeting/budgeting_list.dart';

// Widget for gathering the categories inside a container

class BudgetingCard extends StatelessWidget {
  final List<Budgeting?> budgetingItems;

  const BudgetingCard({
    Key? key,
    required this.budgetingItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      height: 120,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: BudgetingList(
          budgetingList: budgetingItems
              .where((item) => item != null)
              .cast<Budgeting>()
              .toList(),
          getColorForCount: _getColorForCount,
          getReadableCategoryName: getReadableCategoryName,
        ),
      ),
    );
  }

  Color _getColorForCount(int weeklyExpenditure, int weeklyLimit) {
    double percentage = weeklyExpenditure / weeklyLimit;

    if (percentage >= 0.75) {
      return CustomColors.redpercentage;
    } else if (percentage >= 0.45) {
      return CustomColors.yellowpercentage;
    } else {
      return CustomColors.greenpercentage;
    }
  }

  String getReadableCategoryName(String categoryName) {
    String readableName = categoryName.replaceAll('_', ' ');
    readableName = readableName.split(' ').map((word) {
      return '${word[0].toUpperCase()}${word.substring(1)}';
    }).join(' ');
    return readableName;
  }
}
