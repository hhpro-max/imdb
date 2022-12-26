const user = (req,res,next)=>{
    try{
        const user = req.session.user;
        if (!user){
            return res.status(400).json({msg:'you have to login first'});
        }
        next();
    }catch (e){
        console.log(e);
    }
}
module.exports = user;