package iching

class JqueryController {

  def readingService
  static defaultAction = "menu"

  def menu() { }
  def index() { }
  def indexcoffee() { }
  def readingresultjson() {
    def result = readingService.reading()

    render(contentType: "application/json") {
      result
    }
  }

}
