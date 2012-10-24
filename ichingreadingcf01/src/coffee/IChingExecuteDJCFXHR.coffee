require ["dojo/_base/xhr", "dojo/dom", "dojo/query", "dijit/registry",
  "dijit/form/Button", "dojo/fx/Toggler", "dojo/NodeList-dom",
  "dojo/NodeList-manipulate", "dojo/domReady!"], (xhr, dom, query, registry, Button, Toggler) ->
  hideresultpane = ->
    resultpanetoggler.hide()
  hideperspectivebase = ->
    perspectivebasetoggler.hide()
  showresultpane = ->
    resultpanetoggler.show()
  showperspectivebase = ->
    perspectivebasetoggler.show()
  initresultkou = ->
    query(".kousangiimage").attr "src", initsangiimage
    query(".kousymbolimage").attr "src", initkousymbolimage
    query(".kousymbolname").text ""
    query(".kousymbolname").attr "englishname", "none"
  initresulthexagram = ->
    query(".hexagramimage").attr "src", inithexagramimage
    query(".hexagramname").text ""
    query(".hexagramalias").text ""
    query(".hexagramaliasenglish").text ""
  replaceresultkousangiimage = (data) ->
    i = 0

    while i < 6
      if data.kousresult[i].kousangiimage
        ss = sangiimagedir + "/" + data.kousresult[i].kousangiimage
        dom.byId("kousangiimage" + (i + 1)).src = ss
      i++
    return
  replaceresultkousymbolimage = (data) ->
    i = 0

    while i < 6
      if data.kousresult[i].kousymbolimage
        ss = kousymbolimagedir + "/" + data.kousresult[i].kousymbolimage
        dom.byId("kousymbolimage" + (i + 1)).src = ss
      i++
    return
  replaceresultkousymbolname = (data) ->
    i = 0

    while i < 6
      dom.byId("kousymbolname" + (i + 1)).innerHTML = data.kousresult[i].kousymbolname  if data.kousresult[i].kousymbolname
      query("#kousymbolname" + (i + 1)).attr "englishname", data.kousresult[i].kousymbolenglishname  if data.kousresult[i].kousymbolenglishname
      i++
    return
  replaceresulthexagrammain = (data) ->
    if data.mainresult
      if data.mainresult.hexagramimage
        ss = hexagramimagedir + "/" + data.mainresult.hexagramimage
        dom.byId("hexagramimagemain").src = ss
      if data.mainresult.hexagramnumber and data.mainresult.hexagramname
        hn = data.mainresult.hexagramnumber + ". " + data.mainresult.hexagramname
        dom.byId("hexagramnamemain").innerHTML = hn
      dom.byId("hexagramaliasmain").innerHTML = data.mainresult.hexagramaliasname  if data.mainresult.hexagramaliasname
      dom.byId("hexagramaliasenglishmain").innerHTML = data.mainresult.hexagramaliasenglishname  if data.mainresult.hexagramaliasenglishname
    return
  replaceresulthexagramperspective = (data) ->
    if data.perspectiveresult
      showperspectivebase()
      if data.perspectiveresult.hexagramimage
        ss = hexagramimagedir + "/" + data.perspectiveresult.hexagramimage
        dom.byId("hexagramimageperspective").src = ss
      if data.perspectiveresult.hexagramnumber and data.perspectiveresult.hexagramname
        hn = data.perspectiveresult.hexagramnumber + ". " + data.perspectiveresult.hexagramname
        dom.byId("hexagramnameperspective").innerHTML = hn
      dom.byId("hexagramaliasperspective").innerHTML = data.perspectiveresult.hexagramaliasname  if data.perspectiveresult.hexagramaliasname
      dom.byId("hexagramaliasenglishperspective").innerHTML = data.perspectiveresult.hexagramaliasenglishname  if data.perspectiveresult.hexagramaliasenglishname
    return
  readingresultjsonurl_ = "/ichingreadingcf01/dojo/readingresultjson"
  imagemap_ =
    sangi:
      dir: "/ichingreadingcf01/images/iching"
      images:
        oldyang: "icsangiyangB.png"
        youngyang: "icsangiyangB.png"
        oldyin: "icsangiyinB.png"
        youngyin: "icsangiyinB.png"
        init: "sangiW.png"

    kou:
      dir: "/ichingreadingcf01/images/iching"
      images:
        oldyang: "oldyangB.png"
        youngyang: "youngyangB.png"
        oldyin: "oldyinB.png"
        youngyin: "youngyinB.png"
        init: "kousymbolW.png"

    hexagram:
      dir: "/ichingreadingcf01/images/hexagram"
      images:
        init: "emptyIching-hexagram.png"

  sangiimagedir = imagemap_.sangi.dir
  initsangiimage = sangiimagedir + "/" + imagemap_.sangi.images.init
  kousymbolimagedir = imagemap_.kou.dir
  initkousymbolimage = kousymbolimagedir + "/" + imagemap_.kou.images.init
  hexagramimagedir = imagemap_.hexagram.dir
  inithexagramimage = hexagramimagedir + "/" + imagemap_.hexagram.images.init
  resultpanetoggler = new Toggler(node: "ichingresultpane")
  perspectivebasetoggler = new Toggler(node: "hexagramperspectivetablebase")
  readingbtn = new Button(
    label: "Reading"
    onClick: ->
      registry.byId("readingbtn").set "disabled", true
      registry.byId("retrybtn").set "disabled", true
      initresultkou()
      initresulthexagram()
      hideperspectivebase()
      hideresultpane()
      xhr.post
        url: readingresultjsonurl_
        handleAs: "json"
        load: (jsonData) ->
          showresultpane()
          replaceresultkousangiimage jsonData
          replaceresultkousymbolimage jsonData
          replaceresultkousymbolname jsonData
          replaceresulthexagrammain jsonData
          replaceresulthexagramperspective jsonData
          registry.byId("retrybtn").set "disabled", false

        error: (err) ->
          console.error err

  , "readingbtn")
  readingbtn.startup()
  retrybtn = new Button(
    label: "Retry"
    disabled: true
    onClick: ->
      registry.byId("retrybtn").set "disabled", true
      hideperspectivebase()
      hideresultpane()
      initresultkou()
      initresulthexagram()
      registry.byId("readingbtn").set "disabled", false
  , "retrybtn")
  retrybtn.startup()
  hideperspectivebase()
  hideresultpane()
  return

