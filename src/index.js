'use strict';

const fs = require('fs');
const carbone = require('carbone');
const log = require('loglevel');


const datasetTemplate = './templates/dataset-template.odt';

log.enableAll();

processDataset('summer-days-sd');

/**
 * 
 * @param {*} datasetId 
 * @return {boolean} false on error
 */
function processDataset(datasetId) {
  const inputFile = `./input/${datasetId}.json`;
  const outputFile = `./output/${datasetId}.odt`;

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