//
//  MapView.swift
//  BucketList
//
//  Created by Bruce on 2020/5/19.
//  Copyright © 2020 JFF147. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import MapKit

struct MapView: UIViewRepresentable {
  var annotations: [MKPointAnnotation]
  @Binding var centerCoordinate: CLLocationCoordinate2D
  @Binding var selectedPlace: MKPointAnnotation?
  @Binding var showingPlaceDetails: Bool
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    
    let annotation = MKPointAnnotation()
    annotation.title = "London"
    annotation.subtitle = "Captial of England"
    annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
    mapView.addAnnotation(annotation)
    
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    if annotations.count != uiView.annotations.count {
      uiView.removeAnnotations(uiView.annotations)
      uiView.addAnnotations(annotations)
    }
  }
  
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
      self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      guard let placemark = view.annotation as? MKPointAnnotation else { return }
      parent.selectedPlace = placemark
      parent.showingPlaceDetails = true
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      print(mapView.centerCoordinate)
      parent.centerCoordinate = mapView.centerCoordinate
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let identifier = "Placemark"
      var annoView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      if annoView == nil {
        annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annoView?.canShowCallout = true
        annoView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      } else {
        annoView?.annotation = annotation
      }
      
      return annoView
    }
  }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

extension MKPointAnnotation : ObservableObject {
  public var wrappedTitle: String {
    get {
      self.title ?? "Unknown value"
    }
    
    set {
      title = newValue
    }
  }

  public var wrappedSubtitle: String {
      get {
          self.subtitle ?? "Unknown value"
      }

      set {
          subtitle = newValue
      }
  }
}
