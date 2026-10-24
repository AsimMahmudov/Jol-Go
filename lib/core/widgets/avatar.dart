import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jol_go/app/theme/app_colors.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.onTap,
    this.photo,
  });

  final String initials;
  final double size;
  final VoidCallback? onTap;
  final File? photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          image: photo == null
              ? null
              : DecorationImage(image: FileImage(photo!), fit: BoxFit.cover),
        ),
        child: photo == null
            ? Text(
                initials,
                style: TextStyle(
                  fontSize: size * 0.36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              )
            : null,
      ),
    );
  }
}
