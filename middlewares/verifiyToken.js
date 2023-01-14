const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
dotenv.config();



const verifyToken = (req, res, next) =>{
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]
    if(token == null) return res.status(403).json();
    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, verifiedJwt) => {
        if(err) return res.status(403).json({err});
        next();
    })        
} 



module.exports = verifyToken;