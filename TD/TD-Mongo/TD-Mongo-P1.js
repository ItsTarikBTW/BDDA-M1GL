// Select the database to use.
use("mongodbVSCodePlaygroundDB");

// Insert a few documents into the sales collection.
db.hotels.insertOne({
  _id: 99,
  nom: "Renaissance Tlemcen",
  adresse: {
    rue: "Boulevard De Lala Sitti",
    commune: "Tlemcen",
    ville: "Tlemcen",
  },
  groupe_hotelier: "Marriott International",
  "nombre de chambres": 204,
  prix_moyen: 22500,
  "Site internet":
    "http://www.marriott.com/hotels/travel/algbr-renaissancetlemcen-hotel",
  etoiles: 5,
  equipements: [
    "Parking",
    "restaurant",
    "Navette vers l'aéroport",
    "salle de sport",
    "piscine",
    "SPA multiservice",
  ],
  description:
    "Situé à 6 minutes à pied du parc de loisirs Lalla Setti, cet hôtel contemporain est à 7 km de la Grande Mosquée de Tlemcen...",
  annee_inauguration: 2011,
  avis: [
    {
      date_publi: ISODate("2017-12-11T00:00:00.000"),
      commentaire: "Très bon service et accueil ….",
      note: 7,
    },
    {
      date_publi: ISODate("2018-03-06T00:00:00.000"),
      commentaire: "Nous avons vraiment apprécié notre séjour...",
      note: 5,
    },
  ],
});
//2
db.createCollection("restaurants");
//3
db.restaurants.insertOne({
  _id: 1,
  nom: "Restaurant Marrakech",
  specialite: "cuisine traditionnelle",
  annee_inauguration: 2013,
  menus: [
    { nom: "Hrira", prix: 150 },
    { nom: "Tagine Zitoune", prix: 350 },
  ]
});
//4
db.hotels.find();
//5
db.hotels.updateOne(
    { "nom": "Renaissance Tlemcen"},
    { $set: { "nombre de chambres":206 } }
);
//6
db.hotels.updateOne(
    { "nom": "Renaissance Tlemcen"},
    { $set: { "avis.0.note":10 } }
);
//7
db.hotels.updateOne(
    { "nom": "Renaissance Tlemcen"},
    { $addToSet: {
        "equipements": "salle de jeux" 
    } }
);
//8
db.hotels.updateMany({},{$rename:{"nom":"nom_hotel"}});