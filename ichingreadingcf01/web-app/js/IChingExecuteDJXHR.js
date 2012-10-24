require(["dojo/_base/xhr","dojo/dom","dojo/query",
  "dijit/registry","dijit/form/Button","dojo/fx/Toggler","dojo/NodeList-dom",
  "dojo/NodeList-manipulate",
  "dojo/domReady!"],
  function(xhr,dom,query,registry,Button,Toggler) {

    var readingresultjsonurl_ = "/ichingreadingcf01/dojo/readingresultjson";

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
    var resultpanetoggler = new Toggler({node: "ichingresultpane"});
    var perspectivebasetoggler = new Toggler({node: "hexagramperspectivetablebase"});
    function hideresultpane() {
      resultpanetoggler.hide();
    };
    function hideperspectivebase() {
      perspectivebasetoggler.hide();
    };
    function showresultpane() {
      resultpanetoggler.show();
    };
    function showperspectivebase() {
      perspectivebasetoggler.show();
    };
    function initresultkou() {
      query(".kousangiimage").attr("src",initsangiimage);
      query(".kousymbolimage").attr("src",initkousymbolimage);
      query(".kousymbolname").text("");
      query(".kousymbolname").attr("englishname","none");
    };
    function initresulthexagram() {
      query(".hexagramimage").attr("src",inithexagramimage);
      query(".hexagramname").text("");
      query(".hexagramalias").text("");
      query(".hexagramaliasenglish").text("");
    };
    function replaceresultkousangiimage(data) {
      for (var i = 0; i < 6; i++) {
        if (data.kousresult[i].kousangiimage) {
          var ss = sangiimagedir + "/" + data.kousresult[i].kousangiimage;
          dom.byId("kousangiimage" + (i + 1)).src = ss;
        }
      }
    };
    function replaceresultkousymbolimage(data) {
      for (var i = 0; i < 6; i++) {
        if (data.kousresult[i].kousymbolimage) {
          var ss = kousymbolimagedir + "/" + data.kousresult[i].kousymbolimage;
          dom.byId("kousymbolimage" + (i + 1)).src = ss;
        }
      }
    };
    function replaceresultkousymbolname(data) {
      for (var i = 0; i < 6; i++) {
        if (data.kousresult[i].kousymbolname) {
          dom.byId("kousymbolname" + (i + 1)).innerHTML = data.kousresult[i].kousymbolname;
        }
        if (data.kousresult[i].kousymbolenglishname) {
          query("#kousymbolname" + (i + 1)).attr("englishname", 
            data.kousresult[i].kousymbolenglishname);
        }
      }
    };
    function replaceresulthexagrammain(data) {
      if (data.mainresult) {
        if (data.mainresult.hexagramimage) {
          var ss = hexagramimagedir + "/" + data.mainresult.hexagramimage;
          dom.byId("hexagramimagemain").src = ss;
        }
        if (data.mainresult.hexagramnumber && data.mainresult.hexagramname) {
          var hn = data.mainresult.hexagramnumber + ". " + 
            data.mainresult.hexagramname;
          dom.byId("hexagramnamemain").innerHTML = hn;
        }
        if (data.mainresult.hexagramaliasname) {
          dom.byId("hexagramaliasmain").innerHTML = 
            data.mainresult.hexagramaliasname;
        }
        if (data.mainresult.hexagramaliasenglishname) {
          dom.byId("hexagramaliasenglishmain").innerHTML = 
            data.mainresult.hexagramaliasenglishname;
        }
      }
    };
    function replaceresulthexagramperspective(data) {
      if (data.perspectiveresult) {
        showperspectivebase();
        if (data.perspectiveresult.hexagramimage) {
          var ss = hexagramimagedir + "/" + data.perspectiveresult.hexagramimage;
          dom.byId("hexagramimageperspective").src = ss;
        }
        if (data.perspectiveresult.hexagramnumber && data.perspectiveresult.hexagramname) {
          var hn = data.perspectiveresult.hexagramnumber + ". " + 
            data.perspectiveresult.hexagramname;
          dom.byId("hexagramnameperspective").innerHTML = hn;
        }
        if (data.perspectiveresult.hexagramaliasname) {
          dom.byId("hexagramaliasperspective").innerHTML = 
            data.perspectiveresult.hexagramaliasname;
        }
        if (data.perspectiveresult.hexagramaliasenglishname) {
          dom.byId("hexagramaliasenglishperspective").innerHTML = 
            data.perspectiveresult.hexagramaliasenglishname;
        }
      }
    };
    var readingbtn = new Button({
      label: "Reading",
      onClick: function() {
        registry.byId("readingbtn").set('disabled',true);
        registry.byId("retrybtn").set('disabled',true);
        initresultkou();
        initresulthexagram();
        hideperspectivebase();
        hideresultpane();
        xhr.post({
          url:readingresultjsonurl_,
          handleAs: "json",
          load: function(jsonData) {
            showresultpane();
            replaceresultkousangiimage(jsonData);
            replaceresultkousymbolimage(jsonData);
            replaceresultkousymbolname(jsonData);
            replaceresulthexagrammain(jsonData);
            replaceresulthexagramperspective(jsonData);
            registry.byId("retrybtn").set('disabled',false);
          },
          error: function(err) {
            console.error(err);
          }
        });
      }
    },"readingbtn");
    readingbtn.startup();
    var retrybtn = new Button({
      label: "Retry",
      disabled: true,
      onClick: function() {
        registry.byId("retrybtn").set('disabled',true);
        hideperspectivebase();
        hideresultpane();
        initresultkou();
        initresulthexagram();
        registry.byId("readingbtn").set('disabled',false);
      }
    },"retrybtn");
    retrybtn.startup();
    hideperspectivebase();
    hideresultpane();
  });



