import 'package:flutter/material.dart';
import 'package:blabla/ui/theme/theme.dart';

class SeatPickerScreen extends StatefulWidget {
  final int initialSeats;

  const SeatPickerScreen({super.key, required this.initialSeats});

  @override
  State<SeatPickerScreen> createState() => _SeatPickerScreenState();
}

class _SeatPickerScreenState extends State<SeatPickerScreen> {
  late int seats;

  @override
  void initState() {
    super.initState();
    seats = widget.initialSeats;
  }

  void increment() {
    setState(() => seats++);
  }

  void decrement() {
    if (seats > 1) {
      setState(() => seats--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlaColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BlaSpacings.l,
            vertical: BlaSpacings.m,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: BlaColors.primary),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: BlaSpacings.m),
              Text(
                "Number of seats to book",
                style: BlaTextStyles.heading.copyWith(
                  color: BlaColors.textNormal,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 40,
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: seats > 1
                          ? BlaColors.iconLight
                          : BlaColors.disabled,
                    ),
                    onPressed: seats > 1 ? decrement : null,
                  ),
                  Text(
                    seats.toString(),
                    style: BlaTextStyles.heading.copyWith(
                      fontSize: 48,
                      color: BlaColors.textNormal,
                    ),
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: BlaColors.primary,
                    ),
                    onPressed: increment,
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Material(
                  color: BlaColors.primary,
                  borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      BlaSpacings.radiusLarge,
                    ),
                    onTap: () => Navigator.pop(context, seats),
                    child: Container(
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
