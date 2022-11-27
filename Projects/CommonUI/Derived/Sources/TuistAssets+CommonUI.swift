// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum CommonUIAsset {
  public static let black = CommonUIColors(name: "black")
  public static let blackGrey = CommonUIColors(name: "blackGrey")
  public static let cream = CommonUIColors(name: "cream")
  public static let deepGrey = CommonUIColors(name: "deepGrey")
  public static let grey = CommonUIColors(name: "grey")
  public static let mBlue = CommonUIColors(name: "m-blue")
  public static let mGreen = CommonUIColors(name: "m-green")
  public static let mLighBlue = CommonUIColors(name: "m-lighBlue")
  public static let mLightGreen = CommonUIColors(name: "m-lightGreen")
  public static let mRedLighRed = CommonUIColors(name: "m-red-lighRed")
  public static let mRed = CommonUIColors(name: "m-red")
  public static let pointColor = CommonUIColors(name: "pointColor")
  public static let white = CommonUIColors(name: "white")
  public static let whiteGrey = CommonUIColors(name: "whiteGrey")
  public static let approveImage = CommonUIImages(name: "approveImage")
  public static let chevronDownSelected = CommonUIImages(name: "chevron-down-selected")
  public static let chevronDown = CommonUIImages(name: "chevron-down")
  public static let closeImage = CommonUIImages(name: "closeImage")
  public static let disapproveImage = CommonUIImages(name: "disapproveImage")
  public static let informationMark = CommonUIImages(name: "information Mark")
  public static let informationMarkBold = CommonUIImages(name: "informationMarkBold")
  public static let chevronLeft = CommonUIImages(name: "chevron-left")
  public static let cautionImage = CommonUIImages(name: "cautionImage")
  public static let checkImage = CommonUIImages(name: "checkImage")
  public static let dotImage8 = CommonUIImages(name: "dot_Image_8")
  public static let onboarding1 = CommonUIImages(name: "onboarding_1")
  public static let onboarding2 = CommonUIImages(name: "onboarding_2")
  public static let onboarding3 = CommonUIImages(name: "onboarding_3")
  public static let selectedDot = CommonUIImages(name: "selectedDot")
  public static let splashIOS = CommonUIImages(name: "splash_iOS")
  public static let watchImage = CommonUIImages(name: "watchImage")
  public static let celebrationImage = CommonUIImages(name: "celebrationImage")
  public static let diceImage = CommonUIImages(name: "diceImage")
  public static let dotImage = CommonUIImages(name: "dotImage")
  public static let eyeOffImage = CommonUIImages(name: "eyeOffImage")
  public static let eyeOnImage = CommonUIImages(name: "eyeOnImage")
  public static let rightArrowImage = CommonUIImages(name: "rightArrowImage")
  public static let speechBalloonImage = CommonUIImages(name: "speechBalloonImage")
  public static let homeIcon = CommonUIImages(name: "homeIcon")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class CommonUIColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension CommonUIColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: CommonUIColors) {
    let bundle = CommonUIResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct CommonUIImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = CommonUIResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension CommonUIImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the CommonUIImages.image property")
  convenience init?(asset: CommonUIImages) {
    #if os(iOS) || os(tvOS)
    let bundle = CommonUIResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
