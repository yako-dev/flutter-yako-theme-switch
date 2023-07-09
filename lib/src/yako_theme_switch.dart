import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class YakoThemeSwitch extends StatefulWidget {
  final bool enabled;
  final double width;
  final Function({bool changed}) onChanged;
  final Color? enabledBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? enabledToggleColor;
  final Color? disabledToggleColor;
  final Duration animationDuration;
  final double? enabledToggleBorderRadius;

  const YakoThemeSwitch({
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
  _YakoThemeSwitchState createState() => _YakoThemeSwitchState();
}

class _YakoThemeSwitchState extends State<YakoThemeSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late bool turnState;
  late Color enabledBackgroundColor;
  late Color disabledBackgroundColor;
  late Color enabledToggleColor;
  late Color disabledToggleColor;
  double animationControllerValue = 0.0;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    enabledBackgroundColor =
        widget.enabledBackgroundColor ?? Colors.grey.shade300;
    disabledBackgroundColor =
        widget.disabledBackgroundColor ?? Color(0xFF2E386E);
    enabledToggleColor =
        widget.enabledToggleColor ?? Colors.amberAccent.shade700;
    disabledToggleColor = widget.disabledToggleColor ?? Color(0xFF70E2FB);

    animationControllerValue = widget.enabled ? 1.0 : 0.0;
    animationController = AnimationController(
      value: animationControllerValue,
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: widget.animationDuration,
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    animationController.addListener(() {
      setState(() {
        animationControllerValue = animation.value;
      });
    });
    turnState = widget.enabled;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (turnState) {
          animationController.forward();
        }
      });
    });
  }

  @override
  void didUpdateWidget(YakoThemeSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if enabled value is updated, reflect the change in switch
    if (oldWidget.enabled != widget.enabled) {
      turnState = widget.enabled;
      if (turnState) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color? transitionColor = Color.lerp(
      disabledBackgroundColor,
      enabledBackgroundColor,
      animationControllerValue,
    );

    return GestureDetector(
      onTap: () {
        toggle(changeState: true);
      },
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
              offset: Offset((widget.width - 25) * animationControllerValue, 0),
              child: Transform.rotate(
                angle: animationControllerValue,
                child: Container(
                  height: 18,
                  width: 18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity:
                              (1 - animationControllerValue).clamp(0.0, 1.0),
                          child: SvgPicture.asset(
                            'assets/dark_mode_switch_icon.svg',
                            colorFilter: ColorFilter.mode(
                              disabledToggleColor,
                              BlendMode.srcIn,
                            ),
                            height: 18,
                            package: 'yako_theme_switch',
                          ),
                        ),
                      ),
                      Center(
                        child: Opacity(
                          opacity: animationControllerValue.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  widget.enabledToggleBorderRadius ?? 20),
                              color: enabledToggleColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void toggle({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      turnState ? animationController.forward() : animationController.reverse();

      widget.onChanged(changed: turnState);
    });
  }
}
