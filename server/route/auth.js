const {Router} = require('express');
const authRoute = Router();
const User = require('../model/user');


authRoute.post('/register',async (req,res)=>{
        try{

            const {userName,email,password} = req.body;
            const existingUser = await User.findOne({userName});
            if(existingUser){
               return  res.status(400).json({msg:"userName is existing"});
            }

            let user = new User(
                {
                    userName,
                    email,
                    password,
                }
            );

            user = await user.save();
            res.json(user);

        }catch (e){
            res.status(500).json({ err: e.message });
            console.log(e);
        }
});

authRoute.post('/login',async (req,res)=>{
   try{
       const {userName,password} = req.body;
       const user =await User.findOne({userName});
       if (!user){
           return res.status(400).json({
               msg:"username is not exist!"
           });
       }
       const isMatch = await (password === user.password);
       if (!isMatch){
           return res.status(400).json({
               msg:"password is wrong"
           });
       }
       req.session.regenerate((err)=>{
           if(err){
               return  res.status(500).json({err:err});
           }
           req.session.user = user;
           return res.status(200).json({msg:"successful",...user._doc});
       });
   }catch (e){
       console.log(e);
   }
});

authRoute.post('/logout',(req,res)=>{

        req.session.destroy();
        res.status(200).json({status:"successful"});

})

module.exports = authRoute;