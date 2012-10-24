package iching

class JquerymobileController {

  def readingService

  def index() { }
  def readingresulthtml() {
    def result = readingService.reading()

    [result: result]
  }

}
