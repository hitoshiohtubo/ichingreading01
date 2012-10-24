$(document).ready(function() {
  var readingresultjsonurl_ = "/ichingreadingcf01/jquery/readingresultjson";

  var imagemap_ = {
    sangi: {
      dir: "/ichingreadingcf01/images/iching",
      images: {
        oldyang: "icsangiyangB.png",
        youngyang: "icsangiyangB.png",
        oldyin: "icsangiyinB.png",
        youngyin: "icsangiyinB.png",
        init: "sangiW.png"
      }
    },
    kou: {
      dir: "/ichingreadingcf01/images/iching",
      images: {
        oldyang: "oldyangB.png",
        youngyang: "youngyangB.png",
        oldyin: "oldyinB.png",
        youngyin: "youngyinB.png",
        init: "kousymbolW.png"
      }
    },
    hexagram: {
      dir: "/ichingreadingcf01/images/hexagram",
      images: {
        init: "emptyIching-hexagram.png"
      }
    }
  };
  var sangiimagedir = imagemap_.sangi.dir;
  var initsangiimage = sangiimagedir + "/" + imagemap_.sangi.images.init;
  var kousymbolimagedir = imagemap_.kou.dir;
  var initkousymbolimage = kousymbolimagedir + "/" + imagemap_.kou.images.init;
  var hexagramimagedir = imagemap_.hexagram.dir;
  var inithexagramimage = hexagramimagedir + "/" + imagemap_.hexagram.images.init;
  
  function hideresultpane() {
    $("#ichingresultpane").hide();
  };
  function hideperspectivebase() {
    $("#hexagramperspectivetablebase").hide();
  };
  function showresultpane() {
    $("#ichingresultpane").show();
  };
  function showperspectivebase() {
    $("#hexagramperspectivetablebase").show();
  };
  function initresultkou() {
    $(".kousangiimage").attr("src",initsangiimage);
    $(".kousymbolimage").attr("src",initkousymbolimage);
    $(".kousymbolname").text("");
    $(".kousymbolname").attr("englishname","none");
  };
  function initresulthexagram() {
    $(".hexagramimage").attr("src",inithexagramimage);
    $(".hexagramname").text("");
    $(".hexagramalias").text("");
    $(".hexagramaliasenglish").text("");
  };
  function replaceresultkousangiimage(data) {
    for (var i = 0; i < 6; i++) {
      if (data.kousresult[i].kousangiimage) {
        var ss = sangiimagedir + "/" + data.kousresult[i].kousangiimage;
        $("#kousangiimage" + (i + 1)).attr("src",ss);
      }
    }
  };
  function replaceresultkousymbolimage(data) {
    for (var i = 0; i < 6; i++) {
      if (data.kousresult[i].kousymbolimage) {
        var ss = kousymbolimagedir + "/" + data.kousresult[i].kousymbolimage;
        $("#kousymbolimage" + (i + 1)).attr("src",ss);
      }
    }
  };
  function replaceresultkousymbolname(data) {
    for (var i = 0; i < 6; i++) {
      if (data.kousresult[i].kousymbolname) {
        $("#kousymbolname" + (i + 1)).text(data.kousresult[i].kousymbolname);
      }
      if (data.kousresult[i].kousymbolenglishname) {
        $("#kousymbolname" + (i + 1)).attr("englishname", 
          data.kousresult[i].kousymbolenglishname);
      }
    }
  };
  function replaceresulthexagrammain(data) {
    if (data.mainresult) {
      if (data.mainresult.hexagramimage) {
        var ss = hexagramimagedir + "/" + data.mainresult.hexagramimage;
        $("#hexagramimagemain").attr("src",ss);
      }
      if (data.mainresult.hexagramnumber && data.mainresult.hexagramname) {
        var hn = data.mainresult.hexagramnumber + ". " + 
          data.mainresult.hexagramname;
        $("#hexagramnamemain").text(hn);
      }
      if (data.mainresult.hexagramaliasname) {
        $("#hexagramaliasmain").text(data.mainresult.hexagramaliasname);
      }
      if (data.mainresult.hexagramaliasenglishname) {
        $("#hexagramaliasenglishmain").text(data.mainresult.hexagramaliasenglishname);
      }
    }
  };
  function replaceresulthexagramperspective(data) {
    if (data.perspectiveresult) {
      showperspectivebase();
      if (data.perspectiveresult.hexagramimage) {
        var ss = hexagramimagedir + "/" + data.perspectiveresult.hexagramimage;
        $("#hexagramimageperspective").attr("src",ss);
      }
      if (data.perspectiveresult.hexagramnumber && data.perspectiveresult.hexagramname) {
        var hn = data.perspectiveresult.hexagramnumber + ". " + 
          data.perspectiveresult.hexagramname;
        $("#hexagramnameperspective").text(hn);
      }
      if (data.perspectiveresult.hexagramaliasname) {
        $("#hexagramaliasperspective").text(data.perspectiveresult.hexagramaliasname);
      }
      if (data.perspectiveresult.hexagramaliasenglishname) {
        $("#hexagramaliasenglishperspective").text(
          data.perspectiveresult.hexagramaliasenglishname);
      }
    }
  };
  $("#readingbtn").button({label: 'Reading', disabled: false}).click(
    function() {
      $("#readingbtn").button('disable');
      $("#retrybtn").button('disable');
      initresultkou();
      initresulthexagram();
      hideperspectivebase();
      hideresultpane();
      $.ajax({
        type: "POST",
        url: readingresultjsonurl_,
        dataType: "json",
        global: false,
        success: function(data, dataType) {
          showresultpane();
          replaceresultkousangiimage(data);
          replaceresultkousymbolimage(data);
          replaceresultkousymbolname(data);
          replaceresulthexagrammain(data);
          replaceresulthexagramperspective(data);
          $("#retrybtn").button('enable');
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          console.error(textStatus);
        }
      });
    }
  );
  $("#retrybtn").button({label: 'Retry', disabled: true}).click(
    function() {
      $("#retrybtn").button('disable');
      hideperspectivebase();
      hideresultpane();
      initresultkou();
      initresulthexagram();
      $("#readingbtn").button('enable');
    }
  );
  hideperspectivebase();
  hideresultpane();
});


