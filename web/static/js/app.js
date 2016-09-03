// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

var deadline = new Date(Date.parse(new Date()) + 20 * 60 * 1000);
var timer = document.getElementById('timer')
if (timer != null) {
  initializeClock(timer, deadline);
}

function getTimeRemaining(endtime) {
  var t = Date.parse(endtime) - Date.parse(new Date());
  var seconds = Math.floor((t / 1000) % 60);
  var minutes = Math.floor((t / 1000 / 60) % 60);
  return {
    'total': t,
    'minutes': minutes,
    'seconds': seconds
  }
}

function initializeClock(timer, endtime) {
  var minutes = timer.querySelector('.minutes');
  var seconds = timer.querySelector('.seconds');

  function updateClock() {
    var t = getTimeRemaining(endtime);

    minutes.innerHTML = ('0' + t.minutes).slice(-2);
    seconds.innerHTML = ('0' + t.seconds).slice(-2);

    if (t.total <= 0) {
      clearInterval(timeinterval);
      document.getElementById('quiz-form').submit();
    }
  }

  updateClock();
  var timeinterval = setInterval(updateClock, 1000);
}

var link = document.getElementById('instruction-link');
var modal = document.getElementById('instruction-modal');
var close = document.getElementById('close-modal');

function toggleModal() {
  modal.classList.toggle('show');
}

link.addEventListener('click', toggleModal)
close.addEventListener('click', toggleModal)
