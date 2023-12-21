import 'package:frontend/models/ModelProvider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<List<Budgeting?>> queryListItems() async {
  try {
    final request = ModelQueries.list(Budgeting.classType);
    final response = await Amplify.API.query(request: request).response;

    final budgetingItems = response.data?.items;

    if (budgetingItems == null) {
      safePrint('errors: ${response.errors}');
      return const [];
    }

    //Printing the data, can comment it out
    for (var item in budgetingItems) {
      safePrint('Fetched item: $item');
    }

    return budgetingItems;
  } on ApiException catch (e) {
    safePrint('Query failed: $e');
    return const [];
  }
}
