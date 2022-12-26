
const admin = (req,res,next)=>{
    try{
        const user = req.session.user;
        if (!user){
            return res.status(400).json({msg:'you have to login first'});
        }
        if (!(user.type === 'admin')){
            return res.status(400).json({msg:'permission denied'});
        }
        next();
    }catch (e){
        console.log(e);
    }
}
module.exports = admin;