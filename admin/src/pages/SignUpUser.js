import React, { useEffect, useState } from "react";
import { useHistory } from "react-router-dom";
import Grid from "@material-ui/core/Grid";
import Typography from "@material-ui/core/Typography";
import TextField from "@material-ui/core/TextField";
import FormControlLabel from "@material-ui/core/FormControlLabel";
import Checkbox from "@material-ui/core/Checkbox";
import { makeStyles } from "@material-ui/core/styles";
import CssBaseline from "@material-ui/core/CssBaseline";
import AppBar from "@material-ui/core/AppBar";
import Toolbar from "@material-ui/core/Toolbar";
import Paper from "@material-ui/core/Paper";
import Stepper from "@material-ui/core/Stepper";
import Step from "@material-ui/core/Step";
import StepLabel from "@material-ui/core/StepLabel";
import Button from "@material-ui/core/Button";
import axios from "axios";

const useStyles = makeStyles((theme) => ({
  appBar: {
    position: "relative",
  },
  layout: {
    width: "auto",
    marginLeft: theme.spacing(2),
    marginRight: theme.spacing(2),
    [theme.breakpoints.up(600 + theme.spacing(2) * 2)]: {
      width: 600,
      marginLeft: "auto",
      marginRight: "auto",
    },
  },
  paper: {
    marginTop: theme.spacing(3),
    marginBottom: theme.spacing(3),
    padding: theme.spacing(2),
    [theme.breakpoints.up(600 + theme.spacing(3) * 2)]: {
      marginTop: theme.spacing(6),
      marginBottom: theme.spacing(6),
      padding: theme.spacing(3),
    },
  },
  stepper: {
    padding: theme.spacing(3, 0, 5),
  },
  buttons: {
    display: "flex",
    justifyContent: "flex-end",
  },
  button: {
    marginTop: theme.spacing(3),
    marginLeft: theme.spacing(1),
  },
}));

export default function SignUpUser() {
  const steps = ["Input Name Company", "Sign Up"];
  const classes = useStyles();
  const history = useHistory();
  const [activeStep, setActiveStep] = React.useState(0);
  // const [companyToken, setCompanyToken] = useState("");

  

  const handleNext = () => {
    setActiveStep(activeStep + 1);
  };

  const handleBack = () => {
    setActiveStep(activeStep - 1);
  };

  const [companyName, setCompanyName] = useState();
  const handleCompanyNameChange = (event) => {
    setCompanyName(event.target.value);
    // console.log(companyName);
  };

  const [signupAdmin, setSignupAdmin] = useState({
    email: "",
    phone: "",
    name: "",
    password: "",
    role: "admin",
  });

  useEffect(() => {
    if (activeStep === 1) {
      console.log("đăng nhập company");
      console.log(companyName);
      axios
        .post("http://localhost:908/company/signin", {
          name: companyName,
        })
        .then((response) => {
          const token = response.data.token;
          localStorage.setItem("companyToken", token);
          console.log(localStorage.getItem("companyToken"));
        })
        .catch((error) => {
          console.log(error);
        });
    } else if (activeStep === 2) {
      history.push("/login");
      axios
        .post("http://localhost:908/user/signup", signupAdmin, {
          headers: { Authorization: localStorage.getItem("companyToken") },
        })
        .then((response) => {
          
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
    }
  }, [activeStep]);

  function getStepContent(step) {
    switch (step) {
      case 0:
        return (
          <React.Fragment>
            <Typography variant="h6" gutterBottom>
              Input Your Name Company
            </Typography>
            <Grid container spacing={3}>
              <Grid item xs={12}>
                <TextField
                  value={companyName}
                  onChange={handleCompanyNameChange}
                  required
                  id="address1"
                  name="address1"
                  label="Name Company"
                  fullWidth
                  autoComplete="shipping address-line1"
                />
              </Grid>
              <Grid item xs={12}>
                <FormControlLabel
                  control={
                    <Checkbox
                      color="secondary"
                      name="saveAddress"
                      value="yes"
                    />
                  }
                  label="I use this company name"
                />
              </Grid>
            </Grid>
          </React.Fragment>
        );
      case 1:
        return (
          <React.Fragment>
            <Typography variant="h6" gutterBottom>
              Sign Up
            </Typography>
            <Grid container spacing={3}>
              <Grid item xs={12} sm={6}>
                <TextField
                  required
                  id="firstName"
                  name="firstName"
                  label="Email"
                  value = {signupAdmin.email}
                  fullWidth
                  autoComplete="given-name"
                  onChange={(e) =>
                    setSignupAdmin({ ...signupAdmin, email: e.target.value })
                  }
                />
              </Grid>
              <Grid item xs={12} sm={6}>
                <TextField
                  required
                  id="lastName"
                  name="lastName"
                  label="Name"
                  fullWidth
                  autoComplete="family-name"
                  onChange={(e) =>
                    setSignupAdmin({ ...signupAdmin, name: e.target.value })
                  }
                />
              </Grid>
              <Grid item xs={12}>
                <TextField
                  required
                  id="address1"
                  name="Password"
                  label="Phone"
                  fullWidth
                  autoComplete="shipping address-line1"
                  onChange={(e) =>
                    setSignupAdmin({ ...signupAdmin, phone: e.target.value })
                  }
                />
              </Grid>
              <Grid item xs={12}>
                <TextField
                  id="address2"
                  name="address2"
                  label="Password"
                  type="password"
                  fullWidth
                  autoComplete="shipping address-line2"
                  onChange={(e) =>
                    setSignupAdmin({ ...signupAdmin, password: e.target.value })
                  }
                />
              </Grid>
            </Grid>
          </React.Fragment>
        );
      default:
        throw new Error("Unknown step");
    }
  }

  return (
    <React.Fragment>
      <CssBaseline />
      {/* <AppBar position="absolute" color="default" className={classes.appBar}>
        <Toolbar>
          <Typography variant="h6" color="inherit" noWrap>
            Company name
          </Typography>
        </Toolbar>
      </AppBar> */}
      <main className={classes.layout}>
        <Paper className={classes.paper}>
          <Typography component="h1" variant="h4" align="center">
            Sign Up Admin
          </Typography>
          <Stepper activeStep={activeStep} className={classes.stepper}>
            {steps.map((label) => (
              <Step key={label}>
                <StepLabel>{label}</StepLabel>
              </Step>
            ))}
          </Stepper>
          <React.Fragment>
            {activeStep === steps.length ? (
              <React.Fragment>
                <Typography variant="h5" gutterBottom>
                  Thank you Sign Up.
                </Typography>
                <Typography variant="subtitle1">Done Sign Up</Typography>
              </React.Fragment>
            ) : (
              <React.Fragment>
                {getStepContent(activeStep)}
                <div className={classes.buttons}>
                  {activeStep !== 0 && (
                    <Button onClick={handleBack} className={classes.button}>
                      Back
                    </Button>
                  )}
                  <Button
                    variant="contained"
                    color="primary"
                    onClick={handleNext}
                    className={classes.button}
                  >
                    {activeStep === steps.length - 1 ? "Sign Up" : "Next"}
                  </Button>
                </div>
              </React.Fragment>
            )}
          </React.Fragment>
        </Paper>
      </main>
    </React.Fragment>
  );
}
