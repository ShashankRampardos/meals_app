import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSetScreen});
  final void Function(String) onSetScreen;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withAlpha(255),
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 18),
                  Text(
                    'Cooking Up!',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.restaurant,
                size: 26,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                'Meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                ),
              ),
              onTap: () {
                onSetScreen('meal');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 26,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                'Filters',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 24,
                ),
              ),
              onTap: () {
                onSetScreen('filters');
              },
            ),
          ],
        ),
      ),
    );
  }
}
