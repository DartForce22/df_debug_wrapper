import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A debug-only wrapper widget that displays a customizable banner
/// on top of its child widget. The banner is visible only in debug mode
/// and optionally in profile mode, based on the [hideInProfileMode] flag.
///
/// This widget is useful for marking or debugging UI elements during development.
/// In release mode, it does not render anything.
///

enum IgnorePointerMode {
  /// Ignore all pointer events on the child widget.
  all,

  /// Ignore pointer events in profile and release mode.
  profileMode,

  /// Ignore pointer events only in release mode.
  releaseMode,

  ///Events are not ignored in any mode.
  /// This is the default behavior.
  none,
}

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
    this.ignorePointerMode = IgnorePointerMode.none,
    this.bannerBgColor,
    this.description,
    this.hideInProfileMode = false,
    this.hideInReleaseMode = true,
  });

  /// The child widget to be wrapped and displayed.
  final Widget child;

  /// The text displayed on the banner.
  final String bannerText;

  /// Determines whether the banner should be displayed.
  /// Defaults to `true`, which means the banner is displayed.
  final bool displayBanner;

  /// Determines whether to ignore pointer events on the child widget.
  /// Defaults to `IgnorePointerMode.none`, which means pointer events are not ignored.
  final IgnorePointerMode ignorePointerMode;

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
  final bool hideInReleaseMode;

  /// Determines whether to ignore pointer events on the child widget.
  bool get ignoringPointer {
    switch (ignorePointerMode) {
      case IgnorePointerMode.all:
        return true;
      case IgnorePointerMode.profileMode:
        return kProfileMode;
      case IgnorePointerMode.releaseMode:
        return kReleaseMode || kProfileMode;
      case IgnorePointerMode.none:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kReleaseMode && hideInReleaseMode) {
      return const SizedBox();
    }

    if (kProfileMode && hideInProfileMode) {
      return const SizedBox();
    }

    return IgnorePointer(
      ignoring: ignoringPointer,
      child: Stack(
        children: [
          child,
          if (displayBanner)
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
                      bannerText,
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
