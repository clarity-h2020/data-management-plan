'use strict';

const fs = require('fs');
const carbone = require('carbone');
const log = require('loglevel');

module.exports.generateReport = generateReport;

log.enableAll();

/**
 * 
 * @param {String} datasetId 
 * @param {String} datasetTemplate 
 * @return {void}
 */
function generateReport(datasetId, templateName) {
  const inputFile = `./input/${datasetId}.json`;
  const outputFile = `./output/${datasetId}.odt`;
  const datasetTemplate = templateName ? `./templates/${templateName}.odt` : './templates/dataset-template.odt';

  log.debug(`processing '${inputFile}' using the Dataset Template '${datasetTemplate}'.`);
  const inputData = JSON.parse(fs.readFileSync(inputFile));

  carbone.render(datasetTemplate, inputData, function (error, result) {
    if (error) {
      log.error(`Carbone could not process '${inputFile}'!`, error);
    } else {
      fs.writeFileSync(outputFile, result);
      log.info(`Dataset Report '${outputFile}' successfully generated.`);
    }
  });
};