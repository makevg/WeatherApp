//
//  CitiesListView.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import UIKit

final class CitiesListView: UIView {
    
    // MARK: - Properties
    
    var selectionCallBack: ((City) -> Void)?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(
            CityListCell.self,
            forCellReuseIdentifier: CityListCell.identifier
        )
        
        return tableView
    }()
    
    private var cities = [City]()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    
    func update(cities: [City]) {
        self.cities = cities
        tableView.reloadData()
    }
    
    // MARK: - Private
    
    private func configureSubviews() {
        addSubviews(subviews: [tableView])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - Extensions

// MARK: - UITableViewDelegate

extension CitiesListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        selectionCallBack?(city)
    }
}

// MARK: - UITableViewDataSource

extension CitiesListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityListCell.identifier,
            for: indexPath) as? CityListCell else {
                fatalError("Can't dequeue CityTableViewCell")
        }
        
        cell.configure(city: cities[indexPath.row])
        
        return cell
    }
}

final class CityListCell: UITableViewCell {
    
    private struct Appearance {
        static let nameLabelLeadingAnchorConstant = CGFloat(16)
        static let tempLabelWidthAnchorConstant = CGFloat(70)
        static let tempLabelInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -16)
    }
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: CityListCell.self)
    }
    
    private lazy var nameLabel = UILabel()
    private lazy var tempLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(city: City) {
        nameLabel.text = "\(city.name), \(city.country)"
        tempLabel.text = "\(city.temp)°"
    }
    
    // MARK: - Private
    
    private func configureSubviews() {
        contentView.addSubviews(subviews: [nameLabel, tempLabel])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Appearance.nameLabelLeadingAnchorConstant),
            tempLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
            tempLabel.widthAnchor.constraint(
                equalToConstant: Appearance.tempLabelWidthAnchorConstant),
            tempLabel.leadingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor,
                constant: Appearance.tempLabelInsets.left),
            tempLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Appearance.tempLabelInsets.right)
        ])
    }
}
