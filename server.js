const _ = require('lodash');
var data = {
  id: 0, name: 'Australia', children: [
    {id: 10, name: 'Melbourne', children: []},
    {
      id: 11, name: 'Sydney', children: [
        {id: 100, name: 'Surry Hills', children: []},
        {id: 102, name: 'Darlinghurst', children: []}
      ]
    },
    {id: 13, name: 'Kambalda', children: []}
  ]
};

function flatJson(o, {prefix = '', result = {}, keepNull = true, prefixArray = ''}) {
  if (_.isString(o) || _.isNumber(o) || _.isBoolean(o) || (keepNull && _.isNull(o))) {
    result[prefix] = o
    return result
  }
  if (_.isArray(o) || _.isPlainObject(o)) {
    for (let i in o) {
      let pref = prefix;
      if (_.isArray(o)) {
        pref = pref + prefixArray
      } else {
        if (_.isEmpty(prefix)) {
          pref = i
        } else {
          pref = prefix + '.' + i
        }
      }
      flatJson(o[i], {pref, result, keepNull})
    }
    return result
  }
  return result
}

console.log((flatJson(data)));
