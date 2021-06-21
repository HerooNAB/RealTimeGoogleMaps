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

export default function ProfileAdmin() {
  const classes = useStyles();

  const [phoneUser, setPhoneUser] = useState();
  const [nameUser, setNameUser] = useState();
  const [emailUser, setEmailUser] = useState();
  const [listCompany, setCompany] = useState([]);

  useEffect(async () => {
    getMe();
  }, []);

  const getMe = () => {
    axios
      .get("http://localhost:908/user/me")
      .then((response) => {
        const user = response.data;
        setPhoneUser(user.phone);
        setNameUser(user.name);
        setEmailUser(user.email);
        const idCompany = user.company;
        console.log(user);
        axios
          .get("http://localhost:908/company/" + idCompany)
          .then((response) => {
            const company = response.data.Company;
            console.log(company);
            setCompany(company);
          });
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
              Profile Admin
            </Typography>
          </Paper>
        </Grid>
        <Grid item xs={12} sm={6}>
          <Paper className={classes.paper}>
            <Typography variant="h4" gutterBottom>
              Information Admin
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
                onClick={getMe}
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
              Information Company
            </Typography>
            {listCompany.map((item) => (
              <div className={classes.margin}>
                <FormControl fullWidth className={classes.margin}>
                  <InputLabel htmlFor="standard-adornment-amount">
                    Company Name
                  </InputLabel>
                  <Input id="standard-adornment-amount" value={item.name} />
                </FormControl>
                <FormControl fullWidth className={classes.margin}>
                  <InputLabel htmlFor="standard-adornment-amount">
                    Company Phone
                  </InputLabel>
                  <Input id="standard-adornment-amount" value={item.phone} />
                </FormControl>
                <FormControl fullWidth className={classes.margin}>
                  <InputLabel htmlFor="standard-adornment-amount">
                    Compnay Email
                  </InputLabel>
                  <Input id="standard-adornment-amount" value={item.email} />
                </FormControl>
                <FormControl fullWidth className={classes.margin}>
                  <InputLabel htmlFor="standard-adornment-amount">
                    Company Web
                  </InputLabel>
                  <Input id="standard-adornment-amount" value={item.web} />
                </FormControl>
              </div>
            ))}
          </Paper>
        </Grid>
      </Grid>
    </div>
  );
}
