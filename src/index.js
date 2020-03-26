const fs = require('fs');
const carbone = require('carbone');

  // Data to inject
  var data = {
    firstname : 'John',
    lastname : 'Doe'
  };

  // Generate a report using the sample template provided by carbone module
  // This LibreOffice template contains "Hello {d.firstname} {d.lastname} !"
  // Of course, you can create your own templates!
  //carbone.render('./scr/carbone/examples/simple.odt', data, function(err, result){
	carbone.render('./templates/clarity-deliverable-template.docx', data, function(err, result){
	console.log('Generate a report using the sample template provided by carbone module');
    if (err) {
	  console.log(err);
      return console.log(err);
    } else {
		console.log('Report successfully generated using the sample template provided by carbone module');
	}
    // write the result
    fs.writeFileSync('output/result.docx', result);
  });