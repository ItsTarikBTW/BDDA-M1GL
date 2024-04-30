use("ProgrammeCinema");
//1
db.AgendaCinema.distinct("film");
//2
db.AgendaCinema.distinct("salle_cinéma").length;
//3
db.AgendaCinema.find({ film: "Taxi 5" }, { salle_cinéma: 1, _id: 0 }).sort({
  salle_cinéma: 1,
});
//4
db.AgendaCinema.find(
  { tarif: { $lte: 700 } },
  { salle_cinéma: 1, tarif: 1, _id: 0 }
).sort({ tarif: 1 });
//5
db.AgendaCinema.find(
  { "programme.date": "17 mai 2023" },
  { salle_cinéma: 1, _id: 0 }
);
//6
db.AgendaCinema.find(
  { film: "TAXI 5" },
  { salle_cinéma: 1, programme: 1, _id: 0 }
);
//7
db.Cinema.find(
  { "adresse.ville": "Alger", "capacité salle": { $gt: 200 } },
  { nom: 1, _id: 0 }
).count();
//8
db.AgendaCinema.find(
  { genre: { $all: ["Action", "Drame"] }, "programme.date": "17 mai 2023" },
  { film: 1, genre: 1, _id: 0 }
);
//9
db.AgendaCinema.find({ genre: { $size: 2 } }, { film: 1, genre: 1, _id: 0 });
//10
db.AgendaCinema.deleteMany({ programme: { $exists: 0 } });
//11
db.AgendaCinema.distinct("genre").length;
//12
db.AgendaCinema.aggregate([
  { $group: { _id: "$film", salles: { $addToSet: "$salle_cinéma" } } },
]);
//13
db.AgendaCinema.aggregate([
  { $unwind: "$genre" },
  { $group: { _id: "$genre", count: { $sum: 1 } } },
]);
//14
db.AgendaCinema.aggregate([
  {
    $lookup: {
      from: "Cinema",
      localField: "salle_cinéma",
      foreignField: "nom",
      as: "information_cine",
    },
  },
]);

//b
//mongodump.exe -d ProgrammeCinema -o C://Users//tarik//OneDrive//Documents//S2//BDDA//TP//TP4-Mongodb
