import {Polyline, Marker} from "google-maps-react";
export const drawPolyLine = (inputPath) => {
    return (
      <Polyline
          path={inputPath}
          strokeColor="#0000FF"
          strokeOpacity={1}
          strokeWeight={10}
        />
    );
};


export const DataCollection = () => {
  
}

export const displayMarkers = (inputLocation) => {
    return inputLocation.map((location, index) => {
      return (
        <Marker
          key={index}
          id={index}
          position={{
            lat: location.lat,
            lng: location.lng,
          }}
          onClick={() => console.log(location.lat + " " + location.lng)}
        />
      );
    });
  };

  