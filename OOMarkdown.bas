'*** Markdown formatter for Libre(open)Office ****
'    (pre-alpha-demo) tested on LibreOffice 4.2
'    Author: Evgenii Maksimov jekamax@gmail.com
'    License: No any warranties blah blah blah...
'             Send me real postcard if you Like to use it 

Option Explicit
'*** Style names used for foratting ***
Private Const preformatted ="Preformatted Text"
Private Const header ="Heading "

Sub Main
	replaceHeader
	replaceCode
	replaceMath
End Sub

'*** Headers ***
' Apply heading syle to strings starting with some # chars
' # -> Heading 1
' ## -> Heading 2
' ### -> Heading 3
' And so on 
Sub replaceHeader
	Dim searchMark,searchText
 	searchMark=regSearch("^#+")
 	searchText=regSearch(".*$")
	Dim foundMark,foundText
  	foundMark = doc.findFirst(searchMark)
  	While NOT IsNull(foundMark)
  		Dim headlevel
  		headLevel=len(trim(foundMark.getString))
  		If headLevel>5 Then
  			headLevel=5
  		End if
  		foundText=doc.findNext(foundMark,searchText)
  		foundText.ParaStyleName=header & headlevel
  		Dim hs: hs=Trim(foundText.getString)
  		foundMark.setString("")
  		foundText.setString(hs)
  		foundMark = doc.findNext(foundText,searchMark)
  	Wend 
End Sub

'*** Code blocks ***
' Apply preformatted style to text block between lines of tildas.
' Also remove paragraph breaks in that block.
Sub replaceCode
  Dim search
  search=regSearch("^~~+$")
  Dim found1,found2
  found1 = doc.findFirst(search)
  If Not IsNull(found1) Then
    found2 = doc.findNext(found1,search)
  End If
  While NOT IsNull(found1) And Not IsNull(found2)
   	found1.setString("")
   	found2.setString("")
   	found1.gotoRange(found2,True)
   	found1.ParaStyleName=preformatted
   	Dim str
   	'Paragraph breaks are CRLF 
   	'we need just linebreaks without breaking paragraph - LF
   	'so we remove all CR - Chr(13)
   	str=Join(Split(found1.getString(),Chr(13)),"")
   	str=mid(str,2,len(str)-3) 'Indexes in string begin with 1. WTF?!
   	found1.setString(str)
      	found1 = doc.findNext(found2,search)
      	If Not IsNull(found1) Then
      		found2 = doc.findNext(found1,search)
      	End if
  Wend
  
End Sub

'*** Formulas ***
' Convert text between two $ chars to formula object.
' Text must be in OpenOffice Math language.
' Annoyingly tricky implementation...
Sub replaceMath
	Dim search
 	search=regSearch("\$.*\$")
 	Dim found
  	found = doc.findFirst(search)
  	While NOT IsNull(found)
  		Dim mathStr
  		mathStr=found.getString()
  		mathStr=Mid(mathStr,2,Len(mathStr)-2) 'WTF again!
  		Dim math
  		math = doc.createInstance("com.sun.star.text.TextEmbeddedObject")
  		'set type of object by setting UUID. Very intuitive... 
		math.CLSID = "078B7ABA-54FC-457F-8551-6147e776a997"
		math.AnchorType=com.sun.star.text.TextContentAnchorType.AS_CHARACTER 
		doc.getText.insertTextContent(found, math, true)
		math.Model.formula = mathStr
		'resize formula according paragraph text height
		math.Model.BaseFontHeight=Int(math.Anchor.CharHeight)
		'we need to use undocumented interface to perform such simple task?!
		math.ExtendedControlOverEmbeddedObject.update()
		found = doc.findNext(found,search)
  	Wend 

End Sub

'sugar for search patterns
Function regSearch(str)
	Dim search
	search = doc.createSearchDescriptor
	search.SearchRegularExpression = TRUE
	search.SearchString=str
	regSearch=search
End Function

'sugar for getting current document
Function doc
	doc = ThisComponent
End Function
