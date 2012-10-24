package iching

class DojoController {

  def readingService
  static defaultAction = "menu"

  def menu() { }
  def indexprogrammatic() { }
  def indexoutsideprogrammatic() { }
  def indexoutsidecoffeeprogrammatic() { }
  def indexdeclarative() { }
  def readingresultjson() {
    def result = readingService.reading()

    render(contentType: "text/json") {
      result
    }
  }

}
