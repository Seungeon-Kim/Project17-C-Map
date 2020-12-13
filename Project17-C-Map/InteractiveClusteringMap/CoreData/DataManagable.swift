//
//  DataManagable.swift
//  InteractiveClusteringMap
//
//  Created by Oh Donggeon on 2020/11/21.
//

import Foundation
import CoreData

protocol DataManagable {
    
    func deleteAll()
    func delete(coordinate: Coordinate)
    func add(coordinate: Coordinate)
    func update(poi: POI)
    
    func fetch() -> [POIMO]
    func fetch(handler: @escaping ([POIMO]) -> Void)
    
    func fetch(coordinate: Coordinate) -> [POIMO]
    func fetch(coordinate: Coordinate, handler: @escaping ([POIMO]) -> Void)
    func fetch(bottomLeft: Coordinate, topRight: Coordinate) -> [POIMO]
    func fetch(bottomLeft: Coordinate, topRight: Coordinate, handler: @escaping ([POIMO]) -> Void)
   
    func fetchInfo(coordinates: [Coordinate]) -> [POIInfoMO]
    func fetchInfo(coordinate: Coordinate) -> POIInfoMO?
    func fetchInfo(coordinates: [Coordinate], completion: @escaping ([POIInfoMO]) -> Void)
    func fetchInfo(coordinate: Coordinate, completion: @escaping (POIInfoMO?) -> Void)
    
    func save(successHandler: (() -> Void)?, failureHandler: ((NSError) -> Void)?)
    func setValue(_ poi: POI)
    
}
