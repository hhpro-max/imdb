const mongoose = require("mongoose");

const commentsSchema = new mongoose.Schema({
    userId:{
        type:String,
        required:true
    },
    comment:{
        type:String,
        required:true,
        trim:true
    }
});

module.exports = commentsSchema;