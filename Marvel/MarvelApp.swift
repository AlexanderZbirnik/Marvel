//
//  MarvelApp.swift
//  Marvel
//
//  Created by Alexander Zbirnik on 24.01.2023.
//

import SwiftUI
import ComposableArchitecture

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        options: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
}


@main
struct MarvelApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(
                initialState: AppReducer.State(),
                reducer: AppReducer())
            )
        }
    }
}
