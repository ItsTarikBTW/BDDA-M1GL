// Select the database to use.
use('mongodbVSCodePlaygroundDB');


//insert

//1
db.hotels.find().sort({"nom":1,"annee_inauguration":1})
//2
db.hotels.find