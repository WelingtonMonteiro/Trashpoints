const { isEmpty } = require('lodash')
const {ValidationError} = require('../helpers/errors')

const Service = ({repository = {}}) => serviceParam => {
  return {
    /**
     * @author Welington Monteiro
     * @description generic save
     * @param {object} data
     * @return {Promise<data>}
     */
    async save(entity) {
      if (!isEmpty(entity)) ValidationError('Must provide entity to save')

      return repository.save(entity)
    },

    /**
     * @author Welington Monteiro
     * @param {Object} query
     * @return {Promise<*>}
     */
    async findOne(query = {}) {
      if (!isEmpty(query)) ValidationError('Must provide query to findOne')
      return await repository.find(query)
    },

    /**
     * @author Welington Monteiro
     * @param {Object}  params
     * @return {Promise<{total: number, results: []}>}
     */
    async search(params = {}) {
      if (isEmpty(params)) ValidationError('Query params must be provide correctly to search')

      return repository.search(params)
    },

    /**
     * @author Welington Monteiro
     * @param {Object}  query
     * @return {Promise<Object>}
     */
    async autoCompleteSearch(query) {
      if (isEmpty(query)) ValidationError('Query must be provide correctly to Auto Complete Search')

      return repository.autoCompleteSearch(query)
    },

    async update(query = {}, entity = {}, status = undefined) {
      if (isEmpty(query)) ValidationError('Query must be provide correctly to update')
      if (isEmpty(entity)) ValidationError('Entity is required')

      return repository.update(entity)
    },

    /**
     * @author Welington Monteiro
     * @param {Array<String>}  ids
     * @return {Promise<*>}
     */
    async findByIds(ids) {
      if (isEmpty(ids)) ValidationError('Ids list must be provide correctly to find')

      return repository.find({_id: {$in: ids}})
    },

    /**
     * @author Welington Monteiro
     * @param {Object} query
     * @return {Promise<Array<Object>>}
     */
    async aggregate(query) {
      if (isEmpty(query)) ValidationError('Querys list must be provide correctly to aggregate')

      return repository.aggregate(query)
    },

    /**
     * @author Welington Monteiro
     * @param {Object} params
     * @return {Promise<{pageSizeInt: *, query: *, skipResult: *, sortJson: *}>}
     */
    async paginationBuilder(params) {
      if (isEmpty(params)) ValidationError('Params is required to pagination')
      return repository.paginationBuilder(params)
    },

    /**
     * @author Welington Monteiro
     * @param {Object} query
     * @param {Object} entity
     * @return {Promise<*>}
     */
    async updateMany(query = {}, entity = {}) {
      if (isEmpty(query)) ValidationError('Query is required to update Many')
      if (isEmpty(entity)) ValidationError('Entity is required to update Many')

      return repository.updateMany(query, entity)
    },

    /**
     * @author Welington Monteiro
     * @param {Object} query
     * @param {Object} entity
     * @return {Promise<*>}
     */
    async updateOne(query = {}, entity = {}) {
      if (isEmpty(query)) ValidationError('Query is required to update One')
      if (isEmpty(entity)) ValidationError('Entity is required to update One')

      return repository.updateOne(query, entity)
    },

    /**
     * @author Welington Monteiro
     * @param {Object} query
     * @return {Promise<*>}
     */
    async delete(query = {}) {
      if (isEmpty(query)) ValidationError('Query is required to remove')

      return repository.remove(query)
    },

    /**
     * @author Welington Monteiro
     * @param {Object} query
     * @return {Promise<*>}
     */
    async logicalDelete(query = {}) {
      if (isEmpty(query)) ValidationError('Query is required to logical remove')

      return repository.logicalRemove(query)
    },
    ...serviceParam
  }
}

module.exports = Service
