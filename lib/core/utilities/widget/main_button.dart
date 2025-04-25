import 'package:flutter/material.dart';
import 'package:my_web_app/core/utilities/app_color.dart';

class MainButton extends StatefulWidget {
  final void Function()? onPressed;
  final Widget child;
  final bool expanded;
  final double radius;
  final Color? color;
  final Color? borderColor;
  final double? elevation;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Duration animationDuration;

  const MainButton({
    super.key,
    required this.child,
    this.onPressed,
    this.expanded = true,
    this.radius = 10,
    this.color = AppColors.main,
    this.borderColor,
    this.elevation,
    this.verticalPadding = 16,
    this.horizontalPadding,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) {
          if (widget.onPressed != null) {
            setState(() => isPressed = true);
          }
        },
        onTapUp: (_) {
          if (widget.onPressed != null) {
            setState(() => isPressed = false);
            widget.onPressed!();
          }
        },
        onTapCancel: () {
          if (widget.onPressed != null) {
            setState(() => isPressed = false);
          }
        },
        child: AnimatedContainer(
          duration: widget.animationDuration,
          width: widget.expanded ? double.infinity : null,
          transform: Matrix4.identity()..scale(isPressed ? 0.95 : isHovered ? 1.05 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            border: widget.borderColor != null
                ? Border.all(color: widget.borderColor!)
                : null,
            color: isHovered
                ? widget.color?.withOpacity(0.8) ?? AppColors.main.withOpacity(0.8)
                : widget.color ?? AppColors.main,
            boxShadow: [
              if (widget.elevation != null)
                BoxShadow(
                  color: Colors.black.withOpacity(isHovered ? 0.3 : isPressed ? 0.1 : 0.2),
                  blurRadius: isHovered ? 12 : isPressed ? 4 : 8,
                  offset: Offset(0, isHovered ? 6 : isPressed ? 2 : 4),
                ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding ?? 0,
              horizontal: widget.horizontalPadding ?? 0,
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}