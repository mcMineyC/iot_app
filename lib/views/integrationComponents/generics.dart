import "package:flutter/material.dart";

class GenericIntegrationComponent extends StatelessWidget {
  final String title;
  final Widget child;

  GenericIntegrationComponent({required this.title, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onPrimaryContainer,
              ),
            ),
            SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}