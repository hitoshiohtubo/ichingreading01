// Generated by CoffeeScript 1.3.3
var IChingEngine;

IChingEngine = (function() {

  IChingEngine.OldYin = 6;

  IChingEngine.YoungYang = 7;

  IChingEngine.YoungYin = 8;

  IChingEngine.OldYang = 9;

  IChingEngine.OldYangBitCount = 0;

  IChingEngine.YoungYinBitCount = 1;

  IChingEngine.YoungYangBitCount = 2;

  IChingEngine.OldYinBitCount = 3;

  IChingEngine.CoinsCastingRandomMax = 8;

  IChingEngine.KouLines = 6;

  function IChingEngine(hexagramsinfo, imagemap) {
    this.hexagramsinfo = hexagramsinfo;
    this.imagemap = imagemap;
  }

  IChingEngine.prototype.bitCount = function(i) {
    i = i - ((i >>> 1) & 0x55555555);
    i = (i & 0x33333333) + ((i >>> 2) & 0x33333333);
    i = (i + (i >>> 4)) & 0x0f0f0f0f;
    i = i + (i >>> 8);
    i = i + (i >>> 16);
    return i & 0x3f;
  };

  IChingEngine.prototype.coinsCasting = function() {
    var bitcnt, retval, rndval;
    rndval = Math.floor(Math.random() * IChingEngine.CoinsCastingRandomMax);
    bitcnt = this.bitCount(rndval);
    retval = (function() {
      switch (bitcnt) {
        case IChingEngine.OldYinBitCount:
          return IChingEngine.OldYin;
        case IChingEngine.YoungYangBitCount:
          return IChingEngine.YoungYang;
        case IChingEngine.YoungYinBitCount:
          return IChingEngine.YoungYin;
        case IChingEngine.OldYangBitCount:
          return IChingEngine.OldYang;
        default:
          return 0;
      }
    })();
    return retval;
  };

  IChingEngine.prototype.generateKous = function() {
    var i, retary;
    retary = (function() {
      var _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = IChingEngine.KouLines; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        _results.push(this.coinsCasting());
      }
      return _results;
    }).call(this);
    return retary;
  };

  IChingEngine.prototype.kousToHexagrams = function(kous) {
    var i, mval, omask, pval, retobj, v, zmask, _fn, _i, _len;
    mval = 0;
    pval = 0;
    omask = 0;
    zmask = 0;
    _fn = function(v, i) {
      var tval;
      tval = 0x1 << (IChingEngine.KouLines - (1 + i));
      if (v === IChingEngine.YoungYang || v === IChingEngine.OldYang) {
        mval |= tval;
      }
      if (v === IChingEngine.OldYin) {
        omask |= tval;
      }
      if (v === IChingEngine.OldYang) {
        zmask |= tval;
      }
    };
    for (i = _i = 0, _len = kous.length; _i < _len; i = ++_i) {
      v = kous[i];
      _fn(v, i);
    }
    zmask = ~zmask & 0xffffffff;
    pval = mval;
    pval |= omask;
    pval &= zmask;
    retobj = {
      hexagramsmainresult: mval
    };
    if (mval !== pval) {
      retobj.hexagramsperspectiveresult = pval;
    }
    return retobj;
  };

  IChingEngine.prototype.kouToKString = function(code) {
    var retstr;
    retstr = (function() {
      switch (code) {
        case IChingEngine.OldYin:
          return "老陰";
        case IChingEngine.YoungYang:
          return "少陽";
        case IChingEngine.YoungYin:
          return "少陰";
        case IChingEngine.OldYang:
          return "老陽";
        default:
          return "";
      }
    })();
    return retstr;
  };

  IChingEngine.prototype.kouToEString = function(code) {
    var retstr;
    retstr = (function() {
      switch (code) {
        case IChingEngine.OldYin:
          return "OldYin";
        case IChingEngine.YoungYang:
          return "YoungYang";
        case IChingEngine.YoungYin:
          return "YoungYin";
        case IChingEngine.OldYang:
          return "OldYang";
        default:
          return "";
      }
    })();
    return retstr;
  };

  IChingEngine.prototype.kouToKouImage = function(code) {
    var retstr;
    retstr = (function() {
      var _ref, _ref1, _ref10, _ref11, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
      switch (code) {
        case IChingEngine.OldYin:
          return (_ref = this.imagemap) != null ? (_ref1 = _ref.kou) != null ? (_ref2 = _ref1.images) != null ? _ref2.oldyin : void 0 : void 0 : void 0;
        case IChingEngine.YoungYang:
          return (_ref3 = this.imagemap) != null ? (_ref4 = _ref3.kou) != null ? (_ref5 = _ref4.images) != null ? _ref5.youngyang : void 0 : void 0 : void 0;
        case IChingEngine.YoungYin:
          return (_ref6 = this.imagemap) != null ? (_ref7 = _ref6.kou) != null ? (_ref8 = _ref7.images) != null ? _ref8.youngyin : void 0 : void 0 : void 0;
        case IChingEngine.OldYang:
          return (_ref9 = this.imagemap) != null ? (_ref10 = _ref9.kou) != null ? (_ref11 = _ref10.images) != null ? _ref11.oldyang : void 0 : void 0 : void 0;
        default:
          return null;
      }
    }).call(this);
    return retstr;
  };

  IChingEngine.prototype.kouToSangiImage = function(code) {
    var retstr;
    retstr = (function() {
      var _ref, _ref1, _ref10, _ref11, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
      switch (code) {
        case IChingEngine.OldYin:
          return (_ref = this.imagemap) != null ? (_ref1 = _ref.sangi) != null ? (_ref2 = _ref1.images) != null ? _ref2.oldyin : void 0 : void 0 : void 0;
        case IChingEngine.YoungYang:
          return (_ref3 = this.imagemap) != null ? (_ref4 = _ref3.sangi) != null ? (_ref5 = _ref4.images) != null ? _ref5.youngyang : void 0 : void 0 : void 0;
        case IChingEngine.YoungYin:
          return (_ref6 = this.imagemap) != null ? (_ref7 = _ref6.sangi) != null ? (_ref8 = _ref7.images) != null ? _ref8.youngyin : void 0 : void 0 : void 0;
        case IChingEngine.OldYang:
          return (_ref9 = this.imagemap) != null ? (_ref10 = _ref9.sangi) != null ? (_ref11 = _ref10.images) != null ? _ref11.oldyang : void 0 : void 0 : void 0;
        default:
          return null;
      }
    }).call(this);
    return retstr;
  };

  IChingEngine.prototype.reading = function() {
    var code, hexagramsresult, key, kl, km, kousresult, mh, mhexagram, mres, ph, phexagram, pres, result, value;
    kousresult = this.generateKous();
    hexagramsresult = this.kousToHexagrams(kousresult);
    result = {};
    kl = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = kousresult.length; _i < _len; _i++) {
        code = kousresult[_i];
        km = {};
        km.koucode = code;
        km.kousangiimage = this.kouToSangiImage(code);
        km.kousymbolimage = this.kouToKouImage(code);
        km.kousymbolname = this.kouToKString(code);
        km.kousymbolenglishname = this.kouToEString(code);
        _results.push(km);
      }
      return _results;
    }).call(this);
    result.kousresult = kl;
    mres = hexagramsresult.hexagramsmainresult;
    mhexagram = this.hexagramsinfo[mres];
    mh = {};
    for (key in mhexagram) {
      value = mhexagram[key];
      mh[key] = value;
    }
    mh.resultkind = "main";
    result.mainresult = mh;
    if (hexagramsresult.hexagramsperspectiveresult) {
      pres = hexagramsresult.hexagramsperspectiveresult;
      phexagram = this.hexagramsinfo[pres];
      ph = {};
      ph.hexagramnumber = phexagram.hexagramnumber;
      ph.octalvalue = phexagram.octalvalue;
      ph.hexagramname = phexagram.hexagramname;
      ph.hexagramaliasname = phexagram.hexagramaliasname;
      ph.hexagramaliasenglishname = phexagram.hexagramaliasenglishname;
      ph.hexagramimage = phexagram.hexagramimage;
      ph.resultkind = "perspective";
      result.perspectiveresult = ph;
    }
    return result;
  };

  return IChingEngine;

})();
