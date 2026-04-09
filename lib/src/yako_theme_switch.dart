import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YakoThemeSwitch extends StatefulWidget {
  /// false: dark theme (left position), true: light theme (right position)
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
  late AnimationController _animationController;
  late Animation<double> _animation;
  late bool _turnState;
  late Color _enabledBackgroundColor;
  late Color _disabledBackgroundColor;
  late Color _enabledToggleColor;
  late Color _disabledToggleColor;
  double _animationValue = 0.0;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _enabledBackgroundColor =
        widget.enabledBackgroundColor ?? Colors.grey.shade300;
    _disabledBackgroundColor =
        widget.disabledBackgroundColor ?? const Color(0xFF2E386E);
    _enabledToggleColor =
        widget.enabledToggleColor ?? Colors.amberAccent.shade700;
    _disabledToggleColor =
        widget.disabledToggleColor ?? const Color(0xFF70E2FB);

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

    return GestureDetector(
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
              offset: Offset((widget.width - 25) * _animationValue, 0),
              child: Transform.rotate(
                angle: _animationValue,
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
