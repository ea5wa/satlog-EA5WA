* Exporta a ADIFF

PRIVATE DFEC, HFEC

dfec= thisform.dfec.Value
hfec= thisform.hfec.value

* fichero a exportar

PRIVATE adffile
IF EMPTY(thisform.txtfile.value)
   WAIT WINDOW 'Nombre de fichero vacío.'
   RETURN
ELSE
   adffile= ALLTR(thisform.txtfile.value)
ENDIF

* definición de filtros
FILTRO =''

filtro= BETW(fecha, dfec, hfec)


*SET FILTER TO &FILTRO

SET CONSOLE OFF
ERASE &adffile
SET TEXT TO  &adffile ADDITIVE
\Fichero de exportacion del log de EC5CR<EOH>
\
SELECT LOGEA5WA
GO TOP

SCAN REST FOR !EMPTY(CALL) AND !EMPTY(MIRST) AND !EMPTY(SURST)
   *xfecha=SUBSTR(fecha,7,4)+SUBSTR(fecha,4,2)+SUBSTR(fecha,1,2)
   xfecha=DTOS(fecha)
   xhora=ALLTRIM(STRTRAN(hora,":"))
   xcall=ALLTRIM(sucall)
   xmode=ALLTR(modo)
   xcome=ALLTRIM(STRTRAN(comentario,CHR(13)," "))
   xlocator=ALLTRIM(sulocator)
   xsurst=ALLTRIM(STR(surst))
   xmirst=ALLTRIM(STR(mirst))
   
   
   RRR="\<QSO_DATE:8:D>"+ XFECHA +;
       " <TIME_ON:4>"+xhora+;
       " <CALL:"+   ALLTR(STR(LEN(XCALL)))  +">"+ xcall+;
       " <BAND:"+   ALLTR(STR(LEN(XFREQ)))  +">"+ xfreq+;
       " <MODE:"+   ALLTR(STR(LEN(Xmode)))  +">"+ xmode+;
       " <COMMENT:"+ALLTR(STR(LEN(Xcome)))  +">"+ xcome+;
       " <GRIDSQUARE:"+ALLTR(STR(LEN(XLOCATOR)))  +">"+ xLOCATOR+;
	   IIF(xmode='CW',;
	   " <RST_SENT:3>"+xsurst+" <RST_RCVD:3>"+xmirst ,;
	   " <RST_SENT:2>"+xsurst+" <RST_RCVD:2>"+xmirst ) +;
       " <EOR>"
   &RRR
   \
   SELECT LOGEA5WA
   *REPLACE LOTW WITH '2'
ENDSCAN
SELECT LOGEA5WA
SET FILTER TO
SET TEXT TO
SET CONSOLE ON

WAIT WINDOW 'FIN DE EXPORTACION'
