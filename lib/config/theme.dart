import 'package:flutter/material.dart';

Color _secondaryColor = Color(0xFF556b2e);
Color _highlightColor = Colors.white;
Color _primaryColor = Color(0xFFeec584);
Color _accentColor = Color(0xFF764248);
/// The color of the text, used in TextTheme
Color _textColor = Colors.black;
Color _splashColor = Colors.black.withOpacity(0.65);

double? textScaleFactor;

ThemeData theme(BuildContext context){ 
  textScaleFactor = MediaQuery.textScaleFactorOf(context);
  return ThemeData(
    accentColor: _accentColor,
    primaryColor: _primaryColor,
    highlightColor: _highlightColor,
    canvasColor: Colors.white.withOpacity(0.90),
    fontFamily: 'Raleway',
    iconTheme: _iconTheme,
    inputDecorationTheme: _inputDecorationTheme,
    textTheme: _textTheme,
    textSelectionTheme: _textSelectionTheme,
    textButtonTheme: _textButtonTheme,
    elevatedButtonTheme: _elevatedButtonThemeData,
    buttonTheme: _buttonTheme,
    appBarTheme: _appBarTheme,
    snackBarTheme: _snackBarTheme,
    bottomNavigationBarTheme: _bottomNavigationBarTheme
  );
}
TextTheme _textTheme = TextTheme(
  /// Subtitle1 refers to the input style in a text field
  subtitle1: TextStyle(
    color: _highlightColor
  ),
  /// Should be for text within AppBar?
  headline6: TextStyle(
    color: _highlightColor
  ),
  /// Small text in TextButton
  headline5: TextStyle(
    color: _highlightColor,
    fontSize: 20,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold
  ),
  /// Large text within body
  headline4: TextStyle(
    color: _textColor,
    fontSize: 30,
    fontWeight: FontWeight.bold
  ),
  /// Large text in TextButton
  headline3: TextStyle(
    color: _highlightColor,
    fontSize: 40,
    fontWeight: FontWeight.bold
  ),
);

ButtonThemeData _buttonTheme = ButtonThemeData(
  splashColor: Colors.white70,
  // colorScheme: ColorScheme(
  //   error: Colors.red.withOpacity(0.3),
  //   background: _primaryColor,
  //   primaryVariant: _primaryColor,
  //   secondaryVariant: _primaryColor,
  //   onBackground: _primaryColor,
  //   onError: _primaryColor,
  //   onPrimary: _primaryColor,
  //   onSecondary: _primaryColor,
  //   onSurface: _primaryColor,
  //   brightness: Brightness.light,
  //   surface: _primaryColor,
  //   primary: _primaryColor,
  //   secondary: _secondaryColor

  // )
);

ElevatedButtonThemeData _elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(
      _highlightColor
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      _primaryColor
    ),
    
    padding: MaterialStateProperty.all<EdgeInsets>(
      EdgeInsets.symmetric(vertical: 15, horizontal: 30)
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
      TextStyle(
        fontSize: 20*(1/textScaleFactor!),
      )
    ),
    /// Doesn't depend on whether it is focused or not
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      )
    ),
  )
);

TextButtonThemeData _textButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(
      _highlightColor
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      _primaryColor
    ),
    overlayColor: MaterialStateProperty.all<Color>(
      _splashColor
    ),
    padding: MaterialStateProperty.all<EdgeInsets>(
      EdgeInsets.symmetric(vertical: 15, horizontal: 30)
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
      TextStyle(
        fontSize: 15*(1/textScaleFactor!),
        fontFamily: 'Raleway'
      )
    ),
    /// Doesn't depend on whether it is focused or not
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      )
    ),
  )
);

IconThemeData _iconTheme = IconThemeData(
  color: Colors.black
);

TextSelectionThemeData _textSelectionTheme = TextSelectionThemeData(
  cursorColor: _secondaryColor,
  selectionHandleColor: _secondaryColor,
  selectionColor: _secondaryColor
);

InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
  focusColor: _secondaryColor,
  fillColor: _accentColor,
  filled: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
  suffixStyle: TextStyle(color: _highlightColor,),
  labelStyle: TextStyle(
    color: _highlightColor
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.transparent)
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.transparent)
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.transparent),
  ),
);

BottomNavigationBarThemeData _bottomNavigationBarTheme = BottomNavigationBarThemeData(
  elevation: 0,
  selectedItemColor: _primaryColor,
  backgroundColor: Colors.grey[200],
  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
  unselectedLabelStyle: TextStyle(color: Colors.black.withOpacity(0.65))
  // unselectedItemColor: Colors.black.withOpacity(0.65),
);

AppBarTheme _appBarTheme = AppBarTheme(
  elevation: 0,
  backgroundColor: _primaryColor,
  titleTextStyle: TextStyle(
    color: _highlightColor,
    fontSize: 20,
    fontFamily: 'Raleway'
  )
);

SnackBarThemeData _snackBarTheme = SnackBarThemeData(
  backgroundColor: _primaryColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
  ),
  behavior: SnackBarBehavior.floating,
  contentTextStyle: TextStyle(
    fontFamily: "Raleway"
  )
);