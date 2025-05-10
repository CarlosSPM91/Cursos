//Cargar express http
const express = require("express");
const router = express.Router();

//Cargar controlladores
const ProjectController = require("../controllers/project");

//Configurar multer
const multer = require("multer");

const storage = multer.diskStorage({
    destination: (req, res, cb) =>{
        cb(null, "./uploads/images");
    },
    filename: (req, file, cb)=>{
        cb(null, "project-" + Date.now() + "-" +file.originalname);
    }
});

const upload = multer({storage:storage});

//Define routes
router.post("/save", ProjectController.save);
router.get("/list", ProjectController.list);
router.get("/item/:id", ProjectController.item);
router.put("/update", ProjectController.update);
router.delete("/delete/:id", ProjectController.deleteProject);
router.put("/upload/:id", upload.single("file0"), ProjectController.upload);
router.get("/image/:file", ProjectController.getImage);

//Export routes
module.exports = router;