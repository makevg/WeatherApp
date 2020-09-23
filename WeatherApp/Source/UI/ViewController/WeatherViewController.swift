//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import UIKit

typealias WeatherViewType = UIViewController & WeatherViewProtocol

struct WeatherViewCallbacks {
    var viewDidLoadEvent: (() -> Void)?
    var didTapMenuBarButton: (() -> Void)?
}

protocol WeatherViewProtocol: AnyObject {
    var callbacks: WeatherViewCallbacks { get set }
    
    func updateTitle(title: String)
    func update(weather: Weather)
}

final class WeatherViewController: WeatherViewType {
    
    // MARK: - Properties
    
    var retain: Any?
    
    var callbacks = WeatherViewCallbacks()
    
    private lazy var backroundView: UIImageView = {
        let backroundView = UIImageView(image: UIImage(named: "sky_background"))
        backroundView.contentMode = .scaleAspectFill
        
        return backroundView
    }()
    
    private lazy var infoView: WeatherInfoView = {
        let frame = CGRect(
            origin: .zero,
            size: CGSize(width: view.frame.width, height: 220)
        )
        
        return WeatherInfoView(frame: frame)
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableHeaderView = infoView
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 50
        tableView.backgroundColor = .clear
        tableView.register(
            DailyWeatherTableViewCell.self,
            forCellReuseIdentifier: DailyWeatherTableViewCell.identifier
        )
        
        return tableView
    }()
    
    private lazy var menuBarButton = UIBarButtonItem(
        image: UIImage(named: "menu"),
        style: .plain,
        target: self,
        action: #selector(menuBarButtonTapped)
    )
    
    private var dailyWeather = [DailyWeather]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        callbacks.viewDidLoadEvent?()
    }
    
    // MARK: - Internal
    
    func updateTitle(title: String) {
        navigationItem.title = title
    }
    
    func update(weather: Weather) {
        infoView.configure(weather: weather)
        self.dailyWeather = weather.daily
        tableView.reloadData()
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        navigationItem.rightBarButtonItem = menuBarButton
        view.backgroundColor = .white
        view.addSubviews(subviews: [backroundView, tableView])
        
        NSLayoutConstraint.activate([
            backroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func menuBarButtonTapped() {
        callbacks.didTapMenuBarButton?()
    }
}

// MARK: - Extensions

// MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DailyWeatherTableViewCell.identifier,
            for: indexPath) as? DailyWeatherTableViewCell else {
                fatalError("Cant't dequeue DailyWeatherTableViewCell")
        }
        
        cell.configure(dailyWeather: dailyWeather[indexPath.row])
        
        return cell
    }
}
