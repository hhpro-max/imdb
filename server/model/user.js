const mongoose = require('mongoose');
const { movieSchema } = require('./movie');
const userSchema = new mongoose.Schema(
    {
        userName:{
            type:String,
            required:true,
            trim:true
        },
        email:{
            type:String,
            required:true,
            trim:true
        },
        password:{
            type:String,
            required: true,
            trim: true
        },
        type:{
            type:String,
            required:true,
            default:"user"
        },
        favorites:[movieSchema]
    }
);

const User = mongoose.model("User",userSchema);
module.exports = User;