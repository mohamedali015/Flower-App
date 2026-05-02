import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(

      // scaffoldBackgroundColor: AppColors.baseWhite,

      textTheme: GoogleFonts.interTextTheme(),

      useMaterial3: true,

      // inputDecorationTheme: InputDecorationTheme(
      //   floatingLabelBehavior: FloatingLabelBehavior.always,
      //   errorMaxLines: 2,
      //   labelStyle: WidgetStateTextStyle.resolveWith((states) {
      //     if (states.contains(WidgetState.error)) {
      //       return AppTextStyles.regular12().copyWith(color: AppColors.error);
      //     }
      //     return AppTextStyles.regular12().copyWith(color: AppColors.baseGray);
      //   }),
      //
      //   floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
      //     if (states.contains(WidgetState.error)) {
      //       return AppTextStyles.regular12().copyWith(color: AppColors.error);
      //     }
      //     return AppTextStyles.regular12().copyWith(color: AppColors.baseGray);
      //   }),
      //   filled: true,
      //
      //   fillColor: AppColors.baseWhite,
      //   errorStyle: AppTextStyles.regular12().copyWith(color: AppColors.error),
      //   hintStyle: AppTextStyles.regular14().copyWith(
      //     color: AppColors.hintTextGray,
      //   ),
      //
      //   contentPadding: EdgeInsets.symmetric(
      //     horizontal: MyResponsive.width(value: 8),
      //     vertical: MyResponsive.height(value: 12),
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
      //     borderSide: BorderSide(color: AppColors.baseGray),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
      //     borderSide: BorderSide(color: AppColors.baseGray),
      //   ),
      //   errorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
      //     borderSide: BorderSide(color: AppColors.error),
      //   ),
      //   focusedErrorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
      //     borderSide: BorderSide(color: AppColors.error),
      //   ),
      //   disabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
      //     borderSide: BorderSide(color: AppColors.baseGray),
      //   ),
      // ),
      //
      // searchBarTheme: SearchBarThemeData(
      //   hintStyle: WidgetStatePropertyAll(
      //     AppTextStyles.medium14().copyWith(color: AppColors.baseGray),
      //   ),
      //   backgroundColor: WidgetStateProperty.all(AppColors.baseWhite),
      //   elevation: WidgetStateProperty.all(0),
      //   padding: WidgetStateProperty.all(
      //     MyResponsive.paddingSymmetric(horizontal: 16, vertical: 4),
      //   ),
      //   shape: WidgetStateProperty.all(
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(MyResponsive.radius(value: 20)),
      //       side: BorderSide(
      //         color: AppColors.baseGray,
      //         width: MyResponsive.width(value: 1.2),
      //       ),
      //     ),
      //   ),
      // ),
      //
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     elevation: 0,
      //     disabledForegroundColor: AppColors.baseWhite,
      //     minimumSize: Size(double.infinity, MyResponsive.height(value: 48)),
      //     textStyle: AppTextStyles.medium16(),
      //     foregroundColor: AppColors.baseWhite,
      //     backgroundColor: AppColors.primaryColor,
      //     disabledBackgroundColor: AppColors.disabledGray,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(
      //         MyResponsive.radius(value: 100),
      //       ),
      //     ),
      //   ),
      // ),
      //
      // appBarTheme: AppBarTheme(
      //   backgroundColor: AppColors.baseWhite,
      //   elevation: 0,
      //   scrolledUnderElevation: 0,
      //   titleTextStyle: AppTextStyles.medium20().copyWith(
      //     color: AppColors.baseBlack,
      //   ),
      //   iconTheme: IconThemeData(color: AppColors.baseBlack),
      // ),
      //
      // progressIndicatorTheme: ProgressIndicatorThemeData(
      //   color: AppColors.primaryColor,
      // ),
      //
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   backgroundColor: AppColors.questionsLightBlue,
      //   selectedItemColor: AppColors.primaryColor,
      //   unselectedItemColor: AppColors.disabledGray,
      //   unselectedLabelStyle: AppTextStyles.medium12().copyWith(
      //     color: AppColors.disabledGray,
      //   ),
      //   selectedLabelStyle: AppTextStyles.medium12(),
      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   elevation: 0,
      //   type: BottomNavigationBarType.fixed,
      // ),
    );
  }
}
