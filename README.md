![surmagic Command Line Tool to create XCFramework](https://github.com/gurhub/surmagic/blob/master/assets/Surmagic-Banner.png)

🚀 Create XCFramework with ease! Surmagic is a command-line tool to create XCFramework for multiple platforms at one shot! You don't need to waste your time with command-line scripts when you want to create an XCFramework! Surmagic adds an elegant layer between you and the compiler, for your comfort. You can use Surmagic with your current CI/CD pipeline, or as a standalone tool in your toolbox. The better way to deal with XCFrameworks for iOS, Mac Catalyst, tvOS, macOS, and watchOS. 

## Table of Contents

- [Why?](#why)
- [Requirements](#requirements)
- [Installing](#installing-surmagic)
- [Setting up surmagic](#setting-up-surmagic)
- [How To Use surmagic](#how-to-create-an-xcframework)
  - [How To Create an XCFramework](#how-to-create-an-xcframework)
  - [All Available Commands and Options](#all-available-commands-and-options)
  - [What is the Surfile](#what-is-the-surfile)
  - [SDK Options](#sdk-options)
  - [Passing parameters](#passing-parameters-to-surmagic-command-line-tools)
- [Further Reading](#further-reading)
  - [What is a Swift package?](what-is-an-xcframework)
  - [What is an XCFramework?](what-is-an-xcframework)
  - [Advantages in comparison with the FAT Framework approach](#further-reading)
  - [Why not the Swift Package Manager (SPM)?](#further-reading)
- [Uninstalling](https://github.com/gurhub/surmagic/wiki/Uninstalling-surmagic)
- [References](https://github.com/gurhub/surmagic/wiki/References)
- [Contribute](#contribute-to-surmagic)
- [License](#license)

## Why?

XCFrameworks are a new way to bundle up multiple variants of your framework in a way that will work across Xcode Versions going forward.

After Xcode 11 now Xcode fully supports using and creating binary frameworks in Swift. Simultaneously support devices and Simulator with the new XCFramework bundle type. XCFrameworks support the binary distribution of Swift and C-based code. A single XCFramework can contain a variant for the simulator, and for the device. This means you can ship slices for any of the architectures, including simulator, any Apple OS and even separate slices for UIKit and AppKit apps. 

## Requirements

- macOS Version 11.2 and above
- Xcode 12 and above
- Swift 5.1 and above

## Installing surmagic

### Xcode command line tools (macOS)

*If you've already installed the command-line tools you can skip this step.*

Install the command line tools with the command below:

```bash
$ xcode-select --install
```

### Homebrew (macOS)

[Brew](https://brew.sh) is the Recommended way to install/uninstall the surmagic.

```bash
$ brew tap gurhub/surmagic
$ brew install surmagic
```

This command will install _surmagic_ to your desired bash.

## Manually Install

Or you can download the latest binary from [this directory](https://github.com/gurhub/surmagic/blob/master/bin/surmagic). And copy under your /usr/local/bin directory.

## Setting up surmagic

Open the desired terminal application and enter inside of your project directory's root: 

```bash
$ cd [path-on-your-disk]/your-project
```

Use the command below to create the necessary _surmagic_ directory and files.

```bash
$ surmagic init
``` 

This will create a surmagic directory and a Surfile like below:

- --- your-project
- ------ surmagic
- --------- Surfile

## How To Create an XCFramework

After [setting up your directory](#setting-up-surmagic), and filling mandatory parameters in the [Surfile](#what-is-the-surfile) you can simply use:

```bash
$ surmagic xcf
```
command to create an XCFramework. That's it. There are other commands too. Please keep reading.

![surmagic-XCFramework](https://github.com/gurhub/surmagic/blob/master/assets/surmagic-how-to-use.gif)

## All Available Commands and Options

Use 'surmagic --help' to learn all available commands in the surmagic.

```bash
USAGE: surmagic <subcommand>

OPTIONS:
  --version               Show the version.
  -h, --help              Show help information.

SUBCOMMANDS:
  init                    Creates the mandatory directory (surmagic) and files.
  xcf (default)           Creates an XCFramework via Surfile.
  env                     To use while creating an issue on Github, prints the
                          user's environment.

  See 'surmagic help <subcommand>' for detailed help.
```

## Passing parameters to _surmagic_ command-line tools

Surmagic contains several command-line tools, e.g. **surmagic xcf** or **surmagic init**. To pass parameters to these tools, append the option names and values as you would for a normal shell command:

```bash
$ surmagic [tool] --[option] --[option] ...∞

$ surmagic init
$ surmagic xcf --verbose
```

## What is the Surfile

The Surfile is used to configure _surmagic_. Open it in your favorite text editor, and add desired targets.

It's a standard Plist (XML) file.

The Surfile has to be inside your ./SM directory.

The Surfile stores the automation configuration that can be run with _surmagic_.

```xml
<dict>
  <key>output_path</key>
  <string>_OUTPUT_DIRECTORY_NAME_HERE_</string>
  <key>framework</key>
  <string>_FRAMEWORK_NAME_HERE_</string>
  <key>targets</key>
  <array>
    <dict>
      <key>sdk</key>
      <string>_TARGET_OS_HERE_</string>
      <key>workspace</key>
      <string>_WORKSPACE_NAME_HERE_.xcworkspace</string>
      <key>scheme</key>
      <string>_SCHEME_NAME_HERE_</string>
    </dict>
     <!--
       Remove this comment and add more targets for Simulators and the Devices.
      -->
  </array>
  <key>finalActions</key>
  <array>
    <string>openDirectory</string>
  </array>
</dict>
```

##### SDK Options 

| Key            	| Description     	|
|----------------	|-----------------	|
| iOS            	| iOS             	|
| iOSSimulator   	| iOS Simulator   	|
| macOS          	| macOS           	|
| macOSCatalyst  	| macOS Catalyst  	|
| tvOS           	| tvOS            	|
| tvOSSimulator  	| tvOS Simulator  	|
| watchOS        	| watchOS         	|
| watchSimulator 	| watch Simulator 	|


Check the [Demo project's example](https://github.com/gurhub/surmagic/blob/master/Demo/SM/Surfile).

# Further Reading

## What is an XCFramework?

An XCFramework is a distributable binary package created by Xcode that contains variants of a framework or library so that it can be used on multiple platforms (iOS, macOS, tvOS, and watchOS), including Simulator builds. An XCFramework can be either static or dynamic and can include headers.

To use a prebuilt XCFramework, link the target to the XCFramework. Xcode ensures that the target can build against the XCFramework’s headers, link against its binary, and embed it for distribution. If your app has multiple targets (such as app extensions) that use the same XCFramework, you should pick one target (usually your app’s target) to embed the XCFramework and the others should link it without embedding.

Check in the [official Apple documentation](https://help.apple.com/xcode/mac/11.4/#/dev6f6ac218b).

## What is a Swift package?

A Swift package is a folder containing a manifest file and source files used to build software products.

The package manifest (a file named Package.swift at the top level of the package folder) defines the package’s name, products, targets, and dependencies on other packages. The manifest file is written in Swift using API from the Swift Package Manager's PackageDescription library

A package product defines the externally visible build artifact, such as libraries and executables, that are available to clients of a package. A package target defines a test or module from which the products in a package are built. Targets may have dependencies on targets in the same package and dependencies on products from its package dependencies.

A package dependency enables a package target, or Xcode project, to use a product in another package. A package dependency is specified by a URL to the remote Git repository containing the package, and the versions of the package that are supported by the client. The format of a package version uses the Semantic Versioning specification, which is typically a three period-separated integer, such as 2.1.4.

The source files for targets can be written in Swift, C/C++, Objective-C/C++, or assembler, and are located under the Sources folder in the package. Each target can either contain only Swift source code, or any combination of C, C++, Objective-C, Objective-C++, and assembler source code. The source files for Test targets are written using the [XCTest](https://developer.apple.com/documentation/xctest) framework, and are located under the Tests folder.

Check in the [official Apple documentation](https://help.apple.com/xcode/mac/11.4/#/dev5eb834795).

## Advantages of the XCFramework, comparison with the FAT Framework Approach:

* Packing dependencies under all target platforms and architectures into one single bundle from the box
* Connection of the bundle in the format of XCFramework, as a single dependency for all target platforms and architectures
* Missing the need of building fat/universal framework
* No need to get rid of x86_64 slices before uploading end applications to AppStore

Also, with surmagic, you won't need to be an expert on the questions listed below:

* How to create XCFramework in Xcode?
* How to build Universal iOS Frameworks using XCFramework
* XCFramework tutorial
* How do I use XCFramework? 
* What is XCFramework?
* How do I create a custom framework in Swift? 
* How to add XCFramework to Xcode project?
* How do I import framework into Xcode?
* What is Xcode framework? 
* Convert a Universal (FAT) Framework to an XCFramework
* Advances in XCFramework
* Automatic support for Apple Silicon via FAT binaries
* Built-in support for the BCSymbolMaps and dSYMs

## Why not the Swift Package Manager (SPM)?

Well, why not!🤓 It's the easiest! But, Swift PM only allows you to perform the delivery of libs in the form of *open source* code with the description of dependencies.

Apple presented XCFramework as **a new binary format of packing the libs**, considering it as an alternative for [Swift Packages](https://swift.org/package-manager/).

## References

* [WWDC 2020 - 10147 presentation](https://developer.apple.com/videos/play/wwdc2020/10147) 
* [WWDC 2020 - 10170 presentation](https://developer.apple.com/videos/play/wwdc2020/10170)
* [WWDC 2019 - 416 presentation](https://developer.apple.com/videos/play/wwdc2019/416/) 
* [Create an XCFramework](https://help.apple.com/xcode/mac/11.4/#/dev544efab96)
* [Link a target to frameworks and libraries](https://help.apple.com/xcode/mac/11.4/#/dev51a648b07)
* [Distributing Binary Frameworks as Swift Packages](https://developer.apple.com/documentation/swift_packages/distributing_binary_frameworks_as_swift_packages)
* [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app)

## Wiki

If you didn't find what you're looking for, check Surmagic's [Wiki page](https://github.com/gurhub/surmagic/wiki). Or maybe you'll want to improve the Wiki page🤓. Obviously, it's a great idea. 👏🏻

## Contribute to _surmagic_

**🙋🏻‍♂️*Need contribution here!**

*If you want to contribute please check out [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to help with surmagic.

## Contributers

* Muhammed Gurhan Yerlikaya, [gurhanyerlikaya@gmail.com](mailto:gurhanyerlikaya@gmail.com), [@mgyky](https://twitter.com/mgyky)

## License

"Surmagic" is available under the MIT License license. See the [`LICENSE`](LICENSE) file for more info.
