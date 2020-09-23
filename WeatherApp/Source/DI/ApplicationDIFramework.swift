//
//  ApplicationDIFramework.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import DITranquillity

final class ApplicationDIFramework: DIFramework {
    
    static func load(container: DIContainer) {
        container.append(part: ApplicationDIPart.self)
        container.append(part: WeatherDIPart.self)
        container.append(part: CitiesDIPart.self)
    }
    
    static var container: DIContainer = {
        DISetting.Defaults.lifeTime = .prototype
        DISetting.Log.tab = "  "

        let container = DIContainer()
        container.append(framework: ApplicationDIFramework.self)
        
        #if DEBUG
            if !container.makeGraph().checkIsValid(checkGraphCycles: false) {
                fatalError("Your write incorrect dependencies graph")
            }
        #endif
        
        return container
    }()
}

private final class ApplicationDIPart: DIPart {
    
    static func load(container: DIContainer) {
        
        // CitiesProvider
        container.register(CitiesProvider.init)
            .lifetime(.single)
        
        // WeatherService
        container.register(WeatherService.init)
            .lifetime(.single)
        
        // Navigator
        container.register(ApplicationNavigator.init)
            .lifetime(.single)
    }
}
