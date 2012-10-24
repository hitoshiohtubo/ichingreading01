package iching

import groovy.json.*
import grails.converters.*

class HexagramController {
  static scaffold = Hexagram
  def jsonlist() {
    render Hexagram.listOrderByOctalvalue() as JSON
  }
  def jsonesclist() {
    def hexagrams = Hexagram.listOrderByOctalvalue()
    def hexagramslist = hexagrams.collect {
      it.properties
    }
    def hexagramsjson = new JsonBuilder(hexagramslist)
    def jsonstr = hexagramsjson.toString()
    render (contentType: "application/json", text: jsonstr)
  }
  def jsonminilist() {
    def hexagrams = Hexagram.listOrderByOctalvalue()
    def listofhexagram = hexagrams.collect {
      Hexagram hexagram ->
        [
          hexagramnumber : hexagram.hexagramnumber,
          octalvalue : hexagram.octalvalue,
          hexagramname : hexagram.hexagramname,
          hexagramaliasname : hexagram.hexagramaliasname,
          hexagramaliasenglishname : hexagram.hexagramaliasenglishname,
          hexagramimage : hexagram.hexagramimage
        ]
    }

    render(contentType: "application/json") {
      listofhexagram
    }
  }
  def jsonxlist() {
    def hexagrams = Hexagram.listOrderByOctalvalue()
    def listofhexagram = hexagrams.collect {
      it.properties
    }

    render(contentType: "application/json") {
      listofhexagram
    }
  }
  def jsonescprettylist() {
    def hexagrams = Hexagram.listOrderByOctalvalue()
    def hexagramslist = hexagrams.collect {
      it.properties
    }
    def hexagramsjson = new JsonBuilder(hexagramslist)
    def jsonstr = hexagramsjson.toPrettyString()
    render (contentType: "application/json", text: jsonstr)
  }
}
