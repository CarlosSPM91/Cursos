const Project = require("../models/project");
const fs = require("fs");
const path = require("path");

const save = (req, res) => {
    //recibir datos
    let body = req.body;

    //validar
    if (!body.name || !body.description || !body.state) {
        return res.status(400).send({
            status: 'error',
            message: "Faltan datos por enviar"
        });
    }

    //crear objeto
    let projectToSave = new Project(body);

    //Guardar objeto
    //Devolver respuesta
    projectToSave.save().then(project => {
        if (!project) {
            return res.status(404).send({
                status: 'error',
                message: "El proyecto no se guardo bien",
            });
        }
        return res.status(200).send({
            status: 'success',
            project
        });
    }).catch(error => {
        return res.status(500).send({
            status: 'error',
            message: "Error al guardar el projecto",
            error
        });
    });


}

const list = (req, res) => {
    Project.find()
        .then(projects => {
            if (!projects) {
                return res.status(404).send({
                    status: "error",
                    message: "No hay proyectos para mostrar"
                });
            }

            return res.status(200).send({
                status: "acces",
                projects
            })
        }).catch(error => {
            return res.status(500).send({
                status: 'error',
                message: "Error al listar los proyectos",
                error
            });
        });
}

const item = (req, res) => {
    let id = req.params.id;
    console.log(id);

    Project.findById(id)
        .then(project => {
            if (!project) {
                return res.status(404).send({
                    status: "error",
                    message: "No hay proyecto para mostrar"
                });
            }

            return res.status(200).send({
                status: "access",
                project
            });

        }).catch(error => {
            return res.status(500).send({
                status: 'error',
                message: "Error al mostrar el proyecto",
                error
            });
        });
}

const deleteProject = (req, res) => {
    let id = req.params.id;
    console.log(id);

    Project.findById(id)
        .deleteOne()
        .then(project => {
            if (!project) {
                return res.status(404).send({
                    status: "error",
                    message: "No se ha borrado el proyecto"
                });
            }

            return res.status(200).send({
                status: "access",
                project
            });

        }).catch(error => {
            return res.status(500).send({
                status: 'error',
                message: "Error al borrar el proyecto",
                error
            });
        });
}

const update = (req, res) => {
    let body = req.body;

    if (!body || !body.id) {
        return res.status(404).send({
            status: "error",
            message: "No se han recibido datos"
        });
    }

    Project.findByIdAndUpdate(body.id, body, { new: true })
        .then(projectUpdate => {
            if (!projectUpdate) {
                return res.status(404).send({
                    status: "error",
                    message: "No se ha encontrado el proyecto"
                });
            }


            return res.status(200).send({
                status: "success",
                project: projectUpdate
            })

        }).catch(error => {
            return res.status(500).send({
                status: 'error',
                message: "Error al actualizar el proyecto",
                error
            });
        });
};

const upload = (req, res) => {

    let id = req.params.id;

    if (!req.file) {
        return res.status(404).json({
            status: 'error',
            message: "No se ha subido nada",
        });
    }
    const filePath = req.file.path;
    const extension = path.extname(req.file.originalname).toLowerCase().replace(".", "");

    const validExtensions = ["png", "jpg", "gif"];
    if (!validExtensions.includes(extension)) {
        fs.unlinkSync(filePath);
        return res.status(404).json({
            status: 'error',
            message: "Extensión del archivo no valida",
        });
    }

    Project.findByIdAndUpdate({ _id: id }, { image: req.file.filename }, { new: false })
        .then(projectUpdate => {
            if (!projectUpdate) {
                fs.unlinkSync(filePath);
                return res.status(404).json({
                    status: "error",
                    message: "No se ha encontrado el proyecto"
                });
            }

            if (projectUpdate.image && projectUpdate.image != "default.png") {
                const oldImagePath = "./uploads/images/" + projectUpdate.image;

                if (fs.existsSync(oldImagePath)) {
                    fs.unlinkSync(oldImagePath);
                }
            }

            return res.status(200).send({
                status: "success",
                project: projectUpdate,
                newFile: req.file.filename
            })

        }).catch(error => {
            fs.unlinkSync(filePath);
            return res.status(500).send({
                status: 'error',
                message: "Error al actualizar el proyecto",
                error
            });
        });

}

const getImage = (req, res) => {
    //sacar el nombre del archivo
    let file = req.params.file;

    //construir ruta
    let filePath = "./uploads/images/" + file;
    //comprtobar si existe
    fs.stat(filePath, (error, exist => {
        if (!error && exist) {
            return res.sendFile (path.resolve(filePath));
        } else {
            return res.status(404).json({
                status: 'error',
                message: "La imagen no existe",
                error
            });
        }
    }));

    //debvolver respuesta
}

module.exports = {
    save,
    list,
    item,
    deleteProject,
    update,
    upload,
    getImage
}