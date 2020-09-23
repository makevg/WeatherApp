//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    private lazy var navigator: ApplicationNavigator = ApplicationDIFramework.container.resolve()
    private lazy var provider: CitiesProvider = ApplicationDIFramework.container.resolve()
    
    // MARK: - Internal

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        setRootViewController()
        
        return true
    }
    
    // MARK: - Private
    
    private func setRootViewController() {
        let weatherScreen = navigator.weatherScreen
        if let city = provider.fetchCities().last {
            weatherScreen.presenter.configure(city: city)
        }
        window?.rootViewController = UINavigationController(rootViewController: weatherScreen.view)
    }
}
