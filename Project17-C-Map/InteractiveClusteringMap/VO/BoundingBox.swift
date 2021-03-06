//
//  BoundingBox.swift
//  InteractiveClusteringMap
//
//  Created by 박성민 on 2020/11/24.
//

import Foundation
import NMapsMap

struct BoundingBox {

    static let korea = BoundingBox(topRight: Coordinate(x: KoreaCoordinate.maxLng, y: KoreaCoordinate.maxLat),
                                   bottomLeft: Coordinate(x: KoreaCoordinate.minLng, y: KoreaCoordinate.minLat))
    let topRight: Coordinate
    let bottomLeft: Coordinate
    
    func splittedQuadBoundingBoxes() -> [BoundingBox] {
        let center = topRight.center(other: bottomLeft)
        return [
            BoundingBox(topRight: center,
                        bottomLeft: bottomLeft),
            BoundingBox(topRight: Coordinate(x: topRight.x, y: center.y),
                        bottomLeft: Coordinate(x: center.x, y: bottomLeft.y)),
            BoundingBox(topRight: Coordinate(x: center.x, y: topRight.y),
                        bottomLeft: Coordinate(x: bottomLeft.x, y: center.y)),
            BoundingBox(topRight: topRight,
                        bottomLeft: center)
        ]
    }
    
    func contains(coordinate: Coordinate) -> Bool {
        let containsX: Bool = (bottomLeft.x <= coordinate.x) && (coordinate.x <= topRight.x)
        let containsY: Bool = (bottomLeft.y <= coordinate.y) && (coordinate.y <= topRight.y)
        
        return (containsX && containsY)
    }
    
    func isOverlapped(with other: BoundingBox) -> Bool {
        self.bottomLeft <= other.topRight && other.bottomLeft <= self.topRight
    }
    
    func boundingBoxToNMGBounds() -> NMGLatLngBounds {
        let southWest = NMGLatLng(lat: bottomLeft.y, lng: bottomLeft.x)
        let northEast = NMGLatLng(lat: topRight.y, lng: topRight.x)
        
        return NMGLatLngBounds(southWest: southWest, northEast: northEast)
    }
    
}

extension BoundingBox: Hashable {
    static func == (lhs: BoundingBox, rhs: BoundingBox) -> Bool {
        return lhs.topRight == rhs.topRight &&
            lhs.bottomLeft == rhs.bottomLeft
    }
}

private extension BoundingBox {
    
    enum KoreaCoordinate {
        static let minLat: Double = 33
        static let maxLat: Double = 43
        static let minLng: Double = 124
        static let maxLng: Double = 132
    }
}
