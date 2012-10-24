package iching

class DojomobileController {

  def readingService
  static defaultAction = "menu"

  def menu() { }
  def indexxhr() { }
  def indexiconhref() { }
  def indexiconurl() { }
  def readingresultjson() {
    def result = readingService.reading()

    render(contentType: "text/json") {
      result
    }
  }
  def readingresulthrefhtml() {
    def result = readingService.reading()

    [result: result]
  }
  def readingresulturlhtml() {
    def result = readingService.reading()

    [result: result]
  }

}
