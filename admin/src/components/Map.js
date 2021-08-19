import React, { useState, useEffect } from "react";
import { drawPolyLine, displayMarkers } from "../services/RoadsServices";
import {
  withGoogleMap,
  withScriptjs,
  GoogleMap,
} from "react-google-maps";
import {
  withRouter,
} from "react-router-dom";
import axios from "../api/api";

const optionsPolyline = {
  strokeColor: "red",
  strokeOpacity: 0.8,
  strokeWeight: 3,
  fillColor: "#085daa",
  fillOpacity: 0.35,
  clickable: false,
  draggable: false,
  editable: false,
  visible: true,
  radius: 30000,
  zIndex: 1,
};


const Map = (props) => {
  const [formatLocation, setFormatLocation] = useState([]);
  const getState = props.location.state;
  const consoleLog = () => {
    console.log(getState);
  };
  const RoadsMap = () => {
    //get id User từ layout
    if (getState === undefined) {
      console.log(getState);
    } else {
      const idUser = getState.id;
      const timeTracking = getState.timeTrack;
      console.log(timeTracking);
      axios
        .get(
          "http://localhost:908/location/" + idUser + "?time=" + timeTracking,
          {}
        )
        .then((res) => {
          const locations = res.data.Locations;
          console.log(locations);
          //format Data có định dạng x,y|x2,y2|x3,y3|xn,yn
          //để truyền vào path của Roads Api Google
          var formatData = [];
          for (var i in locations) {
            formatData.push(
              locations[i].latitude + "," + locations[i].longitude
            );
          }
          const locationForRoadsApi = formatData.join("|");
          console.log(locationForRoadsApi);
          axios
            .get("https://roads.googleapis.com/v1/snapToRoads", {
              params: {
                interpolate: true,
                key: "AIzaSyCdNikSpHq1KM6IO_6a1JdjBh2p6tktQ2E",
                path: locationForRoadsApi,
              },
            })
            .then((res) => {
              const dataFromRoadsApi = res.data;
              const getSnappedPoints = dataFromRoadsApi.snappedPoints;
              const getLocation = getSnappedPoints.map(
                (objSnappedPoints) => objSnappedPoints.location
              );
              console.log(dataFromRoadsApi);
              //kinh độ vĩ độ nhận về là latitude và longitude
              //nhưng định dạng vẽ PolyLine là lat và lng nên phải format
              const formatLocation = getLocation.map((objLocation) => {
                return {
                  lat: objLocation.latitude,
                  lng: objLocation.longitude,
                };
              });
              console.log(formatLocation);
              // this.setState({ formatLocation });
              setFormatLocation(formatLocation);
            })
            .catch((error) => console.log(error));
        })
        .catch((error) => console.log(error));
    }
  };

  useEffect(async () => {
    RoadsMap();
  }, []);

  return (
    <div>
      <GoogleMap
        defaultZoom={18}
        defaultCenter={{ lat: 13.061910611629555, lng: 109.3296806799064 }}
      >
        {drawPolyLine(formatLocation)}
        {displayMarkers(formatLocation)}
      </GoogleMap>
    </div>
  );
};

export default withRouter(withScriptjs(withGoogleMap(Map)));
