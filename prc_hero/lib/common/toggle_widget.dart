
import 'package:flutter/material.dart';
import 'package:prc_hero/theme.dart';

class ToggleWidget extends StatelessWidget {

  final String firstOption, secondOption;

  ToggleWidget({
    @required this.firstOption,
    this.secondOption,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: firstOption,
        builder: (context, snapshot) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomRadioButton(
                  text: firstOption,
                  isCurrentActive: isEqual(snapshot.data, firstOption)),
              CustomRadioButton(
                  text: secondOption,
                  isCurrentActive: isEqual(snapshot.data, secondOption)),
            ],
          );
        });
  }

  bool isEqual(String snapshotValue, String radioButtonText) {
    return snapshotValue == radioButtonText;
  }
}

class CustomRadioButton extends StatelessWidget {
  final String text;
  final bool isCurrentActive;
  CustomRadioButton({
    @required this.text,
    @required this.isCurrentActive,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: isCurrentActive ? 4 : 0,
      borderRadius: isCurrentActive ? BorderRadius.all(Radius.circular(20)) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(
          text.toUpperCase(),
          style: isCurrentActive ? radioSelectedTextStyle : radioUnSelectedTextStyle,
        ),
        color: isCurrentActive ? primaryColor : Colors.white,
      ),
    );
  }

}