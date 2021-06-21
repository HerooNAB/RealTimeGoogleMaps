import React, { useContext, useRef, useEffect, useState } from "react";
import { Link, useHistory } from "react-router-dom";
import { UserContext } from "../App";
import M from "materialize-css";
import { makeStyles } from "@material-ui/core/styles";
import AppBar from "@material-ui/core/AppBar";
import Toolbar from "@material-ui/core/Toolbar";
import Typography from "@material-ui/core/Typography";
import Button from "@material-ui/core/Button";
import IconButton from "@material-ui/core/IconButton";
import MenuIcon from "@material-ui/icons/Menu";

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  title: {
    flexGrow: 1,
  },
}));

const NavBar = () => {
  const classes = useStyles();
  const { state, dispatch } = useContext(UserContext);
  const history = useHistory();


  return (
    <AppBar position="static">
      <Toolbar>
        {localStorage.getItem("user") ? (
          <>
            
          </>
        ) : (
          <>
            <Typography variant="h6" className={classes.title}>
              <Link to="/login">LogIn</Link>
              <Link to="/signup">Register</Link>
            </Typography>

          </>
        )}
      </Toolbar>
    </AppBar>
  );
};

export default NavBar;
