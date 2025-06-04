const { response } = require('express');
const { validarGoogleIdToken } = require('../helpers/google-verify-token');

const googleAuth = async (req, res = response) => {

    const token = req.body.token;
    if (!token) {
        res.json({
            ok: false,
            msg: 'No hay token en la petición'
        });

    }

    const googleUser = await validarGoogleIdToken(token);
    if (!googleUser) {
        res.json({
            ok: false,
        });
    }
    //TODO: Guardar en la DB local

    res.json({
        ok: true,
        googleUser
    });

}

module.exports = {
    googleAuth
} 