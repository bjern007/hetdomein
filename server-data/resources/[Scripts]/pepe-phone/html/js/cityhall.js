var Cityhall = {}
var mouseOver = false;
var selectedIdentity = null;
var selectedIdentityType = null;
var selectedJob = null;
var selectedJobId = null;
var expired = false;

//KAMATCHO DEVS

$(document).on("click", ".job-page-block", function (e) {
    e.preventDefault();
    var job = $(this).data('job');

    var tomorrow = new Date(new Date().getTime() + 24 * 60 * 60 * 1000);
    const maanden = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var countDownDate = new Date(maanden[tomorrow.getMonth()] + tomorrow.getDate() + ", " + tomorrow.getFullYear() + " 05:00:00").getTime();

    var now = new Date().getTime();
    var distance = countDownDate - now;

    $.post('http://pepe-phone/applyJob', JSON.stringify({
        job: job,
        distance: distance
    }));
    displayTime();
});

function displayTime() {
    setInterval(function () {

        var tomorrow = new Date(new Date().getTime() + 24 * 60 * 60 * 1000);
        const maanden = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        var countDownDate = new Date(maanden[tomorrow.getMonth()] + tomorrow.getDate() + ", " + tomorrow.getFullYear() + " 09:00:00").getTime();

        var now = new Date().getTime();
        var distance = countDownDate - now;
        var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);
        document.getElementById("time-left").innerHTML = hours + "u " + minutes + "m " + seconds + "s ";
    }, 1000)
};