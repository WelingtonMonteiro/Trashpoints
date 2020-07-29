const {omit, set, get, isEmpty, assign} = require('lodash')
const RESULTS_PER_PAGE = 10

/**
 * @author Welington Monteiro
 * @param {Object} collection - entity schema
 * @param {Object} [defaultSort] - query fields sort by
 * @return {function(*): {search(*=): Promise<{total, results}>, findByIds(*=): Promise<*>, findById(*): Promise<*>, logicalRemove(*=): Promise<*>, save(*=): Promise<*>, findOne(*=): Promise<*>, update(*=): Promise<*>, autoCompleteSearch(*=): Promise<*>, paginationBuilder(*): Promise<{pageSizeInt, query, skipResult, sortJson}>, remove(*=): Promise<*>, aggregate(*=): Promise<*>}}
 * @constructor
 */
const Repository = ({collection = {}, defaultSort = {}}) => {
  /**
   * @author Welington Monteiro
   * @param { Object }repository - object functions re-write function repository
   * @return {any}
   */
  return (repository = {}) => {
    if (isEmpty(collection)) return throw new Error('Collection is required')
    return assign(
      {
        /**
         * @author Welington Monteiro
         * @description generic save
         * @param {object} data
         * @return {Promise<data>}
         */
        async save(data) {
          return collection.create(data)
        },

        /**
         * @author Welington Monteiro
         * @param {Object} query
         * @return {Promise<*>}
         */
        async findOne(query) {
          return collection.findOne(query)
        },

        /**
         * @author Welington Monteiro
         * @param {Array<String>}  ids
         * @return {Promise<*>}
         */
        async findByIds(ids) {
          return collection.find({_id: {$in: ids}})
        },

        /**
         * @author Welington Monteiro
         * @param {Object} query
         * @return {Promise<Array<Object>>}
         */
        async aggregate(query) {
          return collection.aggregate(query)
        },

        /**
         * @author Welington Monteiro
         * @param {Object}  params
         * @return {Promise<{total: number, results: []}>}
         */
        async search(params) {
          let {sortJson, query, pageSizeInt, skipResult} = await this.paginationBuilder(params)

          let res = {results: [], total: 0}
          res.results = await collection.find(query)
            .lean()
            .sort(sortJson)
            .skip(skipResult)
            .limit(pageSizeInt)
          res.total = await collection.count(query)
          return res
        },

        /**
         * @author Welington Monteiro
         * @param {Object} params
         * @return {Promise<{pageSizeInt: *, query: *, skipResult: *, sortJson: *}>}
         */
        async paginationBuilder(params) {
          let {currentPage = 1, pageSize, sort, sortDirection, query, noPaginate} = params
          currentPage--
          noPaginate = (noPaginate === 'true' || noPaginate === true)
          pageSize = pageSize || (noPaginate ? 20 : RESULTS_PER_PAGE)

          let sortJson = createSort(sort, sortDirection)

          let pageSizeInt = parseInt(pageSize, 10)
          let skipResult = noPaginate ? 0 : pageSizeInt * currentPage

          return {sortJson, query, pageSizeInt, skipResult}
        },

        /**
         * @author Welington Monteiro
         * @param {Object}  params
         * @return {Promise<Object>}
         */
        async autoCompleteSearch(params = {}) {
          let sortJson = createSort(params.sortBy, 1)
          set(params, '_isAutocompleteSearch', true)
          let {query} = params
          return collection.find(query).sort(sortJson)
        },

        /**
         * @author Welington Monteiro
         * @param {Object} query
         * @param {Object} entity
         * @return {Promise<*>}
         */
        async updateMany(query = {}, entity = {}) {
          let $set = omit(entity, ['_id'])
          return collection.update(query, {$set}, {new: true, multi: true})
        },

        /**
         * @author Welington Monteiro
         * @param {Object} query
         * @param {Object} entity
         * @return {Promise<*>}
         */
        async updateOne(query = {}, entity = {}) {
          let $set = omit(entity, ['_id'])
          return collection.findOneAndUpdate(query, {$set}, {new: true})
        },

        /**
         * @author Welington Monteiro
         * @param {Object} query
         * @return {Promise<*>}
         */
        async remove(query = {}) {
          return collection.remove(query)
        },

        /**
         * @author Welington Monteiro
         * @param {Object} query
         * @return {Promise<*>}
         */
        async logicalRemove(query = {}) {
          return collection.findOneAndUpdate(query, {$set: {isDeleted: true}}, {$new: true})
        }
      }, repository)

    function createSort(field, direction) {
      if (!field || !direction) {
        return defaultSort
      }
      return {[field]: direction}
    }
  }
}

module.exports = Repository
