//
//  CitiesScreen.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

typealias CitiesScreenType = CitiesScreen<CitiesViewController, CitiesPresenter>

final class CitiesScreen<View: CitiesViewController, Presenter> {
    
    // MARK: - Properties
    
    let view: View
    let presenter: Presenter
    
    // MARK: - Init
    
    init(view: View, presenter: Presenter) {
        self.view = view
        self.presenter = presenter
        
        self.view.retain = presenter
    }
}
