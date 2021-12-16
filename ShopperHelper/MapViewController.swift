import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    let locationModel = LocationModel.shared
    let locationManager = CLLocationManager()
    var initiatedMapCamera = false
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            updateAnnotations()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAnnotations()
    }
    func updateAnnotations() {
        for i in 0..<locationModel.numberOfLocations() {
            let annotations = MKPointAnnotation()
            guard let location = locationModel.getLocation(at: i) else { return }
            annotations.title = location.getName()
            annotations.coordinate = CLLocationCoordinate2D(latitude: location.getLatitude(), longitude: location.getLongitude())
            mapView.addAnnotation(annotations)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if(!initiatedMapCamera){
            mapView.camera = MKMapCamera(lookingAtCenter: locValue, fromEyeCoordinate: locValue, eyeAltitude: 15000)
            initiatedMapCamera = true
        }
        
    }
}
