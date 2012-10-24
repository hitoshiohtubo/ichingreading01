<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome IChing Reading</title>
    <script src="//ajax.googleapis.com/ajax/libs/dojo/1.8.0/dojo/dojo.js"
      data-dojo-config="async: true">
    </script>
    <g:javascript src="IChingExecuteDJXHR.js">
    </g:javascript>
    <link rel="stylesheet" type="text/css"
    href="//ajax.googleapis.com/ajax/libs/dojo/1.8/dijit/themes/claro/claro.css" media="screen" />
    <link rel="stylesheet" type="text/css" 
      href="${resource(dir:'css',
    file:'ichingreadingdojo.css')}" />

  </head>
  <body class="claro">
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

    <g:img dir = 'images/iching' file = 'IChingLogo-754.png' alt="logo" />
    <br>
    <div id="buttonpane" class="buttonpane">
      <button id="readingbtn" title="占いを実行します"></button>
      <button id="retrybtn" title="初期状態に戻します"></button>
    </div>
    <br>
    <div id="ichingresultpane" >
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
      <br>
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
      <br>
      <div id="hexagramperspectivetablebase" class="hexagramtable" >
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
  </body>
</html>



