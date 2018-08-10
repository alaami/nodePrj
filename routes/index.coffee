#
# Maxime Girard 
# Seifeddine Selmi
#
# Été 2013 
# UQAM
# INF4375
#

#
# Declaration de variables / base de donnée 
#

mongo = require "mongodb"
server = new mongo.Server "localhost", 27017 , {auto_reconnect: true}
db = new mongo.Db "INF4375", server, {safe:true}

db.open (erreur, db) ->
  if erreur
    console.log erreur
  else
    db.collection "contacts", { strict:true } , (erreur, collection) ->
     if erreur
       console.log "La liste de contacts est vide, nous allons la peupler."
       peuplerBaseDonne()

#
#Peuple base de donnée si inéxistante.
#

peuplerBaseDonne = ->
 star_wars = [
      nom: "Amidala"
      prenom: "Padmé"
      archive: 0
      titre: "Sénatrice de Naboo"
      organisation: "Republique Galactique"
      prof: ""
      naissance: 'nonspécifié'
      noteAdditionnelle: 'aucune'
      archive: 0
      telephone:{} 
      courriel: {}
      website: {}
      dateImportante:{} 
      adresses:{} 
     ,
      nom: "Anakin"
      prenom: "Skywalker"
      archive: 0
      titre: "L'Élu de l'ancienne prophécie Jedi"
      organisation: "Sith"
      prof: ""
      naissance: 'nonspécifié'
      noteAdditionnelle: 'aucune'
      archive: 0
      telephone:{} 
      courriel: {}
      website: {}
      dateImportante:{} 
      adresses:{} 
     ,
      nom: "Solo"
      prenom: "Han"
      archive: 0
      titre: "Capitaine du Faucon Millenium"
      organisation: "Alliance Rebelle"
      prof: ""
      naissance: 'nonspécifié'
      noteAdditionnelle: 'aucune'
      archive: 0
      telephone:{} 
      courriel: {}
      website: {}
      dateImportante:{} 
      adresses:{} 
     ,
      nom: "Skywalker"
      prenom: "Luke"
      archive: 0
      titre: "Dernier chevalier Jedi"
      organisation: "Alliance Rebelle"
      prof: ""
      naissance: 'nonspécifié'
      noteAdditionnelle: 'aucune'
      archive: 0
      telephone:{} 
      courriel: {}
      website: {}
      dateImportante:{} 
      adresses:{} 
     ,
      nom: "Kenobi"
      prenom: "Obiwan"
      archive: 0
      titre: "Chevalier Jedi Légendaire"
      organisation: "Ordre Jedi"
      prof: ""
      naissance: 'nonspécifié'
      noteAdditionnelle: 'aucune'
      archive: 0
      telephone:{} 
      courriel: {}
      website: {}
      dateImportante:{} 
      adresses:{} 
     ,
      nom: "Palpatine"
      prenom: ""
      archive: 0
      titre: "Dernier Chancelier de l'ancienne république"
      organisation: "Sith"
      prof: ""
      naissance: 'nonspécifié'
      noteAdditionnelle: 'aucune'
      archive: 0
      telephone:{} 
      courriel: {}
      website: {}
      dateImportante:{} 
      adresses:{} 
     ,
      nom: "Yoda"
      prenom: ""
      archive: 0
      titre: "Grand Maitre Jedi"
      organisation: "Ordre Jedi"
      prof: ""
      naissance: 'nonspécifié'
      noteAdditionnelle: 'aucune'
      archive: 0
      telephone:{} 
      courriel: {}
      website: {}
      dateImportante:{} 
      adresses:{} 
    ]
 db.collection 'contacts', (err,collection) ->
  collection.insert star_wars, safe:true, (err,result) ->

#
# Index, page par défaut.
#

exports.index = (req,res) -> res.render "index", pretty: true


#
# Afficher tout les contact, retourne la liste de contact. 
# 

exports.contactGetAll = (req, res) ->
  db.collection "contacts", (erreur, collection) ->
    if erreur
      console.log "Erreur: base de donnée inexistante."
    else
      collection.find({"archive": 0}).toArray (erreur, resultat) ->
        if erreur
          console.log erreur
          "<h4>Vous n'avez pas de contacts.</h4>"
        else
          console.log resultat
          res.json resultat
          res.end()
#
# Retourne un seul contact. 
#

exports.contactGetId = (req,res) ->
  db.collection "contacts" , (erreur, collection) ->
    if erreur
       console.log "Erreur: base de donnée inexistante."
    else
       collection.findOne { _id : new mongo.BSONPure.ObjectID(req.params.id)} , (erreur, resultat) ->
          if erreur
             console.log "Erreur: aucun contact de ce nom." + erreur
          else
               res.json resultat
               res.end()
#
# Prend un identifiant et efface un contact
#

exports.contactDeleteId = (req,res) ->
  db.collection "contacts" , (erreur, collection) ->
    if erreur
       console.log "Erreur: base de donnée inexistante." + erreur
    else
       collection.remove { "_id" : new mongo.BSONPure.ObjectID req.params.id }, (erreur, resultat) ->
             if erreur
               console.log "Erreur lors de la suppression."
             else
                console.log "Mise à jour effectuée."
                res.send "Mise à jour complèter." 

#
# Prend des modificateur et modifie les attributs 
# d'un document (contact) par les nouvelles valeurs. 
#

exports.modifyContact = (req, res) ->
 fields = req.body
 db.collection "contacts", (erreur, collection) ->
   collection.update { _id: new mongo.BSONPure.ObjectID(req.params.id)}, { $set: fields } , (erreur, resultat) ->
    if !erreur 
     res.send(200)
     res.end()
#
# Creer un contact.
#

exports.createContact = (req,res) ->
 console.log "pendant : ", req.body
 element = req.body
 db.collection "contacts" , (erreur, collection) ->
  if erreur
   console.log "Erreur : base de donnée inexistante." + erreur
  else
   collection.insert element , (erreur, resultat) ->
    if erreur
      console.log "Erreur : le contact n'as pas été ajouter." + erreur
    else
     res.json resultat[0]
     res.end()

#
# Recherche d'un contact par mot-clef ( Nom, prenom, nom d'organisation)
#

exports.recherche = (req, res) ->
  like = require 'like'
  mot_clef = req.params.terme
  regex = like.startsWith mot_clef
  console.log regex
  
  db.collection "contacts", (erreur, collection) ->
   if erreur
    console.log "Erreur: base de donnée inexistante."
   collection.find({ $or: [{"nom":{ $regex: regex, $options : 'i'}}, {"prenom": { $regex: regex, $options: 'i' }}, {"organisation": {$regex: regex, $options: 'i'}}]}).toArray (erreur, resultat) -> 
       res.send(resultat)
       res.end()

#
# Archiver un contact, rend invisible sauf dans la recherche
#

exports.archiver = (req,res) ->
  db.collection "contacts" , (erreur, collection) ->
    if erreur
       console.log "Erreur: base de donnée inexistante."
    else
      collection.update { _id : new mongo.BSONPure.ObjectID req.params.id }, {$set: { "archive" : 1 }} , (erreur, resultat) ->
       if erreur
         console.log "Erreur: aucun contact de ce nom." + erreur
       else
          console.log resultat
          res.send "Archivé"
          res.end()
