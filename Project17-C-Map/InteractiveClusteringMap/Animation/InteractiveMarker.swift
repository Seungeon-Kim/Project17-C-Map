//
//  InteractiveMarker.swift
//  InteractiveClusteringMap
//
//  Created by eunjeong lee on 2020/11/29.
//

import Foundation
import NMapsMap

final class InteractiveMarker: NMFMarker {
    
    let coordinate: Coordinate
    private let coordinatesCount: Int
    private(set) var markerLayer: ClusteringMarkerLayer
    
    required init(cluster: Cluster) {
        self.coordinate = cluster.center
        self.coordinatesCount = cluster.coordinates.count
        self.markerLayer = ClusteringMarkerLayer(cluster: cluster)
        super.init()
        position = NMGLatLng(lat: cluster.center.y, lng: cluster.center.x)
        
        let uiImage = imageFromLayer(layer: markerLayer)
        configure(image: uiImage)
    }
    
    func configure(image: UIImage) {
        iconImage = NMFOverlayImage(image: image)
        
        switch coordinatesCount {
        case 1..<ClusteringColor.hundred.rawValue:
            iconTintColor = ClusteringColor.hundred.value
        case ClusteringColor.hundred.rawValue..<ClusteringColor.thousand.rawValue:
            iconTintColor = ClusteringColor.thousand.value
        case ClusteringColor.thousand.rawValue..<ClusteringColor.tenThousand.rawValue:
            iconTintColor = ClusteringColor.tenThousand.value
        default:
            iconTintColor = ClusteringColor.hundredThousand.value
        }
        
        anchor = CGPoint(x: 0.5, y: 0.5)
        alpha = 0.8
    }

    func imageFromLayer(layer: CALayer) -> UIImage {
        let originalColor = layer.backgroundColor
        
        defer {
            layer.backgroundColor = originalColor
        }
        
        layer.backgroundColor = UIColor.black.cgColor
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0)
        
        guard let uiGraphicsGetCurrentContext = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        
        layer.render(in: uiGraphicsGetCurrentContext)
        
        guard let outputImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext()
        
        return outputImage
    }
    
}

extension InteractiveMarker: NMFOverlayImageDataSource {
    
    func view(with overlay: NMFOverlay) -> UIView {
        guard let marker = overlay as? NMFMarker else { return UIView() }
        
        let markerView = UIImageView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: marker.iconImage.imageWidth,
                                                   height: marker.iconImage.imageHeight))
        return markerView
    }
}