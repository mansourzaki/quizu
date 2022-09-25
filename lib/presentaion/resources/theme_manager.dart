import 'package:flutter/material.dart';
import 'package:quizu/presentaion/resources/values_manager.dart';

import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: FontSize.s36)),
    // main colors

    // ripple effect color
    // cardview theme

    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      minimumSize: Size(AppWidth.w135, AppHeight.h67),
      maximumSize: Size(AppWidth.w135, AppHeight.h67),
      textStyle: TextStyle(fontSize: FontSize.s20),
      primary: Color(0xFFD9D9D9),
    )),

    // textTheme: TextTheme(
    //     displayLarge: getSemiBoldStyle(
    //         color: ColorManager.darkGrey, fontSize: FontSize.s16),
    //     headlineLarge: getSemiBoldStyle(
    //         color: ColorManager.darkGrey, fontSize: FontSize.s16),
    //     headlineMedium: getRegularStyle(
    //         color: ColorManager.darkGrey, fontSize: FontSize.s14),
    //     titleMedium:
    //         getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s16),
    //     titleSmall:
    //         getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
    //     bodyLarge: getRegularStyle(color: ColorManager.grey1),
    //     bodySmall: getRegularStyle(color: ColorManager.grey),
    //     bodyMedium: getRegularStyle(color: ColorManager.grey2, fontSize: FontSize.s12),
    //     labelSmall:
    //         getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s12)),

    // input decoration theme (text form field)
    // inputDecorationTheme: InputDecorationTheme(
    //     // content padding
    //     contentPadding: const EdgeInsets.all(AppPadding.p8),
    //     // hint style
    //     hintStyle:
    //         getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
    //     labelStyle:
    //         getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
    //     errorStyle: getRegularStyle(color: ColorManager.error),

    //     // enabled border style
    //     enabledBorder: OutlineInputBorder(
    //         borderSide:
    //             BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
    //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

    //     // focused border style
    //     focusedBorder: OutlineInputBorder(
    //         borderSide:
    //             BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
    //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

    //     // error border style
    //     errorBorder: OutlineInputBorder(
    //         borderSide:
    //             BorderSide(color: ColorManager.error, width: AppSize.s1_5),
    //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    //     // focused border style
    //     focusedErrorBorder: OutlineInputBorder(
    //         borderSide:
    //             BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
    //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
    // label style
  );
}
