import 'package:flutter/material.dart';
import 'package:frontend/utils/customColors/custom_colors.dart';

class ButtonRow extends StatelessWidget {
  final List<String> buttonTitles;
  final String selectedButton;
  final void Function(String) onButtonPressed;

  ButtonRow({
    required this.buttonTitles,
    required this.selectedButton,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonTitles.map((title) {
        final bool isSelected = title == selectedButton;

        final double maxFontSize = MediaQuery.of(context).size.width * 0.035;
        final double fontSize = isSelected
            ? MediaQuery.of(context).size.width * 0.035
            : MediaQuery.of(context).size.width * 0.034;

        return isSelected
            ? ElevatedButton(
                onPressed: () => onButtonPressed(title),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.green,
                  //padding: const EdgeInsets.all(10.0),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.05),
                    //borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize.clamp(fontSize, maxFontSize),
                  ),
                ),
              )
            : TextButton(
                onPressed: () => onButtonPressed(title),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: Text(title,
                    style: TextStyle(
                      fontSize: fontSize.clamp(fontSize, maxFontSize),
                    )),
              );
      }).toList(),
    );
  }
}
