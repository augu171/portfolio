const { response } = require("express");
const bcrypt = require('bcryptjs');
const User = require('../models/user.js');
const { generateJWT } = require("../helpers/jwt.js");

const newUser = async (req, res = response) => {

    const { email, password } = req.body;

    try {

        const emailDuplicate = await User.findOne({ email });

        if (emailDuplicate) {
            return res.status(400).json({
                ok: false,
                msg: 'El correo ya está registrado'
            })
        }

        const user = new User(req.body);

        // Encriptando contraseña
        const salt = bcrypt.genSaltSync();
        user.password = bcrypt.hashSync(password, salt);

        await user.save();

        // Generar mi JWT (Json Web Token)
        const token = await generateJWT(user.id);

        res.json({
            ok: true,
            user,
            token
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            ok: false,
            msg: 'Hable con el administrador'
        })
    }

}




const login = async (req, res = response) => {

    const { email, password } = req.body;

    try {

        const userDB = await User.findOne({ email });
        if (!userDB) {
            return res.status(404).json({
                ok: false,
                msg: 'Email no encontrado'
            });
        }
        // validar el pass

        const validatePassword = bcrypt.compareSync(password, userDB.password);
        if (!validatePassword) {
            return res.status(400).json({
                ok: false,
                msg: 'La pass no es válida'
            });
        }

        // Generar el JWT
        const token = await generateJWT(userDB.id);
        res.json({
            ok: true,
            user: userDB,
            token
        })

    } catch (error) {
        return res.json({
            ok: false,
            msg: 'Hable Con el administrador'
        });

    }
}

const renewToken = async (req, res = response) => {

    const uid = req.uid;
    const token = await generateJWT(uid);
    const user = await User.findById(uid);

    res.json({
        ok: true,
        user,
        token
    })
}

const deleteToken = async (req, res = response) => {

    const uid = req.uid;
    const token = '';
    const user = await User.findById(uid);

    res.json({
        ok: true,
        user,
        token
    })
}

module.exports = { newUser, login, renewToken, deleteToken };