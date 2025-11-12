#!/usr/bin/env bash
# Build script for Godot Android APK (local)
# Requirements:
# - Godot 4.x (export templates installed)
# - Android SDK + NDK, Java (for signing if needed)
# - ANDROID_HOME, JAVA_HOME environment variables set (if using Android tools)
#
# Usage: ./build_android.sh [output_apk_name.apk]
OUT=${1:-ComsmocStroje.apk}
# Path to Godot executable (edit if necessary)
GODOT_BIN=${GODOT_BIN:-godot} # or /path/to/Godot_v4.0-linux.x86_64
# Ensure export templates are installed in Godot
# Export using preset name "Android (Unsigned)"
$GODOT_BIN --export "Android (Unsigned)" "$OUT"
echo "If you need a signed APK, sign with jarsigner or use Android build tools."
echo "Example signing (after generating keystore):"
echo "jarsigner -verbose -keystore my_keystore.jks $OUT <alias>"
echo "zipalign -v -p 4 $OUT ComsmocStroje-aligned.apk"
