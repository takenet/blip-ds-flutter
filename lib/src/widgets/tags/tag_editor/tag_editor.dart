import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '/src/widgets/tags/tag_editor/suggestions_box_controller.dart';
import './tag_editor_layout_delegate.dart';
import './tag_layout.dart';

typedef SuggestionBuilder<T> = Widget Function(
    BuildContext context, TagsEditorState<T> state, T data);
typedef InputSuggestions<T> = FutureOr<List<T>> Function(String query);
typedef SearchSuggestions<T> = FutureOr<List<T>> Function();

/// A [Widget] for editing tag similar to Google's Gmail
/// email address input widget in the iOS app.
class TagEditor<T> extends StatefulWidget {
  const TagEditor({
    required this.length,
    this.minTextFieldWidth = 160.0,
    this.tagSpacing = 4.0,
    required this.tagBuilder,
    required this.onTagChanged,
    required this.suggestionBuilder,
    required this.findSuggestions,
    super.key,
    this.focusNode,
    this.hasAddButton = true,
    this.delimiters = const [],
    this.icon,
    this.enabled = true,
    this.controller,
    this.textStyle,
    this.inputDecoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = false,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.resetTextOnSubmitted = false,
    this.onSubmitted,
    this.inputFormatters,
    this.keyboardAppearance,
    this.suggestionsBoxMaxHeight,
    this.suggestionsBoxElevation,
    this.suggestionsBoxBackgroundColor,
    this.suggestionsBoxRadius,
    this.iconSuggestionBox,
    this.searchAllSuggestions,
    this.debounceDuration,
    this.activateSuggestionBox = true,
    this.cursorColor,
    this.backgroundColor,
    this.focusedBorderColor,
    this.enableBorderColor,
    this.borderRadius,
    this.borderSize,
    this.padding,
    this.suggestionPadding,
    this.suggestionMargin,
    this.scrollController,
  });

  /// The controller of scroll in tag box area
  final ScrollController? scrollController;

  /// The number of tags currently shown.
  final int length;

  /// The minimum width that the `TextField` should take
  final double minTextFieldWidth;

  /// The spacing between each tag
  final double tagSpacing;

  /// Builder for building the tags, this usually use Flutter's Material `Chip`.
  final Widget Function(BuildContext, int) tagBuilder;

  /// Show the add button to the right.
  final bool hasAddButton;

  /// The icon for the add button enabled with `hasAddButton`.
  final IconData? icon;

  /// Callback for when the tag changed. Use this to get the new tag and add
  /// it to the state.
  final ValueChanged<String> onTagChanged;

  /// When the string value in this `delimiters` is found, a new tag will be
  /// created and `onTagChanged` is called.
  final List<String> delimiters;

  /// Reset the TextField when `onSubmitted` is called
  /// this is default to `false` because when the form is submitted
  /// usually the outstanding value is just used, but this option is here
  /// in case you want to reset it for any reasons (like converting the
  /// outstanding value to tag).
  final bool resetTextOnSubmitted;

  /// Called when the user are done editing the text in the [TextField]
  /// Use this to get the outstanding text that aren't converted to tag yet
  /// If no text is entered when this is called an empty string will be passed.
  final ValueChanged<String>? onSubmitted;

  /// Focus node for checking if the [TextField] is focused.
  final FocusNode? focusNode;

  /// [TextField]'s properties.
  ///
  /// Please refer to [TextField] documentation.
  final TextEditingController? controller;
  final bool enabled;
  final TextStyle? textStyle;
  final InputDecoration inputDecoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Brightness? keyboardAppearance;
  final Color? cursorColor;
  final Color? backgroundColor;
  final Color? focusedBorderColor;
  final Color? enableBorderColor;
  final double? borderRadius;
  final double? borderSize;
  final EdgeInsets? padding;

  /// [SuggestionBox]'s properties.
  final double? suggestionsBoxMaxHeight;
  final double? suggestionsBoxElevation;
  final SuggestionBuilder<T> suggestionBuilder;
  final InputSuggestions<T> findSuggestions;
  final SearchSuggestions<T>? searchAllSuggestions;
  final Color? suggestionsBoxBackgroundColor;
  final double? suggestionsBoxRadius;
  final Widget? iconSuggestionBox;
  final Duration? debounceDuration;
  final bool activateSuggestionBox;
  final EdgeInsets? suggestionMargin;
  final EdgeInsets? suggestionPadding;

  @override
  TagsEditorState<T> createState() => TagsEditorState<T>();
}

class TagsEditorState<T> extends State<TagEditor<T>> {
  /// A controller to keep value of the [TextField].
  late TextEditingController _textFieldController;

  /// A state variable for checking if new text is enter.
  var _previousText = '';

  /// A state for checking if the [TextFiled] has focus.
  var _isFocused = false;

  /// Focus node for checking if the [TextField] is focused.
  late FocusNode _focusNode;

  StreamController<List<T>?>? _suggestionsStreamController;
  SuggestionsBoxController? _suggestionsBoxController;
  final _layerLink = LayerLink();
  List<T>? _suggestions;
  int _searchId = 0;
  Debouncer? _deBouncer;

  RenderBox? get renderBox => context.findRenderObject() as RenderBox?;

  @override
  void initState() {
    super.initState();
    _textFieldController = (widget.controller ?? TextEditingController());

    _focusNode = (widget.focusNode ?? FocusNode())
      ..addListener(_onFocusChanged);

    if (widget.activateSuggestionBox) _initializeSuggestionBox();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _suggestionsStreamController?.close();
    _suggestionsBoxController?.close();
    super.dispose();
  }

  void _initializeSuggestionBox() {
    _deBouncer = Debouncer<String>(
        widget.debounceDuration ?? const Duration(milliseconds: 300),
        initialValue: '');

    _deBouncer?.values.listen((value) {
      developer.log('TagsEditorState::initState():_deBouncer:listen: $value');
      _onSearchChanged(value);
    });

    _suggestionsBoxController = SuggestionsBoxController(context);
    _suggestionsStreamController = StreamController<List<T>?>.broadcast();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _createOverlayEntry();
    });
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _scrollToVisible();
      _suggestionsBoxController?.open();
    } else {
      _suggestionsBoxController?.close();
    }
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _createOverlayEntry() {
    _suggestionsBoxController?.overlayEntry = OverlayEntry(
      builder: (context) {
        if (renderBox != null) {
          final size = renderBox!.size;
          final renderBoxOffset = renderBox!.localToGlobal(Offset.zero);
          final topAvailableSpace = renderBoxOffset.dy;
          final mq = MediaQuery.of(context);
          final bottomAvailableSpace = mq.size.height -
              mq.viewInsets.bottom -
              renderBoxOffset.dy -
              size.height;
          var suggestionBoxHeight =
              max(topAvailableSpace, bottomAvailableSpace);
          if (null != widget.suggestionsBoxMaxHeight) {
            suggestionBoxHeight =
                min(suggestionBoxHeight, widget.suggestionsBoxMaxHeight!);
          }
          final showTop = topAvailableSpace > bottomAvailableSpace;
          final compositedTransformFollowerOffset =
              showTop ? Offset(0, -size.height) : Offset.zero;

          return StreamBuilder<List<T>?>(
            stream: _suggestionsStreamController?.stream,
            initialData: _suggestions,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final suggestionsListView = PointerInterceptor(
                  child: Padding(
                    padding: widget.suggestionMargin ?? EdgeInsets.zero,
                    child: Material(
                      elevation: widget.suggestionsBoxElevation ?? 20,
                      borderRadius: BorderRadius.circular(
                          widget.suggestionsBoxRadius ?? 20),
                      color:
                          widget.suggestionsBoxBackgroundColor ?? Colors.white,
                      child: Container(
                          decoration: BoxDecoration(
                              color: widget.suggestionsBoxBackgroundColor ??
                                  Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  widget.suggestionsBoxRadius ?? 0))),
                          constraints:
                              BoxConstraints(maxHeight: suggestionBoxHeight),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding:
                                widget.suggestionPadding ?? EdgeInsets.zero,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return _suggestions != null &&
                                      _suggestions?.isNotEmpty == true
                                  ? widget.suggestionBuilder(
                                      context, this, _suggestions![index]!)
                                  : Container();
                            },
                          )),
                    ),
                  ),
                );
                return Positioned(
                  width: size.width,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: compositedTransformFollowerOffset,
                    child: !showTop
                        ? suggestionsListView
                        : FractionalTranslation(
                            translation: const Offset(0, -1),
                            child: suggestionsListView,
                          ),
                  ),
                );
              }
              return Container();
            },
          );
        }
        return Container();
      },
    );
  }

  void _onTagChanged(String string) {
    if (string.isNotEmpty) {
      widget.onTagChanged(string);
      _resetTextField();
    }
  }

  /// This function is still ugly, have to fix this later
  void _onTextFieldChange(String string) {
    if (string != _previousText) {
      _deBouncer?.value = string;
    }

    final previousText = _previousText;
    _previousText = string;

    if (string.isEmpty || widget.delimiters.isEmpty) {
      return;
    }

    // Do not allow the entry of the delimters, this does not account for when
    // the text is set with `TextEditingController` the behaviour of TextEditingContoller
    // should be controller by the developer themselves
    if (string.length == 1 && widget.delimiters.contains(string)) {
      _resetTextField();
      return;
    }

    if (string.length > previousText.length) {
      // Add case
      final newChar = string[string.length - 1];
      if (widget.delimiters.contains(newChar)) {
        final targetString = string.substring(0, string.length - 1);
        if (targetString.isNotEmpty) {
          _onTagChanged(targetString);
        }
      }
    }
  }

  void _onSearchChanged(String value) async {
    final localId = ++_searchId;
    final results = await widget.findSuggestions(value);
    if (_searchId == localId && mounted) {
      setState(() => _suggestions = results);
    }
    _suggestionsStreamController?.add(_suggestions ?? []);
    if (!(_suggestionsBoxController?.isOpened == true)) {
      _suggestionsBoxController?.open();
    }
  }

  void _openSuggestionBox() async {
    if (widget.searchAllSuggestions != null) {
      final localId = ++_searchId;
      final results = await widget.searchAllSuggestions!();
      if (_searchId == localId && mounted) {
        setState(() => _suggestions = results);
      }
      _suggestionsStreamController?.add(_suggestions ?? []);
      if (!(_suggestionsBoxController?.isOpened == true)) {
        _suggestionsBoxController?.open();
      }
    }
  }

  void _scrollToVisible() {
    Future.delayed(const Duration(milliseconds: 300), () {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final renderBox = context.findRenderObject() as RenderBox;
        await Scrollable.of(context).position.ensureVisible(renderBox);
      });
    });
  }

  void selectSuggestion(T data) {
    _suggestions = null;
    _suggestionsStreamController?.add([]);
    _resetTextField();
  }

  void _onSubmitted(String string) {
    widget.onSubmitted?.call(string);
    if (widget.resetTextOnSubmitted) {
      _resetTextField();
    }
  }

  void _resetTextField() {
    _textFieldController.text = '';
    _previousText = '';
  }

  /// Shamelessly copied from [InputDecorator]
  Color _getDefaultIconColor(ThemeData themeData) {
    if (!widget.enabled) {
      return themeData.disabledColor;
    }

    switch (themeData.brightness) {
      case Brightness.dark:
        return Colors.white70;
      case Brightness.light:
        return Colors.black45;
    }
  }

  /// Shamelessly copied from [InputDecorator]
  Color _getActiveColor(ThemeData themeData) {
    if (_focusNode.hasFocus) {
      switch (themeData.brightness) {
        case Brightness.dark:
          return themeData.colorScheme.secondary;
        case Brightness.light:
          return themeData.primaryColor;
      }
    }
    return themeData.hintColor;
  }

  Color _getIconColor(ThemeData themeData) {
    final themeData = Theme.of(context);
    final activeColor = _getActiveColor(themeData);
    return _isFocused ? activeColor : _getDefaultIconColor(themeData);
  }

  @override
  Widget build(BuildContext context) {
    final decoration = widget.hasAddButton
        ? widget.inputDecoration.copyWith(
            suffixIcon: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                _onTagChanged(_textFieldController.text);
              },
              child: const Icon(Icons.add),
            ),
          )
        : widget.inputDecoration;

    final tagEditorArea = Container(
      constraints: const BoxConstraints(maxHeight: 200.0),
      padding: widget.padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(widget.borderRadius ?? 0)),
        border: Border.all(
          width: widget.borderSize ?? (_isFocused ? 1 : 0.5),
          color: _isFocused
              ? widget.focusedBorderColor ?? Colors.transparent
              : widget.enableBorderColor ?? Colors.transparent,
        ),
        color: widget.backgroundColor ?? Colors.transparent,
      ),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        padding: const EdgeInsets.only(
          top: 12.0,
        ),
        child: TagLayout(
          delegate: TagEditorLayoutDelegate(
            length: widget.length,
            minTextFieldWidth: widget.minTextFieldWidth,
            spacing: widget.tagSpacing,
          ),
          children: [
            ...List<Widget>.generate(
              widget.length,
              (index) => LayoutId(
                id: TagEditorLayoutDelegate.getTagId(index),
                child: widget.tagBuilder(context, index),
              ),
            ),
            LayoutId(
              id: TagEditorLayoutDelegate.textFieldId,
              child: TextField(
                style: widget.textStyle,
                focusNode: _focusNode,
                enabled: widget.enabled,
                controller: _textFieldController,
                keyboardType: widget.keyboardType,
                keyboardAppearance: widget.keyboardAppearance,
                textCapitalization: widget.textCapitalization,
                textInputAction: widget.textInputAction,
                cursorColor: widget.cursorColor,
                autocorrect: widget.autocorrect,
                textAlign: widget.textAlign,
                textDirection: widget.textDirection,
                readOnly: widget.readOnly,
                autofocus: widget.autofocus,
                enableSuggestions: widget.enableSuggestions,
                maxLines: widget.maxLines,
                decoration: decoration,
                onChanged: _onTextFieldChange,
                onSubmitted: _onSubmitted,
                inputFormatters: widget.inputFormatters,
              ),
            )
          ],
        ),
      ),
    );

    Widget? itemChild;

    if (widget.icon == null && widget.iconSuggestionBox == null) {
      itemChild = tagEditorArea;
    } else {
      itemChild = Row(
        children: <Widget>[
          if (widget.hasAddButton)
            Container(
              width: 40,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.zero,
              child: IconTheme.merge(
                data: IconThemeData(
                  color: _getIconColor(Theme.of(context)),
                  size: 18.0,
                ),
                child: Icon(widget.icon),
              ),
            ),
          if (widget.iconSuggestionBox != null)
            Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: IconButton(
                    icon: widget.iconSuggestionBox!,
                    splashRadius: 20,
                    onPressed: () => _openSuggestionBox())),
          Expanded(child: tagEditorArea),
        ],
      );
    }

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (SizeChangedLayoutNotification val) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          _suggestionsBoxController?.overlayEntry?.markNeedsBuild();
        });
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Column(
          children: <Widget>[
            itemChild,
            CompositedTransformTarget(
              link: _layerLink,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
