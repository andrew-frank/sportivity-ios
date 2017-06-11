//
//  MapViewController.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 08/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

private struct MapViewControllerConstants {
    static let annotationReuseId = "ann"
}

private typealias C = MapViewControllerConstants

class MapViewController: UIViewController, ViewControllerProtocol, Configurable  {

    /// Tag of the view
    let viewTag : ViewTag = .events
    /// Main `DisposeBag` of the `ViewController`
    let disposeBag = DisposeBag()
    /// Observable that informs that `Router` should route to the `Route`
    let onRouteTo : Observable<Route> = PublishSubject<Route>()

    @IBOutlet weak var mapView: MKMapView!
    var viewModel: MapViewModel! = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        let center = CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegionMake(center, span)
        mapView.setRegion(region, animated: false)
        bind()
    }
}

private extension MapViewController {
    func bind() {
        viewModel
            .placeAnnotations
            .asObservable()
            .delay(1, scheduler: MainScheduler.instance)
            .subscribeNext { [unowned self] (annotations) in
                self.mapView.addAnnotations(annotations)
            }
            .addDisposableTo(disposeBag)
    }
}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: C.annotationReuseId) as? MKPinAnnotationView
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: C.annotationReuseId)
            if #available(iOS 9.0, *) {
                view?.pinTintColor = R.color.sportivity.mellowYellow.color()
            } else {
                view?.pinColor = .purple
            }
        } else {
            view?.annotation = annotation
        }
        return view
    }
}
