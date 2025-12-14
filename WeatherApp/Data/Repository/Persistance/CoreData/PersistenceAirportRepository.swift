//
//  PersistenceAirportRepository.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import CoreData

final class PersistenceAirportRepository{
    private let context: NSManagedObjectContext
    private let defaultAirports: [String]
    
    init(defaultAirports: [String] = ["kpwm", "kaus"], container: NSPersistentContainer) {
        self.context = container.viewContext
        self.defaultAirports = defaultAirports
    }
}

extension PersistenceAirportRepository: PersistenceAirportLoading {
    func loadAirports() async throws -> [String] {
        try await context.perform {
            let context = self.context
            let request: NSFetchRequest<AirportEntity> = AirportEntity.fetchRequest()
            let results = try context.fetch(request)

            let defaults = self.defaultAirports
            if results.isEmpty {
                defaults.forEach { airport in
                    let entity = AirportEntity(context: context)
                    entity.airportName = airport
                    entity.createdAt = Date()
                }
                try context.save()
                return defaults
            }

            return results.compactMap { $0.airportName }.sorted()
        }
    }

    func addAirport(_ airport: String) async throws {
        let context = self.context
        try await context.perform {
            guard !airport.isEmpty else { return }

            let entity = AirportEntity(context: context)
            entity.airportName = airport.lowercased()
            entity.createdAt = Date()

            try context.save()
        }
    }
    
    func clearCache() async throws {
        try await context.perform {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = AirportEntity.fetchRequest()
            let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDelete.resultType = .resultTypeObjectIDs

            let result = try self.context.execute(batchDelete) as? NSBatchDeleteResult
            if let objectIDs = result?.result as? [NSManagedObjectID], !objectIDs.isEmpty {
                let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: objectIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self.context])
            }
        }
    }
}
