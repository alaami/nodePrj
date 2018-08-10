#
# Maxime Girard
# Seifeddine Selmi
#
# UQAM
# ÉTÉ 2013
# INF4375
# 

#
#
# Élément de design (Slide)
#
#

$(document).ready ->
  $('#ajouter').slideUp(30)
  $('#listeContact').click -> 
    $('#liste').slideToggle("fast")
  $('#ajouterBouton').click ->
   $('#ajouter').slideToggle("fast")
 


#
#
# Affiche la fiche d'un contact au complet.
#
#

  $('body').on "click",".contact", (event) ->
    _id = $(this).attr("id")
    console.log("ID : ", _id)
    $.ajax
       type: "GET"
       dataType: "html"
       url: "/contact/"+_id+"/"
       error: (erreur) ->
          console.log "Erreur lors du chargement."
       success: (response_) ->
        $('#fiche, #fiche_modif, #resultatRecherche').html(" ")
        $('#fiche').append("<ul>")
	       contacts = JSON.parse(response_)
        champs = []
        for fields of contacts
          champs.push fields  if hasOwnProperty.call(contacts, fields)
	       champs.forEach (e)->
                  if e == "_id"
                    $('#fiche').append('<div id="_id-liste" style="display:none;">'+contacts[e]+'</div>')
                  if e == "telephone" or e == "courriel" or e == "website" or e == "dateImportante" or e == "adresses"
                    $('#fiche').append('<li>'+e+':</li>')
                    Object.getOwnPropertyNames(contacts[e]).forEach (elem)-> $('#fiche').append('<li>'+elem+' : '+ contacts[e][elem] + '</li>') 
                  $('#fiche').append('<li>'+e+' : '+ contacts[e] + '</li>') unless e is "archive" or e is "_id" or e is "telephone" or e is "courriel" or e is "website" or e is "dateImportante" or e is "adresses"
               
               $('#fiche').append('</ul>')
               $('#fiche').append('<button id="archiver" >Archiver</button>')
               $('#fiche').append('<button id="modifier" >Modifier</button>')
               $('#fiche').append('<button id="effacer"  >Effacer</button><br/><br/>')
	       $('#fiche').show()

#
#
# Afficher la fiche d'un resultat de recherche 
# en cliquant sur un contact
#
#

  $('body').on "click",".contact_r", (event) ->
    _id = $(this).attr("id")
    console.log("ID : ", _id)
    $.ajax
       type: "GET" 
       dataType: "html"
       url: "/contact/"+_id+"/"
       error: (erreur) ->
          console.log "Erreur lors du chargement."
       success: (response_) ->
        $('#fiche, #fiche_modif, #resultatRecherche').html(" ") 
        $('#resultatRecherche').append("<ul>")
	       contacts_r = JSON.parse(response_)
        champs_r = []
        for fields_r of contacts_r
          champs_r.push fields_r  if hasOwnProperty.call(contacts_r, fields_r)
	       champs_r.forEach (g)->
                  if g == "_id"
                    $('#resultatRecherche').append('<div id="_id-liste" style="display:none;">'+contacts_r[g]+'</div>')
                    $('#_id-liste').hide()
                  if g == "telephone" or g == "courriel" or g == "website" or g == "dateImportante" or g == "adresses"
                    $('#resultatRecherche').append('<li>'+g+':</li>')
                    Object.getOwnPropertyNames(contacts_r[g]).forEach (el)-> $('#resultatRecherche').append('<li>'+el+' : '+ contacts_r[g][el] + '</li>')
                  $('#resultatRecherche').append('<li>'+g+' : '+ contacts_r[g] + '</li>') unless g == "archive" or g == "_id" or g == "telephone" or g == "courriel" or g == "website" or g == "dateImportante" or g == "adresses"
               $('#resultatRecherche').append('</ul>')
               $('#resultatRecherche').append('<button id="archiver" >Archiver</button>')
               $('#resultatRecherche').append('<button id="modifier" >Modifier</button>')
               $('#resultatRecherche').append('<button id="effacer"  >Effacer</button><br/><br/>')


#
#
# Chargement de l'interface de
# modification d'un contact dans la page principale
#
#
  
  $('body').on "click", "#modifier", (event_e) ->
    id_a_modifier = $('#_id-liste').text() 
    $.ajax
      type: "GET"
      dataType: "html"
      url: "/contact/"+id_a_modifier+"/"
      error: (erreur) ->
         console.log erreur
      success: (response__) ->
        $('#fiche').hide()
        $('#fiche_modif, #resultatRecherche').html("")
        $('#fiche_modif').append("<h3>Modifier un contact</h3>")
        contacts__ = JSON.parse(response__)
        champs__ = []
        for fields__ of contacts__
          champs__.push fields__  if hasOwnProperty.call(contacts__, fields__)
	       champs__.forEach (k)->
                  if k == "_id"
                    $('#fiche_modif').append('<div id="_id-liste" style="display:none;">'+contacts__[k]+'</div>')
                  if k is "telephone" 
                    $('#fiche_modif').append('<br/><label>Téléphone</label><button id="m-telephone">Ajouter</button><div id="modif-telephone"></div>') 
                    $('#fiche_modif').append('<li>'+k+'</li>')
                    Object.getOwnPropertyNames(contacts__[k]).forEach (element) -> $('#fiche_modif').append('<div class="m-tel_div"><input class="phoneType" type="text" value="'+element+'"></input><input class="phones" type="text" value="'+contacts__[k][element]+'"></input><br/></div>')
                  if k is "courriel" 
                    $('#fiche_modif').append('<br/><label>Courriel</label><button id="m-courriel">Ajouter</button><div id="modif-courriel"></div>')
                    $('#fiche_modif').append('<li>'+k+'</li>')
                    Object.getOwnPropertyNames(contacts__[k]).forEach (element) -> $('#fiche_modif').append('<div class="m-mail_div"><input type="text" class="courrielType" value="'+element+'"></input><input type="text" class="mail" value="'+contacts__[k][element]+'"></input><br/></div>')
                  if k is "website" 
                    $('#fiche_modif').append('<br/><label>Site Web</label><button id="m-website">Ajouter</button><div id="modif-website"></div>')
                    $('#fiche_modif').append('<li>'+k+'</li>')
                    Object.getOwnPropertyNames(contacts__[k]).forEach (element) -> $('#fiche_modif').append('<div class="m-web_div"><input type="text" class="website-type" value="'+element+'"></input><input type="text" class="website" value="'+contacts__[k][element]+'"></input><br/></div>')
                  if k is "dateImportante" 
                    $('#fiche_modif').append('<br/><label>Date Importantes</label><button id="m-dateImportante">Ajouter</button><div id="modif-date"></div>')
                    $('#fiche_modif').append('<li>'+k+'</li>')
                    Object.getOwnPropertyNames(contacts__[k]).forEach (element) -> $('#fiche_modif').append('<div class="m-date_div"><input class="date-type" type="text" value="'+element+'"></input><input type="text" class="dates" value="'+contacts__[k][element]+'"></input><br/></div>')
                  if k is "adresses"
                    $('#fiche_modif').append('<br/><label>Adresse(s)</label><button id="m-adresse">Ajouter</button><div id="modif-adresse"></div>') 
                    $('#fiche_modif').append('<li>'+k+'</li>')
                    Object.getOwnPropertyNames(contacts__[k]).forEach (element) -> $('#fiche_modif').append('<div class="m-adress_form"><input class="adress-type" type="text" value="'+element+'"></input><input class="line" value="'+contacts__[k][element]+'"></input><br/>')
 
                  $('#fiche_modif').append('<li>'+k+'</li><input id="m-'+k+'" type="text" value="'+ contacts__[k] + '"></input>') unless k == "archive" or k == "_id" or k == "telephone" or k == "courriel" or k == "website" or k == "dateImportante" or k == "adresses"
        $('#fiche_modif').append('<br/><br/><button id="sauvegarder">Sauvegarder</button>')
        $('#fiche_modif').append('<button id="annuler">Annuler</button><br/><br/>')


#
#
# Requete AJAX pour aller chercher tous les contacts de la base de données et les 
# afficher dans l'interface principale du site web.
#
#

  contact_ajax =  type: "GET"
                 ,dataType: "html"
                 ,url: "/contact/"
                 ,error: (erreur) ->
                     console.log "Erreur lors du chargement des contact." + erreur
                 ,success: (response) ->
                     nouvRep = JSON.parse(response)
                     nouvRep.forEach (item) ->
                      $("#liste").append "<a class=\"contact\"  href=\"#\" id=\"" + item._id+"\">" + item.prenom + " " + item.nom + "</a><br/><br/>"
  $.ajax contact_ajax


#
#
# Archiver un contact
#
#

  $('body').on "click", "#archiver", (event_) -> 
    contact_id = $('#_id-liste').text()
    $.ajax
       type: "POST"
       url: "/archiver/"+contact_id+"/"
       error: (erreur) ->
          console.log "Erreur lors du chargement."
       success: (response_archive) ->
          $('#fiche').html(" ")
          $('#resultatRecherche').html(" ")
          $('#'+contact_id).html(" ")
          console.log response_archive
          alert("Le contact à été archiver avec succès.")

#
#
# Effacer un contact.
# 
#

  $('body').on "click", "#effacer", (event__) ->
    contact_id_effacer = $('#_id-liste').text()
    $.ajax
      type: "DELETE"
      url: "/contact/"+contact_id_effacer+"/"
      error: (erreur) ->
         console.log "Erreur lors du chargement."
      success: (response_effacer) ->
         $('#'+contact_id_effacer).html(" ") 
         $('#fiche').html(" ")
         $('#resultatRecherche').html(" ")
         console.log response_effacer
         alert("Le Contact à été effacer.")


#
#
# Lancer la recherche à 
# partir de l'interface web.
#
#

  $('body').on "click", "#recherche_", (event___) ->
    terme = $('#recherche_input').val()
    $.ajax
      type: "GET"
      dataType: "json"
      url: "/recherche/"+terme+"/"
      error: (erreur) ->
        console.log "Erreur lors du chargement de la recherche."
      success: (response_recherche) ->
        $('#resultatRecherche').html(" ")
        if (!/\S/.test(response_recherche)) or response_recherche.length is "" 
         $('#resultatRecherche').html("Aucun résultats de recherche")
        resultat_recherche = response_recherche
        resultat_recherche.forEach (item_) ->
          $("#resultatRecherche").append "<a class=\"contact_r\"  href=\"#\" id=\"" + item_._id+"\">" + item_.prenom + " " + item_.nom + "</    a><br/><br/>"


#
#
# Ecouteur sur bouton Annuler qui 
# cache la section de modification
#
#

  $('body').on "click", "#annuler", (_event___) ->
     $('#fiche_modif').html("")
     $('#fiche').show()


# 
#
# Ecouteur sur bouton sauvegarder de la section 
# de modification d'un contact.
#
# 
  
  $("#fiche_modif").on "click", "#sauvegarder", (__event___) ->
    
    telephones = {} 
    tel_cont = {}
    courriels = {}
    courriel_cont = {}
    websites = {}
    website_cont = {}
    dates = {}
    dates_cont = {}
    adress = {}
    adress_cont  = {}
    adressLine = "" 
    id_modifier_contact = $('#_id-liste').text()
    
    send_ajax = (data_sent) ->
      ajax_obj = 
        type: "PUT"
        datatype: "application/json/"
        contentType: "application/json"
        data: JSON.stringify(data_sent)
        url: "/contact/" + id_modifier_contact + "/"
        error: (erreur) ->
          console.log erreur
        success: (response_) ->
      $.ajax ajax_obj

    $('.m-tel_div').each (elem) ->
       phone_type = $(this).find('.phoneType').val()
       telephones[phone_type] = $(this).find('.phones').val()
    tel_cont["telephone"] = telephones
    if $.isEmptyObject(telephones) 
      console.log "empty"
    else 
      send_ajax(tel_cont)

    $('.m-mail_div').each (elem) ->
       mail_type = $(this).find('.courrielType').val()
       courriels[mail_type] = $(this).find('.mail').val()
    courriel_cont["courriel"] = courriels
    if $.isEmptyObject(courriels)
       console.log "empty"
    else
       send_ajax(courriel_cont)
         
    $('.m-web_div').each (elem) ->
       web_type = $(this).find('.website-type').val()
       websites[web_type] = $(this).find('.website').val()
    website_cont["website"] = websites
    send_ajax(website_cont)

    $('.m-date_div').each (elem) -> 
       date_type = $(this).find('.date-type').val()
       dates[date_type] = $(this).find('.dates').val()
    dates_cont["dateImportante"] = dates
    send_ajax(dates_cont)

    $('.m-adress_form').each (elem) ->
       adress_type = $(this).find('.adress-type').val()
       adressLine = $(this).find('.line').val()
       adress[adress_type] = adressLine
    adress_cont["adresses"] = adress
    send_ajax(adress_cont)
    
    prenom = {}
    prenom.prenom = $('#m-prenom').val()
    send_ajax(prenom)
    
    nom = {}
    nom.nom = $('#m-nom').val()
    send_ajax(nom)

    note = {}
    note.noteAdditionnelle = $('#m-noteAdditionnelle').val()
    send_ajax(note)
		    
    prof = {}
    prof.prof = $('#m-prof').val()
    send_ajax(prof)

    organisation = {}
    organisation.organisation = $('#m-organisation').val()
    send_ajax(organisation)

    naissance = {}
    naissance.naissance = $('#m-naissance').val()
    send_ajax(naissance)

    titre = {}
    titre.titre = $('#m-titre').val()
    send_ajax(titre)
      
    $('#liste').find('br, a').remove()
    $("#fiche_modif").html("")
    $.ajax contact_ajax
    alert "Le contact à été modifié."


#
# 
# Methode pour generer le code html nécéssaire à 
# plusieurs téléphones, site web, courriels, etc...
# pour la modification de contact.
#
#

  $('body').on "click", "#m-telephone", (event____) ->
     $('#modif-telephone').append("<label> Téléphone </label><div class='m-tel_div'><input class='phoneType' type='text' placeholder='Bureau, Maison, Cell.'></input>  <input class='phones' type='text' placeholder='XXXXXXXXXX'></input><br/></div>")
    
  $('body').on "click", "#m-courriel", (_event) ->
     $('#modif-courriel').append("<label> Courriel </label><div class='m-mail_div'><input class='courrielType' type='text' placeholder='Promo, Bureau, loisirs'></input>  <input class='mail' type='text' placeholder='example@foo.bar'></input><br/></div>")

  $('body').on "click", "#m-adresse", (__event) ->
     $('#modif-adresse').append('<br/><label> Adresse </label><div class="m-adress_form"><input class="adress-type" type="text" placeholder="Maison, Bureau, Chalet"></input> <label> Adresse </label><input class="line" type="text" placeholder="1234 # avenue/rue/boul."></input><br/><br/></div> ')

  $('body').on "click", "#m-website", (___event) ->
     $('#modif-website').append('<br/><label>Site web</label><div class="m-web_div"><input type="text" placeholder="Professionel, personnel" class="website-type"></input> <input class="website" type="text" placeholder="www.example.com"></input><br/></div> ')

  $('body').on "click", "#m-dateImportante", (_event_) ->
     $('#modif-date').append('<br/><label>Date importante</label><div class="m-date_div"><input type="text" placeholder="Évènement, anniversaire" class="date-type"></input> <input class="dates" type="text" placeholder="AAAA/MM/JJ"></input><br/></div> ' )

#
# 
# Methode pour generer le code html nécéssaire à 
# plusieurs téléphones, site web, courriels, etc..
# Pour l'ajout de contact.
#
#

  $('body').on "click", "#telephone", (event____) ->
     $('#liste-telephone').append("<label> Téléphone </label><div class='tel_div'><input class='phoneType' type='text' placeholder='Bureau, Maison, Cell.'></input>  <input class='phones' type='text' placeholder='XXXXXXXXXX'></input><br/></div>")
    
  $('body').on "click", "#courriel", (_event) ->
     $('#liste-courriel').append("<label> Courriel </label><div class='mail_div'><input class='courrielType' type='text' placeholder='Promo, Bureau, loisirs'></input>  <input class='mail' type='text' placeholder='example@foo.bar'></input><br/></div>")

  $('body').on "click", "#adresse", (__event) ->
     $('#liste-adresse').append('<br/><label> Adresse </label><div class="adress_form"><input class="adress-type" type="text" placeholder="Maison, Bureau, Chalet"></input> <label> Adresse </label> <input class="line" type="text" placeholder="1234 # avenue/rue/boul."></input><br/><br/></div> ')

  $('body').on "click", "#website", (___event) ->
     $('#liste-website').append('<br/><label>Site web</label><div class="web_div"><input type="text" placeholder="Professionel, personnel" class="website-type"></input> <input class="websites" type="text" placeholder="www.example.com"></input><br/></div> ')

  $('body').on "click", "#dateImportante", (_event_) ->
     $('#liste-date').append('<br/><label>Date importante</label><div class="date_div"><input type="text" placeholder="Évènement, anniversaire" class="date-type"></input> <input class="dates" type="text" placeholder="AAAA/MM/JJ"></input><br/></div> ' )


#
#
# Méthode pour construire et envoyer l'objet 
# qui sera insérer dans la base de donnée. 
#
#

  $('body').on "click", "#sendform", (__event_) ->
    objet = {}
    objet.sexe = $('input:radio[name=sexe]:checked').val() or "nonspécifié"
    objet.nom = $('#nom').val() or "nonspécifié"
    objet.prenom = $('#prenom').val() or "nonspécifié"
    objet.titre = $('#titre').val() or "nonspécifié"
    objet.organisation = $('#org').val() or "nonspécifié"
    objet.prof = $('#job').val() or "nonspécifié"
    objet.naissance = $('#naissance').val() or "nonspécifié"
    objet.noteAdditionnelle = $('#noteAdditionnelle').val() or "aucune"
    objet.archive = 0
     
    if objet.nom is "nonspécifié" and objet.prenom is "nonspécifié" 
     if objet.organisation is "nonspécifié" 
       alert("Le contact doit MINIMALEMENT avoir un nom, prénom, ou un nom d'organisation")
       return
    if objet.nom is "nonspécifié" or objet.prenom is "nonspécifié" 
     if objet.organisation is "nonspécifié"
       alert("Le contact doit MINIMALEMENT avoir un nom, prénom, ou un nom d'organisation")
       return

    telephones =  {}
    courriels = {}
    websites = {}
    dates = {}
    adress = {}
    adressLine = ""

    $('.tel_div').each (elem) ->
       phone_type = $(this).find('.phoneType').val()
       telephones[phone_type] = $(this).find('.phones').val()
    objet.telephone = telephones or "nonspécifié"
    
    $('.mail_div').each (elem) ->
       mail_type = $(this).find('.courrielType').val()
       courriels[mail_type] = $(this).find('.mail').val()
    objet.courriel = courriels or "nonspécifié"

    $('.web_div').each (elem) ->
       web_type = $(this).find('.website-type').val()
       websites[web_type] = $(this).find('.websites').val()
    objet.website = websites

    $('.date_div').each (elem) -> 
       date_type = $(this).find('.date-type').val()
       dates[date_type] = $(this).find('.dates').val()
    objet.dateImportante = dates

    $('.adress_form').each (elem) ->
       adress_type = $(this).find('.adress-type').val()
       adressLine = $(this).find('.line').text()
       adress[adress_type] = adressLine
    objet.adresses = adress
    
    json_objet = JSON.stringify(objet)
    escaped = json_objet.replace(/\./g, " point ")
    
    $.ajax
      type: "POST"
      data: escaped
      contentType: 'application/json'
      url: "/contact/"
      error: (erreur) ->
        console.log "Erreur lors du transfert de données." + erreur
      success: (response_create) ->
        $('#ajouter').find('input').each (elem) ->
          $(this).val("")
        $('#liste a, #liste br').remove()
        $('#ajouter').slideToggle()
        $.ajax contact_ajax

