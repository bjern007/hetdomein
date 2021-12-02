// [ Breathalyzer Script 0.1 Created By JKSensation ] //
// [ DO NOT RELEASE/LEAK/SHARE CODE WITHOUT PERMISSION FROM JKSENSATION ] //

$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }else if(item.type === 'data'){
            $('#bacLevel').text(item.bac)
            $('#bacLevel').css("color", `var(${item.textColor})`)
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://breathalyzer/exit', JSON.stringify({}));
            return
        }
    };
    $("#power").click(function () {
        $.post('http://breathalyzer/exit', JSON.stringify({}));
        return
    })
    $("#start").click(function () {
        $.post('http://breathalyzer/startBac', JSON.stringify({}));
        return
    })
})