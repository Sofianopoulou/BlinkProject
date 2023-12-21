import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DemoABar extends AppBar implements StatefulWidget {
  @override
  DemoABar({Key? key}) : super(key: key);

  @override
  State<DemoABar> createState() => _DemoABar();
}

class _DemoABar extends State<DemoABar> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.all(5),
              child: SvgPicture.asset("assets/logo.svg"),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: ClipOval(
                    child: Image.asset("assets/facew1.jpg",
                        width: 40, height: 40, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    return appBar;
  }
}
