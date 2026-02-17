import '../../widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class StoryBookScreen extends StatelessWidget {
  const StoryBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlaButton(text: "TEST", onPressed: () {}),
          SizedBox(height: 20),
          BlaButton(
            text: "TEST",
            icon: Icons.access_time_filled_outlined,
            onPressed: () {},
          ),
          SizedBox(height: 20),
          BlaButton(
            text: "TEST SECONDARY",
            type: ButtonType.secondary,
            onPressed: () {},
          ),
          SizedBox(height: 20),
          BlaButton(
            text: "TEST ICONS",
            icon: Icons.abc_sharp,
            type: ButtonType.secondary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
