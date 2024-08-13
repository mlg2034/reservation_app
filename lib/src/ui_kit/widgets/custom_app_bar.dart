import 'package:flutter/material.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText; 
  final Widget? titleWidget;

  const CustomAppBar({
    super.key,
    this.titleText, 
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:AppColors.white,
      automaticallyImplyLeading: true,
      elevation: 0,
      centerTitle: true,
      title: titleWidget ??
          (titleText != null
              ? Text(
                  titleText!,
                  style: AppFonts.displayLarge.copyWith(
                    color: Colors.black,
                  ),
                )
              : const SizedBox.shrink()), 
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}