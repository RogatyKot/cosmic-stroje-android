Android build helper for "Cosmoc Stroje"

Files added:
- android_icons/           -> generated app icons (various sizes)
- export_presets.cfg       -> Godot export preset template (edit keystore paths)
- build_android.sh         -> local build script (uses godot --export)
- .github/workflows/...    -> example CI workflow to export APK on push

How to build locally (recommended):
1. Install Godot 4 on your PC and install the export templates for Android (Project -> Install Export Templates).
2. Ensure Android SDK/NDK and Java JDK are set up if you need to sign the APK.
3. Copy or move this project to your PC. Open it with Godot to verify the project opens.
4. (Optional) In Project -> Export, import 'export_presets.cfg' or configure a preset named "Android (Unsigned)".
5. Run the build script:
   ./build_android.sh ComsmocStroje.apk
6. To produce a signed APK ready for store, generate a keystore:
   keytool -genkey -v -keystore my_keystore.jks -alias my_alias -keyalg RSA -keysize 2048 -validity 10000
   Then use jarsigner/zipalign to sign and align the APK (Android SDK build-tools provide zipalign).

Using GitHub Actions:
- This repo includes a basic workflow at .github/workflows/build-android.yml which tries to install Godot via snap and run export.
- You may need to adjust the workflow to install a specific Godot binary or use a Docker action for Godot export templates.

If you want, I can:
- Prepare a fully signed APK here and provide it to you (I cannot sign with your private keystore; I can create a debug keystore but publishing requires your own keystore).
- Or automate CI with a pre-built Godot binary action (I can adapt the workflow).

