import React, {useState,useEffect} from 'react';
import { Map, GoogleApiWrapper } from "google-maps-react";
 function MapTest(props){
    
    return(
        <div>
        {/* <Button variant="contained" onClick={()=>console.log(this.state.id)} color="primary" disableElevation>
          Disable elevation
        </Button> */}
        <Map
          google={this.props.google}
          initialCenter={{
            lat: 10.7594539034668,
            lng: 106.70986137692772,
          }}
          zoom={18}
        >
          {/* {displayMarkers(this.state.formatLocation)}
          {drawPolyLine(this.state.formatLocation)} */}
        </Map>
      </div>
    )
}

export default GoogleApiWrapper({
    apiKey: "AIzaSyALgtH2HL9jVRze2d4X6423qUQfxbvYRrU",
})(MapTest);