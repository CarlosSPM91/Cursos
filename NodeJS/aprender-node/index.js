//importar dependencias
const express = require("express");
const cors = require("cors");

//conexión a la base de datos


//Crear server
const app = express();
const port = 6699;

//Configurar el cors
app.use(cors());

//Convertir lso datos a OBJ
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//Cargar rutas
//Crear endpoints
app.get("/", (req, res) => {
    console.log("Ruta Raiz ejecutada");
    return res.status(200).json([
        {
            name: 'pruebas NodeJS',
            url: 'localhost:6699/',
            year: '2025'
        },
        {
            name: 'Página de pruebas',
            url: 'localhost:6699/pruebas',
            year: '2025'
        },
        {
            name: 'No existe',
            url: 'localhost:6699/no-existe',
            year: '2005'
        }
    ]);
});

app.get("/pruebas", (req, res) => {
    console.log("endpoint ejecutado en pruebas");
    return res.status(200).send(`
        <section>
        <h1>Estoy aprendiendo Node</h1>
        <h2> Texto por rellenar</h2>
        </section>
        `);
});
//Poner el server en escucha
app.listen(port, () => {
    console.log("Server running correctly en puerto " + port);
})