
const express = require('express');
const bodyparser = require('body-parser');
require('dotenv').config();

const app = express();

//Body Parser
app.use(bodyparser.urlencoded({ extended: true }));

//Rutas:
app.use('/', require('./routes/auth'));

app.listen(process.env.PORT || 3000, () => {
    const port = process.env.PORT || 3000;
    console.log(`Servidor corriendo en el puerto: ${port} `);
});