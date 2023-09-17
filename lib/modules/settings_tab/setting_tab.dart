import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/modules/settings_tab/provider/setting_provider.dart';

import '../../core/cash_helper/cash_helper.dart';

class SettingTab extends StatefulWidget {
  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var len = AppLocalizations.of(context);
    var pro = Provider.of<SettingProvider>(context);
    var theme = Theme.of(context);
    var selectedLen = pro.Lenguge == "en" ? len!.english : len!.arabic;
    var selectedTheme =
        pro.currentTheme == ThemeMode.dark ? len.dark : len!.light;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            len!.languge,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(12),
            color: theme.canvasColor,
            child: Row(
              children: [
                Text(
                  "${selectedLen}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Spacer(),
                DropdownButton(
                    dropdownColor: Colors.white,
                    style: TextStyle(color: Colors.blue),
                    elevation: 0,
                    icon: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.blue,
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text(len!.arabic),
                        value: len!.arabic,
                        onTap: () {
                          pro.ChangeLanguge("ar");
                          CashHelper.SetDate(key: "lenguge", value: true);
                        },
                      ),
                      DropdownMenuItem(
                        child: Text(len!.english),
                        value: len!.english,
                        onTap: () {
                          pro.ChangeLanguge("en");
                          CashHelper.SetDate(key: "lenguge", value: false);
                        },
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLen = value!;
                      });
                    })
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            len!.mode,
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(12),
            color: theme.canvasColor,
            child: Row(
              children: [
                Text(
                  "${selectedTheme}",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Spacer(),
                DropdownButton(
                    dropdownColor: Colors.white,
                    style: TextStyle(color: Colors.blue),
                    elevation: 0,
                    icon: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.blue,
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Text("Dark"),
                        value: "Dark",
                        onTap: () {
                          pro.ChangeTheme(ThemeMode.dark);
                          CashHelper.SetDate(key: "Theme", value: true)
                              .then((value) {
                            print("Save Data");
                          });
                        },
                      ),
                      DropdownMenuItem(
                        child: Text("Light"),
                        value: "Light",
                        onTap: () {
                          pro.ChangeTheme(ThemeMode.light);
                          CashHelper.SetDate(key: "Theme", value: false)
                              .then((value) {
                            print("Save Data");
                          });
                        },
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedTheme = value!;
                      });
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
