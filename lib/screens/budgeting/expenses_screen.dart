import 'package:flutter/material.dart';
import 'package:frontend/models/ModelProvider.dart';
import 'package:frontend/components/bottom_navigation_bar.dart';
import 'package:frontend/components/budgeting_card.dart';
import 'package:frontend/components/appbar.dart';
import 'package:frontend/utils/theme/theme.dart';
import 'package:frontend/components/section.dart';
import 'package:frontend/components/dropdownlist.dart';
import 'package:frontend/components/buttonrow.dart';
import 'package:frontend/components/expenses_card.dart';

// Screen with SingleChildScrollView which displays all of the screen's widgets:

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Budgeting?> _budgetingItems = [];
  String _selectedDropdownValue = 'This month';
  String _selectedButton = 'Overview';

  @override
  void initState() {
    super.initState();
    _createBudgetingItems();
  }

  // Creating the budgeting Items instead of fetching them:
  void _createBudgetingItems() {
    Budgeting grocery = Budgeting(
      main_category: 'Grocery',
      weekly_expenditure: 3,
      weekly_limit: 30,
    );

    Budgeting restaurant = Budgeting(
      main_category: 'Restaurant',
      weekly_expenditure: 3,
      weekly_limit: 9,
    );

    Budgeting shopping = Budgeting(
      main_category: 'Shopping',
      weekly_expenditure: 6,
      weekly_limit: 10,
    );

    Budgeting fun = Budgeting(
      main_category: 'Fun',
      weekly_expenditure: 3,
      weekly_limit: 30,
    );

    _budgetingItems = [grocery, restaurant, shopping, fun];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blink',
      theme: BlinkThemes().blinkmainTheme(),
      home: Scaffold(
        appBar: DemoABar(),
        bottomNavigationBar: const NewBottomNavBar(),
        body: SingleChildScrollView(
          //SingleChildScrollView Added to be responsive
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: MyDropdown(
                  dropdownValues: const [
                    'This month',
                    'Last month',
                    'Last 90 days',
                    'YtD',
                    'Last 12 months'
                  ],
                  selectedValue: _selectedDropdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDropdownValue = newValue!;
                    });
                  },
                ),
              ),
              Section(
                showSideBorder: true,
                allmargin: 20,
                color: Colors.white,
                text: "Expense categories",
                widget: BudgetingCard(budgetingItems: _budgetingItems),
              ),
              ButtonRow(
                buttonTitles: const [
                  'Overview',
                  'Grocery',
                  'Restaurant',
                  'Shopping',
                  'Fun'
                ],
                selectedButton: _selectedButton,
                onButtonPressed: (title) {
                  setState(() {
                    _selectedButton = title;
                  });
                },
              ),
              ExpensesCard(
                icon: Icons.local_taxi_rounded,
                title: 'Train',
                description: 'Transportation',
                number: "-20 €",
                date: '01.03.2022',
                iconBackgroundColor: const Color.fromRGBO(252, 205, 229, 1),
              ),
              ExpensesCard(
                icon: Icons.shopping_cart,
                title: "Trader Joe's",
                description: 'Groceries',
                number: '-600 €',
                date: '28.02.2022',
                iconBackgroundColor: const Color.fromRGBO(187, 226, 122, 1),
              ),
              ExpensesCard(
                icon: Icons.local_taxi_rounded,
                title: 'Taxi',
                description: 'Transportation',
                number: '-120 €',
                date: '28.02.2022',
                iconBackgroundColor: const Color.fromRGBO(252, 205, 229, 1),
              ),
              ExpensesCard(
                icon: Icons.flight_takeoff_rounded,
                title: 'EasyJet',
                description: 'Travel',
                number: '-1,500 €',
                date: '28.02.2022',
                iconBackgroundColor: const Color.fromRGBO(141, 211, 199, 1),
              ),
              ExpensesCard(
                icon: Icons.shopping_cart,
                title: "Trader Joe's",
                description: 'Groceries',
                number: '-600 €',
                date: '28.02.2022',
                iconBackgroundColor: const Color.fromRGBO(187, 226, 122, 1),
              ),
              ExpensesCard(
                icon: Icons.local_taxi_rounded,
                title: 'Taxi',
                description: 'Transportation',
                number: '-120 €',
                date: '28.02.2022',
                iconBackgroundColor: const Color.fromRGBO(252, 205, 229, 1),
              ),
              ExpensesCard(
                icon: Icons.flight_takeoff_rounded,
                title: 'EasyJet',
                description: 'Travel',
                number: '-1,500 €',
                date: '28.02.2022',
                iconBackgroundColor: const Color.fromRGBO(141, 211, 199, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
