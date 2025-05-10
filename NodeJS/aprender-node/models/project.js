
//importar moongoose
const { trim } = require("validator");
const {Schema, model } = require("mongoose");


//crear esquema
const ProjectSchema = new Schema({
    name:{
        type: String,
        require: true,
        trim: true
    } ,
    description: {
        type: String,
        require: true
    } ,
    state: {
        type: String,
        require: true
    } ,
    image: {
        type: String,
        default: "default.png"
    } ,
    created_at: {
        type: Date,
        default: Date.now()
    } ,
});

//Crear modelo, indicar collection y exportar modelo
module.exports = model("Project" , ProjectSchema, "projects");