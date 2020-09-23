//
//  CitiesPresenter.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import UIKit

protocol CitiesPresenter {
    var view: CitiesViewType? { get set }
    var citySelectionCallBack: ((City) -> Void)? { get set }
}

final class CitiesPresenterImpl: CitiesPresenter {
    
    // MARK: - DI
    
    weak var view: CitiesViewType?
    
    private let provider: CitiesProvider
    private let service: WeatherService
    
    // MARK: - Properties
    
    var citySelectionCallBack: ((City) -> Void)?
    
    private var searchCitiesWorkItem: DispatchWorkItem? {
        willSet { searchCitiesWorkItem?.cancel() }
    }
    
    // MARK: - Init
    
    init(
        view: CitiesViewType,
        provider: CitiesProvider,
        service: WeatherService) {
        self.view = view
        self.provider = provider
        self.service = service
        
        setupViewCallbacks()
    }
    
    // MARK: - Private
    
    private func setupViewCallbacks() {
        view?.callbacks.viewDidLoadEvent = { [weak self] in
            self?.viewDidLoadEvent()
        }
        view?.callbacks.didTapCancelBarButton = { [weak self] in
            self?.view?.dismiss(animated: true, completion: nil)
        }
        view?.callbacks.didSelectCity = { [weak self] city in
            self?.provider.addCity(city)
            self?.citySelectionCallBack?(city)
            self?.view?.dismiss(animated: true, completion: nil)
        }
        view?.callbacks.searchBarTextDidChange = { [weak self] text in
            self?.searchCities(query: text)
        }
    }
    
    private func viewDidLoadEvent() {
        let cities = provider.fetchCities()
        view?.update(cities: cities)
    }
    
    private func searchCities(query: String) {
        searchCitiesWorkItem = DispatchWorkItem {
            self.service.getCities(query: query) { cities in
                DispatchQueue.main.async { [weak self] in
                    self?.view?.update(cities: cities)
                }
            }
        }
        searchCitiesWorkItem.map { DispatchQueue.global().async(execute: $0) }
    }
}
