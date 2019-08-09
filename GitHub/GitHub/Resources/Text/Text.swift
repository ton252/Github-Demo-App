//
//  Text.swift
//  GitHub
//
//  Created by Anton Polyakov on 09.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

internal enum Text {
    
    internal enum Repositories {
        /// Repositories
        internal static let title = Text.tr("Localizable", "repositories.title")
    }
    
    internal enum Summary {
        internal enum Error {
            /// Try again later
            internal static let description = Text.tr("Localizable", "summary.error.description")
            /// Can't load data
            internal static let title = Text.tr("Localizable", "summary.error.title")
        }
        internal enum Section {
            /// Description
            internal static let description = Text.tr("Localizable", "summary.section.description")
            /// Languages
            internal static let languages = Text.tr("Localizable", "summary.section.languages")
            /// README
            internal static let readme = Text.tr("Localizable", "summary.section.readme")
        }
    }
    
    internal enum Zero {
        internal enum Error {
            /// Nothing found for your request\nTry to enter something else
            internal static let notFound = Text.tr("Localizable", "zero.error.notFound")
            /// Can't load data\nCheck your connection
            internal static let unknown = Text.tr("Localizable", "zero.error.unknown")
        }
        internal enum Info {
            /// Retry
            internal static let retry = Text.tr("Localizable", "zero.info.retry")
            /// Enter something to start searching\nFor example "git"
            internal static let search = Text.tr("Localizable", "zero.info.search")
        }
    }
}

// MARK: - Implementation Details

extension Text {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}
