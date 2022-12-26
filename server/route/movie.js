const {Router} = require('express');
const {Movie} = require('../model/movie');
const adminAccessCheck = require('../middleware/checkAdminAccess');
const userLoginCheck = require('../middleware/checkUserLogin');
const movieRouter = Router();

movieRouter.get('/sliders',async (req,res)=>{
    try {
        const movies = await Movie.find().sort({_id:-1}).limit(4);
        res.json(movies);
    } catch (e) {
        res.status(500).json({ err: e.message });
        console.log(e);
    }
});
movieRouter.get('/newMovies',async (req,res)=>{
    try {
        const movies = await Movie.find().sort({_id:-1}).limit(10);
        res.json(movies);
    } catch (e) {
        res.status(500).json({ err: e.message });
        console.log(e);
    }
});
movieRouter.get('/topRatedMovies',async (req,res)=>{
    try {
        let movies = await Movie.find({}).sort({_id:-1}).limit(100);
        movies = movies.sort((a,b)=>{
            let aSum = 0;
            let bSum = 0;
            for (let i = 0; i < a.rating.length; i++) {
                aSum += a.rating[i].rating;
            }

            for (let i = 0; i < b.rating.length; i++) {
                bSum += b.rating[i].rating;
            }
            return aSum < bSum ? 1 : -1;
        });
        let arr = [];
        for (let i =0;i < Object.keys(movies).length;i++){
            arr.push(movies[i]);
            if (i===10){
                break;
            }
        }
        res.json(arr);
    } catch (e) {
        console.log(e);
        res.status(500).json({ err: e.message });
    }
});
movieRouter.post('/addMovie',adminAccessCheck,async (req,res)=>{
    try{
        const {name,images,categories,characters,description} = req.body;
        let movie = new Movie({
            name,
            image :images,
            category:categories,
            characters,
            description
        });
        movie = await movie.save();
        res.json({movie});
    }catch (e){
        console.log(e);
        res.status(500).json({ err: e.message });
    }

});
movieRouter.post('/rateMovie',userLoginCheck,async(req,res)=>{
    try{
        const {id,rating}=req.body;
        let movie = await Movie.findById(id);

        for (let i = 0; i < movie.rating.length; i++) {
            if (movie.rating[i].userId === req.session.user._id) {
                movie.rating.splice(i, 1);
                break;
            }
        }
        const ratingSchema = {
            userId: req.session.user._id,
            rating,
        };
        movie.rating.push(ratingSchema);
        movie = await movie.save();
        res.json(movie);
    }catch (e){
        console.log(e);
        res.status(500).json({ err: e.message });
    }
});

movieRouter.post('/addComment',userLoginCheck,async (req,res)=>{
    try{
        const {userId,movieId,comment}= req.body;
        let movie =await Movie.findById(movieId);
        const commentSchema = {
          userId,
          comment
        };
        movie.comments.push(commentSchema);
        movie = await movie.save();
        res.json(movie);
    }catch (e){
        console.log(e);
    }
});
movieRouter.get('/search/:name',async (req,res)=>{
    try{
        const movies = await Movie.find({
            name: { $regex: req.params.name, $options: "i" },
        });
        res.json(movies);
    }catch(e){
        console.log(e);
    }
})
module.exports = movieRouter;