//
//  DailyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import UIKit
import Kingfisher

final class DailyWeatherTableViewCell: UITableViewCell {
    
    private struct Appearance {
        static let dateLabelInsets = UIEdgeInsets(top: 4, left: 20, bottom: 0, right: 0)
        static let dayLabelInsets = UIEdgeInsets(top: 2, left: 0, bottom: -4, right: 0)
        static let iconImageViewSize = CGSize(width: 30, height: 30)
        static let iconImageViewInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        static let tempMinLabelWidthAnchorConstant = CGFloat(70)
        static let tempMinLabelTrailingAnchorConstant = CGFloat(-16)
        static let tempMaxLabelTrailingAnchorConstant = CGFloat(-8)
    }
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: DailyWeatherTableViewCell.self)
    }
    
    private lazy var dateLabel = UILabel()
    private lazy var dayLabel = UILabel()
    private lazy var tempMaxLabel = UILabel()
    private lazy var tempMinLabel = UILabel()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    
    func configure(dailyWeather: DailyWeather) {
        dateLabel.text = dailyWeather.date.dateFormattedString
        dayLabel.text = dailyWeather.date.weekDayFormattedString
        tempMaxLabel.text = dailyWeather.tempMax.tempString
        tempMinLabel.text = dailyWeather.tempMin.tempString
        iconImageView.kf.setImage(with: URL(string: dailyWeather.info?.iconUrl ?? ""))
    }
    
    // MARK: - Private
    
    private func configureSubviews() {
        backgroundColor = .clear
        contentView.addSubviews(subviews:
            [dateLabel, dayLabel, iconImageView, tempMaxLabel, tempMinLabel]
        )
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Appearance.dateLabelInsets.top),
            dateLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Appearance.dateLabelInsets.left),
            
            dayLabel.topAnchor.constraint(
                equalTo: dateLabel.bottomAnchor,
                constant: Appearance.dayLabelInsets.top),
            dayLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Appearance.dayLabelInsets.bottom),
            dayLabel.leadingAnchor.constraint(
                equalTo: dateLabel.leadingAnchor),
            
            iconImageView.widthAnchor.constraint(
                equalToConstant: Appearance.iconImageViewSize.width),
            iconImageView.heightAnchor.constraint(
                equalToConstant: Appearance.iconImageViewSize.height),
            iconImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(
                equalTo: dateLabel.trailingAnchor,
                constant: Appearance.iconImageViewInsets.left),
            iconImageView.trailingAnchor.constraint(
                equalTo: tempMaxLabel.leadingAnchor,
                constant: Appearance.iconImageViewInsets.right),
            
            tempMinLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
            tempMinLabel.widthAnchor.constraint(
                equalToConstant: Appearance.tempMinLabelWidthAnchorConstant),
            tempMinLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Appearance.tempMinLabelTrailingAnchorConstant),
            
            tempMaxLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
            tempMaxLabel.widthAnchor.constraint(
                equalTo: tempMinLabel.widthAnchor),
            tempMaxLabel.trailingAnchor.constraint(
                equalTo: tempMinLabel.leadingAnchor,
                constant: Appearance.tempMaxLabelTrailingAnchorConstant)
        ])
    }
}
