import 'package:flutter/material.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? selectable;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.selectable,
  });

  @override
  Widget build(BuildContext context) {
    return selectable ?? false
        ? SelectableText(
          text,
          style: style?.copyWith(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontFamily: kFontFamily,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
        )
        : Text(
          text,
          style: style?.copyWith(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontFamily: kFontFamily,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
  }
}

class H1 extends AppText {
  const H1(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.headlineLarge,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class H2 extends AppText {
  const H2(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.headlineMedium,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class H3 extends AppText {
  const H3(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.headlineSmall,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class BodyLargeText extends AppText {
  const BodyLargeText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(text, style: context.textTheme.bodyLarge);
  }
}

class BodyMediumText extends AppText {
  const BodyMediumText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.selectable,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.bodyMedium,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      selectable: selectable,
    );
  }
}

class BodySmallText extends AppText {
  const BodySmallText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.bodySmall,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

//title large
class TitleLargeText extends AppText {
  const TitleLargeText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.titleLarge,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class TitleMediumText extends AppText {
  const TitleMediumText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.titleMedium,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class TitleSmallText extends AppText {
  const TitleSmallText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.titleSmall,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

//label large
class LabelLargeText extends AppText {
  const LabelLargeText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.labelLarge,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

//label medium
class LabelMediumText extends AppText {
  const LabelMediumText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.labelMedium,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

//label small
class LabelSmallText extends AppText {
  const LabelSmallText(
    super.text, {
    super.key,
    super.color,
    super.fontWeight,
    super.fontSize,
    super.textAlign,
    super.maxLines,
    super.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      style: context.textTheme.labelSmall,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
