# Surmagic

🚀 The better way to deal with Binary Frameworks on iOS, macOS, tvOS, watchOS. Create XCFrameworks with ease.

#### Need contribution here! 

If you want to contribute please [contact me](mailto:gurhanyerlikaya@gmail.com).

## About

After Xcode 11 now Xcode fully supports using and creating binary frameworks in Swift. Simultaneously support devices and Simulator with the new XCFramework bundle type. XCFrameworks support binary distribution of Swift and C-based code. 

- [Installing](#installing-surmagic)
- [Setting up surmagic](#setting-up-surmagic)
- [About the Surfile](#about-the-surfile)
- [Todo](#todo)
- [Communication](#communication)
- [Contribute to Surmagic](#contribute-to-surmagic)
- [Contributers](#contributers)
- [License](#license)

## Installing surmagic

### Homebrew (macOS)

Brew is the Recommended way to install the surmagic.

> brew surmagic

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

## About the Surfile

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

### sdk Options 

* iOS
* iOSSimulator
* macOS
* tvOS
* tvOSSimulator
* watchOS
* watchSimulator

## Todo

- [ ] Add surmagic/report.xml for -Xcode build archive- process
- [ ] Add logging options like verbose
- [ ] Add title image **👉Need Contribution here!**
- [x] Add command > surmagic init to create template files
- [x] Add binary under bin directory
- [x] Add arguments > surmagic some

## Communication

If you see a way to improve the project :

- If you **need help**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/ios-universal-framework). (Tag `ios-universal-framework`)
- If you'd like to **ask a general question**, use [Stack Overflow](https://stackoverflow.com/questions/tagged/ios-universal-framework).
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an [issue](https://github.com/gurhub/universal-framework/issues).
- If you **have a feature request**, open an [issue](https://github.com/gurhub/universal-framework/issues).
- If you **want to contribute**, submit a [pull request](https://github.com/gurhub/universal-framework/pulls). It's better to begin with an [issue](https://github.com/gurhub/universal-framework/issues) rather than a [pull request](https://github.com/gurhub/universal-framework/pulls), though, because we might disagree whether the proposed change is an actual improvement. :wink:

Thanks! :v:

## Contribute to _surmagic_

Check out [CONTRIBUTING.md](CONTRIBUTING.md) for more information on how to help with surmagic.

## Contributers

* Muhammed Gurhan Yerlikaya, [gurhanyerlikaya@gmail.com](mailto:gurhanyerlikaya@gmail.com), [@mgyky](https://twitter.com/mgyky)

## License

"universal-framework" is available under the GNU General Public License v3.0 license. See the [`LICENSE`](LICENSE) file for more info.
