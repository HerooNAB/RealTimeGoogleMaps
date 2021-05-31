import "./App.css";
import React,{useEffect,createContext,useReducer,useContext} from 'react';
import GoogleMap from "./components/GoogleMap";
import {reducer,initialState} from './reducers/userReducer'
import { BrowserRouter, Route, Switch, useHistory } from "react-router-dom";
import AdminPage from "./pages/AdminPage";
import LoginPage from "./pages/LoginPage";
import SignUpUser from "./pages/SignUpUser"
import NameCompanyForm from "./pages/NameCompanyForm";


export const UserContext = createContext();

const Routing = () => {
  const history = useHistory();
  const { state, dispatch } = useContext(UserContext);
  useEffect(() => {
    const user = JSON.parse(localStorage.getItem("user"));
    if (user) {
      dispatch({ type: "USER", payload: user });
    } else {
      if (!history.location.pathname.startsWith("/reset"))
        history.push("/");
    }
  }, []);
  return (
    <Switch>
      <Route exact path="/">
        {/* <SignUpUser/> */}
        <LoginPage/>
      </Route>
      <Route path="/admin">
        <AdminPage />
      </Route>
      <Route path="/login">
        <LoginPage />
      </Route>
      <Route path="/signup">
        <SignUpUser/>
      </Route>

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
