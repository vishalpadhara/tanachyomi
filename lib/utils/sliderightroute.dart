// *************************************************************************
// *                                                                       *
// * nopcommerceplus - Flutter Mobile App (Android & IOS) for nopCommerce  *
// * Copyright (c) Forefront Infotech. All Rights Reserved.                *
// *                                                                       *
// *************************************************************************
// *                                                                       *
// * Email: info@nopcommerceplus.com                                       *
// * Website: http://www.nopcommerceplus.com                               *
// *                                                                       *
// *************************************************************************
// *                                                                       *
// * This  software is furnished  under a license  and  may  be  used  and *
// * modified  only in  accordance with the terms of such license and with *
// * the  inclusion of the above  copyright notice.  This software or  any *
// * other copies thereof may not be provided or  otherwise made available *
// * to any  other  person.   No title to and ownership of the software is *
// * hereby transferred.                                                   *
// *                                                                       *
// * You may not reverse  engineer, decompile, defeat  license  encryption *
// * mechanisms  or  disassemble this software product or software product *
// * license.  Forefront Infotech may terminate this license if you don't  *
// * comply with  any  of  the  terms and conditions set forth in  our end *
// * user license agreement (EULA).  In such event,  licensee  agrees to   *
// * return licensor  or destroy  all copies of software  upon termination *
// * of the license.                                                       *
// *                                                                       *
// * Please see the  License file for the full End User License Agreement. *
// * The  complete license agreement is also available on  our  website at *
// * http://www.nopcommerceplus.com/enterprise-license                     *
// *                                                                       *
// *************************************************************************

import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRightRoute({required this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        });
}
