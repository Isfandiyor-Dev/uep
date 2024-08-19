import 'package:flutter/material.dart';

class MyWarringBox extends StatelessWidget {
  const MyWarringBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8FF), // Light background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info, // Info icon
            color: Color(0xFF3F8CFF), // Icon color
            size: 30, // Icon size
          ),
          SizedBox(width: 16), // Space between icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SMS was sent to your number",
                  style: TextStyle(
                    color: Color(0xFF3F8CFF), // Text color
                    fontSize: 16,
                  ),
                ),
                Text(
                  "+1 345 673-56-67",
                  style: TextStyle(
                    color: Color(0xFF3F8CFF), // Text color
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8), // Space between lines
                Text(
                  "It will be valid for 01:25",
                  style: TextStyle(
                    color: Color(0xFF3F8CFF), // Text color
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
