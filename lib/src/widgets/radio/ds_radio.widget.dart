import 'package:flutter/material.dart';

import '../../themes/colors/ds_colors.theme.dart';

class DSRadio<T> extends Radio<T> {
  const DSRadio({
    super.key,
    required super.value,
    required super.groupValue,
    required super.onChanged,
    super.materialTapTargetSize,
    this.isEnabled = true,
  });

  final bool isEnabled;

  bool get _selected => value == groupValue;
  final Color _activeColor = DSColors.primaryNight;

  @override
  State<DSRadio<T>> createState() => _RadioState<T>();
}

class _RadioState<T> extends State<DSRadio<T>>
    with TickerProviderStateMixin, ToggleableStateMixin {
  late final _RadioPainter _painter;

  @override
  void initState() {
    _painter = _RadioPainter(widget._selected);

    super.initState();
  }

  void _handleChanged(bool? selected) {
    if (widget.isEnabled) {
      if (selected == null) {
        widget.onChanged!(null);
        return;
      }
      if (selected) {
        widget.onChanged!(widget.value);
      }
    }
  }

  @override
  void didUpdateWidget(DSRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._selected != oldWidget._selected) {
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  ValueChanged<bool?>? get onChanged =>
      widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => widget.toggleable;

  @override
  bool? get value => widget._selected;

  WidgetStateProperty<Color?> get _widgetFillColor {
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return null;
      }
      if (states.contains(WidgetState.selected)) {
        return widget._activeColor;
      }
      return null;
    });
  }

  WidgetStateProperty<Color> get _defaultFillColor {
    final ThemeData themeData = Theme.of(context);
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return themeData.disabledColor;
      }
      if (states.contains(WidgetState.selected)) {
        return themeData.colorScheme.secondary;
      }
      return themeData.unselectedWidgetColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);
    final MaterialTapTargetSize effectiveMaterialTapTargetSize =
        widget.materialTapTargetSize ??
            themeData.radioTheme.materialTapTargetSize ??
            themeData.materialTapTargetSize;
    final VisualDensity effectiveVisualDensity = widget.visualDensity ??
        themeData.radioTheme.visualDensity ??
        themeData.visualDensity;
    Size size;
    switch (effectiveMaterialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        size = const Size(kMinInteractiveDimension, kMinInteractiveDimension);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        size = const Size(
            kMinInteractiveDimension / 2.0, kMinInteractiveDimension / 2.0);
        break;
    }
    size += effectiveVisualDensity.baseSizeAdjustment;

    final WidgetStateProperty<MouseCursor> effectiveMouseCursor =
        WidgetStateProperty.resolveWith<MouseCursor>(
            (Set<WidgetState> states) {
      return WidgetStateProperty.resolveAs<MouseCursor?>(
              widget.mouseCursor, states) ??
          themeData.radioTheme.mouseCursor?.resolve(states) ??
          WidgetStateProperty.resolveAs<MouseCursor>(
              WidgetStateMouseCursor.clickable, states);
    });

    _painter.isEnabled = widget.isEnabled;

    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between.
    final Set<WidgetState> activeStates = states..add(WidgetState.selected);
    final Set<WidgetState> inactiveStates = states
      ..remove(WidgetState.selected);
    final Color effectiveActiveColor =
        widget.fillColor?.resolve(activeStates) ??
            _widgetFillColor.resolve(activeStates) ??
            themeData.radioTheme.fillColor?.resolve(activeStates) ??
            _defaultFillColor.resolve(activeStates);
    final Color effectiveInactiveColor =
        widget.fillColor?.resolve(inactiveStates) ??
            _widgetFillColor.resolve(inactiveStates) ??
            themeData.radioTheme.fillColor?.resolve(inactiveStates) ??
            _defaultFillColor.resolve(inactiveStates);

    final Set<WidgetState> focusedStates = states..add(WidgetState.focused);
    final Color effectiveFocusOverlayColor =
        widget.overlayColor?.resolve(focusedStates) ??
            widget.focusColor ??
            themeData.radioTheme.overlayColor?.resolve(focusedStates) ??
            themeData.focusColor;

    final Set<WidgetState> hoveredStates = states..add(WidgetState.hovered);
    final Color effectiveHoverOverlayColor =
        widget.overlayColor?.resolve(hoveredStates) ??
            widget.hoverColor ??
            themeData.radioTheme.overlayColor?.resolve(hoveredStates) ??
            themeData.hoverColor;

    final Set<WidgetState> activePressedStates = activeStates
      ..add(WidgetState.pressed);
    final Color effectiveActivePressedOverlayColor =
        widget.overlayColor?.resolve(activePressedStates) ??
            themeData.radioTheme.overlayColor?.resolve(activePressedStates) ??
            effectiveActiveColor.withAlpha(kRadialReactionAlpha);

    final Set<WidgetState> inactivePressedStates = inactiveStates
      ..add(WidgetState.pressed);
    final Color effectiveInactivePressedOverlayColor =
        widget.overlayColor?.resolve(inactivePressedStates) ??
            themeData.radioTheme.overlayColor?.resolve(inactivePressedStates) ??
            effectiveActiveColor.withAlpha(kRadialReactionAlpha);

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: widget._selected,
      child: buildToggleable(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        mouseCursor: effectiveMouseCursor,
        size: size,
        painter: _painter
          ..position = position
          ..reaction = reaction
          ..reactionFocusFade = reactionFocusFade
          ..reactionHoverFade = reactionHoverFade
          ..inactiveReactionColor = effectiveInactivePressedOverlayColor
          ..reactionColor = effectiveActivePressedOverlayColor
          ..hoverColor = effectiveHoverOverlayColor
          ..focusColor = effectiveFocusOverlayColor
          ..splashRadius = widget.splashRadius ??
              themeData.radioTheme.splashRadius ??
              kRadialReactionRadius
          ..downPosition = downPosition
          ..isFocused = states.contains(WidgetState.focused)
          ..isHovered = states.contains(WidgetState.hovered)
          ..activeColor = widget._activeColor
          ..inactiveColor = effectiveInactiveColor,
      ),
    );
  }
}

class _RadioPainter extends ToggleablePainter {
  _RadioPainter(this.isSelected);

  final bool isSelected;
  final double _kOuterRadius = 12.0;
  final double _kInnerRadius = 6.0;
  final double _kBackgroundRadius = 11.0;

  bool isEnabled = true;

  @override
  void paint(Canvas canvas, Size size) {
    paintRadialReaction(canvas: canvas, origin: size.center(Offset.zero));

    final Offset center = (Offset.zero & size).center;

    if (isEnabled) {
      // Outer circle
      final Paint paint = Paint()
        ..color =
            isSelected ? DSColors.neutralDarkCity : DSColors.neutralDarkRooftop
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(center, _kOuterRadius, paint);

      // Inner circle
      if (!position.isDismissed) {
        paint.color = Color.lerp(inactiveColor, activeColor, position.value)!;

        paint.style = PaintingStyle.fill;
        canvas.drawCircle(center, _kInnerRadius * position.value, paint);
      }
    } else {
      // Outer circle background Disabled
      final Paint paintDisabled = Paint()
        ..color = DSColors.neutralMediumWave
        ..style = PaintingStyle.fill;

      // Outer circle Disabled
      final Paint paint = Paint()
        ..color = DSColors.neutralMediumElephant
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(center, _kOuterRadius, paint);

      canvas.drawCircle(center, _kBackgroundRadius, paintDisabled);

      // Inner circle
      if (!position.isDismissed) {
        paint.color = Color.lerp(
            inactiveColor, DSColors.neutralDarkRooftop, position.value)!;

        paint.strokeWidth = _kInnerRadius;

        paint.style = PaintingStyle.fill;
        canvas.drawCircle(center, _kInnerRadius * position.value, paint);
      }
    }
  }
}
