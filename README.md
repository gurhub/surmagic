# Surmagic

🚀 The better way to deal with Binary Frameworks on iOS, Mac Catalyst, tvOS, macOS, and watchOS. Create XCFrameworks with ease.

#### *Need contribution here!*

*If you want to contribute please [contact me](mailto:gurhanyerlikaya@gmail.com).*

- [About](#about)
- [Requirements](#requirements)
- [Installing](#installing-surmagic)
- [Setting up surmagic](#setting-up-surmagic)
- [What is the Surfile](#what-is-the-surfile)
- [Comparison](#comparison)
  - [Advantages in comparison with the FAT Framework approach](#advantages-in-comparison-with-the-fat-framework-approach)
  - [Why not the Swift Package Manager (spm)?](#why-not-the-swift-package-manager-spm)
- [References](#references)
- [Todo](#todo)
- [Communication](#communication)
- [Contribute to Surmagic](#contribute-to-surmagic)
- [Contributers](#contributers)
- [License](#license)

## About

After Xcode 11 now Xcode fully supports using and creating binary frameworks in Swift. Simultaneously support devices and Simulator with the new XCFramework bundle type. XCFrameworks support binary distribution of Swift and C-based code. A single XCFramework can contain a variant for the simulator, and for the device. This means you can ship slices for any of the architectures, including simulator, any Apple OS and even separate slices for UIKit and AppKit apps.

### Requirements

- Xcode 11 and above
- Swift 5.1 and above

## Installing surmagic

### Homebrew (macOS)

Brew is the Recommended way to install the surmagic.

```
brew tap gurhub/surmagic
brew install surmagic
```

This command will install surmagic to your desired bash.

## Setting up surmagic

Open desired terminal application and enter inside of your project directory's root. 

cd Developer/your-project

Use command below to create necessary _surmagic_ directory and files.

> surmagic init

This will create surmagic directory and a Surfile like below:

- --- your-project
- ------ surmagic
- --------- Surfile

## What is the Surfile

It's a standart Plist (XML) file.

```
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
  </array>
</dict>
```

##### sdk Options 

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

## Comparison

### Advantages in comparison with the FAT Framework approach:

* Packing dependencies under all target platforms and architectures into one single bundle from the box

* Connection of the bundle in the format of XCFramework, as a single dependency for all target platforms and architectures

* Missing the need of building fat/universal framework

* No need to get rid of x86_64 slices before uploading end applications to AppStore

### Why not the Swift Package Manager (SPM)?

Well, why not!🤓 It's the easiest! But, Swift PM only allows you to perform the delivery of libs in the form of *open source* code with the description of dependencies.

Apple presented XCFramework as **a new binary format of packing the libs**, considering it as an alternative for Swift Packages.

## References

* [WWDC 2020 - 10147 presentation](https://developer.apple.com/videos/play/wwdc2020/10147) 
* [WWDC 2020 - 10170 presentation](https://developer.apple.com/videos/play/wwdc2020/10170)
* [WWDC 2019 - 416 presentation](https://developer.apple.com/videos/play/wwdc2019/416/) 
* [Create an XCFramework](https://help.apple.com/xcode/mac/11.4/#/dev544efab96)
* [Link a target to frameworks and libraries](https://help.apple.com/xcode/mac/11.4/#/dev51a648b07)

## Todo

- [ ] Add surmagic/report.xml for -Xcode build archive- process
- [ ] Add support for Mac Catalyst
- [ ] Add logging options like verbose
- [ ] Add title image **👉Need Contribution here!**
- [x] Add command > surmagic init to create template files
- [x] Add binary under bin directory
- [x] Add arguments > surmagic some

## Communication

If you see a way to improve the project :

- If you **need help**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/surmagic). (Tag `surmagic`)
- If you'd like to **ask a general question**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/surmagic).
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an [issue](https://github.com/gurhub/surmagic/issues).
- If you **have a feature request**, open an [issue](https://github.com/gurhub/surmagic/issues).
- If you **want to contribute**, submit a [pull request](https://github.com/gurhub/surmagic/pulls). It's better to begin with an [issue](https://github.com/gurhub/surmagic/issues) rather than a [pull request](https://github.com/gurhub/surmagic/pulls), though, because we might disagree whether the proposed change is an actual improvement. :wink:

Thanks! :v:

## Contribute to _surmagic_

Check out [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to help with surmagic.

## Contributers

* Muhammed Gurhan Yerlikaya, [gurhanyerlikaya@gmail.com](mailto:gurhanyerlikaya@gmail.com), [@mgyky](https://twitter.com/mgyky)

## License

"Surmagic" is available under the MIT License license. See the [`LICENSE`](LICENSE) file for more info.
