//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import UIKit

typealias CitiesViewType = UIViewController & CitiesViewProtocol

struct CitiesViewCallbacks {
    var viewDidLoadEvent: (() -> Void)?
    var didTapCancelBarButton: (() -> Void)?
    var didSelectCity: ((City) -> Void)?
    var searchBarTextDidChange: ((String) -> Void)?
}

protocol CitiesViewProtocol: AnyObject {
    var callbacks: CitiesViewCallbacks { get set }
    
    func update(cities: [City])
}

final class CitiesViewController: CitiesViewType {
    
    // MARK: - Properties
    
    var retain: Any?
    
    var callbacks = CitiesViewCallbacks()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Введите название города"
        
        return searchBar
    }()
    
    private lazy var citiesListView: CitiesListView = {
        let citiesListView = CitiesListView()
        citiesListView.selectionCallBack = { [weak self] city in
            self?.callbacks.didSelectCity?(city)
        }
        
        return citiesListView
    }()
    
    private lazy var cancelBarButton = UIBarButtonItem(
        barButtonSystemItem: .cancel,
        target: self,
        action: #selector(cancelBarButtonTapped)
    )
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        callbacks.viewDidLoadEvent?()
    }
    
    // MARK: - Internal
    
    func update(cities: [City]) {
        citiesListView.update(cities: cities)
    }
    
    // MARK: - Private
    
    @objc private func cancelBarButtonTapped() {
        callbacks.didTapCancelBarButton?()
    }
    
    private func configureSubviews() {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = cancelBarButton
        view.addSubviews(subviews: [citiesListView])
        
        NSLayoutConstraint.activate([
            citiesListView.topAnchor.constraint(equalTo: view.topAnchor),
            citiesListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            citiesListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citiesListView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Extensions

// MARK: - UISearchBarDelegate

extension CitiesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        callbacks.searchBarTextDidChange?(searchText)
    }
}
