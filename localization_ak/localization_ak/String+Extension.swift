
import Foundation

extension String {
  func localised() -> String {
    if let path = Bundle.main.path(forResource: "de", ofType: "lproj") {
      guard let bundle = Bundle(path: path) else { return self }
      return NSLocalizedString(self, bundle: bundle, comment: "")
    }
    return self
  }
}





class LocalizationManager {
    static let shared = LocalizationManager()
    private init() {
        // Set the app language at startup
        if let preferredLanguage = UserDefaults.standard.string(forKey: userDefaultsLanguageKey) {
            Bundle.setLanguage(preferredLanguage)
        }
    }
    
    private let userDefaultsLanguageKey = "AppPreferredLanguage"
    
    var currentLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: userDefaultsLanguageKey) ?? "en"
        }
        set {
          if UserDefaults.standard.string(forKey: userDefaultsLanguageKey) == nil {
            UserDefaults.standard.set(Locale.preferredLanguages.first, forKey: userDefaultsLanguageKey)
            Bundle.setLanguage(Locale.preferredLanguages.first ?? newValue)
          }
        }
    }
    
    func localizedString(forKey key: String) -> String {
      let language = LocalizationManager.dynamicLanguageMapping(for: currentLanguage)
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            print("Localization path not found for language: \(language), falling back to English")
            return NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        }
        let bundle = Bundle(path: path)!
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    static func dynamicLanguageMapping(for localeIdentifier: String) -> String {
        let components = localeIdentifier.split(separator: "-")
        if components.count > 1 {
            let baseLanguage = String(components[0])
            if Bundle.main.path(forResource: baseLanguage, ofType: "lproj") != nil {
                return baseLanguage
            }
        }
        return localeIdentifier
    }
}

private var bundleKey: UInt8 = 0

class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}

extension Bundle {
    static func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, BundleEx.self)
        }
      let language = LocalizationManager.dynamicLanguageMapping(for: language)
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"), let bundle = Bundle(path: path) {
            objc_setAssociatedObject(Bundle.main, &bundleKey, bundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            objc_setAssociatedObject(Bundle.main, &bundleKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            print("Localization bundle not found for language: \(language), falling back to main bundle")
        }
    }
}

