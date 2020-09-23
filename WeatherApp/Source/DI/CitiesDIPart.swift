//
//  CitiesDIPart.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import DITranquillity

final class CitiesDIPart: DIPart {
    
    static func load(container: DIContainer) {
        
        // Screen
        container.register(CitiesScreenType.init)
        
        // ViewController
        container.register(CitiesViewController.init(nibName:bundle:))
            .as(CitiesViewType.self)
            .lifetime(.objectGraph)
        
        // Presenter
        container.register(CitiesPresenterImpl.init)
            .as(CitiesPresenter.self)
            .lifetime(.objectGraph)
    }
}
