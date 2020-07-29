let AddressController = require('./address.controller');

module.exports = (app) => {
  app.get('/all', AddressController.findAll)
  app.get('/:id', AddressController.findById)
  app.post('/', AddressController.save)
  app.put('/:id', AddressController.findOneAndUpdate)
  app.delete('/:id', AddressController.remove)
};
