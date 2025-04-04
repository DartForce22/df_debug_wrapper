import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A debug-only wrapper widget that displays a customizable banner
/// on top of its child widget. The banner is visible only in debug mode
/// and optionally in profile mode, based on the [hideInProfileMode] flag.
///
/// This widget is useful for marking or debugging UI elements during development.
/// In release mode, it does not render anything.

class DfDebugWrapper extends StatelessWidget {
  /// - [child] is the widget to wrap.
  /// - [bannerText] is the text displayed in the banner (defaults to "Dummy").
  /// - [bannerBgColor] is the background color of the banner.
  /// - [description] is an optional tooltip message displayed when hovering or
  /// long-pressing on the banner.
  /// - [hideInProfileMode] determines whether to hide the banner in profile mode
  /// (defaults to `true`).
  /// - [hideInReleaseProfileMode] determines whether to hide the banner in release mode
  /// (defaults to `true`).
  /// /// - [displayBanner] determines whether to display the banner (defaults to `true`).
  /// - [ignorePointer] determines whether to ignore pointer events on the child widget
  ///(defaults to `false`).
  ///---
  /// **Important**
  /// This widget needs to be removed before generating a release build
  /// otherwise, the provided widget will not be visible
  const DfDebugWrapper({
    super.key,
    required this.child,
    this.bannerText = "Dummy",
    this.displayBanner = true,
    this.ignorePointer = false,
    this.bannerBgColor,
    this.description,
    this.hideInProfileMode = false,
    this.hideInReleaseProfileMode = true,
  });

  /// The child widget to be wrapped and displayed.
  final Widget child;

  /// The text displayed on the banner.
  final String bannerText;

  /// Determines whether the banner should be displayed.
  /// Defaults to `true`, which means the banner is displayed.
  final bool displayBanner;

  /// Determines whether to ignore pointer events on the child widget.
  /// If set to `true`, the child widget will not respond to pointer events.
  final bool ignorePointer;

  /// Optional tooltip message to provide additional context.
  final String? description;

  /// Optional background color for the banner. Defaults to orange
  /// with reduced opacity if not specified.
  final Color? bannerBgColor;

  /// Determines whether the banner should be hidden in profile mode.
  /// Defaults to `true`, which means the banner is hidden in profile mode.
  final bool hideInProfileMode;

  /// Determines whether the provided child widget should be hidden in release mode.
  /// Defaults to `true`, which means the provided child widget is hidden in release mode.
  final bool hideInReleaseProfileMode;

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode && hideInReleaseProfileMode) {
      return const SizedBox();
    }

    if (kProfileMode && hideInProfileMode) {
      return const SizedBox();
    }

    return IgnorePointer(
      ignoring: ignorePointer,
      child: Stack(
        children: [
          child,
          Positioned(
            right: 0,
            top: 0,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(15 / 360),
              child: Tooltip(
                message: description ?? bannerText,
                child: Container(
                  width: 42,
                  decoration: BoxDecoration(
                    color: bannerBgColor ??
                        Colors.orange.withValues(
                          alpha: 0.4,
                        ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    displayBanner ? bannerText : "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
