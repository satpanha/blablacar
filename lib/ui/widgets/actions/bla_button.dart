import '../../theme/theme.dart';
import 'package:flutter/material.dart';

enum BlaButtonVariant { primary, secondary }

class BlaButton extends StatelessWidget {
  final String label;
  final BlaButtonVariant variant;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool enabled;
  final double height;

  const BlaButton({
    super.key,
    required this.label,
    required this.variant,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = variant == BlaButtonVariant.primary;

    final Color primaryColor = BlaColors.primary;
    final Color disableColor = BlaColors.disabled;

    final ButtonStyle style = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: enabled
          ? (isPrimary ? primaryColor : BlaColors.white)
          : disableColor,
      foregroundColor: isPrimary ? BlaColors.white : primaryColor,
      side: isPrimary
          ? null
          : BorderSide(
              color: enabled ? primaryColor : disableColor,
              width: 1,
            ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
          bottom: Radius.circular(10),
        )),
      minimumSize: Size( double.infinity, height),
    );

    return ElevatedButton(
      style: style,
      onPressed: enabled && !isLoading ? onPressed : null,
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: BlaColors.white,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(label),
              ],
            ),
    );
  }
}
