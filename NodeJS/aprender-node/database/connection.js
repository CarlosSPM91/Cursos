const mongoose = require("mongoose");

const connection = async()=>{
    try{
        await mongoose.connect("mongodb://127.0.0.1:27017/bd-portafolio");

        console.log("Conectado a la BBDD");

    }catch(error){
        console.log(error);
        throw new Error("No se pudo establecer la conexión a la BBDD");
    }
};

module.exports = connection;