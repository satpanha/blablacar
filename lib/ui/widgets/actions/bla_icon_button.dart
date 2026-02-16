import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;
  final bool enabled;

  const BlaIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = BlaSize.icon,
    this.color,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = enabled
        ? (color ?? BlaColors.primary)
        : BlaColors.disabled;

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: Icon(icon, size: size, color: iconColor),
      ),
    );
  }
}
