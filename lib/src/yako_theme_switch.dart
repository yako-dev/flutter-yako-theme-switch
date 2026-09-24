import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

/// An animated switch for changing the theme of the app.
///
/// On the dark side ([enabled] is false) the thumb is a moon icon. On the
/// light side ([enabled] is true) it fades into a filled circle, the sun.
/// In right-to-left layouts the switch is mirrored, so the dark side is on
/// the right.
///
/// The switch keeps its own on/off state, so it flips as soon as it is
/// tapped and then calls [onChanged]. Changing [enabled] from the parent
/// animates it to the new value without calling [onChanged].
class YakoThemeSwitch extends StatefulWidget {
  /// false: dark theme (left position), true: light theme (right position).
  ///
  /// The positions are mirrored in right-to-left layouts.
  final bool enabled;

  /// You can set the custom width of the switch
  final double width;

  /// Callback invoked with the new state whenever the switch is toggled
  final ValueChanged<bool> onChanged;

  /// The background color of the switch when it is enabled
  final Color? enabledBackgroundColor;

  /// The background color of the switch when it is disabled
  final Color? disabledBackgroundColor;

  /// The color of the toggle when it is enabled
  final Color? enabledToggleColor;

  /// The color of the toggle when it is disabled
  final Color? disabledToggleColor;

  /// The duration of the animation
  final Duration animationDuration;

  /// The border radius of the toggle. Try setting it to 4 to make the circle square
  final double? enabledToggleBorderRadius;

  const YakoThemeSwitch({
    super.key,
    this.enabled = false,
    this.width = 45,
    this.enabledBackgroundColor,
    this.disabledBackgroundColor,
    this.enabledToggleColor,
    this.disabledToggleColor,
    this.animationDuration = const Duration(milliseconds: 500),
    required this.onChanged,
    this.enabledToggleBorderRadius = 20,
  });

  @override
  State<YakoThemeSwitch> createState() => _YakoThemeSwitchState();
}

class _YakoThemeSwitchState extends State<YakoThemeSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final CurvedAnimation _animation;
  late bool _turnState;
  double _animationValue = 0.0;

  // Read from the widget on every build so new colors from the parent apply.
  Color get _enabledBackgroundColor =>
      widget.enabledBackgroundColor ?? Colors.grey.shade300;
  Color get _disabledBackgroundColor =>
      widget.disabledBackgroundColor ?? const Color(0xFF2E386E);
  Color get _enabledToggleColor =>
      widget.enabledToggleColor ?? Colors.amberAccent.shade700;
  Color get _disabledToggleColor =>
      widget.disabledToggleColor ?? const Color(0xFF70E2FB);

  @override
  void dispose() {
    _animation.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _turnState = widget.enabled;
    _animationValue = widget.enabled ? 1.0 : 0.0;

    _animationController = AnimationController(
      value: _animationValue,
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: widget.animationDuration,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.addListener(() {
      setState(() {
        _animationValue = _animation.value;
      });
    });
  }

  @override
  void didUpdateWidget(YakoThemeSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    _animationController.duration = widget.animationDuration;

    if (oldWidget.enabled != widget.enabled) {
      _turnState = widget.enabled;
      if (_turnState) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color? transitionColor = Color.lerp(
      _disabledBackgroundColor,
      _enabledBackgroundColor,
      _animationValue,
    );
    // The thumb starts at the start edge (the right edge in RTL) and moves
    // towards the end edge, rolling in the direction it moves.
    final double direction =
        Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;

    return Semantics(
      toggled: _turnState,
      child: GestureDetector(
        onTap: _toggle,
        child: Container(
          padding: const EdgeInsets.all(3),
          width: widget.width,
          decoration: BoxDecoration(
            color: transitionColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(
                  (widget.width - 25) * _animationValue * direction,
                  0,
                ),
                child: Transform.rotate(
                  angle: _animationValue * direction,
                  child: SizedBox(
                    height: 18,
                    width: 18,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Opacity(
                            opacity: (1 - _animationValue).clamp(0.0, 1.0),
                            child: SvgPicture.asset(
                              'assets/dark_mode_switch_icon.svg',
                              colorFilter: ColorFilter.mode(
                                _disabledToggleColor,
                                BlendMode.srcIn,
                              ),
                              height: 18,
                              package: 'yako_theme_switch',
                            ),
                          ),
                        ),
                        Center(
                          child: Opacity(
                            opacity: _animationValue.clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  widget.enabledToggleBorderRadius ?? 20,
                                ),
                                color: _enabledToggleColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _turnState = !_turnState;
      if (_turnState) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
    widget.onChanged(_turnState);
  }
}
