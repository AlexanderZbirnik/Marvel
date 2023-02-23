//
//  MarvelApp.swift
//  Marvel
//
//  Created by Alexander Zbirnik on 24.01.2023.
//

import SwiftUI
import ComposableArchitecture
import Common
import MarvelService

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions
        options: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor(Palette.white)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        return true
    }
}


@main
struct MarvelApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(
                initialState: AppReducer.State(apiParameters: MarvelService.marvelApiParameters()),
                reducer: AppReducer())
            )
            .environment(\.colorScheme, .dark)
        }
    }
}
