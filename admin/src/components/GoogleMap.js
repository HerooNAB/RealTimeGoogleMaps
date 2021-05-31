import React from "react";
import axios from "../api/api";
import { drawPolyLine, displayMarkers } from "../services/RoadsServices";
import { Map, GoogleApiWrapper } from "google-maps-react";

class GoogleMap extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      restrictApiKey: "AIzaSyDJ8qtUhVb7se1VMUsNugrAY6EZIEnJoVg",
      formatLocation: [],
      formatLocationFromUser: [],
      locationForRoadsApi: "",
    };
  }

  componentDidMount() {
    axios
      .get(`http://localhost:908/alllocation`)
      .then((res) => {
        const locations = res.data.Locations;
        console.log(locations);
        this.setState({ locations });
        //format Data có định dạng x,y|x2,y2|x3,y3|xn,yn
        //để truyền vàio path của Roads Api Google
        var formatData = [];
        for (var i in locations) {
          formatData.push(locations[i].latitude + "," + locations[i].longitude);
        }
        const locationForRoadsApi = formatData.join("|");
        console.log(locationForRoadsApi);
        this.setState({ locationForRoadsApi });
        axios
          .get(`https://roads.googleapis.com/v1/snapToRoads`, {
            params: {
              interpolate: true,
              key: this.state.restrictApiKey,
              path: this.state.locationForRoadsApi,
            },
          })
          .then((res) => {
            const dataFromRoadsApi = res.data;
            const getSnappedPoints = dataFromRoadsApi.snappedPoints;
            const getLocation = getSnappedPoints.map(
              (objSnappedPoints) => objSnappedPoints.location
            );
            //kinh độ vĩ độ nhận về là latitude và longitude
            //nhưng định dạng vẽ PolyLine là lat và lng nên phải format
            const formatLocation = getLocation.map((objLocation) => {
              return { lat: objLocation.latitude, lng: objLocation.longitude };
            });
            this.setState({ formatLocation });
          })
          .catch((error) => console.log(error));
      })
      .catch((error) => console.log(error));
  }
  render() {
    return (
      <div>
        <Map
          google={this.props.google}
          initialCenter={{
            lat: 10.7594539034668,
            lng: 106.70986137692772,
          }}
          zoom={18}
        >
          {displayMarkers(this.state.formatLocation)}
          {drawPolyLine(this.state.formatLocation)}
        </Map>
      </div>
    );
  }
}

export default GoogleApiWrapper({
  apiKey: "AIzaSyDJ8qtUhVb7se1VMUsNugrAY6EZIEnJoVg",
})(GoogleMap);
