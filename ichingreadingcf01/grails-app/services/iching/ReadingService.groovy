package iching

import java.security.SecureRandom

class ReadingService {
  def grailsApplication

  static transactional = false

  static final int ICOldYin = 6
  static final int ICYoungYang = 7
  static final int ICYoungYin = 8
  static final int ICOldYang = 9

  static final String ICKSOldYin = "老陰"
  static final String ICKSYoungYang = "少陽"
  static final String ICKSYoungYin = "少陰"
  static final String ICKSOldYang = "老陽"

  static final String ICESOldYin = "OldYin"
  static final String ICESYoungYang = "YoungYang"
  static final String ICESYoungYin = "YoungYin"
  static final String ICESOldYang = "OldYang"

  static final int ICOldYangBitCount = 0
  static final int ICYoungYinBitCount = 1
  static final int ICYoungYangBitCount = 2
  static final int ICOldYinBitCount = 3

  static final int ICCoinCastingRandomMax = 8
  static final int ICKouLines = 6
  
  def coinsCasting() {
    SecureRandom rnd = new SecureRandom()
    int rndval = rnd.nextInt(ICCoinCastingRandomMax)
    int bitcnt = Integer.bitCount(rndval)
    int retval = 0
    if (bitcnt == ICOldYinBitCount) {
      retval = ICOldYin
    }
    else if (bitcnt == ICYoungYangBitCount) {
      retval = ICYoungYang
    }
    else if (bitcnt == ICYoungYinBitCount) {
      retval = ICYoungYin
    }
    else if (bitcnt == ICOldYangBitCount) {
      retval = ICOldYang
    }

    retval
  }

  def generateKous() {
    def retary = []
    ICKouLines.times {
      retary += coinsCasting()
    }
    retary
  }

  def kousToHexagrams(List kous) {
    def retmap = [:]
    int mval = 0
    int pval = 0
    int omask = 0
    int zmask = 0

    kous.eachWithIndex {
      v,i ->
      int tval = 0x1 << (ICKouLines - (1 + i))
      if (v == ICYoungYang || v == ICOldYang) {
        mval |= tval
      }
      if (v == ICOldYin) {
        omask |= tval
      }
      if (v == ICOldYang) {
        zmask |= tval
      }
    }
    zmask = (~zmask & 0xffffffff)
    pval = mval
    pval |= omask
    pval &= zmask
    retmap.put("hexagramsmainresult",mval)
    if (mval != pval) {
      retmap.put("hexagramsperspectiveresult",pval)
    }
    retmap
  }

  def kouToKString(int code) {
    def retstr = ""
    if (code == ICOldYin) {
      retstr = ICKSOldYin
    }
    if (code == ICYoungYang) {
      retstr = ICKSYoungYang
    }
    if (code == ICYoungYin) {
      retstr = ICKSYoungYin
    }
    if (code == ICOldYang) {
      retstr = ICKSOldYang
    }
    retstr
  }

  def kouToEString(int code) {
    def retstr = ""
    if (code == ICOldYin) {
      retstr = ICESOldYin
    }
    if (code == ICYoungYang) {
      retstr = ICESYoungYang
    }
    if (code == ICYoungYin) {
      retstr = ICESYoungYin
    }
    if (code == ICOldYang) {
      retstr = ICESOldYang
    }
    retstr
  }

  def kouToKouImage(int code) {
    def retstr = ""
    if (code == ICOldYin) {
      retstr = grailsApplication.config.iching.image.kou.images.oldyin
    }
    if (code == ICYoungYang) {
      retstr = grailsApplication.config.iching.image.kou.images.youngyang
    }
    if (code == ICYoungYin) {
      retstr = grailsApplication.config.iching.image.kou.images.youngyin
    }
    if (code == ICOldYang) {
      retstr = grailsApplication.config.iching.image.kou.images.oldyang
    }
    retstr
  }

  def kouToSangiImage(int code) {
    def retstr = ""
    if (code == ICOldYin) {
      retstr = grailsApplication.config.iching.image.sangi.images.oldyin
    }
    if (code == ICYoungYang) {
      retstr = grailsApplication.config.iching.image.sangi.images.youngyang
    }
    if (code == ICYoungYin) {
      retstr = grailsApplication.config.iching.image.sangi.images.youngyin
    }
    if (code == ICOldYang) {
      retstr = grailsApplication.config.iching.image.sangi.images.oldyang
    }
    retstr
  }

  def reading() {
    def result = [:]
    def kousresult = generateKous()
    def hexagramresult = kousToHexagrams(kousresult)
    result.put("kousresult",kousresult)
    hexagramresult.each { key, value -> result.put(key,value) }
    kousresult.eachWithIndex {
      code, i ->
      def keysangi = "kousangiimage" + (i + 1)
      def sangiimg = kouToSangiImage(code)
      result.put(keysangi,sangiimg)
      def keysymbol = "kousymbolimage" + (i + 1)
      def symbolimg = kouToKouImage(code)
      result.put(keysymbol,symbolimg)
      def keyname = "kousymbolname" + (i + 1)
      def symbolname = kouToKString(code)
      result.put(keyname,symbolname)
      def keyename = "kousymbolenglishname" + (i + 1)
      def symbolename = kouToEString(code)
      result.put(keyename,symbolename)
    }
    def kl = []
    kousresult.each {
      code ->
      def km = [:]
      def sangiimg = kouToSangiImage(code)
      km.put("kousangiimage",sangiimg)
      def symbolimg = kouToKouImage(code)
      km.put("kousymbolimage",symbolimg)
      def symbolname = kouToKString(code)
      km.put("kousymbolname",symbolname)
      def symbolename = kouToEString(code)
      km.put("kousymbolenglishname",symbolename)
      kl.push(km)
    }
    result.put("kousresult",kl)

    def mres = result.hexagramsmainresult
    def mreso = String.format("%03o",mres)
    def mhexagram = Hexagram.findByOctalvalue(mreso)
    def mh = [:]
    mh.putAll(mhexagram.properties)
    /*
    mh.put("hexagramnumber",mhexagram.hexagramnumber)
    mh.put("octalvalue",mhexagram.octalvalue)
    mh.put("hexagramname",mhexagram.hexagramname)
    mh.put("hexagramaliasname",mhexagram.hexagramaliasname)
    mh.put("hexagramaliasenglishname",mhexagram.hexagramaliasenglishname)
    mh.put("hexagramimage",mhexagram.hexagramimage)
    */
    mh.put("resultkind","main")

    result.put("mainresult",mh)

    def pres = result.hexagramsperspectiveresult
    if (pres != null) {
      def preso = String.format("%03o",pres)
      def phexagram = Hexagram.findByOctalvalue(preso)
      def ph = [:]
      ph.put("hexagramnumber",phexagram.hexagramnumber)
      ph.put("octalvalue",phexagram.octalvalue)
      ph.put("hexagramname",phexagram.hexagramname)
      ph.put("hexagramaliasname",phexagram.hexagramaliasname)
      ph.put("hexagramaliasenglishname",phexagram.hexagramaliasenglishname)
      ph.put("hexagramimage",phexagram.hexagramimage)
      ph.put("resultkind","perspective")
      result.put("perspectiveresult",ph)
    }

    result
  }
}
