// Select the database to use.
use('mongodbVSCodePlaygroundDB');

// Insert a few documents into the sales collection.
/*
db.getCollection('conference').insertMany([
    {
        "_id": 1,
        "titre": "IFIP 2022",
        "detail_titre": "5th IFIP International Conference on Computer Science and Its Applications",
        "lieu": "Oran",
        "type": "Internationale",
        "DateConf": "20/05/2022",
        "laboratoire": "Laboratoire LRIT",
        Organisateurs: ["Saidi Djamel", "Didouche Leila"],
        "Articles": [
            {
                "id": 23,
                "Titre": "An improved Hybrid Optimization",
                "Premier_auteur": "Youcef Djenouri",
                "Evaluation": "Accepté"
            }]
    },

]);
db.getCollection('evaluation').insertMany([
    {
        "_id": 1,
        "Rewiewer": "Natalie Portman",
        "institution": "Berkley University",
        "id_article": 1,
        "note": 15,
        "résultat": "Accepté"
    },
    {
        "_id": 2,
        "Rewiewer": "Mahroussa Iheb",
        "institution": "Tlemcen University",
        "id_article": 2,
        "note": 9,
        "résultat": "Rejeté"
    }
]);
*/
// 1
db.conference.find({
    "type": "Internationale",
    "lieu": "Oran"
},
    {
    _id:0,
    titre:1
    }
)
//2
db.conference.aggregate([
    {$unwind:"$Articles"},
    {
        $lookup:{
            from:"evaluation",
            localField:"Articles.id",
            foreignField:"id_article",
            as:"Articles_evalués"
        }
    },
    {
        $project:{
            "Articles_evalués.id_article":1
        }
    }
])
