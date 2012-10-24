// Generated by CoffeeScript 1.3.3
var IChingExecute, hexagramsjsonurl_, imagemap_, skiprandomvalue;

hexagramsjsonurl_ = "/ichingreadingcf01/hexagram/jsonesclist";

imagemap_ = {
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

IChingExecute = (function() {

  IChingExecute.prototype.hexagramsinfo = null;

  IChingExecute.prototype.ichingengine = null;

  IChingExecute.prototype.hexagramsjsonurl = null;

  function IChingExecute(imagemap, hexagramsjsonurl) {
    this.imagemap = imagemap;
    this.hexagramsjsonurl = hexagramsjsonurl;
  }

  IChingExecute.hideresultpane = function() {
    $("#ichingresultpane").hide();
  };

  IChingExecute.hideperspectivebase = function() {
    $("#hexagramperspectivetablebase").hide();
  };

  IChingExecute.showresultpane = function() {
    $("#ichingresultpane").show();
  };

  IChingExecute.showperspectivebase = function() {
    $("#hexagramperspectivetablebase").show();
  };

  IChingExecute.prototype.initresultkou = function() {
    var koudir, sangidir, _ref, _ref1, _ref2, _ref3;
    if (this.imagemap) {
      sangidir = (_ref = (_ref1 = this.imagemap.sangi) != null ? _ref1.dir : void 0) != null ? _ref : "";
      sangidir = $.trim(sangidir);
      if (sangidir.length > 0) {
        sangidir = sangidir + "/";
      }
      koudir = (_ref2 = (_ref3 = this.imagemap.kou) != null ? _ref3.dir : void 0) != null ? _ref2 : "";
      koudir = $.trim(koudir);
      if (koudir.length > 0) {
        koudir = koudir + "/";
      }
      $(".kousangiimage").attr("src", sangidir + this.imagemap.sangi.images.init);
      $(".kousymbolimage").attr("src", koudir + this.imagemap.kou.images.init);
    }
    $(".kousymbolname").text("");
    $(".kousymbolname").attr("englishname", "none");
  };

  IChingExecute.prototype.initresulthexagram = function() {
    var hexagramdir, _ref, _ref1;
    if (this.imagemap) {
      hexagramdir = (_ref = (_ref1 = this.imagemap.hexagram) != null ? _ref1.dir : void 0) != null ? _ref : "";
      hexagramdir = $.trim(hexagramdir);
      if (hexagramdir.length > 0) {
        hexagramdir = hexagramdir + "/";
      }
      $(".hexagramimage").attr("src", hexagramdir + this.imagemap.hexagram.images.init);
    }
    $(".hexagramname").text("");
    $(".hexagramalias").text("");
    $(".hexagramaliasenglish").text("");
  };

  IChingExecute.prototype.replaceresultkousangiimage = function(data) {
    var i, rs, sangidir, ss, _i, _len, _ref, _ref1, _ref2;
    if (data != null ? data.kousresult : void 0) {
      _ref = data.kousresult;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        rs = _ref[i];
        if (rs.kousangiimage) {
          sangidir = (_ref1 = (_ref2 = this.imagemap.sangi) != null ? _ref2.dir : void 0) != null ? _ref1 : "";
          sangidir = $.trim(sangidir);
          if (sangidir.length > 0) {
            sangidir = sangidir + "/";
          }
          ss = sangidir + rs.kousangiimage;
          $("#kousangiimage" + (i + 1)).attr("src", ss);
        }
      }
    }
  };

  IChingExecute.prototype.replaceresultkousymbolimage = function(data) {
    var i, koudir, rs, ss, _i, _len, _ref, _ref1, _ref2;
    if (data != null ? data.kousresult : void 0) {
      _ref = data.kousresult;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        rs = _ref[i];
        if (rs.kousymbolimage) {
          koudir = (_ref1 = (_ref2 = this.imagemap.kou) != null ? _ref2.dir : void 0) != null ? _ref1 : "";
          koudir = $.trim(koudir);
          if (koudir.length > 0) {
            koudir = koudir + "/";
          }
          ss = koudir + rs.kousymbolimage;
          $("#kousymbolimage" + (i + 1)).attr("src", ss);
        }
      }
    }
  };

  IChingExecute.prototype.replaceresultkousymbolname = function(data) {
    var i, rs, _i, _len, _ref;
    if (data != null ? data.kousresult : void 0) {
      _ref = data.kousresult;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        rs = _ref[i];
        if (rs.kousymbolname) {
          $("#kousymbolname" + (i + 1)).text(rs.kousymbolname);
        }
        if (rs.kousymbolenglishname) {
          $("#kousymbolname" + (i + 1)).attr("englishname", rs.kousymbolenglishname);
        }
      }
    }
  };

  IChingExecute.prototype.replaceresulthexagrammain = function(data) {
    var hexagramdir, hn, ss, _ref, _ref1;
    if (data != null ? data.mainresult : void 0) {
      if (data.mainresult.hexagramimage) {
        hexagramdir = (_ref = (_ref1 = this.imagemap.hexagram) != null ? _ref1.dir : void 0) != null ? _ref : "";
        hexagramdir = $.trim(hexagramdir);
        if (hexagramdir.length > 0) {
          hexagramdir = hexagramdir + "/";
        }
        ss = hexagramdir + data.mainresult.hexagramimage;
        $("#hexagramimagemain").attr("src", ss);
      }
      if (data.mainresult.hexagramnumber && data.mainresult.hexagramname) {
        hn = data.mainresult.hexagramnumber + ". " + data.mainresult.hexagramname;
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

  IChingExecute.prototype.replaceresulthexagramperspective = function(data) {
    var hexagramdir, hn, ss, _ref, _ref1;
    if (data != null ? data.perspectiveresult : void 0) {
      IChingExecute.showperspectivebase();
      if (data.perspectiveresult.hexagramimage) {
        hexagramdir = (_ref = (_ref1 = this.imagemap.hexagram) != null ? _ref1.dir : void 0) != null ? _ref : "";
        hexagramdir = $.trim(hexagramdir);
        if (hexagramdir.length > 0) {
          hexagramdir = hexagramdir + "/";
        }
        ss = hexagramdir + data.perspectiveresult.hexagramimage;
        $("#hexagramimageperspective").attr("src", ss);
      }
      if (data.perspectiveresult.hexagramnumber && data.perspectiveresult.hexagramname) {
        hn = data.perspectiveresult.hexagramnumber + ". " + data.perspectiveresult.hexagramname;
        $("#hexagramnameperspective").text(hn);
      }
      if (data.perspectiveresult.hexagramaliasname) {
        $("#hexagramaliasperspective").text(data.perspectiveresult.hexagramaliasname);
      }
      if (data.perspectiveresult.hexagramaliasenglishname) {
        $("#hexagramaliasenglishperspective").text(data.perspectiveresult.hexagramaliasenglishname);
      }
    }
  };

  IChingExecute.prototype.bindevent = function() {
    var _this = this;
    $("#readingbtn").button({
      label: 'Reading',
      disabled: false
    }).click(function() {
      var resultdata, _ref;
      $("#readingbtn").button('disable');
      _this.initresultkou();
      _this.initresulthexagram();
      IChingExecute.hideperspectivebase();
      IChingExecute.hideresultpane();
      if (!_this.ichingengine) {
        if (_this.hexagramsinfo) {
          _this.ichingengine = new IChingEngine(_this.hexagramsinfo, _this.imagemap);
        }
      }
      resultdata = (_ref = _this.ichingengine) != null ? _ref.reading() : void 0;
      if (resultdata) {
        IChingExecute.showresultpane();
        _this.replaceresultkousangiimage(resultdata);
        _this.replaceresultkousymbolimage(resultdata);
        _this.replaceresultkousymbolname(resultdata);
        _this.replaceresulthexagrammain(resultdata);
        _this.replaceresulthexagramperspective(resultdata);
      }
      $("#retrybtn").button('enable');
    });
    $("#retrybtn").button({
      label: 'Retry',
      disabled: true
    }).click(function() {
      $("#retrybtn").button('disable');
      IChingExecute.hideperspectivebase();
      IChingExecute.hideresultpane();
      _this.initresultkou();
      _this.initresulthexagram();
      $("#readingbtn").button('enable');
    });
  };

  IChingExecute.prototype.getjsonhexagramsinfo = function() {
    var _this = this;
    $("#readingbtn").button('disable');
    $("#retrybtn").button('disable');
    this.initresultkou();
    this.initresulthexagram();
    if (this.hexagramsjsonurl) {
      $.ajax({
        type: "GET",
        async: false,
        url: this.hexagramsjsonurl,
        dataType: "json",
        global: false,
        success: function(data, dataType) {
          _this.hexagramsinfo = $.extend(true, {}, data);
          $("#readingbtn").button('enable');
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
          console.error(textStatus);
        }
      });
    }
  };

  return IChingExecute;

})();

skiprandomvalue = function() {
  var loopcnt, tmpdate;
  tmpdate = new Date();
  loopcnt = tmpdate.getMilliseconds() / 4;
  while (loopcnt >= 0) {
    Math.random();
    loopcnt--;
  }
};

$(document).ready(function() {
  var ichingexecute;
  ichingexecute = new IChingExecute(imagemap_, hexagramsjsonurl_);
  ichingexecute.bindevent();
  ichingexecute.getjsonhexagramsinfo();
  IChingExecute.hideperspectivebase();
  IChingExecute.hideresultpane();
  skiprandomvalue();
});
