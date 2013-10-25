# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	jQuery(".shortname").animate({"color":"red"},1000);


jQuery ->
	jQuery(".flip").filter(function () {
   return parseInt(jQuery(this.price).inner()) < 5.0;
}).hide();