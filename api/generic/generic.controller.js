const {get} = require('lodash')
const { success, error } = require('../../services/api.response.service')

const Controller = ({service = {}}) => controllerParam => {
  return {
    /**
     * @author Welington Monteiro
     * @param { Object }req -  request params
     * @param { Object } res - response from server result
     * @return {Promise<*>}
     */
    async search (req, res) {
      const query = get(req, 'request.query', get(req, 'query'))
      let result = await service.search(query)
      return success(res, result)
    },
    /**
     * @author Welington Monteiro
     * @param { Object }req -  request params
     * @param { Object } res - response from server result
     * @return {Promise<*>}
     */
    async autoCompleteSearch (req, res) {
      const query = get(req, 'request.query', get(req, 'query'))
      let result = await service.autoCompleteSearch(query)
      return success(res, result)
    },
    /**
     * @author Welington Monteiro
     * @param { Object }req -  request params
     * @param { Object } res - response from server result
     * @return {Promise<*>}
     */
    async load (req, res) {
      const id = get(req, 'params.id')
      let result = await service.findOne(id)
      return success(res, result)
    },
    /**
     * @author Welington Monteiro
     * @param { Object }req -  request params
     * @param { Object } res - response from server result
     * @return {Promise<*>}
     */
    async save (req, res) {
      let entity = get(req, 'request.body', get(req, 'body'))
      const result = await service.save(entity, 'create')
      return success(res, result)
    },
    /**
     * @author Welington Monteiro
     * @param { Object }req -  request params
     * @param { Object } res - response from server result
     * @return {Promise<*>}
     */
    async update (req, res) {
      const params = get(req, 'request.body', get(req, 'body'))
      let result = await service.update(params)
      return success(res, result)
    },
    /**
     * @author Welington Monteiro
     * @param { Object }req -  request params
     * @param { Object } res - response from server result
     * @return {Promise<*>}
     */
    async delete (req, res) {
      const id = get(req, 'params.id')
      const result = await service.delete(id)
      return success(res, result)
    },
    /**
     * @author Welington Monteiro
     * @param { Object }req -  request params
     * @param { Object } res - response from server result
     * @return {Promise<*>}
     */
    async logicalDelete (req, res) {
      let {user} = req.state
      const id = get(req, 'params.id')
      const result = await service.logicalDelete(id, user)
      return success(res, result)
    },
    ...controllerParam
  }
}

module.exports = Controller
