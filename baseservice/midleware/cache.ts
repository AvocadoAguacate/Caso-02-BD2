const getExpeditiousCache = require('express-expeditious');

const defaultOptions = {
  namespace: 'expresscache',
  defaultTlt: 'l minutes',
  statusCodeExpires: {
    404: '5 minutes',
    500: '0'
  }
}

const cacheInit = getExpeditiousCache(defaultOptions);

module.exports = { cacheInit }