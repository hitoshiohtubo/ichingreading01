class IChingEngine
  @OldYin: 6
  @YoungYang: 7
  @YoungYin: 8
  @OldYang: 9

  @OldYangBitCount: 0
  @YoungYinBitCount: 1
  @YoungYangBitCount: 2
  @OldYinBitCount: 3

  @CoinsCastingRandomMax: 8
  @KouLines: 6

  constructor: (@hexagramsinfo,@imagemap) ->

  bitCount: (i) ->
    i = i - ((i >>> 1) & 0x55555555)
    i = (i & 0x33333333) + ((i >>> 2) & 0x33333333)
    i = (i + (i >>> 4)) & 0x0f0f0f0f
    i = i + (i >>> 8)
    i = i + (i >>> 16)
    i & 0x3f

  coinsCasting: ->
    rndval = Math.floor(Math.random() * IChingEngine.CoinsCastingRandomMax)
    bitcnt = @bitCount rndval
    retval = switch bitcnt
      when IChingEngine.OldYinBitCount then IChingEngine.OldYin
      when IChingEngine.YoungYangBitCount then IChingEngine.YoungYang
      when IChingEngine.YoungYinBitCount then IChingEngine.YoungYin
      when IChingEngine.OldYangBitCount then IChingEngine.OldYang
      else 0

    retval

  generateKous: ->
    retary = (@coinsCasting() for i in [0...IChingEngine.KouLines])
    retary

  kousToHexagrams: (kous) ->
    mval = 0
    pval = 0
    omask = 0
    zmask = 0

    for v , i in kous
      do (v,i) ->
        tval = 0x1 << (IChingEngine.KouLines - (1 + i))
        if v is IChingEngine.YoungYang or v is IChingEngine.OldYang
          mval |= tval
        if v is IChingEngine.OldYin
          omask |= tval
        if v is IChingEngine.OldYang
          zmask |= tval
        return

    zmask = ~zmask & 0xffffffff
    pval = mval
    pval |= omask
    pval &= zmask
    retobj =
      hexagramsmainresult: mval
    if mval isnt pval then retobj.hexagramsperspectiveresult = pval
    retobj

  kouToKString: (code) ->
    retstr = switch code
      when IChingEngine.OldYin then "老陰"
      when IChingEngine.YoungYang then "少陽"
      when IChingEngine.YoungYin then "少陰"
      when IChingEngine.OldYang then "老陽"
      else ""
    retstr

  kouToEString: (code) ->
    retstr = switch code
      when IChingEngine.OldYin then "OldYin"
      when IChingEngine.YoungYang then "YoungYang"
      when IChingEngine.YoungYin then "YoungYin"
      when IChingEngine.OldYang then "OldYang"
      else ""
    retstr

  kouToKouImage: (code) ->
    retstr = switch code
      when IChingEngine.OldYin
        @imagemap?.kou?.images?.oldyin
      when IChingEngine.YoungYang
        @imagemap?.kou?.images?.youngyang
      when IChingEngine.YoungYin
        @imagemap?.kou?.images?.youngyin
      when IChingEngine.OldYang
        @imagemap?.kou?.images?.oldyang
      else null
    retstr

  kouToSangiImage: (code) ->
    retstr = switch code
      when IChingEngine.OldYin
        @imagemap?.sangi?.images?.oldyin
      when IChingEngine.YoungYang
        @imagemap?.sangi?.images?.youngyang
      when IChingEngine.YoungYin
        @imagemap?.sangi?.images?.youngyin
      when IChingEngine.OldYang
        @imagemap?.sangi?.images?.oldyang
      else null
    retstr

  reading: ->
    kousresult = @generateKous()
    hexagramsresult = @kousToHexagrams(kousresult)
    result = {}
    kl = for code in kousresult
      km = {}
      km.koucode = code
      km.kousangiimage = @kouToSangiImage(code)
      km.kousymbolimage = @kouToKouImage(code)
      km.kousymbolname = @kouToKString(code)
      km.kousymbolenglishname = @kouToEString(code)
      km

    result.kousresult = kl
    mres = hexagramsresult.hexagramsmainresult
    mhexagram = @hexagramsinfo[mres]
    mh = {}
    for key, value of mhexagram
      mh[key] = value

    mh.resultkind = "main"
    result.mainresult = mh

    if hexagramsresult.hexagramsperspectiveresult
      pres = hexagramsresult.hexagramsperspectiveresult
      phexagram = @hexagramsinfo[pres]
      ph = {}
      ph.hexagramnumber = phexagram.hexagramnumber
      ph.octalvalue = phexagram.octalvalue
      ph.hexagramname = phexagram.hexagramname
      ph.hexagramaliasname = phexagram.hexagramaliasname
      ph.hexagramaliasenglishname = phexagram.hexagramaliasenglishname
      ph.hexagramimage = phexagram.hexagramimage
      ph.resultkind = "perspective"
      result.perspectiveresult = ph

    result


