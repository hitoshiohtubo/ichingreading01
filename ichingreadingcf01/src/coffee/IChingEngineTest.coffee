describe 'IChingEngine', ->
  hexagramsinfo = for i in [0...64]
    hn = ("0" + (i + 1)).slice(-2)
    ov = ("0" + i).slice(-2)
    inf =
      hexagramnumber: hn
      octalvalue: ov
      hexagramname: "hexagramname:" + ov
      hexagramaliasname: "hexagramaliasname:" + ov
      hexagramaliasenglishname: "hexagramaliasenglishname:" + ov
      hexagramimage: "hexagramimage:" + ov

      hexagramalllinedescription: "hexagramalllinedescription:" + ov
      hexagramalllineexplanation: "hexagramalllineexplanation:" + ov
      hexagramalllinetranscription: "hexagramalllinetranscription:" + ov

      hexagramdescription: "hexagramdescription:" + ov
      hexagramexplanation: "hexagramexplanation:" + ov
      hexagramtranscription: "hexagramtranscription:" + ov

      hexagramfirstlinedescription: "hexagramfirstlinedescription:" + ov
      hexagramfirstlineexplanation: "hexagramfirstlineexplanation:" + ov
      hexagramfirstlinetranscription: "hexagramfirstlinetranscription:" + ov

      hexagramsecondlinedescription: "hexagramsecondlinedescription:" + ov
      hexagramsecondlineexplanation: "hexagramsecondlineexplanation:" + ov
      hexagramsecondlinetranscription: "hexagramsecondlinetranscription:" + ov

      hexagramthirdlinedescription: "hexagramthirdlinedescription:" + ov
      hexagramthirdlineexplanation: "hexagramthirdlineexplanation:" + ov
      hexagramthirdlinetranscription: "hexagramthirdlinetranscription:" + ov

      hexagramforthlinedescription: "hexagramforthlinedescription:" + ov
      hexagramforthlineexplanation: "hexagramforthlineexplanation:" + ov
      hexagramforthlinetranscription: "hexagramforthlinetranscription:" + ov

      hexagramfifthlinedescription: "hexagramfifthlinedescription:" + ov
      hexagramfifthlineexplanation: "hexagramfifthlineexplanation:" + ov
      hexagramfifthlinetranscription: "hexagramfifthlinetranscription:" + ov

      hexagramsixthlinedescription: "hexagramsixthlinedescription:" + ov
      hexagramsixthlineexplanation: "hexagramsixthlineexplanation:" + ov
      hexagramsixthlinetranscription: "hexagramsixthlinetranscription:" + ov

    inf

  imagemap =
    kou:
      images:
        oldyin: "oldyin:" + "kou"
        youngyang: "youngyang:" + "kou"
        youngyin: "youngyin:" + "kou"
        oldyang: "oldyang:" + "kou"
    sangi:
      images:
        oldyin: "oldyin:" + "sangi"
        youngyang: "youngyang:" + "sangi"
        youngyin: "youngyin:" + "sangi"
        oldyang: "oldyang:" + "sangi"

  ichingengine = null

  beforeEach ->
    ichingengine = new IChingEngine hexagramsinfo , imagemap

  afterEach ->
    ichingengine = null

  it 'const 値のチェック', ->
    expect(IChingEngine.OldYin).to.be 6
    expect(IChingEngine.YoungYang).to.be 7
    expect(IChingEngine.YoungYin).to.be 8
    expect(IChingEngine.OldYang).to.be 9

    expect(IChingEngine.OldYangBitCount).to.be 0
    expect(IChingEngine.YoungYinBitCount).to.be 1
    expect(IChingEngine.YoungYangBitCount).to.be 2
    expect(IChingEngine.OldYinBitCount).to.be 3

    expect(IChingEngine.CoinsCastingRandomMax).to.be 8

    expect(IChingEngine.KouLines).to.be 6

    return

  it '#bitCount', ->
    bitcountresult = [0,1,1,2,1,2,2,3,1]
    for bit , i in bitcountresult
      do (bit,i) ->
        expect(ichingengine.bitCount(i)).to.be bit
    return

  it '#coinsCasting normal', ->
    randomvalues = [
      ->
        0.0
      ->
        0.2
      ->
        0.3
      ->
        0.4
      ->
        0.5
      ->
        0.7
      ->
        0.8
      ->
        0.9
    ]
    randomback = Math.random
    coinscastingresult = [9,8,8,7,8,7,7,6]
    for rnd, i in randomvalues
      do (rnd,i) ->
        Math.random = rnd
        expect(ichingengine.coinsCasting()).to.be coinscastingresult[i]
    Math.random = randomback
    return

  it '#coinsCasting illegal', ->
    bitcountbak = ichingengine.bitCount
    ichingengine.bitCount = (i) ->
      10
    expect(ichingengine.coinsCasting()).to.be 0
    ichingengine.bitCount = bitcountbak
    return

  it '#generateKous', ->
    expect(ichingengine.generateKous()).to.have.length IChingEngine.KouLines
    for kou in ichingengine.generateKous()
      do (kou) ->
        expect(kou).to.be.within IChingEngine.OldYin, IChingEngine.OldYang
    return

  it '#kousToHexagrams', ->
    kousdata = [
      [6,6,6,6,6,6]
      [9,9,9,9,9,9]
      [6,9,6,9,6,9]
      [7,8,7,8,7,8]
    ]
    hexagramsresult = [
      {hexagramsmainresult: 0, hexagramsperspectiveresult: 63}
      {hexagramsmainresult: 63, hexagramsperspectiveresult: 0}
      {hexagramsmainresult: 21, hexagramsperspectiveresult: 42}
      {hexagramsmainresult: 42}
    ]
    for kous, i in kousdata
      hexr = hexagramsresult[i]
      do (kous,hexr) ->
        expect(ichingengine.kousToHexagrams(kous)).to.eql hexr
    return

  it '#kouToKString', ->
    codes = [6,7,8,9,5]
    results = ["老陰","少陽","少陰","老陽",""]
    for code, i in codes
      do (code,i) ->
        expect(ichingengine.kouToKString(code)).to.be results[i]
    return

  it '#kouToEString', ->
    codes = [6,7,8,9,5]
    results = ["OldYin","YoungYang","YoungYin","OldYang",""]
    for code, i in codes
      do (code,i) ->
        expect(ichingengine.kouToEString(code)).to.be results[i]
    return

  it '#kouToKouImage', ->
    codes = [6,7,8,9]
    results = ["oldyin:kou","youngyang:kou","youngyin:kou","oldyang:kou"]
    for code, i in codes
      do (code,i) ->
        expect(ichingengine.kouToKouImage(code)).to.be results[i]
    expect(ichingengine.kouToKouImage(0)).to.be null
    return

  it '#kouToSangiImage', ->
    codes = [6,7,8,9]
    results = ["oldyin:sangi","youngyang:sangi","youngyin:sangi","oldyang:sangi"]
    for code, i in codes
      do (code,i) ->
        expect(ichingengine.kouToSangiImage(code)).to.be results[i]
    expect(ichingengine.kouToSangiImage(0)).to.be null
    return

  it '#reading with perspective', ->
    genkousbak = ichingengine.generateKous
    ichingengine.generateKous = ->
      [6,6,6,6,6,6]
    kousresult = [
      {koucode: 6, kousangiimage: "oldyin:sangi", kousymbolimage: "oldyin:kou", kousymbolname: "老陰", kousymbolenglishname: "OldYin"}
      {koucode: 6, kousangiimage: "oldyin:sangi", kousymbolimage: "oldyin:kou", kousymbolname: "老陰", kousymbolenglishname: "OldYin"}
      {koucode: 6, kousangiimage: "oldyin:sangi", kousymbolimage: "oldyin:kou", kousymbolname: "老陰", kousymbolenglishname: "OldYin"}
      {koucode: 6, kousangiimage: "oldyin:sangi", kousymbolimage: "oldyin:kou", kousymbolname: "老陰", kousymbolenglishname: "OldYin"}
      {koucode: 6, kousangiimage: "oldyin:sangi", kousymbolimage: "oldyin:kou", kousymbolname: "老陰", kousymbolenglishname: "OldYin"}
      {koucode: 6, kousangiimage: "oldyin:sangi", kousymbolimage: "oldyin:kou", kousymbolname: "老陰", kousymbolenglishname: "OldYin"}
    ]
    mainresult = resultkind: "main"
    for key, value of hexagramsinfo[0]
      mainresult[key] = value
    selectkey = [
      "hexagramnumber"
      "octalvalue"
      "hexagramname"
      "hexagramaliasname"
      "hexagramaliasenglishname"
      "hexagramimage"
    ]
    perspectiveresult = resultkind: "perspective"
    info = hexagramsinfo[63]
    for key in selectkey
      do (key) ->
        perspectiveresult[key] = info[key]

    result =
      kousresult: kousresult
      mainresult: mainresult
      perspectiveresult: perspectiveresult

    expect(ichingengine.reading()).to.eql result
    ichingengine.generateKous = genkousbak
    return
    
  it '#reading without perspective', ->
    genkousbak = ichingengine.generateKous
    ichingengine.generateKous = ->
      [7,8,7,8,7,8]
    results = ["老陰","少陽","少陰","老陽",""]
    kousresult = [
      {koucode: 7, kousangiimage: "youngyang:sangi", kousymbolimage: "youngyang:kou", kousymbolname: "少陽", kousymbolenglishname: "YoungYang"}
      {koucode: 8, kousangiimage: "youngyin:sangi", kousymbolimage: "youngyin:kou", kousymbolname: "少陰", kousymbolenglishname: "YoungYin"}
      {koucode: 7, kousangiimage: "youngyang:sangi", kousymbolimage: "youngyang:kou", kousymbolname: "少陽", kousymbolenglishname: "YoungYang"}
      {koucode: 8, kousangiimage: "youngyin:sangi", kousymbolimage: "youngyin:kou", kousymbolname: "少陰", kousymbolenglishname: "YoungYin"}
      {koucode: 7, kousangiimage: "youngyang:sangi", kousymbolimage: "youngyang:kou", kousymbolname: "少陽", kousymbolenglishname: "YoungYang"}
      {koucode: 8, kousangiimage: "youngyin:sangi", kousymbolimage: "youngyin:kou", kousymbolname: "少陰", kousymbolenglishname: "YoungYin"}
    ]
    mainresult = resultkind: "main"
    for key, value of hexagramsinfo[42]
      mainresult[key] = value

    result =
      kousresult: kousresult
      mainresult: mainresult

    res = ichingengine.reading()
    expect(res).to.eql result
    expect('perspectiveresult' of res).not.to.be.ok
    ichingengine.generateKous = genkousbak
    return

