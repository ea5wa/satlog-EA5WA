PP=''
II='PACO'
SET TEXT ON NOSHOW
SET TEXTMERGE TO MEMVAR PP && TEXTMERGE begins on the next line.
   \HOLA
   \<<II>>


? PP   
   
   
*!*	   
*!*	   TEXT TO PP
*!*	   RRR="\<QSO_DATE:8:D>"+ XFECHA +;
*!*	       " <TIME_ON:4>"+xhora+;
*!*	       " <CALL:"+   ALLTR(STR(LEN(xcall)))  +">"+ xcall+;
*!*	       " <MODE:"+   ALLTR(STR(LEN(xmode)))  +">"+ xmode+;
*!*	       " <COMMENT:"+ALLTR(STR(LEN(xcome)))  +">"+ xcome+;
*!*	       " <GRIDSQUARE:"+ALLTR(STR(LEN(xlocator)))  +">"+ xlocator+;
*!*		   IIF(xmode='CW',;
*!*		   " <RST_SENT:3>"+xsurst+" <RST_RCVD:3>"+xmirst ,;
*!*		   " <RST_SENT:2>"+xsurst+" <RST_RCVD:2>"+xmirst ) +;
*!*	       " <EOR>"

*!*	   &RRR
*!*	   \
*!*	   ENDTEXT