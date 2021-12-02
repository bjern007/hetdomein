var CurrentAmbulancePage = null;
var OpenedPerson = null;

$(document).on('click', '.ambulance-block', function(e){
    e.preventDefault();
    var PressedBlock = $(this).data('meosblock');
    OpenAmbulanceApp(PressedBlock);
});

OpenAmbulanceApp = function(page) {
    CurrentAmbulancePage = page;
    $(".ambulance-"+CurrentAmbulancePage+"-page").css({"display":"block"});
    $(".ambulance-homescreen").animate({
        left: 30+"vh"
    }, 200);
    $(".ambulance-tabs").animate({
        left: 0+"vh"
    }, 200, function(){
        $(".ambulance-tabs-footer").animate({
            bottom: 0,
        }, 200)
        if (CurrentAmbulancePage == "alerts") {
            $(".ambulance-recent-alert").removeClass("noodknop");
            $(".ambulance-recent-alert").css({"background-color":"#004682"}); 
        }
    });
}

SetupAmbulancePage = function() {
    $("#ambulance-app-name").html("Welkom " + QB.Phone.Data.PlayerData.charinfo.firstname + " " + QB.Phone.Data.PlayerData.charinfo.lastname);
}

MeosHomePage = function() {
    $(".ambulance-tabs-footer").animate({
        bottom: -5+"vh"
    }, 200);
    setTimeout(function(){
        $(".ambulance-homescreen").animate({
            left: 0+"vh"
        }, 200, function(){
            if (CurrentAmbulancePage == "alerts") {
                $(".ambulance-alert-new").remove();
            }
            $(".ambulance-"+CurrentAmbulancePage+"-page").css({"display":"none"});
            CurrentAmbulancePage = null;
            $(".person-search-results").html("");
            $(".vehicle-search-results").html("");
        });
        $(".ambulance-tabs").animate({
            left: -30+"vh"
        }, 200);
    }, 400);
}

$(document).on('click', '.ambulance-tabs-footer', function(e){
    e.preventDefault();
    MeosHomePage();
});

$(document).on('click', '.person-search-result', function(e){
    e.preventDefault();

    var ClickedPerson = this;
    var ClickedPersonId = $(this).attr('id');
    var ClickedPersonData = $("#"+ClickedPersonId).data('PersonData');

    var Gender = "Man";
    if (ClickedPersonData.gender == 1) {
        Gender = "Vrouw";
    }
    var HasLicense = "Ja";
    if (!ClickedPersonData.driverlicense) {
        HasLicense = "Nee";
    }
    var appartmentid = {};
    if (ClickedPersonData.appartmentid) {
        appartmentid = ClickedPersonData.appartmentid;
    }

    var OpenElement = '<div class="person-search-result-name">Naam: '+ClickedPersonData.firstname+' '+ClickedPersonData.lastname+'</div> <div class="person-search-result-bsn">BSN: '+ClickedPersonData.citizenid+'</div> <div class="person-opensplit"></div> &nbsp; <div class="person-search-result-dob">Geboortedag: '+ClickedPersonData.birthdate+'</div> <div class="person-search-result-number">Telefoon-nummer: '+ClickedPersonData.phone+'</div> <div class="person-search-result-nationality">Nationaliteit: '+ClickedPersonData.nationality+'</div> <div class="person-search-result-gender">Geslacht: '+Gender+'</div> <div class="person-search-result-driverslicense">Rijbewijs: '+HasLicense+'</div> &nbsp; <div class="person-search-result-apartment"><span id="'+ClickedPersonId+'">Appartement: ' +ClickedPersonData.appartmentname+ ' ('+ClickedPersonData.appartmentid+')</span> &nbsp; ';

    if (OpenedPerson === null) {
        $(ClickedPerson).html(OpenElement)
        OpenedPerson = ClickedPerson;
    } else if (OpenedPerson == ClickedPerson) {
        var PreviousPersonId = $(OpenedPerson).attr('id');
        var PreviousPersonData = $("#"+PreviousPersonId).data('PersonData');
        var PreviousElement = '<div class="person-search-result-name">Naam: '+PreviousPersonData.firstname+' '+PreviousPersonData.lastname+'</div> <div class="person-search-result-bsn">BSN: '+PreviousPersonData.citizenid+'</div>';
        $(ClickedPerson).html(PreviousElement)
        OpenedPerson = null;
    } else {
        var PreviousPersonId = $(OpenedPerson).attr('id');
        var PreviousPersonData = $("#"+PreviousPersonId).data('PersonData');
        var PreviousElement = '<div class="person-search-result-name">Naam: '+PreviousPersonData.firstname+' '+PreviousPersonData.lastname+'</div> <div class="person-search-result-bsn">BSN: '+PreviousPersonData.citizenid+'</div>';
        $(OpenedPerson).html(PreviousElement)
        $(ClickedPerson).html(OpenElement)
        OpenedPerson = ClickedPerson;
    }
});


$(document).on('click', '.confirm-search-person-test', function(e){
    e.preventDefault();
    var SearchName = $(".person-search-input").val();

    if (SearchName !== "") {
        $.post('http://pepe-phone/FetchSearchResults', JSON.stringify({
            input: SearchName,
        }), function(result){
            if (result != null) {
                $(".person-search-results").html("");
                $.each(result, function (i, person) {
                    var PersonElement = '<div class="person-search-result" id="person-'+i+'"><div class="person-search-result-name">Naam: '+person.firstname+' '+person.lastname+'</div> <div class="person-search-result-bsn">BSN: '+person.citizenid+'</div> </div>';
                    $(".person-search-results").append(PersonElement);
                    $("#person-"+i).data("PersonData", person);
                });
            } else {
                QB.Phone.Notifications.Add("politie", "MEOS", "Er zijn geen zoek resultaten!");
                $(".person-search-results").html("");
            }
        });
    } else {
        QB.Phone.Notifications.Add("politie", "MEOS", "Er zijn geen zoek resultaten!");
        $(".person-search-results").html("");
    }
});

$(document).on('click', '.confirm-search-vehicle', function(e){
    e.preventDefault();
    var SearchName = $(".vehicle-search-input").val();
    
    if (SearchName !== "") {
        $.post('http://pepe-phone/FetchVehicleResults', JSON.stringify({
            input: SearchName,
        }), function(result){
            if (result != null) {
                $(".vehicle-search-results").html("");
                $.each(result, function (i, vehicle) {
                    var APK = "Ja";
                    if (!vehicle.status) {
                        APK = "Nee";
                    }
                    var Flagged = "Nee";
                    if (vehicle.isFlagged) {
                        Flagged = "Ja";
                    }
                    
                    var VehicleElement = '<div class="vehicle-search-result"> <div class="vehicle-search-result-name">'+vehicle.label+'</div> <div class="vehicle-search-result-plate">Kenteken: '+vehicle.plate+'</div> <div class="vehicle-opensplit"></div> &nbsp; <div class="vehicle-search-result-owner">Eigenaar: '+vehicle.owner+'</div> &nbsp; <div class="vehicle-search-result-apk">APK: '+APK+'</div> <div class="vehicle-search-result-warrant">Gesignaleerd: '+Flagged+'</div> </div>'
                    $(".vehicle-search-results").append(VehicleElement);
                });
            }
        });
    } else {
        QB.Phone.Notifications.Add("politie", "MEOS", "Er zijn geen zoek resultaten!");
        $(".vehicle-search-results").html("");
    }
});

$(document).on('click', '.scan-search-vehicle', function(e){
    e.preventDefault();
    $.post('http://pepe-phone/FetchVehicleScan', JSON.stringify({}), function(vehicle){
        if (vehicle != null) {
            $(".vehicle-search-results").html("");
            var APK = "Ja";
            if (!vehicle.status) {
                APK = "Nee";
            }
            var Flagged = "Nee";
            if (vehicle.isFlagged) {
                Flagged = "Ja";
            }

            var VehicleElement = '<div class="vehicle-search-result"> <div class="vehicle-search-result-name">'+vehicle.label+'</div> <div class="vehicle-search-result-plate">Kenteken: '+vehicle.plate+'</div> <div class="vehicle-opensplit"></div> &nbsp; <div class="vehicle-search-result-owner">Eigenaar: '+vehicle.owner+'</div> &nbsp; <div class="vehicle-search-result-apk">APK: '+APK+'</div> <div class="vehicle-search-result-warrant">Gesignaleerd: '+Flagged+'</div> </div>'
            $(".vehicle-search-results").append(VehicleElement);
        } else {
            QB.Phone.Notifications.Add("politie", "MEOS", "Geen voertuig in de buurt!");
            $(".vehicle-search-results").append("");
        }
    });
});

AddAmbulanceAlert = function(data) {
    var randId = Math.floor((Math.random() * 10000) + 1);
    var AlertElement = '';
    if (data.alert.coords != undefined && data.alert.coords != null) {
        AlertElement = '<div class="ambulance-alerts" id="alert-'+randId+'"> <span class="ambulance-alert-new" style="margin-bottom: 1vh;">NIEUW</span> <p class="ambulance-alert-type">Melding: '+data.alert.title+'</p> <p class="ambulance-alert-description">'+data.alert.description+'</p> <hr> <div class="ambulance-location-button">LOCATIE</div> </div>';
    } else {
        AlertElement = '<div class="ambulance-alerts" id="alert-'+randId+'"> <span class="ambulance-alert-new" style="margin-bottom: 1vh;">NIEUW</span> <p class="ambulance-alert-type">Melding: '+data.alert.title+'</p> <p class="ambulance-alert-description">'+data.alert.description+'</p></div>';
    }
    $(".ambulance-recent-alerts").html('<div class="ambulance-recent-alert" id="recent-alert-'+randId+'"><span class="ambulance-recent-alert-title">Melding: '+data.alert.title+'</span><p class="ambulance-recent-alert-description">'+data.alert.description+'</p></div>');
    if (data.alert.title == "Assistentie collega") {
        $(".ambulance-recent-alert").css({"background-color":"#d30404"}); 
        $(".ambulance-recent-alert").addClass("noodknop");
    }
    $(".ambulance-alerts").prepend(AlertElement);
    $("#ambulance-alert-"+randId).data("alertData", data.alert);
    $("#recent-alert-"+randId).data("alertData", data.alert);
}

$(document).on('click', '.ambulance-recent-alert', function(e){
    e.preventDefault();
    var alertData = $(this).data("alertData");

    if (alertData.coords != undefined && alertData.coords != null) {
        $.post('http://pepe-phone/SetAlertWaypoint', JSON.stringify({
            alert: alertData,
        }));
    } else {
        QB.Phone.Notifications.Add("politie", "MEOS", "Deze melding heeft geen GPS Locatie!");
    }
});

$(document).on('click', '.ambulance-location-button', function(e){
    e.preventDefault();
    var alertData = $(this).parent().data("alertData");
    $.post('http://pepe-phone/SetAlertWaypoint', JSON.stringify({
        alert: alertData,
    }));
});

$(document).on('click', '.ambulance-clear-alerts', function(e){
    $(".ambulance-alerts").html("");
    $(".ambulance-recent-alerts").html('<div class="ambulance-recent-alert"> <span class="ambulance-recent-alert-title">Je hebt nog geen meldingen!</span></div>');
    QB.Phone.Notifications.Add("politie", "MEOS", "Alle meldingen zijn verwijderd!");
});