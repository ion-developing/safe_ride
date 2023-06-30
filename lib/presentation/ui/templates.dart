import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Templates {
  static const String fontName = 'Poppins';
  // regular = 400 || medium = 500 || bold = 700

  static const Color primaryTurquoiseColor = Color(0xff21c2af);
  static const Color greyColor = Color(0xFFd9d9d9);
  static const Color darkGreyColor = Color(0xFFadadad);
  static const Color lightGreyColor = Color(0xFFededed);
  static const Color primaryBlackColor = Color(0xff111111);
  static const Color secondaryBlackColor = Color(0xff1d1d1b);
  static const Color whiteColor = Color(0xffffffff);
  static const Color greenColor = Color(0xff21c25f);
  static const Color redColor = Color(0xffc22121);
  static const Color yellowColor = Color(0xfff2f3b6);

  static const EdgeInsets paddingTop = EdgeInsets.only(top: 20);
  static const EdgeInsets paddingBottom = EdgeInsets.only(bottom: 20);
  static const EdgeInsets paddingApp = EdgeInsets.all(24);
  static const EdgeInsets paddingHorizontal =
      EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingCard = EdgeInsets.all(16);

  static const SizedBox spaceBoxH = SizedBox(height: 20);
  static const SizedBox spaceBoxW = SizedBox(width: 20);
  static SizedBox spaceBoxNW(double n) => SizedBox(width: n);
  static SizedBox spaceBoxNH(double n) => SizedBox(height: n);

  static const TextStyle head = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 64,
    letterSpacing: 0.8,
    color: primaryTurquoiseColor,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.18,
    color: primaryTurquoiseColor,
  );
  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: -0.04,
    color: primaryBlackColor,
  );
  static const TextStyle goodLabel = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.04,
    color: greenColor,
  );
  static const TextStyle minLabel = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.04,
    color: yellowColor,
  );
  static const TextStyle badLabel = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: -0.04,
    color: redColor,
  );
  static const TextStyle body = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.1,
    color: greyColor,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    letterSpacing: 1.25,
    color: secondaryBlackColor,
  );

  static const TextStyle button2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 1.25,
    color: whiteColor,
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 1.25,
    color: darkGreyColor,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkGreyColor,
  );
  static const TextStyle noCaption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: greyColor,
  );

  static const OutlineInputBorder basicIB = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: greyColor));
  static const OutlineInputBorder focusedIB = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: secondaryBlackColor));

  static InputDecoration inputDecoration(text, IconData icon) =>
      InputDecoration(
        fillColor: lightGreyColor,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: basicIB,
        focusedBorder: focusedIB,
        border: basicIB,
        hintText: text,
        hintStyle: hintTextStyle,
        prefixIcon: Icon(icon, color: darkGreyColor),
      );

  static InputDecoration locationInputDecoration(text, IconData icon) =>
      InputDecoration(
        // fillColor: lightGreyColor,
        // filled: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintText: text,
        hintStyle: const TextStyle(
          fontFamily: fontName,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 1.25,
          color: greyColor,
        ),
        prefixIcon: Icon(icon, color: darkGreyColor),
      );

  static TextField textField(TextEditingController controller, String text,
          IconData icon, keyboardType, onTap, obscure) =>
      TextField(
        controller: controller,
        obscureText: obscure,
        style: body,
        keyboardType: keyboardType,
        decoration: inputDecoration(text, icon),
        readOnly: keyboardType == TextInputType.datetime ? true : false,
        onTap: onTap,
      );

  static TextField locationFiled(TextEditingController controller, String text,
          IconData icon, keyboardType,onTap) =>
      TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: fontName,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 1.25,
          color: darkGreyColor,
        ),
        readOnly: true,
        keyboardType: keyboardType,
        decoration: locationInputDecoration(text, icon),
        onTap: onTap,
      );

  static SizedBox elevatedButton(text, onPressed) => SizedBox(
    height: 50,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryTurquoiseColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(uppercase(text), style: button),
    ),
  );

  static ElevatedButton selectButton(text, onPressed) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: greenColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: onPressed,
    child: Text(text, style: button2),
  );

  static Row captionRowForPage(text, pageName, context, StatefulWidget page) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text, style: noCaption),
      TextButton(
        child: Text(pageName, style: caption),
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => page));
        },
      ),
    ],
  );

  static Container routeTag( lable, IconData icon)=> Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: lightGreyColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icon, color: darkGreyColor),
        spaceBoxNW(10),
        Text(lable, style: noCaption),
      ],
    ),
  );

  static String uppercase(String text) {
    return text.toUpperCase();
  }
}
