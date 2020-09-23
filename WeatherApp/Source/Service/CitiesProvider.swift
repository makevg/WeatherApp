//
//  CitiesProvider.swift
//  WeatherApp
//
//  Created by Maximychev Evgeny on 22.09.2020.
//  Copyright © 2020 Evgeny Maximychev. All rights reserved.
//

import CoreData

final class CitiesProvider {
    
    // MARK: - Properties
    
    static let shared = CitiesProvider()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cities")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Init
    
    init() {
        prepareInitialData()
    }
    
    // MARK: - Internal
    
    func fetchCities() -> [City] {
        fetchCityModels().map { City(entity: $0) }
    }
    
    func addCity(_ city: City) {
        var cityModel = getCityModel(by: city.id)
        
        if cityModel == nil {
            cityModel = CityModel(context: persistentContainer.viewContext)
        }
        
        cityModel?.id = Int32(city.id)
        cityModel?.name = city.name
        cityModel?.country = city.country
        cityModel?.temp = city.temp
        cityModel?.lat = city.lat
        cityModel?.lon = city.lon
        
        saveContext()
    }
    
    // MARK: - Private
    
    private func prepareInitialData() {
        let moscow = City(id: 524901, name: "Moscow", country: "RU", temp: 0, lon: 55.7522, lat: 37.6156)
        let stPetersburg = City(id: 498817, name: "Saint Petersburg", country: "RU", temp: 0, lon: 30.2642, lat: 59.8944)
        [moscow, stPetersburg].forEach { addCity($0) }
    }
    
    private func getCityModel(by id: Int) -> CityModel? {
        fetchCityModels().first(where: { $0.id == id })
    }
    
    private func fetchCityModels() -> [CityModel] {
        var models = [CityModel]()
        
        do {
            models = try persistentContainer.viewContext.fetch(CityModel.fetchRequest())
        } catch {
            fatalError("ERROR: CityModels fetching failed")
        }
        
        return models
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - Extensions

private extension City {
    init(entity: CityModel) {
        self.id = Int(entity.id)
        self.name = entity.name ?? ""
        self.country = entity.country ?? ""
        self.temp = entity.temp
        self.lat = entity.lat
        self.lon = entity.lon
    }
}
