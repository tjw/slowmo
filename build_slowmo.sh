#!/bin/zsh -euf

dev_dir=`xcode-select -print-path`

# Hack to find the latest SDK. Asked for real support in 10580379: xcodebuild should have flags to print the platform list and current sdk
sdk_name=`/bin/ls "$dev_dir/Platforms/MacOSX.platform/Developer/SDKs" | tail -1`

if [ -x "$dev_dir/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang" ]; then
	CC="$dev_dir"/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
else
	CC="$dev_dir"/usr/bin/gcc
fi
	
"$CC" -arch i386 -isysroot "$dev_dir/Platforms/MacOSX.platform/Developer/SDKs/$sdk_name" -lobjc -framework Foundation -bundle -o _slowmo slowmo.m
