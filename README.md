# XDUICommon :iphone:

Use XDUICommon in Swift projects to import boilerplate view controller code such as TableViewController and CollectionViewController.

## Installation

Using version 1.1.1 or above of Cocoapods, add XDUICommon to your podfile then run `pod install`.

## Swift Versions

- For Swift 3: `pod 'XDUICommon', '< 2.0'`
- For Swift 4: `pod 'XDUICommon', '>= 2.0'`

## Development

If you wish to make changes to XDUICommon:

1. Add the private pod specs repo to your cocoapods installation (if you have not already): `pod repo add xdesign-specs git@bitbucket.org:xdesign365/podspecs.git`
2. Update the version number of the pod in XDUICommon.podspec
3. Create a git tag for the new version, and push it to master. E.g. `git tag 1.0.2 && git push origin --tags`
4. Validate the podspec: `pod lib lint XDUICommon.podspec --verbose --no-clean --swift-version=4.0`
5. Publish the pod (to xDesign's private spec repo): `pod repo push xdesign-specs --allow-warnings --verbose --swift-version=4.0`
