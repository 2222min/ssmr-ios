// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum CommonUIFontFamily {
  public enum AppleSDGothicNeoB00 {
    public static let regular = CommonUIFontConvertible(name: "AppleSDGothicNeoB00", family: "AppleSDGothicNeoB00", path: "AppleSDGothicNeoBold.ttf")
    public static let all: [CommonUIFontConvertible] = [regular]
  }
  public enum AppleSDGothicNeoEB00 {
    public static let regular = CommonUIFontConvertible(name: "AppleSDGothicNeoEB00", family: "AppleSDGothicNeoEB00", path: "AppleSDGothicNeoExtraBold.ttf")
    public static let all: [CommonUIFontConvertible] = [regular]
  }
  public enum AppleSDGothicNeoL00 {
    public static let regular = CommonUIFontConvertible(name: "AppleSDGothicNeoL00", family: "AppleSDGothicNeoL00", path: "AppleSDGothicNeoLight.ttf")
    public static let all: [CommonUIFontConvertible] = [regular]
  }
  public enum AppleSDGothicNeoM00 {
    public static let regular = CommonUIFontConvertible(name: "AppleSDGothicNeoM00", family: "AppleSDGothicNeoM00", path: "AppleSDGothicNeoMedium.ttf")
    public static let all: [CommonUIFontConvertible] = [regular]
  }
  public static let allCustomFonts: [CommonUIFontConvertible] = [AppleSDGothicNeoB00.all, AppleSDGothicNeoEB00.all, AppleSDGothicNeoL00.all, AppleSDGothicNeoM00.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct CommonUIFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return Bundle.module.url(forResource: path, withExtension: nil)
  }
}

public extension CommonUIFontConvertible.Font {
  convenience init?(font: CommonUIFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}
// swiftlint:enable all
// swiftformat:enable all
