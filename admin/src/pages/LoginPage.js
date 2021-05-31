import React, { useState, useContext } from "react";
import { UserContext } from "../App";
import Avatar from "@material-ui/core/Avatar";
import Button from "@material-ui/core/Button";
import CssBaseline from "@material-ui/core/CssBaseline";
import TextField from "@material-ui/core/TextField";
import FormControlLabel from "@material-ui/core/FormControlLabel";
import Checkbox from "@material-ui/core/Checkbox";
import { useHistory } from "react-router-dom";
import Link from "@material-ui/core/Link";
import Grid from "@material-ui/core/Grid";
import Box from "@material-ui/core/Box";
import Typography from "@material-ui/core/Typography";
import { makeStyles } from "@material-ui/core/styles";
import Container from "@material-ui/core/Container";
import AirportShuttleIcon from "@material-ui/icons/AirportShuttle";
import handleLogin from "../api/api";
import axios from "axios";
import M from 'materialize-css';

import jwt from 'jwt-decode'

const useStyles = makeStyles((theme) => ({
  paper: {
    marginTop: theme.spacing(8),
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.primary.light,
  },
  form: {
    width: "100%", // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
}));

export default function SignIn() {
  const { state, dispatch } = useContext(UserContext);
  const history = useHistory();
  const classes = useStyles();
  const [phone, setPhone] = useState();
  const [password, setPassword] = useState();

  const handlePhoneChange = (event) => {
    setPhone(event.target.value);
  };

  const handlePasswordChange = (event) => {
    setPassword(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    var toastHTML = '<span>I am toast content</span><button class="btn-flat toast-action">Undo</button>';
    if(!/(03|07|08|09|01[2|6|8|9])+([0-9]{8})\b/.test(phone)){
      M.toast({html: 'I am a toast!', classes: 'rounded'})
      return
  }
    axios
      .post("http://localhost:908/user/signin", { phone: phone, password: password })
      .then((response) => {
        const token = response.data.token;
        const user = jwt(token);
        console.log(token);
        console.log(user.user.role);
        const userRole = user.user.role;
        if (userRole === "admin") {
          localStorage.setItem("accessToken", response.data.token);
          localStorage.setItem("user", JSON.stringify(user.user));
          dispatch({ type: "USER", payload: user.user });
          M.toast({html:"signedin success",classes:"#43a047 green darken-1"})
          history.push("/admin");
        }
        else{
          history.push('/')
          console.log("Khong phai admin")
        }
      })
      

      .catch((error) => {
        console.log(error);
      });

  };

  return (
    <Container component="main" maxWidth="xs">
      <CssBaseline />
      <div className={classes.paper}>
        <Avatar className={classes.avatar}>
          <AirportShuttleIcon />
        </Avatar>
        <Typography component="h1" variant="h5">
          Sign in
        </Typography>
        <form className={classes.form} noValidate>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="phone"
            label="Phone Number"
            name="phone"
            autoFocus
            onChange={handlePhoneChange}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            name="password"
            label="Password"
            type="password"
            id="password"
            // autoComplete="current-password"
            onChange={handlePasswordChange}
          />
          <FormControlLabel
            control={<Checkbox value="remember" color="primary" />}
            label="Remember me"
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            className={classes.submit}
            onClick={handleSubmit}
          >
            Sign In
          </Button>
          <Grid container>
            <Grid item xs>
              <Link href="#" variant="body2">
                Forgot password?
              </Link>
            </Grid>
            <Grid item>
              <Link href="#" variant="body2">
                {"Don't have an account? Sign Up"}
              </Link>
            </Grid>
          </Grid>
        </form>
      </div>
      <Box mt={8}></Box>
    </Container>
  );
}
