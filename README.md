# Surmagic

🚀 The better way to deal with Binary Frameworks on iOS, Mac Catalyst, tvOS, macOS, and watchOS. Create XCFrameworks with ease. Stop wasting your time with the Universal/Fat Framework Approach. You don't need to update your shell script periodically anymore.

- [About](#about)
- [Requirements](#requirements)
- [Installing](#installing-surmagic)
- [Setting up surmagic](https://github.com/gurhub/surmagic/wiki/Setting-up)
- [How to Use](https://github.com/gurhub/surmagic/wiki/How-to-Use)
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

After Xcode 11 now Xcode fully supports using and creating binary frameworks in Swift. Simultaneously support devices and Simulator with the new XCFramework bundle type. XCFrameworks support binary distribution of Swift and C-based code. A single XCFramework can contain a variant for the simulator, and for the device. This means you can ship slices for any of the architectures, including simulator, any Apple OS and even separate slices for UIKit and AppKit apps.

### Requirements

- macOS Version 11.0.1 and above
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

Then, check the [How to Use](https://github.com/gurhub/surmagic/wiki/How-to-Use) section on the Wiki.

![](https://github.com/gurhub/surmagic/blob/master/assets/surmagic-how-to-use.gif)

## Wiki

If you didn't find what you're looking for, check Surmagic's [Wiki page](https://github.com/gurhub/surmagic/wiki). Or maybe you'll want to improve the Wiki page🤓. Obviously is a great idea. 👏🏻

## Contribute to _surmagic_

**🙋🏻‍♂️*Need contribution here!**

*If you want to contribute please check out [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to help with surmagic.

## Contributers

* Muhammed Gurhan Yerlikaya, [gurhanyerlikaya@gmail.com](mailto:gurhanyerlikaya@gmail.com), [@mgyky](https://twitter.com/mgyky)

## License

"Surmagic" is available under the MIT License license. See the [`LICENSE`](LICENSE) file for more info.
