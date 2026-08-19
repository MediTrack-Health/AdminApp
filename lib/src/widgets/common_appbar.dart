import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSize? bottom;
  final Size? appBarHeight;
  final bool? isCenter;
  final Color? backgroundColor;
  final Color? color;
  final Color? surfaceTintColor;
  final Function()? onTapDone;
  final String? doneImage;
  final bool isLeading;
  final Color? titleColor;
  final double? size;
  final Widget? titleWidget;
  final double? leadingWidth;
  final double? elevation;
  final Function()? onTapBack;

  const CommonAppBar({
    super.key,
    this.title = '',
    this.leading,
    this.actions,
    this.bottom,
    this.appBarHeight,
    this.backgroundColor,
    this.isCenter,
    this.color,
    this.surfaceTintColor,
    this.onTapDone,
    this.doneImage,
    this.isLeading = true,
    this.titleColor,
    this.size,
    this.leadingWidth,
    this.titleWidget,
    this.elevation,
    this.onTapBack
  }) : preferredSize = appBarHeight ?? const Size.fromHeight(65.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height, // Set the height of the AppBar
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: onTapBack ?? () => Navigator.of(context).pop(),
                child: Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
              titleWidget ??
                  Text(
                    title,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                  ),
            ],
          ),
      leadingWidth: leadingWidth ?? 75,
      elevation: elevation ?? 0,
      centerTitle: isCenter ?? true,
      actions: actions,
      bottom: bottom,
    );
  }
}
