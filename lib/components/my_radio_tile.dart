import 'package:flutter/material.dart';

class CustomRadioTile extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?)? onChanged;
  final String title;
  final String imagePath;

  const CustomRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: RadioListTile(
            value: value,
            activeColor: Theme.of(context).colorScheme.inversePrimary,
            groupValue: groupValue,
            onChanged: onChanged,
            title: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            secondary: CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(
                imagePath,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
