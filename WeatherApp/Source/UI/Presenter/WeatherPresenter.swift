//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import UIKit

protocol WeatherPresenter {
    var view: WeatherViewType? { get set }
    
    func configure(city: City)
}

final class WeatherPresenterImpl: WeatherPresenter {
    
    // MARK: - DI
    
    weak var view: WeatherViewType?
    
    private let service: WeatherService
    private let navigator: ApplicationNavigator
    
    // MARK: - Init
    
    init(
        view: WeatherViewType,
        service: WeatherService,
        navigator: ApplicationNavigator) {
        self.view = view
        self.service = service
        self.navigator = navigator
        
        setupViewCallbacks()
    }
    
    // MARK: - Internal
    
    func configure(city: City) {
        view?.updateTitle(title: city.name)
        
        service.getWeather(for: (city.lat, city.lon)) { weather in
            DispatchQueue.main.async { [weak self] in
                self?.view?.update(weather: weather)
            }
        }
    }
    
    // MARK: - Private
    
    func setupViewCallbacks() {
        view?.callbacks.didTapMenuBarButton = { [weak self] in
            self?.menuBarButtonTapped()
        }
    }
    
    private func menuBarButtonTapped() {
        guard let view = view else {
            return
        }
        
        navigator.showCitiesScreen(presentringController: view) { [weak self] city in
            self?.configure(city: city)
        }
    }
}
