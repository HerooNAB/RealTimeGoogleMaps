import React, { useState, useEffect } from "react";
import { makeStyles } from "@material-ui/core";
import Drawer from "@material-ui/core/Drawer";
import Typography from "@material-ui/core/Typography";
import { useHistory, useLocation } from "react-router-dom";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemIcon from "@material-ui/core/ListItemIcon";
import ListItemText from "@material-ui/core/ListItemText";
import ListAltIcon from "@material-ui/icons/ListAlt";
import MenuIcon from "@material-ui/icons/Menu";
import ExitToAppIcon from '@material-ui/icons/ExitToApp';
import Divider from "@material-ui/core/Divider";
import MapIcon from "@material-ui/icons/Map";
import PersonIcon from "@material-ui/icons/Person";
import ExpandLess from "@material-ui/icons/ExpandLess";
import ExpandMore from "@material-ui/icons/ExpandMore";
import Collapse from "@material-ui/core/Collapse";
import { Link } from "react-router-dom";
import DashboardIcon from "@material-ui/icons/Dashboard";
import LocationOnSharpIcon from "@material-ui/icons/LocationOnSharp";
import {
  AddCircleOutlineOutlined,
  NoEncryption,
  SubjectOutlined,
} from "@material-ui/icons";
import GoogleMap from "./GoogleMap";
import axios from "../api/api";

const drawerWidth = 240;

const useStyles = makeStyles({
  page: {
    background: "#f9f9f9",
    width: "100%",
  },
  root: {
    display: "flex",
  },
  drawer: {
    width: drawerWidth,
  },
  drawerPaper: {
    width: drawerWidth,
  },
  active: {
    background: "#f4f4f4",
  },

  disablelink: {
    pointerEvents: null,
  },
});

function Layout({ children }) {
  const classes = useStyles();
  const history = useHistory();
  const location = useLocation();
  const [open, setOpen] = React.useState(true);
  const [listData, setListData] = useState([]);

  useEffect(async () => {
    getUserList();
  }, []);

  const getLocationWithId = (idUser) => {
    axios
      .get("/location/" + idUser)
      .then((response) => {
        const location = response.data;
        console.log(location);
      })
      .catch((error) => {
        console.log(error);
      });
  };


  const getUserList = () => {
    //sử dụng user/me để lấy id của Company
    axios
      .get("http://localhost:908/user/me")
      .then((response) => {
        const user = response.data;
        const idCompany = user.company;
        //get danh sách User Obj có chung Company
        axios
          .get("http://localhost:908/company/listuser/" + idCompany)
          .then((response) => {
            let listUser = response.data.listUser;
            setListData(listUser);
            console.log(listUser);
          })

          .catch((error) => {
            console.log(error);
          });
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const handleClick = () => {
    setOpen(!open);
  };

  const menuItems = [
    {
      text: "Dashboard",
      icon: <DashboardIcon />,
      path: "/dashboard",
    },
    {
      text: "Map",
      icon: <MapIcon />,
      path: "/map",
    },
    {
      text: "Profile",
      icon: <PersonIcon />,
      path: "/profile",
    },
  ];

  return (
    <div className={classes.root}>
      {/* app bar */}

      {/* side drawer */}
      <Drawer
        className={classes.drawer}
        variant="permanent"
        classes={{ paper: classes.drawerPaper }}
        anchor="left"
      >
        <div>
          <Typography variant="h4" color="primary" className={classes.title}>
            Admin Page
          </Typography>
          <Divider />
        </div>

        {/* links/list section */}
        <List>
          {menuItems.map((item) => (
            <ListItem
              button
              key={item.text}
              onClick={() => history.push(item.path)}
              className={location.pathname == item.path ? classes.active : null}
            >
              <ListItemIcon>{item.icon}</ListItemIcon>
              <ListItemText primary={item.text} />
            </ListItem>
          ))}
        </List>
        <Divider />
        <List>
          <ListItem button onClick={handleClick}>
            <ListItemIcon>
              <LocationOnSharpIcon />
            </ListItemIcon>
            <ListItemText primary="User Tracking" />
            {open ? <ExpandLess /> : <ExpandMore />}
          </ListItem>

          {listData.map((item) => (
            <Collapse in={open} timeout="auto" unmountOnExit>
              <List component="div" disablePadding>
                <ListItem
                  onClick={() =>
                    history.push({ pathname: "/user", state: { id: item._id } })
                  }
                  button
                  className={classes.nested}
                >
                  <ListItemIcon>
                    <PersonIcon />
                  </ListItemIcon>
                  <ListItemText primary={item.name} />
                </ListItem>
              </List>
            </Collapse>
          ))}
        </List>
        <ListItem button onClick={()=>{
          localStorage.clear()
          history.push('/');
        }}>
            <ListItemIcon>
              <ExitToAppIcon/>
            </ListItemIcon>
            <ListItemText primary="Log Out" />
          </ListItem>
      </Drawer>

      {/* main content */}
      <div className={classes.page}>{children}</div>
    </div>
  );
}

export default Layout;
