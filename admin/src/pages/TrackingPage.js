import React, { useState, useEffect } from "react";
import Avatar from "@material-ui/core/Avatar";
import Button from "@material-ui/core/Button";
import CssBaseline from "@material-ui/core/CssBaseline";
import TextField from "@material-ui/core/TextField";
import FormControlLabel from "@material-ui/core/FormControlLabel";
import Checkbox from "@material-ui/core/Checkbox";
import Link from "@material-ui/core/Link";
import Paper from "@material-ui/core/Paper";
import Box from "@material-ui/core/Box";
import Grid from "@material-ui/core/Grid";
import LockOutlinedIcon from "@material-ui/icons/LockOutlined";
import Typography from "@material-ui/core/Typography";
import { makeStyles } from "@material-ui/core/styles";
import { FormControl } from "@material-ui/core";
import { InputLabel } from "@material-ui/core";
import { Input } from "@material-ui/core";
import GoogleMap from "../components/GoogleMap";
function Copyright() {
  return (
    <Typography variant="body2" color="textSecondary" align="center">
      {"Copyright © "}
      <Link color="inherit" href="https://material-ui.com/">
        Your Website
      </Link>{" "}
      {new Date().getFullYear()}
      {"."}
    </Typography>
  );
}

const useStyles = makeStyles((theme) => ({
  root: {
    height: "100vh",
  },
  image: {
    backgroundRepeat: "no-repeat",
    backgroundColor:
      theme.palette.type === "light"
        ? theme.palette.grey[50]
        : theme.palette.grey[900],
    backgroundSize: "cover",
    backgroundPosition: "center",
  },
  paper: {
    margin: theme.spacing(8, 4),
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.secondary.main,
  },
  form: {
    width: "100%", // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  margin: {
    marginTop: theme.spacing(2),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
  container: {
    display: "flex",
    flexWrap: "wrap",
  },
  textField: {
    marginLeft: theme.spacing(1),
    marginRight: theme.spacing(1),
    width: 200,
  },
}));

export default function TrackingPage() {
  const classes = useStyles();
  const [currentTime, setCurrentTime] = useState();

  useEffect(async () => {
    getCurrentTime();
  }, []);
  function getCurrentTime() {
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, "0");
    var mm = String(today.getMonth() + 1).padStart(2, "0"); //January is 0!
    var yyyy = today.getFullYear();
    today = yyyy + "-" + mm + "-" + dd;
    setCurrentTime(today);
    console.log(today);
  }

  return (
    <Grid container component="main" className={classes.root}>
      <CssBaseline />

      <Grid item xs={12} sm={4} md={4} elevation={6} square>
        <div className={classes.paper}>
          <Typography component="h1" variant="h5"></Typography>
          <form className={classes.form} noValidate>
         
          <Typography variant="h5" gutterBottom>
              Information User
            </Typography>
            <div className={classes.margin}>
              <FormControl fullWidth className={classes.margin}>
                <InputLabel htmlFor="standard-adornment-amount">
                  Name
                </InputLabel>
                <Input
                  id="standard-adornment-amount"
                  defaultValue=" "
                />
              </FormControl>
              <FormControl fullWidth className={classes.margin}>
                <InputLabel htmlFor="standard-adornment-amount">
                  Phone
                </InputLabel>
                <Input
                  id="standard-adornment-amount"
                  defaultValue=" "
                />
              </FormControl>
              <FormControl fullWidth className={classes.margin}>
                <InputLabel htmlFor="standard-adornment-amount">
                  Email
                </InputLabel>
                <Input
                  id="standard-adornment-amount"
                  defaultValue=" "
     
                />
              </FormControl>
              <FormControl fullWidth className={classes.margin}>
              <TextField
              id="date"
              label="Select Time Tracking"
              type="date"
              value={currentTime}
              className={classes.margin}
              InputLabelProps={{
                shrink: true,
              }}
            />
              </FormControl>
              <Button
                variant="contained"
                className={classes.margin}
                color="primary"
                disableElevation
              >
                Tracking
              </Button>
            </div>
          </form>
        </div>
      </Grid>
      <Grid
        item
        xs={12}
        sm={8}
        md={8}
        component={GoogleMap}
        elevation={6}
        square
      ></Grid>
    </Grid>
  );
}
