#df_dropdown

`df_debug_wrapper` is the `DfDebugWrapper` widget is a development tool that overlays a customizable banner on its child widget. 
It is visible only in debug mode and optionally in profile mode, based on the `hideInProfileMode` flag. 
This is useful for marking or debugging specific UI components during development. 
### In release mode, it renders nothing.

# Installation

Add the package to your `pubspec.yaml` file

```dart
dependencies:
  df_debug_wrapper: latest_version
```

Then, run: `flutter pub get`

  ### Example
  ```dart
//Remove `DebugWrapper` after the `MyWidget()` is completed
     DebugWrapper(
        child: MyWidget(),
      )
  ```
