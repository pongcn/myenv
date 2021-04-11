#!/bin/bash
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_PREFS_ROOT=$HOME
export ANDROID_SDK_HOME=$ANDROID_PREFS_ROOT # In Android Studio 4.1 and lower
export ANDROID_EMULATOR_HOME=$ANDROID_PREFS_ROOT/.android
export ANDROID_AVD_HOME=$ANDROID_EMULATOR_HOME/avd
export FLUTTER_ROOT=$HOME/Flutter/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_AVD_HOME
export PATH=$PATH:$FLUTTER_ROOT/bin

export ADB_SERVER_SOCKET=tcp:localhost:5037

# wslip=$(hostname -I | awk '{print $1}')
# WSL_HOST_IP="$(tail -1 /etc/resolv.conf | cut -d' ' -f2)"
# export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037

echo "setting flutter environment is done"
