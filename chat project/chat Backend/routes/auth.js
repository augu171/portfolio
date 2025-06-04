/*
    Path: /api/login
*/

const { Router } = require('express');
const { check } = require('express-validator');

const { newUser, login, renewToken, } = require('../controller/auth');
const { validateFields } = require('../middlewares/validate_fields');
const { validateJWT } = require('../middlewares/validate_jwt');

const router = Router();

router.post('/new', [
    check('password', 'La contraseña es obligatoria').not().isEmpty(),
    check('name', 'El nombre es obligatorio').not().isEmpty(),
    check('email', 'Ingrese un email válido').isEmail(), validateFields,
], newUser);

router.post('/', [
    check('email', 'Ingrese un email válido').isEmail(),
    check('password', 'La contraseña es obligatoria').not().isEmpty(),
], login);

router.get('/renew', validateJWT, renewToken);
router.get('/delete', validateJWT, deleteToken);

module.exports = router;