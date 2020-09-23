//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import UIKit
import Kingfisher

final class WeatherInfoView: UIView {
    
    private struct Appearance {
        static let tempLabelTopAnchorConstant = CGFloat(16)
        static let tempLabelCenterXAnchorConstant = CGFloat(-10)
        static let iconImageViewSize = CGSize(width: 50, height: 50)
        static let iconImageViewLeadingAnchorConstant = CGFloat(8)
        static let infoLabelTopAnchorConstant = CGFloat(10)
        static let feelLikesLabelTopAnchorConstant = CGFloat(10)
        static let windContentViewSize = CGSize(width: 250, height: 25)
        static let windContentViewTopAnchorConstant = CGFloat(8)
        static let pressureContentViewTopAnchorConstant = CGFloat(8)
        static let humidityContentViewTopAnchorConstant = CGFloat(8)
    }
    
    // MARK: - Properties
    
    private lazy var tempLabel = UILabel()
    private lazy var infoLabel = UILabel()
    private lazy var feelLikesLabel = UILabel()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var windContentView = WeatherContentView()
    private lazy var pressureContentView = WeatherContentView()
    private lazy var humidityContentView = WeatherContentView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    
    func configure(weather: Weather) {
        tempLabel.text = "\(weather.temp)°"
        infoLabel.text = weather.info?.description ?? ""
        feelLikesLabel.text = "Ощущается как \(weather.feelsLike)°"
        iconImageView.kf.setImage(with: URL(string: weather.info?.iconUrl ?? ""))
        windContentView.text = "\(weather.windSpeed) м/с"
        windContentView.isHidden = false
        pressureContentView.text = "\(weather.pressure) мм рт. ст."
        pressureContentView.isHidden = false
        humidityContentView.text = "\(weather.humidity) %"
        humidityContentView.isHidden = false
    }
    
    // MARK: - Private
    
    private func configureSubviews() {
        backgroundColor = .clear
        
        windContentView.icon = UIImage(named: "wind")
        windContentView.isHidden = true
        pressureContentView.icon = UIImage(named: "pressure")
        pressureContentView.isHidden = true
        humidityContentView.icon = UIImage(named: "humidity")
        humidityContentView.isHidden = true
        
        addSubviews(subviews: [
            tempLabel,
            iconImageView,
            infoLabel,
            feelLikesLabel,
            windContentView,
            pressureContentView,
            humidityContentView]
        )
        
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: Appearance.tempLabelTopAnchorConstant),
            tempLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor,
                constant: Appearance.tempLabelCenterXAnchorConstant),
            
            iconImageView.widthAnchor.constraint(
                equalToConstant: Appearance.iconImageViewSize.width),
            iconImageView.heightAnchor.constraint(
                equalToConstant: Appearance.iconImageViewSize.height),
            iconImageView.centerYAnchor.constraint(
                equalTo: tempLabel.centerYAnchor),
            iconImageView.leadingAnchor.constraint(
                equalTo: tempLabel.trailingAnchor,
                constant: Appearance.iconImageViewLeadingAnchorConstant),
            
            infoLabel.topAnchor.constraint(
                equalTo: tempLabel.bottomAnchor,
                constant: Appearance.infoLabelTopAnchorConstant),
            infoLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            
            feelLikesLabel.topAnchor.constraint(
                equalTo: infoLabel.bottomAnchor,
                constant: Appearance.feelLikesLabelTopAnchorConstant),
            feelLikesLabel.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            
            windContentView.widthAnchor.constraint(
                equalToConstant: Appearance.windContentViewSize.width),
            windContentView.heightAnchor.constraint(
                equalToConstant: Appearance.windContentViewSize.height),
            
            windContentView.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            windContentView.topAnchor.constraint(
                equalTo: feelLikesLabel.bottomAnchor,
                constant: Appearance.feelLikesLabelTopAnchorConstant),
            
            pressureContentView.widthAnchor.constraint(
                equalTo: windContentView.widthAnchor),
            pressureContentView.heightAnchor.constraint(
                equalTo: windContentView.heightAnchor),
            pressureContentView.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            pressureContentView.topAnchor.constraint(
                equalTo: windContentView.bottomAnchor,
                constant: Appearance.pressureContentViewTopAnchorConstant),
            
            humidityContentView.widthAnchor.constraint(
                equalTo: windContentView.widthAnchor),
            humidityContentView.heightAnchor.constraint(
                equalTo: windContentView.heightAnchor),
            humidityContentView.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            humidityContentView.topAnchor.constraint(
                equalTo: pressureContentView.bottomAnchor,
                constant: Appearance.humidityContentViewTopAnchorConstant),
        ])
    }
}

final class WeatherContentView: UIView {
    
    private struct Appearance {
        static let iconImageViewSize = CGSize(width: 25, height: 25)
        static let textLabelInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
    }
    
    // MARK: - Properties
    
    var icon: UIImage? {
        didSet { iconImageView.image = icon }
    }
    
    var text: String? {
        didSet { textLabel.text = text }
    }
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var textLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configureSubviews() {
        backgroundColor = .clear
        addSubviews(subviews: [iconImageView, textLabel])
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(
                equalToConstant: Appearance.iconImageViewSize.width),
            iconImageView.heightAnchor.constraint(
                equalToConstant: Appearance.iconImageViewSize.height),
            iconImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor),
            textLabel.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            textLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: Appearance.textLabelInsets.left),
            textLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Appearance.textLabelInsets.right)
        ])
    }
}
