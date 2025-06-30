import 'package:flutter/material.dart';

final _partialData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
);
//witchcraft taken from Theme.of, necessary to make sure the text themes are correct
final themeData = ThemeData.localize(
  _partialData,
  _partialData.typography.geometryThemeFor(ScriptCategory.englishLike),
);
final bodySmall = themeData.textTheme.bodySmall!.copyWith(
  color: themeData.colorScheme.onSecondaryContainer,
);
final bodySmallBold = bodySmall.copyWith(fontWeight: FontWeight.bold);
final bodyMedium = themeData.textTheme.bodyMedium!.copyWith(
  color: themeData.colorScheme.onSecondaryContainer,
);
final titleMedium = themeData.textTheme.titleMedium!.copyWith(
  color: themeData.colorScheme.onSecondaryContainer,
);
