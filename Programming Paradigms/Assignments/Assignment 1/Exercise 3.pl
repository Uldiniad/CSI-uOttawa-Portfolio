distance(Latitude1,Longitude1,Latitude2,Longitude2,Distance) :- toRadians(Latitude1,Lat1), toRadians(Latitude2,Lat2), toRadians(Longitude1,Lon1), toRadians(Longitude2,Lon2), Distance is 6371*2*asin(sqrt(((sin((Lat1-Lat2)/2))^2)+cos(Lat1)*cos(Lat2)*((sin((Lon1-Lon2)/2))^2))).

toRadians(Degrees, Radians) :- Radians is Degrees*(pi/180).