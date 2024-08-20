import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const RoundButton
  ({
  super.key, 
  required this.title,
  required this.ontap,
  this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
  
  
  return InkWell(
    onTap: ontap,
    child: Center(
      child: Container(
      height: 45,
      width: 120,
      decoration: BoxDecoration(
      color: Colors.cyan,
      borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: loading ? const CircularProgressIndicator(
        strokeWidth: 5,
        color: Colors.white,
        ) :  Text(
        title,
        style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        ),
        ),
      ),
      ),
    ),
  );
  }
}