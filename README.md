# cognitive_shuffle

Flutter Starter Project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## スプラッシュスクリーン作成

<https://zenn.dev/susatthi/articles/20220406-061305-flutter-native-splash>

1. 768 x 768のアイコンを用意する。
    1. macbookの画像加工でサイズの変更は可能
1. 「Kakumaru Punch」を使用して、角丸に加工する
    1. https://wayohoo.com/article/4368
    1. rouded 30 ぐらい
1. assets/icon/splash.png に配置
1. `dart pub run flutter_native_splash:create` 実行

## リリース手順

### スクリーンショット作成

1. [フレーム付き影なしスクリーンショットを作成](https://reasonable-code.com/xcode-simulator-screenshot/)
2. Canvaで画像を作成

### iOS

[iOS](https://docs.flutter.dev/deployment/ios)

### ADB

Android StudioのSDKを使用する。
[Android SDK Platform-Toolsのパスを通す方法](https://qiita.com/uhooi/items/a3dcc15f7e15ae11d1d6)

```~/.bash_profile
export ANDROID_HOME=${HOME}/Library/Android/sdk
if [ -d "${ANDROID_HOME}" ]; then
  export PATH="${ANDROID_HOME}/bin:$PATH"
fi

# Platform-Toolsのパスを通す
export ANDROID_TOOL_PATH=${ANDROID_HOME}/platform-tools
if [ -d "${ANDROID_TOOL_PATH}" ]; then
  export PATH="${ANDROID_TOOL_PATH}:$PATH"
fi
```
