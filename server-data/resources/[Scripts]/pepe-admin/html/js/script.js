QB = {}
QB.Admin = {}
var CurrentMenu = null;
var CurrentData = null;

var announceopen = false

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case "open":
            QB.Admin.Open(event.data);
            break;
        case "close":
            QB.Admin.Close(event.data);
            break;            
    }
});

QB.Admin.Open = function(data) {
    $(".mainblock").fadeIn(450);
    $(".title").fadeIn(450);
    $(".block4").fadeIn(450);
    $("#total-players").html("<p>"+data.playersonline+"</p>");
    $.post('http://pepe-admin/GetPlayers', JSON.stringify({}), function(Players){
        for (const [key, value] of Object.entries(Players)) {
            if (value.DeathState) {
                var PlayersContainer = '<div class="player-goto-options" id="total'+key+'"><div class="spectate-button"><p data-serverid="'+value.Serverid+'" data-playername="'+value.Name+'"></p></div><p><i class="fas fa-user-tag"></i>   '+ value.Steam +' #'+value.Serverid+' (Dood)</p><p><i class="fas fa-user-cog" ></i>   '+ value.Job +'</p></div>';
            } else {
                var PlayersContainer = '<div class="player-goto-options" id="total'+key+'"><div class="spectate-button"><p data-serverid="'+value.Serverid+'" data-playername="'+value.Name+'"></p></div><p><i class="fas fa-user-tag"></i>   '+ value.Steam +' #'+value.Serverid+' (Levend)</p><p><i class="fas fa-user-cog" ></i>   '+ value.Job +'</p></div>';
            }
            $('.player-container').append(PlayersContainer);
        }
    });
}

QB.Admin.Close = function(data) {
    $(".mainblock").fadeOut(450);
    $(".title").fadeOut(450);
    $(".block4").fadeOut(450);

    $('.player-container').html('');
    $.post('http://pepe-admin/Close');
}

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESCAPE
            QB.Admin.Close();
            break;
    }
});

$(document).on('click', '.spectate-button > p', function(e) {
    e.preventDefault();
    CurrentData = {serverid: $(this).data('serverid'), playername: $(this).data('playername')}
    $('.player-back-button').fadeOut(150)
    $('.current-player').html("<p>Huidige Speler: "+ CurrentData.playername + " #"+CurrentData.serverid+"</p>")
    $('.players-container').animate({"left": "40vh"}, 450, function() {
        $('.players-container').css("display", "none");
        setTimeout(function() {
            $('.player-options').css("display", "block");
            $('.player-options').animate({"left": "0vh"}, 450, function() {
                $('.player-back-button').fadeIn(150)
                CurrentMenu = ".player-options"
            })
          }, 50)
    })
});

$(document).on('click', '.player-back-button', function(e) {
    e.preventDefault();
    $(CurrentMenu).animate({"left": "40vh"}, 450, function() {
        $(CurrentMenu).css("display", "none");
        setTimeout(function() {
            $('.start-select').css("display", "block");
            $('.player-back-button').fadeOut(150)
            $('.start-select').animate({"left": "0vh"});
            CurrentMenu = ".start-select"
        }, 50)
    })
});

$(document).on('click', '.player-button', function(e) {
    e.preventDefault();
    var ClickType = $(this).data('type')
    if (ClickType == 'openinventory') {
        CloseAdminMenu()
        $.post('http://pepe-admin/OpenInventoryPlayer', JSON.stringify({
            serverid: CurrentData.serverid
        }));  
    } else if (ClickType == 'giveclothing') {
        CloseAdminMenu()
        $.post('http://pepe-admin/ClothingMenuPlayer', JSON.stringify({
            serverid: CurrentData.serverid
        })); 
    } else if (ClickType == 'kill') {
        $.post('http://pepe-admin/KillPlayer', JSON.stringify({
            serverid: CurrentData.serverid
        }));  
    } else if (ClickType == 'revive') { 
        $.post('http://pepe-admin/RevivePlayer', JSON.stringify({
            serverid: CurrentData.serverid
        }));  
    } else if (ClickType == 'kickplayer') {
        $.post('http://pepe-admin/KickPlayer', JSON.stringify({
            serverid: CurrentData.serverid
        }));  
    }
});

$(document).on('click', '#player-options', function(e) {
    e.preventDefault();
    $('.start-select').animate({"left": "40vh"}, 450, function() {
        $('.start-select').css("display", "none");
        setTimeout(function() {
            $('.players-container').css("display", "block");
            $('.players-container').animate({"left": "0vh"}, 450, function() {
                $('.player-back-button').fadeIn(150)
                CurrentMenu = ".players-container"
            })
        }, 50)
    })
});

$(document).on('click', '.option1', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/FixVehicle');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.option2', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/GeefKeys');
    QB.Admin.Close(event.data);

});


$(document).on('click', '.option3', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/CleanVehicle');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.option4', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/Hotwireveh');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.option5', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/Hotwireveh');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.type1', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/WeerExtraSunny');
    QB.Admin.Close(event.data);

});


$(document).on('click', '.type2', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/WeerExtraNeutral');
    QB.Admin.Close(event.data);

});


$(document).on('click', '.type3', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/WeerExtraClearing');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.type4', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/WeerExtraFoggy');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.type5', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/WeerExtraRain');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.houses-switch', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/ResetHouses');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.winkels-switch', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/StoreReset');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.humane-switch', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/HumaneReset');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.doors-switch', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/DoorsReset');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.weatherselect', function(e){


    // let weer2 = $('.weer').selected();
    $.post('http://pepe-admin/Weer', JSON.stringify({
        weer2: weer2
    }));
});

$(document).on('click', '.kick-all', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/KickAllPlayers');
    QB.Admin.Close(event.data);

});

$(document).on('click', '.weer', function(e){
    e.preventDefault();

    let weer = $('.weer').val();
    if (weer != null || weer != undefined) {
        $.post('http://pepe-admin/Weer', JSON.stringify({
            weer: weer
        }));
    } else {
        $.post('http://pepe-admin/NothingAnnounced');
    }

});

$(document).on('click', '.option1-play', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/SelfRevive');
});

$(document).on('click', '.option2-play', function(e){
    e.preventDefault();
    $.post('http://pepe-admin/DistanceRevive');
});

$(document).on('click', '.option3-play', function(e){
    e.preventDefault();

    let SpelerID = $('.server-id-form').val();
    if (SpelerID != null || SpelerID != undefined) {
        $.post('http://pepe-admin/ReviveOther', JSON.stringify({
            SpelerID: SpelerID
        }));
        $('.server-id-form').val('');

    } else {
        $.post('http://pepe-admin/NothingAnnounced');
    }
});

$(document).on('click', '.option4-play', function(e){
    e.preventDefault();

    let SpelerID = $('.server-id-form').val();
    if (SpelerID != null || SpelerID != undefined) {
        $.post('http://pepe-admin/BringPlayer', JSON.stringify({
            SpelerID: SpelerID
        }));
        $('.server-id-form').val('');

    } else {
        $.post('http://pepe-admin/NothingAnnounced');
    }
});

$(document).on('click', '.openinv-play', function(e){
    e.preventDefault();

    let SpelerID = $('.server-id-form').val();
    if (SpelerID != null || SpelerID != undefined) {
        $.post('http://pepe-admin/OpenInv', JSON.stringify({
            SpelerID: SpelerID
        }));
        $('.server-id-form').val('');

    } else {
        $.post('http://pepe-admin/NothingAnnounced');
    }
});

$(document).on('click', '.option6-play', function(e){
    e.preventDefault();

    let SpelerID = $('.server-id-form').val();
    if (SpelerID != null || SpelerID != undefined) {
        $.post('http://pepe-admin/GotoPlayer', JSON.stringify({
            SpelerID: SpelerID
        }));
        $('.server-id-form').val('');

    } else {
        $.post('http://pepe-admin/NothingAnnounced');
    }
});

$(document).on('change', '.noclip-switch', function(e){
    e.preventDefault();
    var checkBoxes = $(".noclip-switch")
    Naampies = !checkBoxes.prop("checked");
    checkBoxes.prop("checked", Naampies);
        $.post('http://pepe-admin/Shownames', JSON.stringify({
            Aan: Naampies
        }));
});

$(document).on('change', '.blips-switch', function(e){
    e.preventDefault();
    var checkBoxes2 = $(".blips-switch")
    Blipjes = !checkBoxes2.prop("checked");
    checkBoxes2.prop("checked", Blipjes);
        $.post('http://pepe-admin/SpelerBlips', JSON.stringify({
            Aan: Blipjes
        }));
});

$(document).on('change', '.reports-switch', function(e){
    e.preventDefault();
    var checkBoxes2 = $(".reports-switch")
    Reports = !checkBoxes2.prop("checked");
    checkBoxes2.prop("checked", Reports);
        $.post('http://pepe-admin/ToggleReport', JSON.stringify({
            Aan: Reports
        }));
});

$(document).on('change', '.invisible-switch', function(e){
    e.preventDefault();
    var checkBoxes3 = $(".invisible-switch")
    Godmodes = !checkBoxes3.prop("checked");
    checkBoxes3.prop("checked", Godmodes);
        $.post('http://pepe-admin/Godmode', JSON.stringify({
            Aan: Godmodes
        }));
});


$(document).on('click', '.server-broadcast', function(e){
    e.preventDefault();
    $(".announcement-popup").fadeIn(450);
});

$(document).on('click', '.restart-popup', function(e){
    e.preventDefault();
        $(".restart").fadeIn(450);
});

$(document).on('click', '.server-broadcast', function(e){
    e.preventDefault();
        let message = $('.announce-form').val();
        if (message != null || message != undefined) {
            $.post('http://pepe-admin/Announced', JSON.stringify({
                message: message
            }));
            $('.announce-form').val('');

        } else {
            $.post('http://pepe-admin/NothingAnnounced');
        }
});

$(document).on('click', '#cancel-annoucement', function(e){
    e.preventDefault();
        $(".announcement-popup").fadeOut(450);
});

