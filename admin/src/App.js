import "./App.css";
import React, {
  useEffect,
  createContext,
  useReducer,
  useContext,
  useRef,
} from "react";
import GoogleMap from "./components/GoogleMap";
import { reducer, initialState } from "./reducers/userReducer";
import { BrowserRouter, Route, Switch, useHistory } from "react-router-dom";

//import Page
import LoginPage from "./pages/LoginPage";
import SignUpUser from "./pages/SignUpUser";
import ProfileAdmin from "./pages/ProfilePage";
import DashBoard from "./pages/DashBoard";
import Layout from "./components/Layout";
import DetailUser from "./pages/DetailUser";
import HomePage from "./pages/HomePage";
import ControlledOpenSelect from "./pages/Demo";
//import components

import Map from "./components/Map";

export const UserContext = createContext();

const Routing = () => {
  const history = useHistory();
  const { state, dispatch } = useContext(UserContext);
  useEffect(() => {
    const user = JSON.parse(localStorage.getItem("user"));
    if (user) {
      dispatch({ type: "USER", payload: user });
    } else {
      if (!history.location.pathname.startsWith("/reset")) history.push("/");
    }
  }, []);
  return (
    <Switch>
      <Route exact path="/">
        {/* <HomePage /> */}
        <HomePage/>
      </Route>
      <Route path="/signin">
        <LoginPage />
      </Route>
      <Route path="/signup">
        <SignUpUser />
      </Route>
      <Layout>
        <Route path="/maptest">
          <GoogleMap />
        </Route>
        <Route path="/dashboard">
          <DashBoard />
        </Route>
        <Route path="/login">
          <LoginPage />
        </Route>
        <Route path="/profile">
          <ProfileAdmin />
        </Route>
        <Route path="/user">
          <DetailUser />
        </Route>
        <Route path="/demo">
          <ControlledOpenSelect/>
        </Route>
        <Route path="/map">
          <Map
            googleMapURL={`https://maps.googleapis.com/maps/api/js?key=AIzaSyCdNikSpHq1KM6IO_6a1JdjBh2p6tktQ2E&callback=initMap`}
            loadingElement={<div style={{ height: `100%` }} />}
            containerElement={
              <div
                style={{
                  height: `90vh`,
                  margin: `auto`,
                  border: "2px solid black",
                }}
              />
            }
            mapElement={<div style={{ height: `100%` }} />}
          />
        </Route>
      </Layout>
    </Switch>
  );
};

function App() {
  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <UserContext.Provider value={{ state, dispatch }}>
      <BrowserRouter>
        <Routing />
      </BrowserRouter>
    </UserContext.Provider>
  );
}

export default App;
