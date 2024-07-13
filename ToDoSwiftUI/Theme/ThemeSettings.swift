//
//  ThemeSettings.swift
//  ToDoSwiftUI
//
//  Created by Khavishini on 13/07/2024.
//

import SwiftUI

//MARK: Theme Class

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    
    public static let shared = ThemeSettings()
}
