import '../../widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BlaButton Test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            BlaButton(
              label: "Secondary With Icon",
              variant: BlaButtonVariant.secondary,
              icon: Icons.chat_bubble_outline,
              onPressed: () => debugPrint("Secondary pressed"),
            ),
            const SizedBox(height: 20),
            BlaButton(
              label: "Primary Button",
              variant: BlaButtonVariant.primary,
              icon: Icons.calendar_month,
              onPressed: () => debugPrint("Primary pressed"),
            ),
            const SizedBox(height: 20),
            BlaButton(
              label: "Disabled",
              variant: BlaButtonVariant.primary,
              enabled: false,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            BlaButton(
              label: "Loading",
              variant: BlaButtonVariant.primary,
              isLoading: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
