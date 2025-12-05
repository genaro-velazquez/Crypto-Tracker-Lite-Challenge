
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget{
  final String text;
  final TextStyle style;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;

  const CustomText(
    this.text, {
      super.key,
      required this.style,
      this.maxLines,
      this.overflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.start,
    }
  );


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
  
}