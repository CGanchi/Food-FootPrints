//
//  FoodEmissionsApp.swift
//  FoodEmissions
//
//  Created by Camron Ganchi  on 6/19/24.
//

import SwiftUI

@main
struct FoodEmissionsApp: App {
    init(){
        UITabBar.appearance().backgroundColor = UIColor.systemGray6
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
