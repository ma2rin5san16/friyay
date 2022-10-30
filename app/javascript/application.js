// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require jquery_ujs
//= require jquery
//= require popper
//= require bootstrap-sprockets
//= require_tree .
import "@hotwired/turbo-rails"
import jQuery from "jquery";
window.$ = window.jQuery = jQuery;
