import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAuthButtons extends StatelessWidget {
  final String imagePath;
  const SocialAuthButtons({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 65,
        height: 65,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue[100],
          boxShadow: [
            BoxShadow(
              color: const Color(0xffC4CBD6).withOpacity(0.1),
            )
          ],
        ),
        child: SvgPicture.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
