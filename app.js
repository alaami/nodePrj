require('coffee-script');

var express = require('express')
  , routes = require('./routes')
  , path = require('path')
  , http = require('http');

var app = express();

app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(require('stylus').middleware(__dirname + '/public'));
app.use(express.static(path.join(__dirname, 'public')));

if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index); //Accueil fonctionnel
app.get('/contact', routes.contactGetAll); // Consulter tout les contacts fonctionnel
app.get('/contact/:id', routes.contactGetId); //Consulter un seul contact fonctionnel
app.post('/contact', routes.createContact);  //Creer un contact fonctionnel
app.delete('/contact/:id', routes.contactDeleteId); //Effacer un contact fonctionnel
app.put('/contact/:id',routes.modifyContact);  //Modifier un contact  
app.get('/recherche/:terme', routes.recherche); // Rechercher un contact par mot-clef en param. Fonctionnel
app.post('/archiver/:id', routes.archiver); //Archiver contact Fonctionnel.

app.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
