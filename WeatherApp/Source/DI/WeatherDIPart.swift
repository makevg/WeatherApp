//
//  WeatherDIPart.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import DITranquillity

final class WeatherDIPart: DIPart {

    static func load(container: DIContainer) {
        
        // Screen
        container.register(WeatherScreenType.init)
        
        // ViewController
        container.register(WeatherViewController.init(nibName:bundle:))
            .as(WeatherViewType.self)
            .lifetime(.objectGraph)
        
        // Presenter
        container.register(WeatherPresenterImpl.init)
            .as(WeatherPresenter.self)
            .lifetime(.objectGraph)
    }
}
