// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.prettySocial
//= require_tree .

/*
 * Work Page Events
 */

$( document ).ready(function() {

    /**
     * Set up the prettySocial jQuery plugin for custom share buttons
     */
    $('.prettySocial').prettySocial();

    /*
     * Open all offsite links in another browser
     */
    $(document.links).filter(function() {
        return this.hostname != window.location.hostname;
    }).attr('target', '_blank');
    
    /*
     * Art / More Info Toggle
     */
    $("nav.bioNav a.artLink").click(function(e) {
        $(this).addClass("selected");
        $("nav.bioNav a.moreInfoLink").removeClass("selected");
        $("section.moreInfo").hide();
        $("ul.experienceTheWork").show();
        console.log('artlink clicked');
    });
    $("nav.bioNav a.moreInfoLink").click(function(e) {
        $(this).addClass("selected");
        $("nav.bioNav a.artLink").removeClass("selected");
        $("ul.experienceTheWork").hide();
        $("section.moreInfo").show();
        console.log('moreinfo link clicked');
    });

    /*
     * Larger work click
     */
    $("ul.experienceTheWork li a").click(function(e) {        
       var idPattern = /[-](\d+)/; 
       var workId = $(this).attr("id").match(idPattern)[1];
        
       console.log(workId[1]);
       $("section.main").fadeOut("fast", function(){              
           $("figure#fullsize-" + workId).fadeIn("fast");
           $("body").css('background', '#666');
       });   
       e.preventDefault();
    });
    $("div#extraElements figure.fullsize").click(function(e) {        
       var idPattern = /[-](\d+)/; 
       var workId = $(this).attr("id").match(idPattern)[1]; 
        
       $("body").css('background', 'white');
       $("figure#fullsize-" + workId).fadeOut("fast", function(){            
            $("section.main").fadeIn("fast");
       });
       e.preventDefault();
    });    

    /*
     * Before Work Nav Rollovers
     */
    $("a.beforeWork").hover(
        function() {      
            /* Roll Over */      
            var workId = $(this).attr('id');
            $("#beforeWorkInfo" + workId).show();
        
      }, function() {
        /* Roll Out */
        var workId = $(this).attr('id');
        $("#beforeWorkInfo" + workId).hide();
      }
    );    
    
    /*
     * Next Work Nav Rollovers
     */
    $("a.nextWork").hover(
        function() {      
            /* Roll Over */      
            var workId = $(this).attr('id');
            $("#nextWorkInfo" + workId).show();
        
      }, function() {
        /* Roll Out */
        var workId = $(this).attr('id');
        $("#nextWorkInfo" + workId).hide();
      }
    );        
            
        

 
});




