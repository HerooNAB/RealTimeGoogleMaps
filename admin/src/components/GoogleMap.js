import React, { Component, PureComponent } from "react";
import axios from "../api/api";
import { drawPolyLine, displayMarkers } from "../services/RoadsServices";
import { Map, GoogleApiWrapper } from "google-maps-react";
import {
  useParams,
  withRouter,
  useHistory,
  useLocation,
} from "react-router-dom";
import Button from "@material-ui/core/Button";
import { makeStyles } from "@material-ui/core/styles";
import { withStyles } from '@material-ui/core/styles';
import Paper from "@material-ui/core/Paper";
import Grid from "@material-ui/core/Grid";


// const useStyles = makeStyles((theme) => ({
//   root: {
//     flexGrow: 1,
//   },
//   paper: {
//     padding: theme.spacing(2),
//     textAlign: "center",
//     color: theme.palette.text.secondary,
//   },
// }));



const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
  },
  paper: {
    padding: theme.spacing(2),
    textAlign: 'center',
    color: theme.palette.text.secondary,
  },
}));

class GoogleMap extends Component {
  constructor(props) {
    super(props);
    this.state = {
      restrictApiKey: "AIzaSyBBlCjhbUgXc85_yqcce_NgiUeA_89N8AI",
      formatLocation: [],
      formatLocationFromUser: [],
      locationForRoadsApi: "",
    };
  }

  


  componentDidMount() {
    //get id User từ layout
    const getState = this.props.location.state;
    if (getState === undefined) {
      console.log(getState);
    } else {
      const idUser = getState.id;
      const timeTracking = getState.timeTrack;
      console.log(timeTracking);
      axios
        .get("http://localhost:908/location/"+idUser+"?time="+timeTracking,{
        })
        .then((res) => {
          const locations = res.data.Locations;
          console.log(locations);
          this.setState({ locations });
          //format Data có định dạng x,y|x2,y2|x3,y3|xn,yn
          //để truyền vàio path của Roads Api Google
          var formatData = [];
          for (var i in locations) {
            formatData.push(
              locations[i].latitude + "," + locations[i].longitude
            );
          }
          const locationForRoadsApi = formatData.join("|");
          console.log(locationForRoadsApi);
          this.setState({ locationForRoadsApi });
          axios
            .get("https://roads.googleapis.com/v1/snapToRoads", {
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
                return {
                  lat: objLocation.latitude,
                  lng: objLocation.longitude,
                };
              });
              this.setState({ formatLocation });
            })
            .catch((error) => console.log(error));
        })
        .catch((error) => console.log(error));
    }
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
export default withRouter(
  GoogleApiWrapper({
    apiKey: "AIzaSyBBlCjhbUgXc85_yqcce_NgiUeA_89N8AI",
  })(GoogleMap)
);


