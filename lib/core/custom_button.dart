import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String text;
  final VoidCallback onPressed;

  const CustomButton(
      {Key? key, this.color,required this.text,required this.onPressed, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          text,
          style: Theme.of(context).textTheme.button!.copyWith(
              color: textColor ?? Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
