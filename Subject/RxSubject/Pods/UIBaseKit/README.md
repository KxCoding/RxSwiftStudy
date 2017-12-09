# UIBaseKit

![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/UIBaseKit.svg?style=flat)](http://cocoapods.org/pods/UIBaseKit)
[![License](https://img.shields.io/cocoapods/l/UIBaseKit.svg?style=flat)](http://cocoapods.org/pods/UIBaseKit)
[![Platform](https://img.shields.io/cocoapods/p/UIBaseKit.svg?style=flat)](http://cocoapods.org/pods/UIBaseKit)

🤔So far, when coding for a view, we wrote a combination of configuration code, constraint code, and hierarchical code, resulting in a poor understanding of the source. So, I created a library that helps you separate this configuration code, constraint code, and hierarchical code to make it cleaner.

## Usage

### QuickStart

After inheriting from `BaseViewController`, override and implement the `setupViews`  and `setupConstraints` methods.

```swift

import UIKit
import UIBaseKit

class SignUpViewController: BaseViewController {
  // MARK: - UI
  var usernameLabel: UILabel = {
    $0.textColor = .black
    $0.textAlignment = .right
    $0.font = .boldSystemFont(ofSize: 16.0)
    $0.text = "Username"
    return $0
  }(UILabel())

  ...

  var emailLabel: UILabel = {
    $0.textColor = .black
    $0.textAlignment = .right
    $0.font = .boldSystemFont(ofSize: 16.0)
    $0.text = "Email"
    return $0
  }(UILabel())

  ...

  /// After configure propertys for each view,
  /// return an array of views to add to the superview in desired order.
  override func setupViews() -> [CanBeSubview]? {
    // 1) configure views
    view.backgroundColor = .white
    registerKeyboardObservers()
    signUpButton.addTarget(self, action: #selector(signUpButtonDidTouch), for: .touchUpInside)

    ...

    // 2) return subviews
    /** 😍 viewController`s view hierarchy
      → keyboardAvoidView
         → containerView
             → usernameLabel
             → usernameTextField
             → emailLabel
             → emailTextField
             → passwordLabel
             → passwordTextField
      → signUpButton
    */
    let hierarchy = [
      keyboardAvoidView.addSubviews(
        containerView.addSubviews(
          usernameLabel,
          usernameTextField,
          emailLabel,
          emailTextField,
          passwordLabel,
          passwordTextField
        )
      ),
      signUpButton
    ]
    return hierarchy
  }

  /// Configure the constraints for each view.
  override func setupConstraints() {
    // 3) set constraints for each view added to superview.
    // 🤓Note: I set constraints for each view using my favorite `FluidAnchor` library.
    // https://github.com/audrl1010/FluidAnchor

    keyboardAvoidView.flu
      .leftAnchor(equalTo: view.leftAnchor)
      .topAnchor(equalTo: view.topAnchor)
      .rightAnchor(equalTo: view.rightAnchor)
      .bottomAnchor(equalTo: view.bottomAnchor)

    containerView.flu
      .topAnchor(equalTo: view.topAnchor, constant: 60)
      .leftAnchor(equalTo: view.leftAnchor, constant: 15)
      .rightAnchor(equalTo: view.rightAnchor, constant: -15)
      .heightAnchor(equalToConstant: 180)
    
      ...
  }
}
```

## Support Classes
```swift
class BaseView: UIView { ... }
class BaseTableViewCell: UITableViewCell { ... }
class BaseCollectionViewCell: UICollectionViewCell { ... }
class BaseViewController: UIViewController { ... }
```
## Installation

```ruby
pod 'UIBaseKit'
```

## Author

Myung gi son, audrl1010@naver.com

## License

UIBaseKit is available under the MIT license. See the LICENSE file for more info.
