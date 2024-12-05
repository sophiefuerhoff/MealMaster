import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

sealed class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      // Custom colors
      primary: Color(0xFF004881),
      primaryContainer: Color(0xFFD0E4FF),
      primaryLightRef: Color(0xFF004881),
      secondary: Color(0xFFAC3306),
      secondaryContainer: Color(0xFFFFDBCF),
      secondaryLightRef: Color(0xFFAC3306),
      tertiary: Color(0xFF006875),
      tertiaryContainer: Color(0xFF95F0FF),
      tertiaryLightRef: Color(0xFF006875),
      appBarColor: Color(0xFFFFDBCF),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
    ),
    surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
    blendLevel: 17,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useMaterial3Typography: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedBorderIsColored: true,
      inputDecoratorFocusedBorderWidth: 1.5,
      listTileSelectedSchemeColor: SchemeColor.primaryFixed,
      listTileIconSchemeColor: SchemeColor.primary,
      listTileTextSchemeColor: SchemeColor.primary,
      listTileTileSchemeColor: SchemeColor.transparent,
      listTileSelectedTileSchemeColor: SchemeColor.surfaceTint,
      listTileMinVerticalPadding: 12.0,
      cardRadius: 8.0,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
    ),
    tones: FlexSchemeVariant.material3Legacy.tones(Brightness.light),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );

  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      // Custom colors
      primary: Color(0xFF9FC9FF),
      primaryContainer: Color(0xFF00325B),
      primaryLightRef: Color(0xFF004881),
      secondary: Color(0xFFFFB59D),
      secondaryContainer: Color(0xFF872100),
      secondaryLightRef: Color(0xFFAC3306),
      tertiary: Color(0xFF86D2E1),
      tertiaryContainer: Color(0xFF004E59),
      tertiaryLightRef: Color(0xFF006875),
      appBarColor: Color(0xFFFFDBCF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
    ),
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    blendLevel: 19,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      scaffoldBackgroundSchemeColor: SchemeColor.surfaceContainerLow,
      useMaterial3Typography: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 8.0,
      inputDecoratorUnfocusedBorderIsColored: true,
      inputDecoratorFocusedBorderWidth: 1.5,
      listTileSelectedSchemeColor: SchemeColor.primaryFixed,
      listTileIconSchemeColor: SchemeColor.primary,
      listTileTextSchemeColor: SchemeColor.primary,
      listTileTileSchemeColor: SchemeColor.transparent,
      listTileSelectedTileSchemeColor: SchemeColor.surfaceTint,
      listTileMinVerticalPadding: 12.0,
      cardRadius: 8.0,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
    ),
    tones: FlexSchemeVariant.material3Legacy.tones(Brightness.dark),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );
}
