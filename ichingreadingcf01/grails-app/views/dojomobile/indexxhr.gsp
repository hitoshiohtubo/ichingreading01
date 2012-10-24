<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome IChing Reading</title>
    <script src="//ajax.googleapis.com/ajax/libs/dojo/1.8.0/dojo/dojo.js"
      data-dojo-config="async: true">
    </script>
    <link rel="stylesheet" type="text/css" 
      href="${resource(dir:'css',
      file:'ichingreadingdojomobile.css')}" />
  </head>
  <body>
    <g:set var="koulabels" 
      value="['','初爻','二爻','三爻','四爻','五爻','上爻']" />
    <g:set var="sangiimagedir"
      value="${resource(dir:grailsApplication.config.iching.image.sangi.dir)}/" />
    <g:set var="initsangiimage" 
      value="${resource(dir:grailsApplication.config.iching.image.sangi.dir,
      file:grailsApplication.config.iching.image.sangi.images.init)}" />
    <g:set var="initkousymbolimage" 
      value="${resource(dir:grailsApplication.config.iching.image.kou.dir,
      file:grailsApplication.config.iching.image.kou.images.init)}" />
    <g:set var="kousymbolimagedir" 
      value="${resource(dir:grailsApplication.config.iching.image.kou.dir)}/" />
    <g:set var="inithexagramimage" 
      value="${resource(dir:grailsApplication.config.iching.image.hexagram.dir,
      file:grailsApplication.config.iching.image.hexagram.images.init)}" />
    <g:set var="hexagramimagedir" 
      value="${resource(dir:grailsApplication.config.iching.image.hexagram.dir)}/" />

    <div id="startview" >
      <h1 id="startheadingtitle"></h1>
      <g:img dir = 'images/iching' file = 'IChingLogo-754.png' alt="logo" />
      <div id="buttonpane" class="buttonpane">
        <button id="readingbtn"></button>
      </div>
      <br>
      <pre id="ajaxpane" style="white-space:pre-wrap;"></pre>
    </div>
  
    <div id="resultview">
      <div id="ichingresultpane" style="visibility : hidden ;">
        <h1 id="resultheadingtitle">
        </h1>
        <h2 id="resultreadingcategory"></h2>
        <div id="koutablebase" class="koutable">
          <table>
            <tbody>
            <g:each var="i" in="${(6..1)}">
              <tr>
                <td class="koulabelbase">
                  <div class="koulabel">${koulabels[i]}</div>
                </td>
                <td class="kousangi">
                  <img id="kousangiimage${i}" class="kousangiimage"
                    src="${initsangiimage}"
                    alt="sangi image">
                  </img>
                </td>
                <td class="kousymbol">
                  <img id="kousymbolimage${i}" class="kousymbolimage"
                    src="${initkousymbolimage}"
                    alt="kou symbol image">
                  </img>
                </td>
                <td class="kousymbolnamebase">
                  <div id="kousymbolname${i}" class="kousymbolname" englishname="none"></div>
                </td>
              </tr>
              </g:each>
            </tbody>
          </table>
        </div>
        <h2 id="resultreadingmaincategory"></h2>
        <div id="hexagrammaintablebase" class="hexagramtable">
          <table>
            <thead>
              <tr>
                <th class="hexagramheader" colspan="2">本卦(main result)</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td rowspan="3" class="hexagramimagebase">
                  <img id="hexagramimagemain" class="hexagramimage"
                    src="${inithexagramimage}"
                    alt="hexagram image">
                  </img>
                </td>
                <td class="hexagramnamebase">
                  <div id="hexagramnamemain" class="hexagramname"></div>
                </td>
              </tr>
              <tr>
                <td class="hexagramaliasbase">
                  <div id="hexagramaliasmain" class="hexagramalias"></div>
                </td>
              </tr>
              <tr>
                <td class="hexagramaliasenglishbase">
                  <div id="hexagramaliasenglishmain" class="hexagramaliasenglish"></div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      <div id="resultperspectivepane" style="visibility : hidden ;">
        <h2 id="resultreadingperspectivecategory"></h2>
        <div id="hexagramperspectivetablebase" class="hexagramtable">
          <table>
            <thead>
              <tr>
                <th class="hexagramheader" colspan="2">之卦(perspective result)</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td rowspan="3" class="hexagramimagebase">
                  <img id="hexagramimageperspective" class="hexagramimage"
                    src="${inithexagramimage}"
                    alt="hexagram image">
                  </img>
                </td>
                <td class="hexagramnamebase">
                  <div id="hexagramnameperspective" class="hexagramname"></div>
                </td>
              </tr>
              <tr>
                <td class="hexagramaliasbase">
                  <div id="hexagramaliasperspective" class="hexagramalias"></div>
                </td>
              </tr>
              <tr>
                <td class="hexagramaliasenglishbase">
                  <div id="hexagramaliasenglishperspective" class="hexagramaliasenglish"></div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    require(
      [
        "dojo/_base/xhr","dojo/dom","dojo/query",
        "dijit/registry",
        "dojox/mobile/View","dojox/mobile/Heading",
        "dojox/mobile/Button",
        "dojox/mobile/RoundRectCategory",
        "dojox/mobile/RoundRect","dojox/mobile/ProgressIndicator",
        "dojox/mobile","dojox/mobile/deviceTheme","dojox/mobile/compat",
        "dojo/NodeList-dom",
        "dojo/NodeList-manipulate",
        "dojo/domReady!"],
        function(xhr,dom,query,registry,View,Heading,Button,RoundRectCategory,
          RoundRect,ProgressIndicator
        ) {
          function hideresultpane() {
            query("#ichingresultpane").style("visibility","hidden");
          };
          function hideperspectivebase() {
            query("#hexagramperspectivetablebase").style("visibility","hidden");
          };
          function hideperspectivepane() {
            query("#resultperspectivepane").style("visibility","hidden");
          };
          function showresultpane() {
            query("#ichingresultpane").style("visibility","visible");
          };
          function showperspectivebase() {
            query("#hexagramperspectivetablebase").style("visibility","visible");
          };
          function showperspectivepane() {
            query("#resultperspectivepane").style("visibility","visible");
          };
          function initresultkou() {
            query(".kousangiimage").attr("src",
              "${initsangiimage}");
            query(".kousymbolimage").attr("src",
              "${initkousymbolimage}");
            query(".kousymbolname").text("");
            query(".kousymbolname").attr("englishname","none");
          };
          function initresulthexagram() {
            query(".hexagramimage").attr("src",
              "${inithexagramimage}");
            query(".hexagramname").text("");
            query(".hexagramalias").text("");
            query(".hexagramaliasenglish").text("");
          };
          function replaceresultkousangiimage(data) {
            for (var i = 0; i < 6; i++) {
              if (data.kousresult[i].kousangiimage) {
                var ss = "${sangiimagedir}" + data.kousresult[i].kousangiimage;
                dom.byId("kousangiimage" + (i + 1)).src = ss;
              }
            }
          };
          function replaceresultkousymbolimage(data) {
            for (var i = 0; i < 6; i++) {
              if (data.kousresult[i].kousymbolimage) {
                var ss = "${kousymbolimagedir}" + data.kousresult[i].kousymbolimage;
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
                var ss = "${hexagramimagedir}" + data.mainresult.hexagramimage;
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
              showperspectivepane();
              if (data.perspectiveresult.hexagramimage) {
                var ss = "${hexagramimagedir}" + data.perspectiveresult.hexagramimage;
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
      
          var readingheading = new Heading({
            label: "IChing Reading"
          },"startheadingtitle");
      
          var readingbtn = new Button({
            label: "Reading",
            onClick: function() {
              registry.byId("readingbtn").set('disabled',true);
              initresultkou();
              initresulthexagram();
              hideperspectivepane();
              hideresultpane();
              var prog = ProgressIndicator.getInstance();
              prog.stop();
              dom.byId("startview").appendChild(prog.domNode);
              prog.start();
              xhr.post({
                url:"${createLink(action: 'readingresultjson' ,controller:'dojomobile')}",
                handleAs: "json",
                load: function(jsonData) {
                  showresultpane();
                  replaceresultkousangiimage(jsonData);
                  replaceresultkousymbolimage(jsonData);
                  replaceresultkousymbolname(jsonData);
                  replaceresulthexagrammain(jsonData);
                  replaceresulthexagramperspective(jsonData);
                  prog.stop();
                  registry.byId("readingbtn").set('disabled',false);
                  var s = registry.byId("startview");
                  s.performTransition("resultview",1,"slide",null,null);
                },
                error: function(err) {
                  console.error(err);
                  dom.byId('ajaxpane').innerHTML = err;
                  prog.stop();
                  initresultkou();
                  initresulthexagram();
                  registry.byId("readingbtn").set('disabled',false);
                }
              });
            }
          },"readingbtn");
          readingbtn.startup();
          var startview = new View({
              selected: true
          },"startview");
          startview.startup();
          var resultheading = new Heading({
            label: "Result",
            back: "Reading",
            moveTo: "startview"
          },"resultheadingtitle");
          var resultreadingcategory = new RoundRectCategory({
            label: "占 (Reading)"
          },"resultreadingcategory");
          var resultreadingmaincategory = new RoundRectCategory({
            label: "本卦 (Main result)"
          },"resultreadingmaincategory");
          var resultreadingperspectivecategory = new RoundRectCategory({
            label: "之卦 (Perspective result)"
          },"resultreadingperspectivecategory");
          var resultreadingrect = new RoundRect({
            class: "koutable"
          },"koutablebase");
          resultreadingrect.startup();
          var resultreadingmainrect = new RoundRect({
            class: "hexagramtable"
          },"hexagrammaintablebase");
          var resultreadingperspectiverect = new RoundRect({
            class: "hexagramtable"
          },"hexagramperspectivetablebase");
          var resultview = new View({
          },"resultview");
          resultview.startup();
      });
    </script>

  </body>
</html>

