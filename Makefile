FLUTTER := $(shell if [ -d ".fvm/flutter_sdk" ]; then echo ".fvm/flutter_sdk/bin/flutter"; else echo "flutter"; fi)

default:
	make -h
	@echo ""
	@echo "Makefile Commands"
	@echo "make init"
	@echo "make runner"
	@echo "make release-android"
	@echo "make release-android-build-apk"
	@echo "make release-ios"
	@echo "make install-ios"
	@echo "make pod-clean"
	@echo "make clean"
	@echo "make act"

.PHONY: init
init:
	fvm use
	$(FLUTTER) pub get
	cp .github/workflows/workflow.secrets.example .github/workflows/workflow.secrets
	cp .vscode/launch.json.example .vscode/launch.json
	cp .env.example .env
	@make runner

runner:
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs

.PHONY: release-android
release-android:
	make clean
	$(FLUTTER) build appbundle --release --obfuscate --split-debug-info=./debug-info

# iOS Upload to AppStoreConnect
.PHONY: release-ios
release-ios:
	$(FLUTTER) build ipa --obfuscate --split-debug-info=./debug-info --export-options-plist="ios/ExportOptions.plist"

# iOS 直接インストール用
install-ios:
	make clean
	$(FLUTTER) build ios --release
	$(FLUTTER) install

# Android 直接インストール用
install-android:
	$(FLUTTER) build apk --release
	adb install build/app/outputs/apk/release/app-release.apk

.PHONY: pod-reset
pod-reset:
	make clean
	cd ios && rm -rf .symlinks Pods Podfile.lock ~/Library/Caches/CocoaPods/Pods/
	cd ios && pod deintegrate
	cd ios && pod setup
	cd ios && pod install --repo-update --clean-install

clean:
	$(FLUTTER) clean
	$(FLUTTER) pub get

.PHONY: act
act:
	act -P macos-latest=-self-hosted --secret-file .github/workflows/workflow.secrets
