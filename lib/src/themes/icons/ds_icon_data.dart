import 'package:flutter/widgets.dart';

import '../../utils/ds_utils.util.dart';

class DSIconData extends IconData {
  static const _kFontFam = 'DSIcons';
  static const String _kFontPkg = DSUtils.packageName;

  const DSIconData(super.codePoint)
      : super(
          fontFamily: DSIconData._kFontFam,
          fontPackage: DSIconData._kFontPkg,
        );
}
