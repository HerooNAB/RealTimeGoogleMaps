import "./App.css";
import React, { useEffect, createContext, useReducer, useContext } from "react";
import GoogleMap from "./components/GoogleMap";
import { reducer, initialState } from "./reducers/userReducer";
import { BrowserRouter, Route, Switch, useHistory } from "react-router-dom";

//import Page
import LoginPage from "./pages/LoginPage";
import SignUpUser from "./pages/SignUpUser";
import ProfileAdmin from "./pages/ProfilePage";
import DashBoard from "./pages/DashBoard";
import Layout from "./components/Layout";
import LogisticPage from "./pages/TrackingPage";
import DetailUser from "./pages/DetailUser";
//import components
import NavBar from "./components/Navbar";
import MapTest from "./components/MapTest";
import TrackingPage from "./pages/TrackingPage";

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
        <LoginPage />
      </Route>
      <Layout>
        <Route path="/map">
          <GoogleMap />
          {/* <MapTest/> */}
        </Route>
        <Route path="/dashboard">
          <DashBoard />
        </Route>
        <Route path="/admin">
          <TrackingPage/>
        </Route>
        <Route path="/login">
          <LoginPage />
        </Route>
        <Route path="/signup">
          <SignUpUser />
        </Route>
        <Route path="/profile">
          <ProfileAdmin />
        </Route>
        <Route path="/user">
          <DetailUser/>
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
        {/* <NavBar /> */}
        <Routing />
      </BrowserRouter>
    </UserContext.Provider>
  );
}

export default App;
