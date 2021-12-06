"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var Accordion =
/*#__PURE__*/
function () {
  function Accordion(container) {
    _classCallCheck(this, Accordion);

    this.$container = $(container);
    this.$item = this.$container.find('.js-accordion-item');
    this.$button = this.$container.find('.js-accordion-btn');
    this.setListeners();
  }

  _createClass(Accordion, [{
    key: "setListeners",
    value: function setListeners() {
      this.$item.on('click', '.js-accordion-btn', function (event) {
        event.preventDefault();
        var $currentItem = $(event.currentTarget).parents('.js-accordion-item');
        var $content = $currentItem.find('.js-accordion-content');

        if ($currentItem.hasClass('open')) {
          $currentItem.removeClass('open');
          $content.slideUp(300);
        } else {
          $currentItem.addClass('open');
          $content.slideDown(300);
        }
      });
    }
  }]);

  return Accordion;
}();

$(function () {
  $('.js-accordion').each(function (i, container) {
    return new Accordion(container);
  });
});

var Select =
/*#__PURE__*/
function () {
  function Select(item) {
    _classCallCheck(this, Select);

    this.$select = $(item);
    this.setListeners();
  }

  // Если что, расскомментить
  // _createClass(Select, [{
  //   key: "setListeners",
  //   value: function setListeners() {
  //     this.$select.select2({
  //       theme: 'main',
  //       language: 'ru',
  //       minimumResultsForSearch: -1 // опции для поиска в селекте
  //       // selectionAdapter: $.fn.select2.amd.require('SearchableSingleSelection'),
  //       // dropdownAdapter: $.fn.select2.amd.require('UnsearchableDropdown'),
  //
  //     });
  //   }
  // }]);

  return Select;
}();

$(function () {
  $('.js-select').each(function (i, item) {
    return new Select(item);
  });
});

var MobileMenu =
/*#__PURE__*/
function () {
  function MobileMenu(ontainer) {
    _classCallCheck(this, MobileMenu);

    this.$container = $(ontainer);
    this.$button = this.$container.find('.js-mobile-menu-btn');
    this.$body = $('body');
    this.CLASS_OPEN = 'is-open';
    this.setListeners();
  }

  _createClass(MobileMenu, [{
    key: "setListeners",
    value: function setListeners() {
      var _this = this;

      this.$button.on('click', function () {
        if (_this.$container.hasClass(_this.CLASS_OPEN)) {
          _this.$container.removeClass(_this.CLASS_OPEN);

          _this.$body.css('overflow', '');
        } else {
          _this.$container.addClass(_this.CLASS_OPEN);

          _this.$body.css('overflow', 'hidden');
        }
      });
    }
  }]);

  return MobileMenu;
}();

$(function () {
  $('.js-mobile-menu').each(function (i, item) {
    return new MobileMenu(item);
  });
});

function getData(sel){
    var r_id = sel.val();
    var Name;
    sel.find('option').each(function(i){
        var option = $(this);
        if (option.val() == r_id){
            Name = option.attr("data-name");
            return false;
        }
    });
    return Name;
}
var SiteCountryID = $("#SiteCountryID");
var SiteCountry = $("#SiteCountry");
var SiteRegionID = $("#SiteRegionID");
/*var SiteRegion = $("#SiteRegion");*/
var SiteCityID = $("#SiteCityID");
var SiteCity = $("#SiteCity");
SiteCountryID.change(function(){
    SiteCountry.val(getData($(this)));
    SiteCityID.html('<option>Загрузка</option>');
    $.ajax({
        type: 'POST',
        url: '/system/controllers/settings/ajax.php',
        data: 'get_city='+$(this).val(),
        success: function(result){
            SiteCityID.html(result);
            SiteCityID.change();;
        }
    });
});
/*SiteRegionID.change(function(){
    SiteRegion.val(getData($(this)));
    SiteCityID.html('<option>Загрузка</option>');
    $.ajax({
        type: 'POST',
        url: '/system/controllers/settings/ajax.php',
        data: 'get_city='+$(this).val(),
        success: function(result){
            SiteCityID.html(result);
            SiteCityID.change();
        }
    });
});*/
SiteCityID.change(function(){
    SiteCity.val(getData($(this)));
});

$("#filter-form, .search-sidebar__form").submit(function(){
    var url = '/catalog/find/';
    if (Number($("#SiteCountryID").val()) > 0){
        url += 'country=' + $("#SiteCountryID").val() + '/';
    }
    if (Number($("#SiteRegionID").val()) > 0){
        url += 'region=' + $("#SiteRegionID").val() + '/';
    }
    if (Number($("#SiteCityID").val()) > 0){
        url += 'city=' + $("#SiteCityID").val() + '/';
    }
    if ($("#duration").val() != '' && Number($("#duration").val()) > 0){
        url += 'duration=' + $("#duration").val() + '/';
    }
    if ($("#age").val() != '' && Number($("#age").val()) > 0){
        url += 'age=' + $("#age").val() + '/';
    }
    if ($("#25").prop("checked")){
        url += '25=true/';
    }
    if ($("#pm").prop("checked")){
        url += 'pm=true/';
    }
    if ($("#p_top").prop("checked")){
        url += 'top=true/';
    }
    if ($("#predmet").val() != '' && Number($("#predmet").val()) > 0){
        url += 'predmet=' + $("#predmet").val() + '/';
    }
    if($('*').is('#address') && $("#address").val() != '' ) {
        url += 'address=' + $("#address").val() + '/';
    }
    //alert(url);
    document.location.href = url;
    return false;
});


$(".confirm").click(function(e){
    if (!confirm("Вы уверенны что хотите это сделать?")){
        e.preventDefault();
    }
});





$(function(){
    var btnUpload=$('#upload');
    var status=$('#status');
    var id = btnUpload.data('id');
    new AjaxUpload(btnUpload, {
        action: '/system/controllers/register/upload.php?id=' + id,
        name: 'image',
        onSubmit: function(file, ext){
            if (! (ext && /^(jpg|png|jpeg|gif)$/.test(ext))){
                status.text('Поддерживаемые форматы JPG, PNG или GIF');
                return false;
            }
            status.text('Загрузка...');
        },
        onComplete: function(file, response){

            status.text('');
            if(response !==""){
                $("#img-pr").html(response);
            } else{
                $("#img-pr").html(file);

            }
        }
    });

});

$("#sort-select").change(function(){
    var url = '/catalog/';
    if ($(this).val() != ''){
        url += 'sort=' + $(this).val() + '/';
    }

    document.location.href = url;
    return false;
});
