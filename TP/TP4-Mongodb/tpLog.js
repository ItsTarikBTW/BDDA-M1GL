//1
var sortie = {
  _id: 3,
  salle_cinéma: "Salle Ibn Khaldoun",
  film: "The Batman",
  année_sortie_salle: 2022,
  mois_sortie: "avril",
  durée: "1h 40mn",
  genre: ["Action", "Drame"],
  tarif: 100,
  synopsys:
    "Lorsqu`un tueur s`en prend à l`élite de Gotham par une série de machinations sadiques, une piste ….",
  programme: [
    { date: "05 avril 2023", séances: ["10h00", "17h00"] },
    { date: "07 avril 2023", séances: ["20h00", "22h00"] },
    { date: "17 mai 2023", séances: ["20h00"] },
  ],
};

//2
db.AgendaCinema.insertOne(sortie);

//3
db.AgendaCinema.countDocuments();

//4
db.AgendaCinema.insertOne({
  _id: 2,
  salle_cinéma: "Le  Mouggar",
  film: "The Batman",
  année_sortie: 2022,
  mois_sortie: "avril",
  durée: "1h 40mn",
  genre: ["Action", "Drame"],
  tarif: 120,
  synopsys:
    "Lorsqu'un tueur s'en prend à l'élite de Gotham par une série de machinations sadiques, une piste ….",
  programme: [
    { date: "08 mai 2023", séances: ["13h45", "20h00"] },
    { date: "17 mai 2023", séances: ["20h00", "21h45"] },
  ],
});

//5 5-	Insérer le même document sans le champ "_id". Vérifier les documents de votre base, que remarquer vous !
db.AgendaCinema.insertMany([
  {
    salle_cinéma: "Salle Ibn Khaldoun",
    film: "The Batman",
    année_sortie_salle: 2022,
    mois_sortie: "avril",
    durée: "1h 40mn",
    genre: ["Action", "Drame"],
    tarif: 100,
    synopsys:
      "Lorsqu`un tueur s`en prend à l`élite de Gotham par une série de machinations sadiques, une piste ….",
    programme: [
      { date: "05 avril 2023", séances: ["10h00", "17h00"] },
      { date: "07 avril 2023", séances: ["20h00", "22h00"] },
      { date: "17 mai 2023", séances: ["20h00"] },
    ],
  },
  {
    salle_cinéma: "Le  Mouggar",
    film: "The Batman",
    année_sortie: 2022,
    mois_sortie: "avril",
    durée: "1h 40mn",
    genre: ["Action", "Drame"],
    tarif: 120,
    synopsys:
      "Lorsqu'un tueur s'en prend à l'élite de Gotham par une série de machinations sadiques, une piste ….",
    programme: [
      { date: "08 mai 2023", séances: ["13h45", "20h00"] },
      { date: "17 mai 2023", séances: ["20h00", "21h45"] },
    ],
  },
]);

//6
db.AgendaCinema.updateMany(
  { film: "The Batman" },
  { $set: { mois_sortie: "mars" } }
);

//7
db.AgendaCinema.updateOne(
  { salle_cinéma: "Le  Mouggar", film: "The Batman" },
  { $push: { "programme.0.séances": "17:00" } }
);

//8
db.AgendaCinema.updateOne(
  { film: " The Batman", genre: "Drame" },
  { $set: { "genre.$": "Thriller" } }
);

//9
db.AgendaCinema.updateOne(
  {},
  { $rename: { année_sortie_salle: "année_sortie" } }
);

//mongoimport --db ProgrammeCinema --collection Cinema --file C://Users//tarik//OneDrive//Documents//S2//BDDA//TP//TP4-Mongodb//Cinemas.json

db.Cinema.find().pretty()