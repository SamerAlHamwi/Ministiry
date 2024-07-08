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
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button!.copyWith(
              color: textColor ?? Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
