//
//  MapKitUtilities.h
//  urbanspin
//
//  Created by JASON CROSS on 7/9/13.
//  Copyright (c) 2013 Urbanspoon. All rights reserved.
//

#ifndef urbanspin_MapKitUtilities_h
#define urbanspin_MapKitUtilities_h

static inline MKMapRect mapRectForCoordinateRegion(MKCoordinateRegion coordinateRegion) {
    CLLocationCoordinate2D topLeftCoordinate =
    CLLocationCoordinate2DMake(coordinateRegion.center.latitude
                               + (coordinateRegion.span.latitudeDelta/2.0),
                               coordinateRegion.center.longitude
                               - (coordinateRegion.span.longitudeDelta/2.0));
    
    MKMapPoint topLeftMapPoint = MKMapPointForCoordinate(topLeftCoordinate);
    
    CLLocationCoordinate2D bottomRightCoordinate =
    CLLocationCoordinate2DMake(coordinateRegion.center.latitude
                               - (coordinateRegion.span.latitudeDelta/2.0),
                               coordinateRegion.center.longitude
                               + (coordinateRegion.span.longitudeDelta/2.0));
    
    MKMapPoint bottomRightMapPoint = MKMapPointForCoordinate(bottomRightCoordinate);
    
    MKMapRect mapRect = MKMapRectMake(topLeftMapPoint.x,
                                      topLeftMapPoint.y,
                                      fabs(bottomRightMapPoint.x-topLeftMapPoint.x),
                                      fabs(bottomRightMapPoint.y-topLeftMapPoint.y));
    return mapRect;
}

//static inline CGFloat radiusInMetersOfMapRect(MKMapRect mapRect) {
//    MKMapPoint origin = mapRect.origin;
//    MKMapPoint southWestPoint = MKMapPointMake(origin.x,
//                                               origin.y - mapRect.size.height);
//    MKMapPoint northEastPoint = MKMapPointMake(origin.x + mapRect.size.width,
//                                               origin.y);
//    
//    CLLocationDistance width = MKMetersBetweenMapPoints(origin, northEastPoint);
//    CLLocationDistance height = MKMetersBetweenMapPoints(origin, southWestPoint);
//    CGFloat diameterMeters = fmin(width, height);
//    CGFloat radiusMeters = diameterMeters * 0.5f / kUSPAnnotationRegionPadFactor;
//    return radiusMeters;
//}
//
//static inline CGFloat radiusInMilesOfMapRect(MKMapRect mapRect) {
//    CGFloat radiusMeters = radiusInMetersOfMapRect(mapRect);
//    CGFloat radiusMiles = radiusMeters * kUSPConversionFactorMetersToMiles;
//    return radiusMiles;
//}


static inline BOOL coordinatesAreEqualToDecimals(CLLocationCoordinate2D firstCoordinate, CLLocationCoordinate2D secondCoordinate, int decimalPlaces) {
    int decimalsToShift = (decimalPlaces > 0) ? decimalPlaces : 1;
    int m = 10 * decimalsToShift;
    BOOL latitudesAreEqual = (int)(m * firstCoordinate.latitude) == (int)(m * secondCoordinate.latitude);
    BOOL longitudesAreEqual = (int)(m * firstCoordinate.longitude) == (int)(m * secondCoordinate.longitude);
    BOOL value = latitudesAreEqual && longitudesAreEqual;
    return value;
}

#endif
