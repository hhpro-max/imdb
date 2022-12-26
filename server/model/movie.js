const mongoose = require('mongoose');
const ratingSchema = require('./rating');
const commentSchema = require('./comments');
const movieSchema = new mongoose.Schema(
    {
        name:{
            type:String,
            required:true,
            trim:true
        },
        image:[{
          type:String,
          required:true
        }],
        category:[{
            type:String,
            required: true,
        }],
        characters:[{
            type:String,
            required:true
        }],
        description:{
            type:String,
            required:true
        },
        rating:[ratingSchema],
        comments:[commentSchema]
    }
);

const Movie = mongoose.model("Movie",movieSchema);
module.exports = {Movie , movieSchema};
