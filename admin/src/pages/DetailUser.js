import React, { useState, useEffect } from "react";
import { makeStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import Grid from "@material-ui/core/Grid";
import TextField from "@material-ui/core/TextField";
import FormControl from "@material-ui/core/FormControl";
import OutlinedInput from "@material-ui/core/OutlinedInput";
import InputLabel from "@material-ui/core/InputLabel";
import InputAdornment from "@material-ui/core/InputAdornment";
import Typography from "@material-ui/core/Typography";
import Input from "@material-ui/core/Input";
import axios from "../api/api";
import Button from "@material-ui/core/Button";
import "date-fns";
import DateFnsUtils from "@date-io/date-fns";
import {
  MuiPickersUtilsProvider,
  KeyboardTimePicker,
  KeyboardDatePicker,
} from "@material-ui/pickers";
import { useLocation, useHistory } from "react-router-dom";

const useStyles = makeStyles((theme) => ({
  root: {
    margin: theme.spacing(5),
    flexGrow: 1,
  },
  paper: {
    padding: theme.spacing(2),
    textAlign: "center",
    color: theme.palette.text.secondary,
  },

  margin: {
    marginTop: theme.spacing(2),
  },
}));

function DetailUser(props) {
  const classes = useStyles();

  const [phoneUser, setPhoneUser] = useState();
  const [nameUser, setNameUser] = useState();
  const [emailUser, setEmailUser] = useState();
  const [listCompany, setCompany] = useState([]);
  const [selectedDate, setSelectedDate] = React.useState(new Date());
  const [timeTracking,setTimeTracking] = useState();
  const location = useLocation();
  const history = useHistory();
  const handleDateChange = (date) => {
    setSelectedDate(date);
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var dt = date.getDate();

    if (dt < 10) {
      dt = "0" + dt;
    }
    if (month < 10) {
      month = "0" + month;
    }

    var time = year + "-" + month + "-" + dt;
    console.log(time);
    setTimeTracking(time);
  };

  useEffect(async () => {
    getMe();

  }, []);

  const getID = () => {
    console.log(timeTracking);
  };

  const getMe = () => {
    axios
      .get("http://localhost:908/user/" + location.state.id)
      .then((response) => {
        const user = response.data;
        setPhoneUser(user[0].phone);
        setNameUser(user[0].name);
        setEmailUser(user[0].email);
        const idCompany = user.company;
        console.log(user);
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div className={classes.root}>
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <Paper className={classes.paper}>
            {" "}
            <Typography variant="h3" gutterBottom>
              Profile User
            </Typography>
          </Paper>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Paper className={classes.paper}>
            <Typography variant="h4" gutterBottom>
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
                  value={nameUser}
                />
              </FormControl>
              <FormControl fullWidth className={classes.margin}>
                <InputLabel htmlFor="standard-adornment-amount">
                  Phone
                </InputLabel>
                <Input
                  id="standard-adornment-amount"
                  defaultValue=" "
                  value={phoneUser}
                />
              </FormControl>
              <FormControl fullWidth className={classes.margin}>
                <InputLabel htmlFor="standard-adornment-amount">
                  Email
                </InputLabel>
                <Input
                  id="standard-adornment-amount"
                  defaultValue=" "
                  value={emailUser}
                />
              </FormControl>
              <Button
                variant="contained"
                onClick={getID}
                className={classes.margin}
                color="primary"
                disableElevation
              >
                Edit Profile
              </Button>
            </div>
          </Paper>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Paper className={classes.paper}>
            <Typography variant="h4" gutterBottom>
              Pick Time Tracking
            </Typography>
            <MuiPickersUtilsProvider utils={DateFnsUtils}>
              <Grid container justify="space-around">
                <KeyboardDatePicker
                  disableToolbar
                  variant="inline"
                  format="MM/dd/yyyy"
                  margin="normal"
                  id="date-picker-inline"
                  label="Calender"
                  value={selectedDate}
                  onChange={handleDateChange}
                  KeyboardButtonProps={{
                    "aria-label": "change date",
                  }}
                />
              </Grid>
            </MuiPickersUtilsProvider>
            <Button
              variant="contained"
              onClick={() =>
                history.push({
                  pathname: "/map/",
                  state: { id: location.state.id,timeTrack: timeTracking},
                })
              }
              className={classes.margin}
              color="primary"
              disableElevation
            >
              Tracking User
            </Button>
          </Paper>
        </Grid>
      </Grid>
    </div>
  );
}

export default DetailUser;
