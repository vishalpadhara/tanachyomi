import 'package:flutter/material.dart';

class CaptionText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  CaptionText({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: true,
      textAlign: align,
      style: style(context).copyWith(fontSize: 10),
      maxLines: maxLine,
    );
  }

  TextStyle style(BuildContext context) {
    if (color != null) {
      return Theme.of(context).textTheme.caption!.copyWith(color: color);
    } else {
      return Theme.of(context).textTheme.caption!.copyWith(color: Colors.black);
    }
  }
}

class SmallText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  SmallText({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: true,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 12.0, color: color ?? Colors.black),
      maxLines: maxLine,
    );
  }
}

class Body1Text extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  Body1Text({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: true,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, color: color),
      maxLines: maxLine,
    );
  }

  TextStyle style(BuildContext context) {
    if (color != null) {
      return Theme.of(context).textTheme.bodyText1!.copyWith(color: color);
    } else {
      return Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: Colors.black);
    }
  }
}

class Body2Text extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  Body2Text({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: true,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w500),
      maxLines: maxLine,
    );
  }

  TextStyle style(BuildContext context) {
    if (color != null) {
      return Theme.of(context).textTheme.bodyText2!.copyWith(color: color);
    } else {
      return Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: Colors.black);
    }
  }
}

class SubTitleText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  SubTitleText({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: true,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: style(context).copyWith(fontSize: 16),
      maxLines: maxLine,
    );
  }

  TextStyle style(BuildContext context) {
    if (color != null) {
      return Theme.of(context).textTheme.subtitle2!.copyWith(color: color);
    } else {
      return Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(color: Colors.black);
    }
  }
}

class TitleText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  TitleText({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: false,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 18.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          color: color),
      maxLines: maxLine,
    );
  }

  TextStyle style(BuildContext context) {
    if (color != null) {
      return Theme.of(context).textTheme.headline6!.copyWith(color: color);
    } else {
      return Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Colors.black);
    }
  }
}

class SubHeadText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  SubHeadText({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      style: TextStyle(fontSize: 20.0, color: color),
      maxLines: maxLine,
    );
  }
}

class HeadlineText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  HeadlineText({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: true,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: style(context).copyWith(fontSize: 22),
      maxLines: maxLine,
    );
  }

  TextStyle style(BuildContext context) {
    if (color != null) {
      return Theme.of(context).textTheme.headline5!.copyWith(color: color);
    } else {
      return Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(color: Colors.black);
    }
  }
}

class Display1Text extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final int? maxLine;

  Display1Text({Key? key, required this.text, this.color, this.align, this.maxLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text??"",
      softWrap: true,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style:
          style(context)!.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
      maxLines: maxLine,
    );
  }

  TextStyle? style(BuildContext context) {
    if (color != null) {
      return Theme.of(context).textTheme.headline4!.copyWith(color: color,);
    } else {
      return Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color: Colors.black);
    }
  }
}
