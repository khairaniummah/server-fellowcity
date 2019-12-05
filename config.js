module.exports = {
  // Replace this with a container that you own.
  containerIdentifier:'iCloud.com.BussMeStoryboard',

  environment: 'development',

  serverToServerKeyAuth: {
    // Generate a key ID through CloudKit Dashboard and insert it here.
    keyID: '9be3dea10a687f82792add5ed9c99c25b6ee2556647deb68d2df22d367e708e3',

    // This should reference the private key file that you used to generate the above key ID.
    privateKeyFile: __dirname + '/eckey.pem'
  }
};