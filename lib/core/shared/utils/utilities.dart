import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

const assetsPath = "assets/images/";

String getImageAssetPath(String image) => assetsPath + image;

Image getImageResource(String image) => Image.asset(getImageAssetPath(image));

String getDensityName(BuildContext context) {
  double ratio = MediaQuery.of(context).devicePixelRatio;

  if (Platform.isAndroid) {
    if (ratio >= 4) {
      return "xxxhdpi";
    } else if (ratio >= 3) {
      return "xxhdpi";
    } else if (ratio >= 2) {
      return "xhdpi";
    } else if (ratio >= 1.5) {
      return "hdpi";
    } else {
      return "mdpi";
    }
  } else if (Platform.isIOS) {
    if (ratio >= 3) {
      return "3x";
    } else if (ratio >= 2) {
      return "2x";
    } else {
      return "1x";
    }
  }
  return "";
}

String getUrlCDNByPlatform(BuildContext context, String url) {
  return url
      .replaceAll("path", Platform.operatingSystem)
      .replaceAll("resolution", getDensityName(context));
}

String getStringFormatBrlByDouble(double value) {
  return NumberFormat.simpleCurrency(locale: "pt_br").format(value);
}

String getDoubleValueWithComma(double value, {int decimalPlaces = 2}) {
  return value.toStringAsFixed(decimalPlaces).replaceFirst(".", ",");
}

extension StringExtension on String {
  static const diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  static const nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  String format(List<String> params) {
    String result = this;
    for (int i = 1; i < params.length + 1; i++) {
      result = result.replaceFirst('%s', params[i - 1]);
    }
    return result;
  }

  String get withoutDiacriticalMarks => this.splitMapJoin('',
      onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char)
          ? nonDiacritics[diacritics.indexOf(char)]
          : char);
}

double? convertStringCurrencyInDouble(String? value) {
  if (value != null && value.isNotEmpty) {
    return double.tryParse(
        value.replaceAll("R\$", "").replaceAll(".", "").replaceAll(",", "."));
  }
  return null;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length < 6) return Color.fromARGB(0, 0, 0, 0);
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

CurrencyInputFormatter getCurrencyInputFormatter() => CurrencyInputFormatter();

class CurrencyInputFormatter extends TextInputFormatter {
  static const _divider = 100;
  static const _locale = "pt_br";
  late TextEditingValue newValuex;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;
    double value = double.parse(newValue.text);
    final formatter = NumberFormat.simpleCurrency(locale: _locale);
    String newText = formatter.format(value / _divider);

    newValuex = oldValue;

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }

  String getNewValue() {
    return newValuex.text;
  }
}

Widget getCdnImage(
    context, String imageUrl, String imageDefault, double width, double height,
    {Color? color}) {
  var _imageDefault;
  if (imageDefault.endsWith(".svg")) {
    _imageDefault = SvgPicture.asset(
      getImageAssetPath(imageDefault),
      color: color,
    );
  } else {
    _imageDefault = Image.asset(
      getImageAssetPath(imageDefault),
      width: width,
      height: height,
    );
  }
  Widget imageCardIcon;
  if (Platform.isIOS) {
    imageCardIcon = Image.network(getUrlCDNByPlatform(context, imageUrl),
        width: width,
        height: height,
        errorBuilder: (context, url, error) => _imageDefault);
  } else {
    imageCardIcon = CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: getUrlCDNByPlatform(context, imageUrl),
      errorWidget: (context, url, error) => _imageDefault,
    );
  }

  return imageCardIcon;
}

class KeyboardUtil {
  ///  call inside a setState
  static void dismissByUnfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
