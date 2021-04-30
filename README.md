# Surmagic

🚀 Create XCFrameworks with ease! A Command Line Tool to create XCFrameworks for multiple platforms at one shot! The better way to deal with XCFrameworks for iOS, Mac Catalyst, tvOS, macOS, and watchOS. 

Stop wasting your time with the Universal/Fat Framework Approach. You don't need to update your shell script periodically anymore.

![](https://github.com/gurhub/surmagic/blob/master/assets/surmagic-how-to-use.gif)

- [About](#about)
- [Requirements](#requirements)
- [Installing](#installing-surmagic)
- [Setting up surmagic](https://github.com/gurhub/surmagic/wiki/Setting-up)
- [How to Use](#how-to-use)
- [What is the Surfile](https://github.com/gurhub/surmagic/wiki/What-is-the-Surfile)
- [Passing parameters](https://github.com/gurhub/surmagic/wiki/How-to-Use)
- [Further Reading](https://github.com/gurhub/surmagic/wiki/Further-Reading)
  - [Advantages in comparison with the FAT Framework approach](https://github.com/gurhub/surmagic/wiki/Further-Reading)
  - [Why not the Swift Package Manager (spm)?](https://github.com/gurhub/surmagic/wiki/Further-Reading)
- [Uninstalling](https://github.com/gurhub/surmagic/wiki/Uninstalling-surmagic)
- [References](https://github.com/gurhub/surmagic/wiki/References)
- [Contribute](#contribute-to-surmagic)
- [License](#license)
- [Further Reading](https://github.com/gurhub/surmagic/wiki/Further-Reading)

## About

After Xcode 11 now Xcode fully supports using and creating binary frameworks in Swift. Simultaneously support devices and Simulator with the new XCFramework bundle type. XCFrameworks support the binary distribution of Swift and C-based code. A single XCFramework can contain a variant for the simulator, and for the device. This means you can ship slices for any of the architectures, including simulator, any Apple OS and even separate slices for UIKit and AppKit apps. 

With this library, you won't need to be an expert on the questions listed below:

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

### Requirements

- macOS Version 11.2 and above
- Xcode 12 and above
- Swift 5.1 and above

## Installing surmagic

### Homebrew (macOS)

[Brew](https://brew.sh) is the Recommended way to install/uninstall the surmagic.


```bash
$ brew tap gurhub/surmagic
$ brew install surmagic
```

This command will install surmagic to your desired bash.

Then, check the [How to Use](#how-to-use) section on the Wiki.

# How to Use

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

## Wiki

If you didn't find what you're looking for, check Surmagic's [Wiki page](https://github.com/gurhub/surmagic/wiki). Or maybe you'll want to improve the Wiki page🤓. Obviously, it's a great idea. 👏🏻

## Contribute to _surmagic_

**🙋🏻‍♂️*Need contribution here!**

*If you want to contribute please check out [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to help with surmagic.

## Contributers

* Muhammed Gurhan Yerlikaya, [gurhanyerlikaya@gmail.com](mailto:gurhanyerlikaya@gmail.com), [@mgyky](https://twitter.com/mgyky)

## License

"Surmagic" is available under the MIT License license. See the [`LICENSE`](LICENSE) file for more info.
