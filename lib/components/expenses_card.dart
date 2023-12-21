import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:frontend/components/dropdownlist.dart';
import 'package:frontend/utils/customColors/custom_colors.dart';

class ExpensesCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String number;
  final String date;
  final Color iconBackgroundColor;

  ExpensesCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.number,
    required this.date,
    required this.iconBackgroundColor,
  });

  @override
  State<ExpensesCard> createState() => _ExpensesCardState();
}

class _ExpensesCardState extends State<ExpensesCard> {
  double containerPosition = 0.0;
  bool isSplitting = false; // sp
  bool isHidden = false; // visibility of the card

  @override
  Widget build(BuildContext context) {
    bool iconsVisible = containerPosition < -50 && !isHidden;

    // Controlling the swipping effect
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          containerPosition += details.primaryDelta!;
        });
      },
      onHorizontalDragEnd: (details) {
        if (containerPosition < -100) {
          // User swiped enough to trigger the left action
          setState(() {
            containerPosition = -100;
            isSplitting = true;
          });
        } else if (containerPosition > 0) {
          // Limit swiping to the right
          setState(() {
            containerPosition = 0.0;
          });
        } else {
          // Reset container position if not swiped enough
          setState(() {
            containerPosition = 0.0;
          });
        }
      },
      child: isHidden
          ? Container() // if isHidden, return empty container
          : Stack(
              children: [
                AnimatedContainer(
                  transform:
                      Matrix4.translationValues(containerPosition, 0.0, 0.0),
                  duration: const Duration(milliseconds: 300),
                  // Contents of the card
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.iconBackgroundColor,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(widget.icon,
                          size: 20, color: CustomColors.darkgreen),
                    ),
                    title: Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    subtitle: Text(widget.description),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.number.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(widget.date,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15)),
                      ],
                    ),
                  ),
                ),
                // Icons that appear/disappear with sliding
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: Visibility(
                    visible: iconsVisible,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.call_split_rounded),
                          onPressed: () {
                            _showSplitBottomSheet(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.flag),
                          onPressed: () {
                            showFlagBottomSheet(context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.hide_source_rounded),
                          onPressed: () {
                            setState(() {
                              isHidden = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _showSplitBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SplitExpenseWidget(
          icon: widget.icon,
          title: widget.title,
          description: widget.description,
          number: widget.number,
          date: widget.date,
          iconBackgroundColor: widget.iconBackgroundColor,
          onClose: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void showFlagBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (BuildContext context) {
          return FlagBottomSheetWidget(
            onClose: () {
              Navigator.of(context).pop();
            },
          );
        });
  }
}

class SplitExpenseWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String number;
  final String date;
  final Color iconBackgroundColor;
  final VoidCallback onClose;

  final TextEditingController _amountController = TextEditingController();

  SplitExpenseWidget({
    required this.icon,
    required this.title,
    required this.description,
    required this.number,
    required this.date,
    required this.iconBackgroundColor,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'I paid for a friend',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16.0),
              ExpensesCard(
                icon: icon,
                title: title,
                description: description,
                number: number,
                date: date,
                iconBackgroundColor: iconBackgroundColor,
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How much of the total about your own \nexpense?',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: 100.0,
                      height: 30.0,
                      child: TextField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}$'),
                          )
                        ],
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: CustomColors.green),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      onPressed: () {
                        double? enteredAmount =
                            double.tryParse(_amountController.text);
                        if (enteredAmount != null) {
                          safePrint('Entered Amount: $enteredAmount');
                        } else {
                          safePrint('Invalid Amount');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.green,
                      ),
                      child: const Text(
                        'Split',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                size: 40.0,
                color: Colors.black,
              ),
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}

class FlagBottomSheetWidget extends StatefulWidget {
  final VoidCallback onClose;

  const FlagBottomSheetWidget({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  @override
  State<FlagBottomSheetWidget> createState() => _FlagBottomSheetWidgetState();
}

class _FlagBottomSheetWidgetState extends State<FlagBottomSheetWidget> {
  String selectedCategory = 'Category';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 40.0,
                  color: Colors.black,
                ),
                onPressed: widget.onClose,
              ),
            ],
          ),
          const Text(
            'Thank you for letting us know \nand we are improving every day',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'What is the correct category?',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14.0),
          MyDropdown(
            dropdownValues: const [
              'Category',
              'Restaurant',
              'Shopping',
              'Fun',
            ],
            selectedValue: selectedCategory,
            onChanged: (newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
