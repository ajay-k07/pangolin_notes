import 'package:flutter/material.dart';
import 'package:pangolin_notes/model/list_tile_name.dart';
import 'package:pangolin_notes/widget/appearance_settings.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<ListTileName> _list = const [
    ListTileName(
      title: 'Background Effect',
      subtitle: 'change the appearance of the window',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (p0, p1) {
          return Row(
            children: [
              Drawer(
                elevation: 0,
                child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    final name = _list[index];
                    return ListTile(
                      title: Text(
                        name.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        name.subtitle,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    );
                  },
                ),
              ),
              const Expanded(child: AppearanceSettings()),
            ],
          );
        },
      ),
    );
  }
}
