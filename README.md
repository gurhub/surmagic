# Surmagic

🚀 The better way to deal with Binary Frameworks on iOS, Mac Catalyst, tvOS, macOS, and watchOS. Create XCFrameworks with ease.

#### 🙋🏻‍♂️*Need contribution here!*

*If you want to contribute please [contact me](mailto:gurhanyerlikaya@gmail.com).*

- [About](#about)
- [Requirements](#requirements)
- [Installing](#installing-surmagic)
- [Setting up surmagic](#setting-up-surmagic)
- [How to Use](#how-to-use)
- [What is the Surfile](https://github.com/gurhub/surmagic/wiki/What-is-the-Surfile)
- [Passing parameters](#passing-parameters-to-surmagic-command-line-tools)
- [Comparison](#comparison)
  - [Advantages in comparison with the FAT Framework approach](#advantages-in-comparison-with-the-fat-framework-approach)
  - [Why not the Swift Package Manager (spm)?](#why-not-the-swift-package-manager-spm)
- [Uninstalling](https://github.com/gurhub/surmagic/wiki/Uninstalling-surmagic)
- [References](https://github.com/gurhub/surmagic/wiki/References)
- [Todo](#todo)
- [Contribute to Surmagic](#contribute-to-surmagic)
- [Contributers](#contributers)
- [License](#license)
- [Further Reading](https://github.com/gurhub/surmagic/wiki/Further-Reading)


## Wiki

Surmagic's [Wiki page](https://github.com/gurhub/surmagic/wiki) is kind of under conctruction. Anyways, you can take a look if you didn't find what you're looking for or maybe even want to improve the Wiki.

## About

After Xcode 11 now Xcode fully supports using and creating binary frameworks in Swift. Simultaneously support devices and Simulator with the new XCFramework bundle type. XCFrameworks support binary distribution of Swift and C-based code. A single XCFramework can contain a variant for the simulator, and for the device. This means you can ship slices for any of the architectures, including simulator, any Apple OS and even separate slices for UIKit and AppKit apps.

### Requirements

- Xcode 11 and above
- Swift 5.1 and above

## Installing surmagic

### Homebrew (macOS)

[Brew](https://brew.sh) is the Recommended way to install/uninstall the surmagic.

```
brew tap gurhub/surmagic
brew install surmagic
```

This command will install surmagic to your desired bash.

Check the [wiki](https://github.com/gurhub/surmagic/wiki/Installing-surmagic) for installing details.

## Setting up surmagic

Open desired terminal application and enter inside of your project directory's root: 

```
cd [path-on-your-disk]/your-project
```

Use command below to create necessary _surmagic_ directory and files.

``` 
surmagic init
``` 

This will create surmagic directory and a Surfile like below:

- --- your-project
- ------ surmagic
- --------- Surfile

## How to Use

After setting up your directory, and filling mandatory parameters in the [Surfile](https://github.com/gurhub/surmagic/wiki/What-is-the-Surfile) you can simply use:

```
surmagic xcf
```
command to create an XCFramework. Thats it.

### All Aviable Commands and Options

```
USAGE: surmagic <subcommand>

OPTIONS:
  --version               Show the version.
  -h, --help              Show help information.

SUBCOMMANDS:
  init                    Creates the mandatory directory (surmagic) and files.
  xcf (default)           Creates an XCFramework via Surfile.
  See 'surmagic help <subcommand>' for detailed help.
```

## Passing parameters to _surmagic_ command-line tools

Surmagic contains several command-line tools, e.g. **surmagic xcf** or **surmagic init**. To pass parameters to these tools, append the option names and values as you would for a normal shell command:

```
surmagic [tool] --[option] --[option] ...∞

surmagic init
surmagic xcf --verbose
```

## Todo

- [ ] Add surmagic/report.xml for -Xcode build archive- process
- [ ] Add title image **👉Need Contribution here!**
- [ ] Add surmagic env command
- [ ] Update the CONTRIBUTING.md file
- [x] Add logging options like verbose
- [x] Add support for Mac Catalyst
- [x] Add command > surmagic init to create template files
- [x] Add binary under bin directory
- [x] Add arguments > surmagic some

## Contribute to _surmagic_

Check out [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to help with surmagic.

## Contributers

* Muhammed Gurhan Yerlikaya, [gurhanyerlikaya@gmail.com](mailto:gurhanyerlikaya@gmail.com), [@mgyky](https://twitter.com/mgyky)

## License

"Surmagic" is available under the MIT License license. See the [`LICENSE`](LICENSE) file for more info.
