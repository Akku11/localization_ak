
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


