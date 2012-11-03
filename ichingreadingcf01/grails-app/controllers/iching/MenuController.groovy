package iching

class MenuController {

  def index() { }
  def selectdojo() {
    def ua = request.getHeader("User-Agent")
    if (UserAgentUtil.isTablet(ua)) {
      redirect(action: "menu", controller: "dojomobile")
    }
    else if (UserAgentUtil.isPC(ua)) {
      redirect(action: "menu", controller: "dojo")
    }
    else {
      render "not supported"
    }

  }
  def selectjquery() {
    def ua = request.getHeader("User-Agent")
    if (UserAgentUtil.isTablet(ua)) {
      redirect(action: "index", controller: "jquerymobile")
    }
    else if (UserAgentUtil.isPC(ua)) {
      redirect(action: "index", controller: "jquery")
    }
    else {
      render "not supported"
    }
  }
}
