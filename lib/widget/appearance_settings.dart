import 'package:flutter/material.dart';

import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:pangolin_notes/service/settings_service_impl.dart';

class AppearanceSettings extends StatefulWidget {
  const AppearanceSettings({super.key});

  @override
  State<AppearanceSettings> createState() => _AppearanceSettingsState();
}

class _AppearanceSettingsState extends State<AppearanceSettings> {
  WindowEffect _selected = WindowEffect.acrylic;
  final List<WindowEffect> _background = [
    WindowEffect.acrylic,
    WindowEffect.aero,
    WindowEffect.mica,
    WindowEffect.solid,
    WindowEffect.transparent
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        return SizedBox(
          width: p1.maxWidth,
          height: p1.maxHeight,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Backgroud',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 0,
                    dropdownColor: Colors.grey.shade800,
                    value: _selected,
                    items: _background.map<DropdownMenuItem<WindowEffect>>(
                        (WindowEffect value) {
                      return DropdownMenuItem<WindowEffect>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value.name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (WindowEffect? value) {
                      setState(() {
                        _selected = value!;
                        Window.setEffect(
                          effect: value,
                        );
                        SharedPrefSettingsService().setWindowEffect(value);
                      });
                    },
                  ),
                  const Spacer(),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
