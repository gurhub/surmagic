# How to make a Universal (Fat) Framework

### 💡Before Starting
Before starting to reading craziest things please check the [Demo Project](#demo-project). An example can explain more than the words :)

### What is a FAT library?
The iOS framework includes a **FAT (multi-architecture) binary** that contains slices for **armv7, arm64, i386, and x86_64 CPU** architectures. **ARM** slices are used by **physical iOS devices**, while **i386 and x86_64** are used by **Simulator** and are stripped from your app during the build and archive process. When a user downloads the app from the App Store, they receive only the architecture that their device requires.

### Why We Need?

* If you're building for iphonesimulator, you'll get a framework with an x86 slice but no ARM slice. 
* If you build for iphoneos, you'll get a framework with arm slice(s), but no simulator support 🤔. 
* While developing your application, you need a Framework that works on both platforms. You can't rebuild your framework every time for Simulator or Device.

**Good News!** This script compiles for *both* platforms and *all* potential slices, merges the binaries produced from each, and produces a completed framework using the structure from either of the first two, single platform builds. 

**In other words** This script creates a Fat Framework that includes both.

# Demo Project

* Demo workspace includes 2 projects:
  * A Framework project named [**fat**](https://github.com/gurhub/universal-framework/tree/master/fat), that written in Objective-C 🤯
  * A Demo project named [**demo**](https://github.com/gurhub/universal-framework/tree/master/demo), that written in Swift 5 and uses [SwiftUI](https://developer.apple.com/xcode/swiftui/) 🥳
* The demo project uses the fat framework in it
* For more details please download and check the demo project.

# How to add in your Framework Project

As you can see in the demo project, noting is complicated. 🤓 
👉🏻 Remember that your project must be created **as a Framework project** for this script works, otherwise, this script won't help you out.

## STEP 1: Add a new scheme

**Warning:** If you're using the **Cocoapods** in your project start from here, otherwise this step is **not mandatory**. You can directly add in your current sheme.

⚠️ If you're using the Cocoapods you need to copy all the other settings under your scheme. That's why we will duplicate our scheme instead of creating a new one.

Duplicate your scheme under Product → Scheme → Manage Schemes... menu. Make sure that the **shared box is selected**.

Edit your scheme name like line below: 

```
YourProjectName-Universal
```

* ⚠️ we will use this naming convention in our script file.

## STEP 2: Add a Run Script Action

Select **Project Target → Edit Scheme → Archive → Post-actions → Press “+” → New Run Script Action**

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

* ⚠️ Under the **Provide Build Settings From** menu *YourProjectName* must be selected.

## STEP 3: Archive

Then run the Build > Archive on your Xcode.

The *Post Script* will be executed after the Archive is completed. And the Universal Framework would be generated and opened in project directory itself.

## STEP 4: Sending to the App Store

So, you move your archived Universal framework in your desired project. But, while you sending your application to the App Store you will face **"Operation Error: Unsupported architectures"** error. You have to remove the unused architectures from your Fat (Universal) framework before sending to the App Store. For this select the **Project, Choose Target → Project Name → Select Build Phases → Press “+” → New Run Script Phase** and than Name the Script as “Remove Unused Architectures”. 

And add the script from [`this file`](cleanforappstore.sh).

* ⚠️ Don't forget to change the line below with your Universal framework's name:

```
FRAMEWORK="YOUR_FRAMEWORK_NAME"
```

Thats All!

Best of luck! :v:

## Possible Errors

* If your project is unable to build via **xcodebuild** command for some reason, this script will not help you, and you'll get a build error. First, be sure that your project **can build on the terminal and try** this project.
* If you have a project **without a workspace please update your xcodebuild lines** in the script file with code below:

```
xcodebuild -target "${PROJECT_NAME}" 
```

final result is something like this:

```
xcodebuild -target "${PROJECT_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" -UseModernBuildSystem=NO clean build
```

## Test

This script tested with this configurations:

* Tested on the [Xcode](https://developer.apple.com/xcode/) versions listed below:
  * 11.1 (11A1027) (this is where we started...)
  * 11.2 (11B52) 
  * 11.2.1 (11B500) 
  * 11.3 (11C29)
  * 11.3.1 (11C504)
  * 11.5 (11E608c) 
  * **11.6 (11E708)** and above...
* Also tested with the [Cocoapods](https://cocoapods.org) (CocoaPods is a dependency manager for Swift and Objective-C Cocoa projects)

## Resources

* [What is app thinning?](https://help.apple.com/xcode/mac/current/#/devbbdc5ce4f)
* [Distribute an app through the App Store](https://help.apple.com/xcode/mac/current/#/dev067853c94)
* [Verify the target and project build settings](https://help.apple.com/xcode/mac/current/#/dev34b59f90c)
* [What is an XCFramework?](https://help.apple.com/xcode/mac/current/#/dev6f6ac218b)
* [Create an XCFramework](https://help.apple.com/xcode/mac/current/#/dev544efab96)
* [Embedding Frameworks In An App](https://developer.apple.com/library/archive/technotes/tn2435/_index.html)
* [Anatomy of Framework Bundles](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/FrameworkAnatomy.html#//apple_ref/doc/uid/20002253-97623-BAJJHAJC)

## TODO

- [ ] Support for multiple frameworks in [`cleanforappstore.sh`](cleanforappstore.sh). But not all (this will cause an error because of Cocoapods frameworks are not fat frameworks). Use an static array 🤔.
- [x] Add a demo project 

## Communication

If you see a way to improve the project :

- If you **need help**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/ios-universal-framework). (Tag `ios-universal-framework`)
- If you'd like to **ask a general question**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/ios-universal-framework).
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an [issue](https://github.com/gurhub/universal-framework/issues).
- If you **have a feature request**, open an [issue](https://github.com/gurhub/universal-framework/issues).
- If you **want to contribute**, submit a [pull request](https://github.com/gurhub/universal-framework/pulls). It's better to begin with an [issue](https://github.com/gurhub/universal-framework/issues) rather than a [pull request](https://github.com/gurhub/universal-framework/pulls), though, because we might disagree whether the proposed change is an actual improvement. :wink:

Thanks! :v:

## Author

Muhammed Gurhan Yerlikaya, gurhanyerlikaya@gmail.com

## License

"universal-framework" is available under the GNU General Public License v3.0 license. See the [`LICENSE`](LICENSE) file for more info.

