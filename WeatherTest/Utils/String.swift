//
//  String.swift
//  Pods
//
//  Created by Admin on 11/24/16.
//
//

import Foundation
import UIKit

public extension StringProtocol where Index == String.Index {

    /// SwifterSwift: The longest common suffix.
    ///
    ///        "Hello world!".commonSuffix(with: "It's cold!") = "ld!"
    ///
    /// - Parameters:
    ///     - Parameter aString: The string with which to compare the receiver.
    ///     - Parameter options: Options for the comparison.
    /// - Returns: The longest common suffix of the receiver and the given String
    public func commonSuffix<T: StringProtocol>(with aString: T, options: String.CompareOptions = []) -> String {
        let reversedSuffix = String(reversed()).commonPrefix(with: String(aString.reversed()), options: options)
        return String(reversedSuffix.reversed())
    }

}

public extension String {

    func dayOfWeek(s: String) -> String {

        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let yourDate = dayFormatter.date(from: s)

        dayFormatter.dateFormat = "EEEE"
        let dayName = dayFormatter.string(from: yourDate!)
        
        return dayName.uppercased()
    }

    func dayOfItems(s: String) -> String {

        let fiterFormatter = DateFormatter()
        fiterFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let filterDate = fiterFormatter.date(from: s)
        fiterFormatter.dateFormat = "EEEE"

        let filterName = fiterFormatter.string(from: filterDate!)

        return filterName
    }

    /// SwifterSwift: String decoded from base64 (if applicable).
    ///
    ///        "SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
    ///
    public var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }

    /// SwifterSwift: String encoded in base64 (if applicable).
    ///
    ///        "Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
    ///
    public var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }

    /// SwifterSwift: Array of characters of a string.
    ///
    public var charactersArray: [Character] {
        return Array(self)
    }

    /// SwifterSwift: CamelCase of string.
    ///
    ///        "sOme vAriable naMe".camelCased -> "someVariableName"
    ///
    public var camelCased: String {
        let source = lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }

    /// SwifterSwift: Check if string contains one or more emojis.
    ///
    ///        "Hello 😀".containEmoji -> true
    ///
    public var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
                 0x1D000...0x1F77F, // Emoticons
                 0x2100...0x27BF, // Misc symbols and Dingbats
                 0xFE00...0xFE0F, // Variation Selectors
                 0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }

    /// SwifterSwift: First character of string (if applicable).
    ///
    ///        "Hello".firstCharacterAsString -> Optional("H")
    ///        "".firstCharacterAsString -> nil
    ///
    public var firstCharacterAsString: String? {
        guard let first = self.first else { return nil }
        return String(first)
    }

    /// SwifterSwift: Check if string contains one or more letters.
    ///
    ///        "123abc".hasLetters -> true
    ///        "123".hasLetters -> false
    ///
    public var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }

    /// SwifterSwift: Check if string contains one or more numbers.
    ///
    ///        "abcd".hasNumbers -> false
    ///        "123abc".hasNumbers -> true
    ///
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }

    /// SwifterSwift: Check if string contains only letters.
    ///
    ///        "abc".isAlphabetic -> true
    ///        "123abc".isAlphabetic -> false
    ///
    public var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }

    /// SwifterSwift: Check if string contains at least one letter and one number.
    ///
    ///        // useful for passwords
    ///        "123abc".isAlphaNumeric -> true
    ///        "abc".isAlphaNumeric -> false
    ///
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }

    /// SwifterSwift: Check if string is valid email format.
    ///
    ///        "john@doe.com".isEmail -> true
    ///
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return self.matches(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }

    /// SwifterSwift: Check if string is a valid URL.
    ///
    ///        "https://google.com".isValidUrl -> true
    ///
    public var isValidUrl: Bool {
        return URL(string: self) != nil
    }

    /// SwifterSwift: Check if string is a valid schemed URL.
    ///
    ///        "https://google.com".isValidSchemedUrl -> true
    ///        "google.com".isValidSchemedUrl -> false
    ///
    public var isValidSchemedUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil
    }

    /// SwifterSwift: Check if string is a valid https URL.
    ///
    ///        "https://google.com".isValidHttpsUrl -> true
    ///
    public var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "https"
    }

    /// SwifterSwift: Check if string is a valid http URL.
    ///
    ///        "http://google.com".isValidHttpUrl -> true
    ///
    public var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http"
    }

    /// SwifterSwift: Check if string is a valid file URL.
    ///
    ///        "file://Documents/file.txt".isValidFileUrl -> true
    ///
    public var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }

    /// SwifterSwift: Check if string is a valid Swift number.
    ///
    /// Note:
    /// In North America, "." is the decimal separator,
    /// while in many parts of Europe "," is used,
    ///
    ///        "123".isNumeric -> true
    ///     "1.3".isNumeric -> true (en_US)
    ///     "1,3".isNumeric -> true (fr_FR)
    ///        "abc".isNumeric -> false
    ///
    public var isNumeric: Bool {
        let scanner = Scanner(string: self)
        scanner.locale = NSLocale.current
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }

    /// SwifterSwift: Check if string only contains digits.
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    public var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }

    /// SwifterSwift: Last character of string (if applicable).
    ///
    ///        "Hello".lastCharacterAsString -> Optional("o")
    ///        "".lastCharacterAsString -> nil
    ///
    public var lastCharacterAsString: String? {
        guard let last = self.last else { return nil }
        return String(last)
    }

    /// SwifterSwift: Latinized string.
    ///
    ///        "Hèllö Wórld!".latinized -> "Hello World!"
    ///
    public var latinized: String {
        return folding(options: .diacriticInsensitive, locale: Locale.current)
    }

    /// SwifterSwift: Bool value from string (if applicable).
    ///
    ///        "1".bool -> true
    ///        "False".bool -> false
    ///        "Hello".bool = nil
    ///
    public var bool: Bool? {
        let selfLowercased = trimmed.lowercased()
        if selfLowercased == "true" || selfLowercased == "1" {
            return true
        } else if selfLowercased == "false" || selfLowercased == "0" {
            return false
        }
        return nil
    }

    /// SwifterSwift: Date object from "yyyy-MM-dd" formatted string.
    ///
    ///        "2007-06-29".date -> Optional(Date)
    ///
    public var date: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: selfLowercased)
    }

    /// SwifterSwift: Date object from "yyyy-MM-dd HH:mm:ss" formatted string.
    ///
    ///        "2007-06-29 14:23:09".dateTime -> Optional(Date)
    ///
    public var dateTime: Date? {
        let selfLowercased = trimmed.lowercased()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: selfLowercased)
    }

    /// SwifterSwift: Integer value from string (if applicable).
    ///
    ///        "101".int -> 101
    ///
    public var int: Int? {
        return Int(self)
    }

    /// SwifterSwift: Lorem ipsum string of given length.
    ///
    /// - Parameter length: number of characters to limit lorem ipsum to (default is 445 - full lorem ipsum).
    /// - Returns: Lorem ipsum dolor sit amet... string.
    public static func loremIpsum(ofLength length: Int = 445) -> String {
        guard length > 0 else { return "" }

        // https://www.lipsum.com/
        let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        if loremIpsum.count > length {
            return String(loremIpsum[loremIpsum.startIndex..<loremIpsum.index(loremIpsum.startIndex, offsetBy: length)])
        }
        return loremIpsum
    }

    /// SwifterSwift: URL from string (if applicable).
    ///
    ///        "https://google.com".url -> URL(string: "https://google.com")
    ///        "not url".url -> nil
    ///
    public var url: URL? {
        return URL(string: self)
    }

    /// SwifterSwift: String with no spaces or new lines in beginning and end.
    ///
    ///        "   hello  \n".trimmed -> "hello"
    ///
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// SwifterSwift: Readable string from a URL string.
    ///
    ///        "it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    public var urlDecoded: String {
        return removingPercentEncoding ?? self
    }

    /// SwifterSwift: URL escaped string.
    ///
    ///        "it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    public var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    /// SwifterSwift: String without spaces and new lines.
    ///
    ///        "   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
    ///
    public var withoutSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }

    /// SwifterSwift: Check if the given string contains only white spaces
    public var isWhitespace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    public var escapedForXML: String {
        // & needs to go first, otherwise other replacements will be replaced again
        let htmlEscapes = [
            ("&", "&amp;"),
            ("\"", "&quot;"),
            ("'", "&apos;"),
            (">", "&gt;"),
            ("<", "&lt;")
        ]
        var newString = self
        for (key, value) in htmlEscapes {
            newString = newString.replacingOccurrences(of: key, with: value)
        }
        return newString
    }

    public func stripHTML() -> String? {
        return self.data?.attributedString?.string
    }

    /// The collection of Latin letters and Arabic digits or a text constructed from this collection.
    public enum RandomStringType {
        /// The character set with 36 (`A-Z+0-9`, case insensitive) or 62 (`A-Z+a-z+0-9`, case-sensitive) alphanumeric characters.
        case alphanumeric(caseSensitive: Bool)
        /// The character set with 26 (`A-Z`, case insensitive) or 52 (`A-Z+a-z`, case-sensitive) Latin letters.
        case alphabetic(caseSensitive: Bool)
        /// The character set with 10 (`0-9`) Arabic digits.
        case numeric

        fileprivate var characterSet: String {
            switch self {
            case .alphanumeric(true): return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            case .alphanumeric(false): return "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            case .alphabetic(true): return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            case .alphabetic(false): return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            case .numeric: return "0123456789"
            }
        }
    }

    /**
     Creates a new string with randomized characters.

     - parameter random: The desired randomized character set.
     - parameter length: The desired length of a string.
     - parameter nonRepeating: The boolean value that determines whether characters in the initialized can or cannot be repeated. The default value is `false`. If `true` and length is greater than number of characters in selected character set, then string with maximum allowed length will be produced.
     - returns: The new string with randomized characters.
     */
    public init(random: RandomStringType, length: Int, nonRepeating: Bool = false) {
        var letters = random.characterSet

        var length = length
        if length > random.characterSet.length, nonRepeating {
            length = random.characterSet.length
        }

        var string = ""

        while string.length < length {
            let index = letters.characters.index(letters.startIndex, offsetBy: Int(arc4random_uniform(UInt32(letters.length))))
            let letter = letters[index]
            string.append(letter)
            if nonRepeating {
                letters.remove(at: index)
            }
        }

        self = string
    }

    /**
     Creates a new string with a path for the specified directories in the user's home directory.

     - parameter directory: The location of a variety of directories
     - note: The directory returned by this method may not exist. This method simply gives you the appropriate location for the requested directory. Depending on the application’s needs, it may be up to the developer to create the appropriate directory and any in between.
     - returns: The string with a path for the specified directories in the user's home directory or `nil` if a path cannot be found.
     */
    public init?(path directory: FileManager.SearchPathDirectory) {
        guard let path = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first else { return nil }
        self = path
    }

    /// Returns a new string made by first letter of the each String word.
    public var initials: String? {
        return components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .map { $0.substring(to: index(after: startIndex)) }
            .joined()
    }

    /// Returns an array of strings where elements are the String non-empty lines.
    public var nonEmptyLines: [String] {
        return self.lines().filter { !$0.trimmed.isEmpty }
    }

    /// Returns a data created from the value treated as a hexadecimal string.
    public var dataFromHexadecimalString: Data? {
        guard let regex = try? NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive) else { return nil }

        var data = Data(capacity: length / 2)
        regex.enumerateMatches(in: self, options: [], range: NSRange(location: 0, length: length)) { match, _, _ in
            guard let match = match else { return }
            let byteString = (self as NSString).substring(with: match.range)
            guard var num = UInt8(byteString, radix: 16) else { return }
            data.append(&num, count: 1)
        }

        return data
    }

    /// Returns the number of occurrences of a String into self.
    ///
    /// - Parameter string: String of occurrences.
    /// - Returns: Returns the number of occurrences of a String into self.
    public func occurrences(of string: String, caseSensitive: Bool = true) -> Int {
        var string = string
        if !caseSensitive {
            string = string.lowercased()
        }
        return self.lowercased().components(separatedBy: string).count - 1
    }

    /// Returns true if the String has at least one uppercase chatacter, otherwise false.
    ///
    /// - returns: Returns true if the String has at least one uppercase chatacter, otherwise false.
    public func hasUppercasedCharacters() -> Bool {
        var found = false
        for character in self.unicodeScalars {
            if CharacterSet.uppercaseLetters.contains(character) {
                found = true
                break
            }
        }
        return found
    }

    /// Returns true if the String has at least one lowercase chatacter, otherwise false.
    ///
    /// - returns: Returns true if the String has at least one lowercase chatacter, otherwise false.
    public func hasLowercasedCharacters() -> Bool {
        var found = false
        for character in self.unicodeScalars {
            if CharacterSet.lowercaseLetters.contains(character) {
                found = true
                break
            }
        }
        return found
    }

    // Check if string starts with substring.
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    public func start(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }

    // Check if string is https URL.
    public var isHttpsUrl: Bool {
        guard self.start(with: "https://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }

    // Check if string is http URL.
    public var isHttpUrl: Bool {
        guard self.start(with: "http://".lowercased()) else {
            return false
        }
        return URL(string: self) != nil
    }

    /**
     Returns an upper camel case version of the string.

     Here’s an example of transforming a string to all upper camel case letters.

     let variable = "find way home"
     print(variable.camelCased)
     // Prints "FindWayHome"
     */
    public var upperCamelCased: String {
        return capitalized.components(separatedBy: .whitespacesAndNewlines).joined()
    }

    // initialize string with an array of UInt8 integer values
    public init?(utf8chars: [UInt8]) {
        var str = ""
        var generator = utf8chars.makeIterator()
        var utf8 = UTF8()
        var done = false

        while !done {
            let r = utf8.decode(&generator)

            switch r {
            case .emptyInput:
                done = true
            case let .scalarValue(val):
                str.append(Character(val))
            case .error:
                return nil
            }
        }

        self = str
    }

    /// Converts self to an unsigned byte array.
    public var bytes: [UInt8] {
        return utf8.map { $0 }
    }

    // composed count takes into account emojis that are represented by character sequences
    public var composedCount: Int {
        var count = 0

        enumerateSubstrings(in: startIndex..<endIndex, options: .byComposedCharacterSequences) { _, _, _, _ in
            count += 1
        }

        return count
    }

    // encode string for a url query parameter value
    public func encodingForURLQueryValue() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumeric()
        characterSet.addCharacters(in: "-._~")

        return addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)
    }

    public func getPathNameExtension() -> String {
        return (self as NSString).pathExtension
    }

    public func maxFontSize(_ font: UIFont, boundingWidth: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let textHeight = self.labelHeightWithConstrainedWidth(boundingWidth, font: font) // self.height(font: font, boundingWidth: boundingWidth)
        if textHeight < maxHeight {
            return floor(textHeight)
        } else {
            let newFont = font.withSize(font.pointSize - 1)
            return self.maxFontSize(newFont, boundingWidth: boundingWidth, maxHeight: maxHeight)
        }
    }

    public func labelHeightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        if self.isEmpty {
            return 0
        }

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))

        label.font = font
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = self

        label.sizeToFit()
        label.layoutIfNeeded()

        return ceil(label.frame.height)
    }

    // get index of substring in string, or -1 if not contained in other string
    public func indexOf(_ target: String) -> Int {
        let range = self.range(of: target)
        if let range = range {
            return self.characters.distance(from: self.startIndex, to: range.lowerBound)
        } else {
            return -1
        }
    }

    // check if digits only (if empty string returns true)
    public func isDigitsOnly() -> Bool {
        let digits = CharacterSet.decimalDigits

        var isDigitsOnly = true

        for char in self.unicodeScalars {
            if !digits.contains(UnicodeScalar(char.value)!) {
                // character not alpha
                isDigitsOnly = false
                break
            }
        }

        return isDigitsOnly
    }

    // check if letters only (if empty string returns true)
    public func isValidName() -> Bool {
        let letters = CharacterSet.letters
        let punctuation = CharacterSet.punctuationCharacters

        var isValidName = true

        for char in self.unicodeScalars {
            if !letters.contains(UnicodeScalar(char.value)!) && !punctuation.contains(UnicodeScalar(char.value)!) {
                // character not alpha
                isValidName = false
                break
            }
        }

        return isValidName
    }

    public func isAlphaPunctuationWhiteSpace() -> Bool {
        let letters = CharacterSet.letters
        let punctuation = CharacterSet.punctuationCharacters
        let whitespace = CharacterSet.whitespaces

        var isAlphaPunctuationWhiteSpace = true

        for char in self.unicodeScalars {
            if !letters.contains(UnicodeScalar(char.value)!) && !punctuation.contains(UnicodeScalar(char.value)!) && !whitespace.contains(UnicodeScalar(char.value)!) {
                // character not letter or whitespace
                isAlphaPunctuationWhiteSpace = false
                break
            }
        }

        return isAlphaPunctuationWhiteSpace
    }

    /// Remove double or more duplicated spaces.
    ///
    /// - returns: Remove double or more duplicated spaces.
    public func removeExtraSpaces() -> String {
        let squashed = self.replacingOccurrences(of: "[ ]+", with: " ", options: .regularExpression, range: nil)
        #if os(Linux) // Caused by a Linux bug with emoji.
        return squashed
        #else
        return squashed.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        #endif
    }

    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }

    public func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)

        return ceil(boundingBox.width)
    }

    public func replace(_ target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }

    /**
     Replaces all occurences of the pattern on self in-place.

     Examples:

     ```
     "hello".regexInPlace("[aeiou]", "*")      // "h*ll*"
     "hello".regexInPlace("([aeiou])", "<$1>") // "h<e>ll<o>"
     ```
     */
    public mutating func formRegex(_ pattern: String, _ replacement: String) {
        do {
            let expression = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: characters.count)
            self = expression.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacement)
        } catch { return }
    }

    /**
     Returns a string containing replacements for all pattern matches.

     Examples:

     ```
     "hello".regex("[aeiou]", "*")      // "h*ll*"
     "hello".regex("([aeiou])", "<$1>") // "h<e>ll<o>"
     ```
     */
    public func regex(_ pattern: String, _ replacement: String) -> String {
        var replacementString = self
        replacementString.formRegex(pattern, replacement)
        return replacementString
    }

    /**
     Replaces pattern-matched strings, operated upon by a closure, on self in-place.

     - parameter pattern: The pattern to match against.
     - parameter matches: The closure in which to handle matched strings.

     Example:

     ```
     "hello".regexInPlace(".") {
     let s = $0.unicodeScalars
     let v = s[s.startIndex].value
     return "\(v) "
     }   // "104 101 108 108 111 "
     */
    public mutating func formRegex(_ pattern: String, _ matches: (String) -> String) {

        let expression: NSRegularExpression
        do {
            expression = try NSRegularExpression(pattern: "(\(pattern))", options: [])
        } catch {
            print("regex error: \(error)")
            return
        }

        let range = NSMakeRange(0, self.characters.count)

        var startOffset = 0

        let results = expression.matches(in: self, options: [], range: range)

        for result in results {

            var endOffset = startOffset

            for i in 1..<result.numberOfRanges {
                var resultRange = result.range
                resultRange.location += startOffset

                let startIndex = self.index(self.startIndex, offsetBy: resultRange.location)
                let endIndex = self.index(self.startIndex, offsetBy: resultRange.location + resultRange.length)
                let replacementRange = startIndex..<endIndex

                let match = expression.replacementString(for: result, in: self, offset: startOffset, template: "$\(i)")
                let replacement = matches(match)

                self.replaceSubrange(replacementRange, with: replacement)

                endOffset += replacement.characters.count - resultRange.length
            }

            startOffset = endOffset
        }
    }

    /**
     Returns a string with pattern-matched strings, operated upon by a closure.

     - parameter pattern: The pattern to match against.
     - parameter matches: The closure in which to handle matched strings.

     - returns: String containing replacements for the matched pattern.

     Example:

     ```
     "hello".regex(".") {
     let s = $0.unicodeScalars
     let v = s[s.startIndex].value
     return "\(v) "
     }   // "104 101 108 108 111 "
     */
    public func regex(_ pattern: String, _ matches: (String) -> String) -> String {
        var replacementString = self
        replacementString.formRegex(pattern, matches)
        return replacementString
    }

    /// Returns if self is a valid UUID for APNS (Apple Push Notification System) or not.
    ///
    /// - Returns: Returns if self is a valid UUID for APNS (Apple Push Notification System) or not.
    public func isUUIDForAPNS() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{32}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.length))
            return matches == 1
        } catch {
            return false
        }
    }

    /// Returns if self is a valid UUID or not.
    ///
    /// - Returns: Returns if self is a valid UUID or not.
    public func isUUID() -> Bool {
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", options: .caseInsensitive)
            let matches: Int = regex.numberOfMatches(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.length))
            return matches == 1
        } catch {
            return false
        }
    }

    /// Returns the reversed String.
    ///
    /// - parameter preserveFormat: If set to true preserve the String format.
    ///                             The default value is false.
    ///                             **Example:**
    ///                                 "Let's try this function?" ->
    ///                                 "?noitcnuf siht yrt S'tel"
    ///
    /// - returns: Returns the reversed String.
    public func reversed(preserveFormat: Bool = false) -> String {
        guard !self.characters.isEmpty else {
            return ""
        }

        var reversed = String(self.removeExtraSpaces().characters.reversed())

        if !preserveFormat {
            return reversed
        }

        let words = reversed.components(separatedBy: " ").filter { $0 != "" }

        reversed.removeAll()
        for word in words {
            if let char = word.unicodeScalars.first {
                if CharacterSet.uppercaseLetters.contains(char) {
                    reversed += word.lowercased().uppercasedFirst() + " "
                } else {
                    reversed += word.lowercased() + " "
                }
            } else {
                reversed += word.lowercased() + " "
            }
        }

        return reversed
    }

    /// Returns string with the first character uppercased.
    ///
    /// - returns: Returns string with the first character uppercased.
    public func uppercasedFirst() -> String {
        return String(self.characters.prefix(1)).uppercased() + String(self.characters.dropFirst())
    }

    /// Returns string with the first character lowercased.
    ///
    /// - returns: Returns string with the first character lowercased.
    public func lowercasedFirst() -> String {
        return String(self.characters.prefix(1)).lowercased() + String(self.characters.dropFirst())
    }

    // Array of strings separated by given string.
    ///
    /// - Parameter separator: separator to split string by.
    /// - Returns: array of strings separated by given string.
    public func splited(by separator: Character) -> [String] {
        return characters.split { $0 == separator }.map(String.init)
    }

    /**
     Truncates the string to length characters, optionally appending a trailing string. If the string is shorter
     than the required length, then this function is a non-op.

     - parameter length:   The length of string required.
     - parameter trailing: An optional addition to the end of the string (increasing "length"), such as ellipsis.

     - returns: The truncated string.

     Examples:

     ```
     "hello there".truncated(to: 5)                   // "hello"
     "hello there".truncated(to: 5, trailing: "...")  // "hello..."
     ```

     */
    public func truncated(to length: Int, trailing: String = "") -> String {
        guard !characters.isEmpty && characters.count > length else { return self }
        return self.substring(to: self.index(startIndex, offsetBy: length)) + trailing
    }

    public mutating func truncate(to length: Int, trailing: String = "") {
        self = self.truncated(to: length, trailing: trailing)
    }

    /// Get the character at a given index.
    ///
    /// - Parameter index: The index.
    /// - Returns: Returns the character at a given index, starts from 0.
    public func character(at index: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: index)]
    }

    /// Creates a substring with a given range.
    ///
    /// - Parameter range: The range.
    /// - Returns: Returns the string between the range.
    public func substring(with range: Range<Int>) -> String {
        let start = self.characters.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.characters.index(self.startIndex, offsetBy: range.upperBound)

        return self.substring(with: start..<end)
    }

    /**
     Convert an NSRange to a Range. There is still a mismatch between the regular expression libraries
     and NSString/String. This makes it easier to convert between the two. Using this allows complex
     strings (including emoji, regonial indicattors, etc.) to be manipulated without having to resort
     to NSString instances.

     Note that it may not always be possible to convert from an NSRange as they are not exactly the same.

     Taken from:
     http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index

     - parameter nsRange: The NSRange instance to covert to a Range.

     - returns: The Range, if it was possible to convert. Otherwise nil.
     */
    public func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
        else { return nil }

        return from..<to
    }

    /// Returns the index of the given character.
    ///
    /// - Parameter character: The character to search.
    /// - Returns: Returns the index of the given character, -1 if not found.
    public func index(of character: Character) -> Int {
        if let index = self.characters.index(of: character) {
            return self.characters.distance(from: self.startIndex, to: index)
        }
        return -1
    }

    fileprivate var vowels: [String] {
        return ["a", "e", "i", "o", "u"]
    }

    fileprivate var consonants: [String] {
        return ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
    }

    /**

     Convenience property for a `String`'s length

     */
    public var length: Int {
        return self.characters.count

    }

    /**

     An Array of the individual substrings composing `self`. Read-only.

     */
    public var chars: [String] {

        return Array(self.characters).map({ String($0) })

    }

    /**

     A Set<String> of the unique characters in `self`.

     */
    public var charSet: Set<String> {

        return Set(self.characters.map { String($0) })

    }

    public var firstCharacter: String? {

        return self.chars.first

    }

    /// SwifterSwift: Last character of string (if applicable).
    public var lastCharacter: String? {
        guard let last = characters.last else {
            return nil
        }
        return String(last)
    }

    public func random() -> Character {
        let randomIndex = Int(arc4random_uniform(UInt32(self.length)))
        return self.characters[self.characters.index(self.startIndex, offsetBy: randomIndex)]
    }

    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.

    public func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")

        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }

    /// Gets the individual characters and puts them in an array as Strings.
    var array: [String] {
        return description.characters.map { String($0) }
    }

    // Double value from string (if applicable).
    public var double: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }

    // Double value from string (if applicable).
    public var doubleValue: Double {
        return NSString(string: self).doubleValue
    }

    // Float value from string (if applicable).
    public var float: Float? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float
    }

    /// Returns the Float value
    public var floatValue: Float {
        return NSString(string: self).floatValue
    }

    // Float32 value from string (if applicable).
    public var float32: Float32? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float32
    }

    // Float64 value from string (if applicable).
    public var float64: Float64? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Float64
    }

    /// Returns the Int value
    public var intValue: Int {
        return Int(NSString(string: self).intValue)
    }

    // Int16 value from string (if applicable).
    public var int16: Int16? {
        return Int16(self)
    }

    // Int32 value from string (if applicable).
    public var int32: Int32? {
        return Int32(self)
    }

    // Int64 value from string (if applicable).
    public var int64: Int64? {
        return Int64(self)
    }

    // Int8 value from string (if applicable).
    public var int8: Int8? {
        return Int8(self)
    }

    /// Convert self to a Data.
    public var data: Data? {
        return self.data(using: .utf8)
    }

    /// Returns a new string containing the characters of the String from the one at a given index to the end.
    ///
    /// - Parameter index: The index.
    /// - Returns: Returns the substring from index.
    public func substring(from index: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: index))
    }

    /// Creates a substring from the given character.
    ///
    /// - Parameter character: The character.
    /// - Returns: Returns the substring from character.
    public func substring(from character: Character) -> String {
        let index: Int = self.index(of: character) + 1
        guard index > -1 else {
            return ""
        }
        return self.substring(from: index)
    }

    /// Returns a new string containing the characters of the String up to, but not including, the one at a given index.
    ///
    /// - Parameter index: The index.
    /// - Returns: Returns the substring to index.
    public func substring(to index: Int) -> String {
        var _index = max(0, min(index, self.length - 1))

        return self.substring(to: self.characters.index(self.startIndex, offsetBy: _index))
    }

    /// Creates a substring to the given character.
    ///
    /// - Parameter character: The character.
    /// - Returns: Returns the substring to character.
    public func substring(to character: Character) -> String {
        let index: Int = self.index(of: character)
        guard index > -1 else {
            return ""
        }
        return self.substring(to: index)
    }

    // Subscript string with index.
    ///
    /// - Parameter i: index.
    public subscript(i: Int) -> String? {
        guard i >= 0 && i < length else {
            return nil
        }
        return String(self[index(startIndex, offsetBy: i)])
    }

    /// Creates a substring with a given range.
    ///
    /// - Parameter range: The range.
    /// - Returns: Returns the string between the range.
    public func substring(with range: CountableClosedRange<Int>) -> String {
        return self.substring(with: Range(uncheckedBounds: (lower: range.lowerBound, upper: range.upperBound + 1)))
    }

    // Subscript string within a half-open range.
    ///
    /// - Parameter range: Half-open range.
    public subscript(range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }

    // Subscript string within a closed range.
    ///
    /// - Parameter range: Closed range.
    public subscript(range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else {
            return nil
        }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else {
            return nil
        }
        return String(self[lowerIndex..<upperIndex])
    }

    public subscript(r: Range<Int>) -> String {
        let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound - 1)

        return String(self[Range(startIndex..<endIndex)])
    }

    // Check if string contains one or more instance of substring.
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    public func contain(_ string: String, caseSensitive: Bool = true) -> Bool {
        //        if !caseSensitive {
        //            return range(of: string, options: .caseInsensitive) != nil
        //        }
        //        return range(of: string) != nil

        if #available(iOS 9.0, *) {
            return caseSensitive ? localizedStandardContains(string) : localizedCaseInsensitiveContains(string)
        }

        return self.range(of: string, options: [.caseInsensitive, .diacriticInsensitive], locale: .current) != nil
    }

    // Check if string ends with substring.
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    public func end(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }

    /**
     Convert argb string to rgba string.
     */
    public func argb2rgba() -> String? {
        guard self.hasPrefix("#") else {
            return nil
        }

        let hexString: String = self.substring(from: self.characters.index(self.startIndex, offsetBy: 1))
        switch hexString.length {
        case 4:
            return "#"
                + hexString.substring(from: self.characters.index(self.startIndex, offsetBy: 1))
                + hexString.substring(to: self.characters.index(self.startIndex, offsetBy: 1))
        case 8:
            return "#"
                + hexString.substring(from: self.characters.index(self.startIndex, offsetBy: 2))
                + hexString.substring(to: self.characters.index(self.startIndex, offsetBy: 2))
        default:
            return nil
        }
    }

    /// Converts self to an UUID APNS valid (No "<>" or "-" or spaces).
    ///
    /// - Returns: Converts self to an UUID APNS valid (No "<>" or "-" or spaces).
    public func readableUUID() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
    }

    /// Returns an array of String with all the hashtags in self.
    ///
    /// - Returns: Returns an array of String with all the hashtags in self.
    /// - Throws: Throws NSRegularExpression errors.
    public func hashtags() -> [String] {
        guard let detector = try? NSRegularExpression(pattern: "#(\\w+)", options: NSRegularExpression.Options.caseInsensitive) else {
            return []
        }

        let hashtags = detector.matches(in: self, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSRange(location: 0, length: length)).map { $0 }

        return hashtags.map({
            (self as NSString).substring(with: $0.range(at: 1))
        })
    }

    /// Returns an array of String with all the mentions in self.
    ///
    /// - Returns: Returns an array of String with all the mentions in self.
    /// - Throws: Throws NSRegularExpression errors.
    public func mentions() -> [String] {
        guard let detector = try? NSRegularExpression(pattern: "@(\\w+)", options: NSRegularExpression.Options.caseInsensitive) else {
            return []
        }

        let mentions = detector.matches(in: self, options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds, range: NSRange(location: 0, length: length)).map { $0 }

        return mentions.map({
            (self as NSString).substring(with: $0.range(at: 1))
        })
    }

    /// Returns an array of String with all the links in self.
    ///
    /// - Returns: Returns an array of String with all the links in self.
    /// - Throws: Throws NSDataDetector errors.
    public func links() -> [String] {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return []
        }

        let links = detector.matches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length)).map { $0 }

        return links.filter { link in
            link.url != nil
        }.map { link -> String in
            link.url!.absoluteString
        }
    }

    /// Returns an array of Date with all the dates in self.
    ///
    /// - Returns: Returns an array of Date with all the date in self.
    /// - Throws: Throws NSDataDetector errors.
    public func dates() -> [Date] {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue) else {
            return []
        }

        let dates = detector.matches(in: self, options: NSRegularExpression.MatchingOptions.withTransparentBounds, range: NSRange(location: 0, length: length)).map { $0 }

        return dates.filter { date in
            date.date != nil
        }.map { date -> Date in
            date.date!
        }
    }

    /// SwifterSwift: String by replacing part of string with another string.
    ///
    /// - Parameters:
    ///   - substring: old substring to find and replace.
    ///   - newString: new string to insert in old string place.
    /// - Returns: string after replacing substring with newString.
    public func replacing(_ substring: String, with newString: String) -> String {
        return replacingOccurrences(of: substring, with: newString)
    }
}

// MARK: - Methods
public extension String {

    /// Float value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Float value from given string.
    public func float(locale: Locale = .current) -> Float? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? Float
    }

    /// Double value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional Double value from given string.
    public func double(locale: Locale = .current) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? Double
    }

    /// CGFloat value from string (if applicable).
    ///
    /// - Parameter locale: Locale (default is Locale.current)
    /// - Returns: Optional CGFloat value from given string.
    public func cgFloat(locale: Locale = .current) -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.allowsFloats = true
        return formatter.number(from: self) as? CGFloat
    }

    /// SwifterSwift: Array of strings separated by new lines.
    ///
    ///        "Hello\ntest".lines() -> ["Hello", "test"]
    ///
    /// - Returns: Strings separated by new lines.
    public func lines() -> [String] {
        var result = [String]()
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }

    /// SwifterSwift: Returns a localized string, with an optional comment for translators.
    ///
    ///        "Hello world".localized -> Hallo Welt
    ///
    public func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    /// SwifterSwift: The most common character in string.
    ///
    ///        "This is a test, since e is appearing everywhere e should be the common character".mostCommonCharacter() -> "e"
    ///
    /// - Returns: The most common character.
    public func mostCommonCharacter() -> Character? {
        let mostCommon = withoutSpacesAndNewLines.reduce(into: [Character: Int]()) {
            let count = $0[$1] ?? 0
            $0[$1] = count + 1
        }.max { $0.1 < $1.1 }?.0

        return mostCommon
    }

    /// SwifterSwift: Array with unicodes for all characters in a string.
    ///
    ///        "SwifterSwift".unicodeArray -> [83, 119, 105, 102, 116, 101, 114, 83, 119, 105, 102, 116]
    ///
    /// - Returns: The unicodes for all characters in a string.
    public func unicodeArray() -> [Int] {
        return unicodeScalars.map({ $0.hashValue })
    }

    /// SwifterSwift: an array of all words in a string
    ///
    ///        "Swift is amazing".words() -> ["Swift", "is", "amazing"]
    ///
    /// - Returns: The words contained in a string.
    public func words() -> [String] {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }

    /// SwifterSwift: Count of words in a string.
    ///
    ///        "Swift is amazing".wordsCount() -> 3
    ///
    /// - Returns: The count of words contained in a string.
    public func wordCount() -> Int {
        // https://stackoverflow.com/questions/42822838
        return self.words().count
    }

    /// SwifterSwift: Transforms the string into a slug string.
    ///
    ///        "Swift is amazing".toSlug() -> "swift-is-amazing"
    ///
    /// - Returns: The string in slug format.
    public func toSlug() -> String {
        let lowercased = self.lowercased()
        let latinized = lowercased.latinized
        let withDashes = latinized.replacingOccurrences(of: " ", with: "-")

        let alphanumerics = NSCharacterSet.alphanumerics
        var filtered = withDashes.filter {
            guard String($0) != "-" else { return true }
            guard String($0) != "&" else { return true }
            return String($0).rangeOfCharacter(from: alphanumerics) != nil
        }

        while filtered.lastCharacterAsString == "-" {
            filtered = String(filtered.dropLast())
        }

        while filtered.firstCharacterAsString == "-" {
            filtered = String(filtered.dropFirst())
        }

        return filtered.replacingOccurrences(of: "--", with: "-")
    }

    /// SwifterSwift: Safely subscript string with index.
    ///
    ///        "Hello World!"[3] -> "l"
    ///        "Hello World!"[20] -> nil
    ///
    /// - Parameter i: index.
    public subscript(safe i: Int) -> Character? {
        guard i >= 0 && i < count else { return nil }
        return self[index(startIndex, offsetBy: i)]
    }

    /// SwifterSwift: Safely subscript string within a half-open range.
    ///
    ///        "Hello World!"[6..<11] -> "World"
    ///        "Hello World!"[21..<110] -> nil
    ///
    /// - Parameter range: Half-open range.
    public subscript(safe range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }

    /// SwifterSwift: Safely subscript string within a closed range.
    ///
    ///        "Hello World!"[6...11] -> "World!"
    ///        "Hello World!"[21...110] -> nil
    ///
    /// - Parameter range: Closed range.
    public subscript(safe range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }

    #if os(iOS) || os(macOS)
    /// SwifterSwift: Copy string to global pasteboard.
    ///
    ///        "SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    public func copyToPasteboard() {
        #if os(iOS)
        UIPasteboard.general.string = self
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(self, forType: .string)
        #endif
    }
    #endif

    /// SwifterSwift: Converts string format to CamelCase.
    ///
    ///        var str = "sOme vaRiabLe Name"
    ///        str.camelize()
    ///        print(str) // prints "someVariableName"
    ///
    public mutating func camelize() {
        self = self.camelCased
    }

    /// SwifterSwift: Check if string contains only unique characters.
    ///
    public func hasUniqueCharacters() -> Bool {
        guard self.count > 0 else { return false }
        var uniqueChars = Set<String>()
        for char in self {
            if uniqueChars.contains(String(char)) { return false }
            uniqueChars.insert(String(char))
        }
        return true
    }

    /// SwifterSwift: Check if string contains one or more instance of substring.
    ///
    ///        "Hello World!".contain("O") -> false
    ///        "Hello World!".contain("o", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    public func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return self.range(of: string, options: .caseInsensitive) != nil
        }
        return self.range(of: string) != nil
    }

    /// SwifterSwift: Count of substring in string.
    ///
    ///        "Hello World!".count(of: "o") -> 2
    ///        "Hello World!".count(of: "L", caseSensitive: false) -> 3
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: count of appearance of substring in string.
    public func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }

    /// SwifterSwift: Check if string ends with substring.
    ///
    ///        "Hello World!".ends(with: "!") -> true
    ///        "Hello World!".ends(with: "WoRld!", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    public func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }

    /// SwifterSwift: Latinize string.
    ///
    ///        var str = "Hèllö Wórld!"
    ///        str.latinize()
    ///        print(str) // prints "Hello World!"
    ///
    public mutating func latinize() {
        self = self.latinized
    }

    /// SwifterSwift: Random string of given length.
    ///
    ///        String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    public static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            let randomIndex = arc4random_uniform(UInt32(base.count))
            let randomCharacter = base.charactersArray[Int(randomIndex)]
            randomString.append(randomCharacter)
        }
        return randomString
    }

    /// SwifterSwift: Reverse string.
    public mutating func reverse() {
        let chars: [Character] = reversed()
        self = String(chars)
    }

    /// SwifterSwift: Sliced string from a start index with length.
    ///
    ///        "Hello World".slicing(from: 6, length: 5) -> "World"
    ///
    /// - Parameters:
    ///   - i: string index the slicing should start from.
    ///   - length: amount of characters to be sliced after given index.
    /// - Returns: sliced substring of length number of characters (if applicable) (example: "Hello World".slicing(from: 6, length: 5) -> "World")
    public func slicing(from i: Int, length: Int) -> String? {
        guard length >= 0, i >= 0, i < count else { return nil }
        guard i.advanced(by: length) <= count else {
            return self[safe: i..<count]
        }
        guard length > 0 else { return "" }
        return self[safe: i..<i.advanced(by: length)]
    }

    /// SwifterSwift: Slice given string from a start index with length (if applicable).
    ///
    ///        var str = "Hello World"
    ///        str.slice(from: 6, length: 5)
    ///        print(str) // prints "World"
    ///
    /// - Parameters:
    ///   - i: string index the slicing should start from.
    ///   - length: amount of characters to be sliced after given index.
    public mutating func slice(from i: Int, length: Int) {
        if let str = self.slicing(from: i, length: length) {
            self = String(str)
        }
    }

    /// SwifterSwift: Slice given string from a start index to an end index (if applicable).
    ///
    ///        var str = "Hello World"
    ///        str.slice(from: 6, to: 11)
    ///        print(str) // prints "World"
    ///
    /// - Parameters:
    ///   - start: string index the slicing should start from.
    ///   - end: string index the slicing should end at.
    public mutating func slice(from start: Int, to end: Int) {
        guard end >= start else { return }
        if let str = self[safe: start..<end] {
            self = str
        }
    }

    /// SwifterSwift: Slice given string from a start index (if applicable).
    ///
    ///        var str = "Hello World"
    ///        str.slice(at: 6)
    ///        print(str) // prints "World"
    ///
    /// - Parameter i: string index the slicing should start from.
    public mutating func slice(at i: Int) {
        guard i < count else { return }
        if let str = self[safe: i..<count] {
            self = str
        }
    }

    /// SwifterSwift: Check if string starts with substring.
    ///
    ///        "hello World".starts(with: "h") -> true
    ///        "hello World".starts(with: "H", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    public func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }

    /// SwifterSwift: Date object from string of date format.
    ///
    ///        "2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
    ///        "not date string".date(withFormat: "yyyy-MM-dd") -> nil
    ///
    /// - Parameter format: date format.
    /// - Returns: Date object from string (if applicable).
    public func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    /// SwifterSwift: Removes spaces and new lines in beginning and end of string.
    ///
    ///        var str = "  \n Hello World \n\n\n"
    ///        str.trim()
    ///        print(str) // prints "Hello World"
    ///
    public mutating func trim() {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// SwifterSwift: Truncate string (cut it to a given number of characters).
    ///
    ///        var str = "This is a very long sentence"
    ///        str.truncate(toLength: 14)
    ///        print(str) // prints "This is a very..."
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string (default is "...").
    public mutating func truncate(toLength length: Int, trailing: String? = "...") {
        guard length > 0 else { return }
        if self.count > length {
            self = self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
        }
    }

    /// SwifterSwift: Truncated string (limited to a given number of characters).
    ///
    ///        "This is a very long sentence".truncated(toLength: 14) -> "This is a very..."
    ///        "Short sentence".truncated(toLength: 14) -> "Short sentence"
    ///
    /// - Parameters:
    ///   - toLength: maximum number of characters before cutting.
    ///   - trailing: string to add at the end of truncated string.
    /// - Returns: truncated string (this is an extr...).
    public func truncated(toLength length: Int, trailing: String? = "...") -> String {
        guard 1..<self.count ~= length else { return self }
        return self[startIndex..<index(startIndex, offsetBy: length)] + (trailing ?? "")
    }

    /// SwifterSwift: Convert URL string to readable string.
    ///
    ///        var str = "it's%20easy%20to%20decode%20strings"
    ///        str.urlDecode()
    ///        print(str) // prints "it's easy to decode strings"
    ///
    public mutating func urlDecode() {
        if let decoded = removingPercentEncoding {
            self = decoded
        }
    }

    /// SwifterSwift: Escape string.
    ///
    ///        var str = "it's easy to encode strings"
    ///        str.urlEncode()
    ///        print(str) // prints "it's%20easy%20to%20encode%20strings"
    ///
    public mutating func urlEncode() {
        if let encoded = addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            self = encoded
        }
    }

    /// SwifterSwift: Verify if string matches the regex pattern.
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: true if string matches the pattern.
    public func matches(pattern: String) -> Bool {
        return self.range(of: pattern,
                          options: String.CompareOptions.regularExpression,
                          range: nil, locale: nil) != nil
    }

    /// SwifterSwift: Pad string to fit the length parameter size with another string in the start.
    ///
    ///   "hue".padStart(10) -> "       hue"
    ///   "hue".padStart(10, with: "br") -> "brbrbrbhue"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    public mutating func padStart(_ length: Int, with string: String = " ") {
        self = self.paddingStart(length, with: string)
    }

    /// SwifterSwift: Returns a string by padding to fit the length parameter size with another string in the start.
    ///
    ///   "hue".paddingStart(10) -> "       hue"
    ///   "hue".paddingStart(10, with: "br") -> "brbrbrbhue"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    /// - Returns: The string with the padding on the start.
    public func paddingStart(_ length: Int, with string: String = " ") -> String {
        guard self.count < length else { return self }

        let padLength = length - count
        if padLength < string.count {
            return string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)] + self
        } else {
            var padding = string
            while padding.count < padLength {
                padding.append(string)
            }
            return padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)] + self
        }
    }

    /// SwifterSwift: Pad string to fit the length parameter size with another string in the start.
    ///
    ///   "hue".padEnd(10) -> "hue       "
    ///   "hue".padEnd(10, with: "br") -> "huebrbrbrb"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    public mutating func padEnd(_ length: Int, with string: String = " ") {
        self = self.paddingEnd(length, with: string)
    }

    /// SwifterSwift: Returns a string by padding to fit the length parameter size with another string in the end.
    ///
    ///   "hue".paddingEnd(10) -> "hue       "
    ///   "hue".paddingEnd(10, with: "br") -> "huebrbrbrb"
    ///
    /// - Parameter length: The target length to pad.
    /// - Parameter string: Pad string. Default is " ".
    /// - Returns: The string with the padding on the end.
    public func paddingEnd(_ length: Int, with string: String = " ") -> String {
        guard self.count < length else { return self }

        let padLength = length - count
        if padLength < string.count {
            return self + string[string.startIndex..<string.index(string.startIndex, offsetBy: padLength)]
        } else {
            var padding = string
            while padding.count < padLength {
                padding.append(string)
            }
            return self + padding[padding.startIndex..<padding.index(padding.startIndex, offsetBy: padLength)]
        }
    }

}

// MARK: - Operators
public extension String {

    /// SwifterSwift: Repeat string multiple times.
    ///
    ///        'bar' * 3 -> "barbarbar"
    ///
    /// - Parameters:
    ///   - lhs: string to repeat.
    ///   - rhs: number of times to repeat character.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: lhs, count: rhs)
    }

    /// SwifterSwift: Repeat string multiple times.
    ///
    ///        3 * 'bar' -> "barbarbar"
    ///
    /// - Parameters:
    ///   - lhs: number of times to repeat character.
    ///   - rhs: string to repeat.
    /// - Returns: new string with given string repeated n times.
    public static func * (lhs: Int, rhs: String) -> String {
        guard lhs > 0 else { return "" }
        return String(repeating: rhs, count: lhs)
    }

}

// MARK: - Initializers
public extension String {

    /// SwifterSwift: Create a new string from a base64 string (if applicable).
    ///
    ///        String(base64: "SGVsbG8gV29ybGQh") = "Hello World!"
    ///        String(base64: "hello") = nil
    ///
    /// - Parameter base64: base64 string.
    public init?(base64: String) {
        guard let str = base64.base64Decoded else { return nil }
        self.init(str)
    }

    /// SwifterSwift: Create a new random string of given length.
    ///
    ///        String(randomOfLength: 10) -> "gY8r3MHvlQ"
    ///
    /// - Parameter length: number of characters in string.
    public init(randomOfLength length: Int) {
        self = String.random(ofLength: length)
    }

}

// MARK: - NSAttributedString extensions
public extension String {

    #if !os(tvOS) && !os(watchOS)
    /// SwifterSwift: Bold string.
    public var bold: NSAttributedString {
        #if os(macOS)
        return NSMutableAttributedString(string: self, attributes: [.font: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize)])
        #else
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        #endif
    }
    #endif

    /// SwifterSwift: Underlined string
    public var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }

    /// SwifterSwift: Strikethrough string.
    public var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
    }

    #if os(iOS)
    /// SwifterSwift: Italic string.
    public var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif

    #if os(macOS)
    /// SwifterSwift: Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: NSColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    #else
    /// SwifterSwift: Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    #endif

}

// MARK: - NSString extensions
public extension String {

    /// SwifterSwift: NSString from a string.
    public var nsString: NSString {
        return NSString(string: self)
    }

    /// SwifterSwift: NSString lastPathComponent.
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }

    /// SwifterSwift: NSString pathExtension.
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }

    /// SwifterSwift: NSString deletingLastPathComponent.
    public var deletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }

    /// SwifterSwift: NSString deletingPathExtension.
    public var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }

    /// SwifterSwift: NSString pathComponents.
    public var pathComponents: [String] {
        return (self as NSString).pathComponents
    }

    /// SwifterSwift: NSString appendingPathComponent(str: String)
    ///
    /// - Parameter str: the path component to append to the receiver.
    /// - Returns: a new string made by appending aString to the receiver, preceded if necessary by a path separator.
    public func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }

    /// SwifterSwift: NSString appendingPathExtension(str: String)
    ///
    /// - Parameter str: The extension to append to the receiver.
    /// - Returns: a new string made by appending to the receiver an extension separator followed by ext (if applicable).
    public func appendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }

}

infix operator ???: NilCoalescingPrecedence

/// Returns defaultValue if optional is nil, otherwise returns optional.
///
/// - Parameters:
///   - optional: The optional variable.
///   - defaultValue: The default value.
/// - Returns: Returns defaultValue if optional is nil, otherwise returns optional.
public func ??? <T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    return optional.map { String(describing: $0) } ?? defaultValue()
}
