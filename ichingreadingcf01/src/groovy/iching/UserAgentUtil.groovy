package iching

class UserAgentUtil {
  static boolean isTablet(String useragent) {
    def uuseragent = useragent.toUpperCase()
    boolean r = false
    if (uuseragent =~ /IPAD/) {
      r = true
    }
    else if (uuseragent =~ /ANDROID/ && !(uuseragent =~ /MOBILE/)) {
      r = true
    }
    return r
  }
  static boolean isSmartPhone(String useragent) {
    def uuseragent = useragent.toUpperCase()
    boolean r = false
    if (uuseragent =~ /IPHONE/ && !(uuseragent =~ /IPOD/)) {
      r = true
    }
    else if (uuseragent =~ /ANDROID/ && uuseragent =~ /MOBILE/) {
      r = true
    }
    else if (uuseragent =~ /WINDOWS PHONE/) {
      r = true
    }
    else if (uuseragent =~ /BLACKBERRY/) {
      r = true
    }
    return r
  }
  static boolean isiPod(String useragent) {
    def uuseragent = useragent.toUpperCase()
    boolean r = false
    if (uuseragent =~ /IPOD/) {
      r = true
    }
    return r
  }
  static boolean isMobile(String useragent) {
    boolean r = false
    if (isTablet(useragent) || isSmartPhone(useragent) || isiPod(useragent)) {
      r = true
    }
    return r
  }
  static boolean isPC(String useragent) {
    def uuseragent = useragent.toUpperCase()
    boolean r = false
    if (!isMobile(useragent)) {
      if (uuseragent =~ /MACINTOSH/ || uuseragent =~ /WINDOWS NT/) {
        r = true
      }
    }
    return r
  }

}

