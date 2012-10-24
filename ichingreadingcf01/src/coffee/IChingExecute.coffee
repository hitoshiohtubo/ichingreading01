hexagramsjsonurl_ = "/ichingreadingcf01/hexagram/jsonesclist" 

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

class IChingExecute
  hexagramsinfo: null
  ichingengine: null
  hexagramsjsonurl: null

  constructor: (@imagemap,@hexagramsjsonurl) ->

  @hideresultpane: ->
    $("#ichingresultpane").hide()
    return

  @hideperspectivebase: ->
    $("#hexagramperspectivetablebase").hide()
    return

  @showresultpane: ->
    $("#ichingresultpane").show()
    return

  @showperspectivebase: ->
    $("#hexagramperspectivetablebase").show()
    return

  initresultkou: ->
    if @imagemap
      sangidir = @imagemap.sangi?.dir ? ""
      sangidir = $.trim(sangidir)
      sangidir = sangidir + "/" if sangidir.length > 0
      koudir = @imagemap.kou?.dir ? ""
      koudir = $.trim(koudir)
      koudir = koudir + "/" if koudir.length > 0
      $(".kousangiimage").attr("src",sangidir + @imagemap.sangi.images.init)
      $(".kousymbolimage").attr("src",koudir + @imagemap.kou.images.init)
    $(".kousymbolname").text("")
    $(".kousymbolname").attr("englishname","none")
    return

  initresulthexagram: ->
    if @imagemap
      hexagramdir = @imagemap.hexagram?.dir ? ""
      hexagramdir = $.trim(hexagramdir)
      hexagramdir = hexagramdir + "/" if hexagramdir.length > 0
      $(".hexagramimage").attr("src",hexagramdir + @imagemap.hexagram.images.init)
    $(".hexagramname").text("")
    $(".hexagramalias").text("")
    $(".hexagramaliasenglish").text("")
    return

  replaceresultkousangiimage: (data)->
    if data?.kousresult
      for rs, i in data.kousresult
        if rs.kousangiimage
          sangidir = @imagemap.sangi?.dir ? ""
          sangidir = $.trim(sangidir)
          sangidir = sangidir + "/" if sangidir.length > 0
          ss = sangidir + rs.kousangiimage
          $("#kousangiimage" + (i + 1)).attr("src",ss)
    return

  replaceresultkousymbolimage: (data)->
    if data?.kousresult
      for rs, i in data.kousresult
        if rs.kousymbolimage
          koudir = @imagemap.kou?.dir ? ""
          koudir = $.trim(koudir)
          koudir = koudir + "/" if koudir.length > 0
          ss = koudir + rs.kousymbolimage
          $("#kousymbolimage" + (i + 1)).attr("src",ss)
    return

  replaceresultkousymbolname: (data)->
    if data?.kousresult
      for rs, i in data.kousresult
        if rs.kousymbolname
          $("#kousymbolname" + (i + 1)).text(rs.kousymbolname)
        if rs.kousymbolenglishname
          $("#kousymbolname" + (i + 1)).attr("englishname",rs.kousymbolenglishname)
    return

  replaceresulthexagrammain: (data)->
    if data?.mainresult
      if data.mainresult.hexagramimage
        hexagramdir = @imagemap.hexagram?.dir ? ""
        hexagramdir = $.trim(hexagramdir)
        hexagramdir = hexagramdir + "/" if hexagramdir.length > 0
        ss = hexagramdir + data.mainresult.hexagramimage
        $("#hexagramimagemain").attr("src",ss)
      if data.mainresult.hexagramnumber and data.mainresult.hexagramname
        hn = data.mainresult.hexagramnumber + ". " + data.mainresult.hexagramname
        $("#hexagramnamemain").text(hn)
      if data.mainresult.hexagramaliasname
        $("#hexagramaliasmain").text(data.mainresult.hexagramaliasname)
      if data.mainresult.hexagramaliasenglishname
        $("#hexagramaliasenglishmain").text(data.mainresult.hexagramaliasenglishname)
    return

  replaceresulthexagramperspective: (data)->
    if data?.perspectiveresult
      do IChingExecute.showperspectivebase
      if data.perspectiveresult.hexagramimage
        hexagramdir = @imagemap.hexagram?.dir ? ""
        hexagramdir = $.trim(hexagramdir)
        hexagramdir = hexagramdir + "/" if hexagramdir.length > 0
        ss = hexagramdir + data.perspectiveresult.hexagramimage
        $("#hexagramimageperspective").attr("src",ss)
      if data.perspectiveresult.hexagramnumber and data.perspectiveresult.hexagramname
        hn = data.perspectiveresult.hexagramnumber + ". " + data.perspectiveresult.hexagramname
        $("#hexagramnameperspective").text(hn)
      if data.perspectiveresult.hexagramaliasname
        $("#hexagramaliasperspective").text(data.perspectiveresult.hexagramaliasname)
      if data.perspectiveresult.hexagramaliasenglishname
        $("#hexagramaliasenglishperspective").text(data.perspectiveresult.hexagramaliasenglishname)
    return

  bindevent: ->
    $("#readingbtn").button({label: 'Reading', disabled: false}).click =>
      $("#readingbtn").button('disable')
      @initresultkou()
      @initresulthexagram()
      IChingExecute.hideperspectivebase()
      IChingExecute.hideresultpane()
      if not @ichingengine
        if @hexagramsinfo
          @ichingengine = new IChingEngine(@hexagramsinfo,@imagemap)
      resultdata = @ichingengine?.reading()

      if resultdata
        IChingExecute.showresultpane()
        @replaceresultkousangiimage(resultdata)
        @replaceresultkousymbolimage(resultdata)
        @replaceresultkousymbolname(resultdata)
        @replaceresulthexagrammain(resultdata)
        @replaceresulthexagramperspective(resultdata)

      $("#retrybtn").button('enable')

      return

    $("#retrybtn").button({label: 'Retry', disabled: true}).click =>
      $("#retrybtn").button('disable')
      IChingExecute.hideperspectivebase()
      IChingExecute.hideresultpane()
      @initresultkou()
      @initresulthexagram()
      $("#readingbtn").button('enable')
      return

    return

  getjsonhexagramsinfo: ->
    $("#readingbtn").button('disable')
    $("#retrybtn").button('disable')
    @initresultkou()
    @initresulthexagram()
    if @hexagramsjsonurl
      $.ajax({
        type: "GET",
        async: false,
        url: @hexagramsjsonurl,
        dataType: "json",
        global: false,
        success: (data, dataType)=>
          @hexagramsinfo = $.extend(true,{},data)
          $("#readingbtn").button('enable')
          return
        ,
        error: (XMLHttpRequest, textStatus, errorThrown)->
          console.error(textStatus)
          return
      })
    return

skiprandomvalue = ->
  tmpdate = new Date()
  loopcnt = tmpdate.getMilliseconds() / 4
  while loopcnt >= 0
    Math.random()
    loopcnt--
  return

$(document).ready ->
  ichingexecute = new IChingExecute(imagemap_,hexagramsjsonurl_)
  ichingexecute.bindevent()
  ichingexecute.getjsonhexagramsinfo()
  IChingExecute.hideperspectivebase()
  IChingExecute.hideresultpane()
  skiprandomvalue()
  return

