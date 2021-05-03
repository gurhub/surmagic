# Surmagic

🚀 Create XCFrameworks with ease! A Command Line Tool to create XCFrameworks for multiple platforms at one shot! The better way to deal with XCFrameworks for iOS, Mac Catalyst, tvOS, macOS, and watchOS. 

Stop wasting your time with the Universal/Fat Framework Approach. You don't need to update your shell script periodically anymore.

![](https://github.com/gurhub/surmagic/blob/master/assets/surmagic-how-to-use.gif)

- [About](#about)
- [Requirements](#requirements)
- [Installing](#installing-surmagic)
- [Setting up surmagic](https://github.com/gurhub/surmagic/wiki/Setting-up)
- [How To Create an XCFramework](#how-to-create-an-xcframework)
- [What is the Surfile](#what-is-the-surfile)
- [Passing parameters](#how-to-use)
- [Further Reading](#further-reading)
  - [Advantages in comparison with the FAT Framework approach](#further-reading)
  - [Why not the Swift Package Manager (spm)?](#further-reading)
- [Uninstalling](https://github.com/gurhub/surmagic/wiki/Uninstalling-surmagic)
- [References](https://github.com/gurhub/surmagic/wiki/References)
- [Contribute](#contribute-to-surmagic)
- [License](#license)

## About

After Xcode 11 now Xcode fully supports using and creating binary frameworks in Swift. Simultaneously support devices and Simulator with the new XCFramework bundle type. XCFrameworks support the binary distribution of Swift and C-based code. A single XCFramework can contain a variant for the simulator, and for the device. This means you can ship slices for any of the architectures, including simulator, any Apple OS and even separate slices for UIKit and AppKit apps. 

## Requirements

- macOS Version 11.2 and above
- Xcode 12 and above
- Swift 5.1 and above

## Installing surmagic

### Xcode command line tools (macOS)

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

## How To Create an XCFramework

After [setting up your directory](https://github.com/gurhub/surmagic/wiki/Setting-up), and filling mandatory parameters in the [Surfile](https://github.com/gurhub/surmagic/wiki/What-is-the-Surfile) you can simply use:

```bash
$ surmagic xcf
```
command to create an XCFramework. That's it. There are other commands too. Please keep reading.

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

## Further Reading

### Advantages of the XCFramework, comparison with the FAT Framework Approach:

* Packing dependencies under all target platforms and architectures into one single bundle from the box
* Connection of the bundle in the format of XCFramework, as a single dependency for all target platforms and architectures
* Missing the need of building fat/universal framework
* No need to get rid of x86_64 slices before uploading end applications to AppStore

Also, with surmagic, you won't need to be an expert on the questions listed below:

* How to create XCFramework in Xcode?
* How to build Universal iOS Frameworks using XCFrameworks
* XCFramework tutorial
* How do I use XCFramework? 
* What is XCFramework?
* How do I create a custom framework in Swift? 
* How to add XCFramework to Xcode project?
* How do I import framework into Xcode?
* What is Xcode framework? 
* Convert a Universal (FAT) Framework to an XCFramework)
* Advances in XCFrameworks
* Automatic support for Apple Silicon via FAT binaries
* Built-in support for the BCSymbolMaps and dSYMs



### Why not the Swift Package Manager (SPM)?

Well, why not!🤓 It's the easiest! But, Swift PM only allows you to perform the delivery of libs in the form of *open source* code with the description of dependencies.

Apple presented XCFramework as **a new binary format of packing the libs**, considering it as an alternative for [Swift Packages](https://swift.org/package-manager/).

## Wiki

If you didn't find what you're looking for, check Surmagic's [Wiki page](https://github.com/gurhub/surmagic/wiki). Or maybe you'll want to improve the Wiki page🤓. Obviously, it's a great idea. 👏🏻

## Contribute to _surmagic_

**🙋🏻‍♂️*Need contribution here!**

*If you want to contribute please check out [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to help with surmagic.

## Contributers

* Muhammed Gurhan Yerlikaya, [gurhanyerlikaya@gmail.com](mailto:gurhanyerlikaya@gmail.com), [@mgyky](https://twitter.com/mgyky)

## License

"Surmagic" is available under the MIT License license. See the [`LICENSE`](LICENSE) file for more info.
