
// IMPORT FROM PACKAGES
const express = require('express');
const mongoose = require('mongoose');
const path = require('path');
const dotEnv = require('dotenv');
const session = require('express-session');
//IMPORT FROM FILES
const movieRoute = require('./route/movie');
const authRoute = require('./route/auth');


// LOADING CONFIGS
dotEnv.config(
    {
        path: path.join(__dirname,'config/config.env')
    }
);

// INIT
const port = process.env.PORT || 3050;
const app = express();
const dbURL = process.env.MONGO_URI;

// MIDDLEWARES
app.use(express.json());
app.use(session({
    resave:false,
    saveUninitialized:false,
    secret: "noSecret!"
}))
//ROUTES
app.use("/movie",movieRoute);
app.use('/auth',authRoute);
//CONNECTIONS
//to make sure configs are load I used setTimeout function
setTimeout(()=>{
    mongoose.connect(dbURL).then(
        ()=>{
            console.log("<-:CONNECTED TO DATABASE:->");
        }
    ).catch(
        (e)=>{
            console.log(e);
        }
    );
    app.listen(port,()=>{
        console.log(`!-|SERVER IS RUNNING ON PORT ${port}|-!`);
    });
});

