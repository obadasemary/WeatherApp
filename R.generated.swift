//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 4 files.
  struct file {
    /// Resource file `DEBUG.plist`.
    static let debugPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "DEBUG", pathExtension: "plist")
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    /// Resource file `RELEASE.plist`.
    static let releasePlist = Rswift.FileResource(bundle: R.hostingBundle, name: "RELEASE", pathExtension: "plist")
    /// Resource file `STAGING.plist`.
    static let stagingPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "STAGING", pathExtension: "plist")
    
    /// `bundle.url(forResource: "DEBUG", withExtension: "plist")`
    static func debugPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.debugPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "RELEASE", withExtension: "plist")`
    static func releasePlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.releasePlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "STAGING", withExtension: "plist")`
    static func stagingPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.stagingPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 0 images.
  struct image {
    /// This `R.image.forecast` struct is generated, and contains static references to 16 images.
    struct forecast {
      /// Image `CloudyBig`.
      static let cloudyBig = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/CloudyBig")
      /// Image `Cloudy`.
      static let cloudy = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/Cloudy")
      /// Image `CurrentPosition`.
      static let currentPosition = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/CurrentPosition")
      /// Image `Divider`.
      static let divider = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/Divider")
      /// Image `LightningBig`.
      static let lightningBig = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/LightningBig")
      /// Image `Lightning`.
      static let lightning = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/Lightning")
      /// Image `LineRainbow`.
      static let lineRainbow = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/LineRainbow")
      /// Image `SunBig`.
      static let sunBig = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/SunBig")
      /// Image `Sun`.
      static let sun = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/Sun")
      /// Image `WIndBig`.
      static let wIndBig = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/WIndBig")
      /// Image `Wind`.
      static let wind = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/Wind")
      /// Image `indicator1`.
      static let indicator1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/indicator1")
      /// Image `indicator2`.
      static let indicator2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/indicator2")
      /// Image `indicator3`.
      static let indicator3 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/indicator3")
      /// Image `indicator4`.
      static let indicator4 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/indicator4")
      /// Image `indicator5`.
      static let indicator5 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Forecast/indicator5")
      
      /// `UIImage(named: "Cloudy", bundle: ..., traitCollection: ...)`
      static func cloudy(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.cloudy, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "CloudyBig", bundle: ..., traitCollection: ...)`
      static func cloudyBig(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.cloudyBig, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "CurrentPosition", bundle: ..., traitCollection: ...)`
      static func currentPosition(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.currentPosition, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "Divider", bundle: ..., traitCollection: ...)`
      static func divider(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.divider, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "Lightning", bundle: ..., traitCollection: ...)`
      static func lightning(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.lightning, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "LightningBig", bundle: ..., traitCollection: ...)`
      static func lightningBig(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.lightningBig, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "LineRainbow", bundle: ..., traitCollection: ...)`
      static func lineRainbow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.lineRainbow, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "Sun", bundle: ..., traitCollection: ...)`
      static func sun(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.sun, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "SunBig", bundle: ..., traitCollection: ...)`
      static func sunBig(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.sunBig, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "WIndBig", bundle: ..., traitCollection: ...)`
      static func wIndBig(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.wIndBig, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "Wind", bundle: ..., traitCollection: ...)`
      static func wind(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.wind, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "indicator1", bundle: ..., traitCollection: ...)`
      static func indicator1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.indicator1, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "indicator2", bundle: ..., traitCollection: ...)`
      static func indicator2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.indicator2, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "indicator3", bundle: ..., traitCollection: ...)`
      static func indicator3(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.indicator3, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "indicator4", bundle: ..., traitCollection: ...)`
      static func indicator4(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.indicator4, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "indicator5", bundle: ..., traitCollection: ...)`
      static func indicator5(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.forecast.indicator5, compatibleWith: traitCollection)
      }
      
      fileprivate init() {}
    }
    
    /// This `R.image.tabMenu` struct is generated, and contains static references to 4 images.
    struct tabMenu {
      /// Image `TabForecastSelected`.
      static let tabForecastSelected = Rswift.ImageResource(bundle: R.hostingBundle, name: "TabMenu/TabForecastSelected")
      /// Image `TabForecast`.
      static let tabForecast = Rswift.ImageResource(bundle: R.hostingBundle, name: "TabMenu/TabForecast")
      /// Image `TabTodaySelected`.
      static let tabTodaySelected = Rswift.ImageResource(bundle: R.hostingBundle, name: "TabMenu/TabTodaySelected")
      /// Image `TabToday`.
      static let tabToday = Rswift.ImageResource(bundle: R.hostingBundle, name: "TabMenu/TabToday")
      
      /// `UIImage(named: "TabForecast", bundle: ..., traitCollection: ...)`
      static func tabForecast(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.tabMenu.tabForecast, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "TabForecastSelected", bundle: ..., traitCollection: ...)`
      static func tabForecastSelected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.tabMenu.tabForecastSelected, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "TabToday", bundle: ..., traitCollection: ...)`
      static func tabToday(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.tabMenu.tabToday, compatibleWith: traitCollection)
      }
      
      /// `UIImage(named: "TabTodaySelected", bundle: ..., traitCollection: ...)`
      static func tabTodaySelected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.tabMenu.tabTodaySelected, compatibleWith: traitCollection)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `ForecastCell`.
    static let forecastCell: Rswift.ReuseIdentifier<ForecastCell> = Rswift.ReuseIdentifier(identifier: "ForecastCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `Forecast`.
    static let forecast = _R.storyboard.forecast()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `MainTabController`.
    static let mainTabController = _R.storyboard.mainTabController()
    /// Storyboard `Today`.
    static let today = _R.storyboard.today()
    
    /// `UIStoryboard(name: "Forecast", bundle: ...)`
    static func forecast(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.forecast)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "MainTabController", bundle: ...)`
    static func mainTabController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.mainTabController)
    }
    
    /// `UIStoryboard(name: "Today", bundle: ...)`
    static func today(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.today)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try today.validate()
      try forecast.validate()
      try mainTabController.validate()
    }
    
    struct forecast: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "Forecast"
      
      static func validate() throws {
        if UIKit.UIImage(named: "TabMenu/TabForecastSelected") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'TabMenu/TabForecastSelected' is used in storyboard 'Forecast', but couldn't be loaded.") }
        if UIKit.UIImage(named: "TabMenu/TabForecast") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'TabMenu/TabForecast' is used in storyboard 'Forecast', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct mainTabController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MainTabController
      
      let bundle = R.hostingBundle
      let mainTabController = StoryboardViewControllerResource<MainTabController>(identifier: "MainTabController")
      let name = "MainTabController"
      
      func mainTabController(_: Void = ()) -> MainTabController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainTabController)
      }
      
      static func validate() throws {
        if _R.storyboard.mainTabController().mainTabController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mainTabController' could not be loaded from storyboard 'MainTabController' as 'MainTabController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct today: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let name = "Today"
      
      static func validate() throws {
        if UIKit.UIImage(named: "TabMenu/TabToday") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'TabMenu/TabToday' is used in storyboard 'Today', but couldn't be loaded.") }
        if UIKit.UIImage(named: "TabMenu/TabTodaySelected") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'TabMenu/TabTodaySelected' is used in storyboard 'Today', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
