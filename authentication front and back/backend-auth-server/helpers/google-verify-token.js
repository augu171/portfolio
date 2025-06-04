const { OAuth2Client } = require('google-auth-library');

const CLIENT_ID = '270621649409-adsp2d1m5j0sd4ich18u1cujbpacn5td.apps.googleusercontent.com';

const client = new OAuth2Client(CLIENT_ID);

const validarGoogleIdToken = async (token) => {

    try {
        const ticket = await client.verifyIdToken({
            idToken: token,
            audience: [CLIENT_ID, '270621649409-m7nse5rl8kq2p684ke3icsh31tqoj0sb.apps.googleusercontent.com'],  // Specify the CLIENT_ID of the app that accesses the backend
            // Or, if multiple clients access the backend:
            //[CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3]
        });
        const payload = ticket.getPayload();
        // const userid = payload['sub'];

        // If request specified a G Suite domain:
        // const domain = payload['hd'];
        return {
            name: payload['name'],
            picture: payload['picture'],
            email: payload['email'],
        }

    } catch (error) {
        return null;
    }
}



module.exports = {
    validarGoogleIdToken
}