
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2019/5/27
 *     desc  : 自定义侧滑控件，主要是为了限制宽度
 *     revise:
 * </pre>
 */
class SmartDrawer extends StatelessWidget {
  final double elevation;
  final Widget child;
  final String semanticLabel;
  final double widthPercent;
  const SmartDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
    this.widthPercent = 0.7,
  }) :
        assert(widthPercent!=null&&widthPercent<1.0&&widthPercent>0.0)
  ,super(key: key);
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
        break;
    }
    final double _width = MediaQuery.of(context).size.width*widthPercent;
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _width),
        child: Material(
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}
