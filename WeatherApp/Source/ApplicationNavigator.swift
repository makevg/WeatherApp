//
//  ApplicationNavigator.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import SwiftLazy

final class ApplicationNavigator {
    
    // MARK: - DI
    
    private let weatherScreenProvider: Provider<WeatherScreenType>
    private let citiesScreenProvider: Provider<CitiesScreenType>
    
    // MARK: - Properties
    
    var weatherScreen: WeatherScreenType { weatherScreenProvider.value }
    var citiesScreen: CitiesScreenType { citiesScreenProvider.value }
    
    // MARK: - Init
    
    init(
        weatherScreenProvider: Provider<WeatherScreenType>,
        citiesScreenProvider: Provider<CitiesScreenType>) {
        self.weatherScreenProvider = weatherScreenProvider
        self.citiesScreenProvider = citiesScreenProvider
    }
    
    // MARK: - Internal
    
    func showCitiesScreen(presentringController: UIViewController, citySelectionCallBack: ((City) -> Void)?) {
        let screen = citiesScreen
        var presenter = screen.presenter
        presenter.citySelectionCallBack = citySelectionCallBack
        presentringController.present(
            UINavigationController(rootViewController: screen.view),
            animated: true,
            completion: nil
        )
    }
}
