// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../theme/theme_handler.dart';
import '../../../../database/databaseHandler.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  const _CustomListTile(
                    title: "About Phone",
                    icon: Icons.phone_android,
                  ),
                  _CustomListTile(
                    title: "Dark Mode",
                    icon: Icons.nightlight_round,
                    trailing: Switch(
                        value: Theme.of(context).brightness == Brightness.dark,
                        onChanged: (value) {
                          // Handle dark mode toggle
                          setState(() {
                            if (value) {
                              // Switch to dark mode
                              // You can implement your dark mode logic here
                              // For example, using a ThemeData with dark colors
                              ThemeUpdater.toggleTheme(context);
                            } else {
                              // Switch to light mode
                              // You can implement your light mode logic here
                              // For example, using a ThemeData with light colors
                              ThemeUpdater.toggleTheme(context);
                            }
                          });
                        }),
                  ),
                  const _CustomListTile(
                    title: "App Version",
                    icon: Icons.cloud_download,
                  ),
                  const _CustomListTile(
                    title: "Hidden",
                    icon: Icons.security,
                  ),
                ],
              ),
              _SingleSection(
                title: "Storage",
                children: [
                  _CustomListTile(
                    title: "Save Images to Phone",
                    icon: Icons.sd_card,
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  _CustomListTile(
                    title: "Automatically Delete Old Bookmarks",
                    icon: Icons.bookmark,
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                ],
              ),
              _SingleSection(
                title: "Privacy and Security",
                children: [
                  _CustomListTile(
                    title: "Hide Location",
                    icon: Icons.location_on_outlined,
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  _CustomListTile(
                    title: "Lock Profile",
                    icon: Icons.lock,
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  _CustomListTile(
                    title: "Sound and Vibration",
                    icon: Icons.volume_up,
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  const _CustomListTile(
                    title: "Themes",
                    icon: Icons.palette,
                  ),
                  _CustomListTile(
                    title: "Log Out",
                    icon: Icons.logout,
                    ontap: () {
                      SignOutUser.proceedToSignOutUser(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final void Function()? ontap;

  const _CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.ontap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap, // Invoke the function by calling ontap
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: trailing ?? const SizedBox(),
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
