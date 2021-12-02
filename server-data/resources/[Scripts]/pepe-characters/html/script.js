var selectedChar = null;
MultiChar = {}

$(document).ready(function (){
    window.addEventListener('message', function (event) {
        var data = event.data;

        if (data.action == "ui") {
            if (data.toggle) {
                $('.character-list').fadeIn(1000);
                $('.character-list-buttons').hide();

                $.post('http://pepe-characters/setupCharacters');
                $.post('http://pepe-characters/removeBlur');

            } else {
                $('.character-list').fadeOut(250);
            }
        }

        if (data.action == "setupCharacters") {
            setupCharacters(event.data.characters)
        }
    });
});

function setupCharacters(characters) {
    $.each(characters, function(index, char){
        $('#char-'+char.cid).html("");
        $('#char-'+char.cid).data("citizenid", char.citizenid);

        $('#char-'+char.cid).html('<div class="character-icon"><i class="fas fa-id-badge"></i></div><p>'+char.charinfo.firstname+' '+char.charinfo.lastname+'<p>');
        $('#char-'+char.cid).data('cData', char)
        $('#char-'+char.cid).data('cid', char.cid)
    })
}

$(document).on('click', '.character-box', function(e) {
    var cDataPed = $(this).data('cData');
    e.preventDefault();
    if (selectedChar === null) {
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            $(selectedChar).addClass("selected");
            $('.character-list-buttons').css({"display":"block"});
            $('#create').css({"display":"block"});
            $('#play').css({"display":"none"});
            $('#delete').css({"display":"none"});
            $.post('http://pepe-characters/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        } else {
            $(selectedChar).addClass("selected");
            $('.character-list-buttons').css({"display":"block"});
            $('#create').css({"display":"none"});
            $('#play').css({"display":"block"});
            $('#delete').css({"display":"block"});
            $.post('http://pepe-characters/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        }
    } else if ($(selectedChar).attr('id') !== $(this).attr('id')) {
        $(selectedChar).removeClass("selected");
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            $(selectedChar).addClass("selected");
            $('.character-list-buttons').css({"display":"block"});
            $('#create').css({"display":"block"});
            $('#play').css({"display":"none"});
            $('#delete').css({"display":"none"});
            $.post('http://pepe-characters/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        } else {
            $(selectedChar).addClass("selected");
            $('.character-list-buttons').css({"display":"block"});
            $('#create').css({"display":"none"});
            $('#play').css({"display":"block"});
            $('#delete').css({"display":"block"});
            $.post('http://pepe-characters/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        }
    }
});

$(document).on('click', '#create', function(e) {
    $('.character-container').css({"display":"none"});
    $('#hidden').css({"display":"block"});
});

$(document).on('click', '#create-user', function(e){
    e.preventDefault();
    $.post('http://pepe-characters/createNewCharacter', JSON.stringify({
        firstname: $('#first_name').val(),
        lastname: $('#last_name').val(),
        nationality: $('#nationality').val(),
        birthdate: $('#birthdate').val(),
        gender: $('select[name=gender]').val(),
        cid: $(selectedChar).attr('id').replace('char-', ''),
    }));
    refreshCharacters()
});

$(document).on('click', '#accept-delete', function(e){
    $.post('http://pepe-characters/removeCharacter', JSON.stringify({
        citizenid: $(selectedChar).data("citizenid"),
    }));
    $('.character-delete').fadeOut(150);
    refreshCharacters()
});

function refreshCharacters() {
    $('.character-list-block').html('<div class="character-box" id="char-1" data-cid=""><div class="character-icon"><i class="fas fa-plus"></i></div><div class="character-box" id="char-2" data-cid=""><div class="character-icon"><i class="fas fa-plus"></i></div><div class="character-box" id="char-3" data-cid=""><div class="character-icon"><i class="fas fa-plus"></i></div><div class="character-box" id="char-4" data-cid=""><div class="character-icon"><i class="fas fa-plus"></i></div><div class="character-box" id="char-5" data-cid=""><div class="character-icon"><i class="fas fa-plus"></i></div><div class="character-list-buttons"><div class="char-button" id="create">Nieuw karakter aanmaken</div><div class="char-button" id="play">Met gekozen karakter spelen</div><div class="char-button" id="delete">Gekozen karakter verwijderen</div></div>')

    $(selectedChar).removeClass("selected");
    selectedChar = null;
    $.post('http://pepe-characters/setupCharacters');
    $('.character-list-buttons').css({"display":"none"});
    $('#create').css({"display":"none"});
    $('#play').css({"display":"none"});
    $('#delete').css({"display":"none"});
}


$("#close-reg").click(function (e) {
    e.preventDefault();
    $('.character-creation').css({"display":"none"});
})

$("#close-del").click(function (e) {
    e.preventDefault();
    $('.character-delete').css({"display":"none"});
})

$(document).on('click', '#play', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $.post('http://pepe-characters/selectCharacter', JSON.stringify({
                cData: $(selectedChar).data('cData')
            }));
            $(selectedChar).removeClass("selected");
        }
    }
});

$(document).on('click', '#delete', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $('.character-delete').fadeIn(250);
        }
    }
});


window.onload = function(e) {
    $(".character-list").hide();
}