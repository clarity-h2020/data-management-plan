'use strict';

const reportGenerator = require('./reportGenerator');
const log = require('loglevel');

log.enableAll();

if (process.argv.length === 2) {
  log.error('Expected argument(s) $datasetId and optional $templateName');
  process.exit(1);
} else if (process.argv.length === 4 && process.argv[2] && process.argv[3]) {
  reportGenerator.generateReport(process.argv[2], process.argv[3]);
} else if (process.argv.length === 3 && process.argv[2]) {
  reportGenerator.generateReport(process.argv[2]);
} else {
  log.error(`Unexpected number of arguments: ${process.argv.length}`);
}