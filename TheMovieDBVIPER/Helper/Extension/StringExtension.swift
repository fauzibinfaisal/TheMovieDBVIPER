//
//  StringExtension.swift
//  TheMovieDBVIPER
//
//  Created by Gop-c2s2-f on 02/04/23.
//

import Foundation
import UIKit

extension String {
    func htmlAttributedString(font: UIFont? = nil) -> NSAttributedString? {
        var text = self
        if let font = font {
            text = String(format:"<span style=\"font-family: \(font.familyName); font-size: \(font.pointSize)\">%@</span>", self)
        }
        
        guard let data = text.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
}
