import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/my_responsive.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.interTextTheme(),
      useMaterial3: true,

      ///? Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorMaxLines: 2,
        labelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTextStyles.regular12(
              context,
            ).copyWith(color: AppColors.error);
          }
          return AppTextStyles.regular12(
            context,
          ).copyWith(color: AppColors.grayDark);
        }),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTextStyles.regular12(
              context,
            ).copyWith(color: AppColors.error);
          }
          return AppTextStyles.regular12(
            context,
          ).copyWith(color: AppColors.grayDark);
        }),
        filled: true,
        fillColor: AppColors.background,
        errorStyle: AppTextStyles.regular12(
          context,
        ).copyWith(color: AppColors.error),
        hintStyle: AppTextStyles.regular14(
          context,
        ).copyWith(color: AppColors.grayMedium),
        contentPadding: EdgeInsets.symmetric(
          horizontal: MyResponsive.width(value: 8, context),
          vertical: MyResponsive.height(value: 12, context),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MyResponsive.radius(value: 4, context),
          ),
          borderSide: BorderSide(color: AppColors.grayDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MyResponsive.radius(value: 4, context),
          ),
          borderSide: BorderSide(color: AppColors.grayDark),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MyResponsive.radius(value: 4, context),
          ),
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MyResponsive.radius(value: 4, context),
          ),
          borderSide: BorderSide(color: AppColors.error),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            MyResponsive.radius(value: 4, context),
          ),
          borderSide: BorderSide(color: AppColors.grayDark),
        ),
      ),

      ///?  Search Bar
      searchBarTheme: SearchBarThemeData(
        hintStyle: WidgetStatePropertyAll(
          AppTextStyles.medium14(context).copyWith(color: AppColors.textHint,fontWeight: FontWeight.bold),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.background),
        elevation: WidgetStateProperty.all(0),
        padding: WidgetStateProperty.all(
          MyResponsive.paddingSymmetric(horizontal: 16,context),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              MyResponsive.radius(value: 12, context),
            ),
            side: BorderSide(
              color: AppColors.textHint,
              width: MyResponsive.width(value: 1.5, context),
            ),
          ),
        ),
      ),

      ///?  Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          disabledForegroundColor: AppColors.background,
          minimumSize: Size(
            double.infinity,
            MyResponsive.height(value: 48, context),
          ),
          textStyle: AppTextStyles.medium16(context),
          foregroundColor: AppColors.background,
          backgroundColor: AppColors.primaryColor,
          disabledBackgroundColor: AppColors.disabledGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              MyResponsive.radius(value: 100, context),
            ),
          ),
        ),
      ),

      ///?  AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.medium20(
          context,
        ).copyWith(color: AppColors.black100),
        iconTheme: IconThemeData(color: AppColors.black100),
      ),

      ///?  Progress Indicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      ),

      ///?  Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.disabledGray,
        unselectedLabelStyle: AppTextStyles.medium12(
          context,
        ).copyWith(color: AppColors.disabledGray),
        selectedLabelStyle: AppTextStyles.medium12(context),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
