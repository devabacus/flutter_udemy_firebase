import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy_firebase/common_widgets/custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            height: 44,
            color: Colors.indigo,
            borderRadius: 4,
            onPressed: onPressed);
}
