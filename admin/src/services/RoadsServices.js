import {
  Marker,
  Polyline,
} from "react-google-maps";

const optionsPolyline = {
  strokeColor: 'blue',
  strokeOpacity: 1,
  strokeWeight: 8,
  fillColor: '#085daa',
  fillOpacity: 0.35,
  clickable: false,
  draggable: false,
  editable: false,
  visible: true,
  radius: 30000,
  zIndex: 1
};

export const drawPolyLine = (inputPath) => {
    return (
      <Polyline
          path={inputPath}
          options={optionsPolyline}
        />
    );
};


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

  