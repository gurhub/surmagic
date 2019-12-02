# How to make a Universal Framework

### Info

This example uses:

* Xcode Version 11.1 (11A1027), Version 11.2 (11B52), Version 11.2.1 (11B500) and above...
* and the Cocoapods. 

**CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects.** 

That's why in the script file we're using the workspace instead of the target. So, if you have a project without a workspace please update your **xcodebuild** lines in the script file with code below:

```
xcodebuild -target "${PROJECT_NAME}" 
```

final result is something like this:

```
xcodebuild -target "${PROJECT_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build
```

## Add a new scheme

**Warning:** This step is not mandatory. You can directly add in your current sheme. **But** I found a it's little bit risky for newbies.

If you're using the Cocoapods you need to copy all the other settings under your scheme. That's why we will duplicate our scheme instead of creating a new one.

Duplicate your scheme under Product → Scheme → Manage Schemes... menu. Make sure that the shared box is selected.

Edit your schema name like below, we will use this naming convention in our script file:

```
YourProjectName-Universal
```

## Run Script Action

Select **Project Target → Edit Schema → Archive → Post-actions → Press “+” → New Run Script Action**

* copy-paste the script from [`this file`](universal.sh). 
* at the top of script file find the **Global Variables** section. And fill your target's architecture like giving example below the line:

**iOS**
```
DEVICE_ARCH="iphoneos"
DEVICE_SIM_ARCH="iphonesimulator"
```

**All Avilable Architectures**

| **Device**  | **Simulator**    |
| :----:      |    :----:        | 
| macosx      | -                |
| iphoneos    | iphonesimulator  | 
| appletvos   | appletvsimulator |
| watchos     | watchsimulator

* macosx
* iphoneos | iphonesimulator  
* appletvos | appletvsimulator 
* watchos | watchsimulator

* Under the **Provide Build Settings From** menu *YourProjectName* must be selected. ⚠️

## Archive

Then run the Build > Archive on your Xcode.

The *Post Script* will be executed after the Archive is completed. And the Universal Framework would be generated and opened in project directory itself.

## Sending to the App Store

So, you move your archived Universal framework in your desired project. But, while you sending your application to the App Store you will face **"Operation Error: Unsupported architectures"** error. You have to remove the unused architectures from your Fat (Universal) framework before sending to the App Store. For this select the **Project, Choose Target → Project Name → Select Build Phases → Press “+” → New Run Script Phase** and than Name the Script as “Remove Unused Architectures”. 

And add the script below: 

```
#!/bin/sh

echo "\n ⏱ Removing Unused Architectures \n\n\n"

exec > /tmp/${PROJECT_NAME}_archive.log 2>&1

FRAMEWORK="YOUR_FRAMEWORK_NAME"

FRAMEWORK_EXECUTABLE_PATH="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/$FRAMEWORK.framework/$FRAMEWORK"

EXTRACTED_ARCHS=()

for ARCH in $ARCHS

do

lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"

EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")

done

lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"

rm "${EXTRACTED_ARCHS[@]}"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

echo "\n ⏱ Removing Unused Architectures \n\n\n"
echo "\n\n\n 🏁 Completed removing unused architectures from your fat framework."
echo "\n\n\n 🔍 For more details please check the /tmp/${PROJECT_NAME}_archive.log file. \n\n\n"

```

Don't forget to change the line below with your Universal framework name:

```
FRAMEWORK="YOUR_FRAMEWORK_NAME"
```

Thanks! :v:

### TODO

- [ ] Support for multiple frameworks. But not all (this will cause an error because of Cocoapods frameworks are not fat frameworks). Use an static array.

## Author

Muhammed Gurhan Yerlikaya, gurhanyerlikaya@gmail.com

## License

"universal-framework" is available under the GNU General Public License v3.0 license. See the [`LICENSE`](LICENSE) file for more info.

