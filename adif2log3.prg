CLOS DATA
SET DATE ITALIAN
CLEAR
USE ADI
SELECT 0
USE LOGADF EXCLU
ZAP

fimporta= getfile()
SELECT adi
APPEND FROM (fimporta) sdf
scan
m.tira= ALLTRIM(UPPER(tira))

*'FOR jjj=1 TO LEN(m.tira)
	II=0
	DO WHILE  ii<= LEN(ALLTR(m.tira))
	   ii=ii+1
	    car= SUBSTR(m.tira,ii,1)
*wait window car
		* nuevo campo
		IF car='<'
		
		   * nombre del campo
		   fin=0
		   campo=''
		   DO WHILE car#':' and car#'>' and fin<100
			  ii=ii+1
	          car= SUBSTR(m.tira,ii,1)
		      fin= fin+1
		      IF car #':' AND ASC(CAR)>=32
	             campo=campo +car
	          ENDIF
*wait window campo
		   ENDDO
		
		   IF campo#'EOR'
			   * avanzo hasta el siguiente '>'
			   fin=0
			   DO WHILE car#'>' and fin<100
			      fin= fin+1
			      ii=ii+1
		          car= SUBSTR(m.tira,ii,1)
			   ENDDO		   
			
			   * CONTENIDO
			   contenido=''
			   fin=0
			   DO WHILE car#'<' and fin<300
			      fin= fin+1
			      ii=ii+1
		          car= SUBSTR(m.tira,ii,1)
		          IF car#'<'  AND ASC(CAR)>=32
		             contenido = contenido +car
		          ENDIF
			   ENDDO
			   ii=ii-1


			   * Grabando campos importados
			   DO CASE
			      CASE campo='CALL'
			           SELECT LOGADF
			           APPEND blank
			           REPLACE call  WITH contenido
			      CASE campo='QSO_DATE'
			           SELECT LOGADF
			           REPLACE fecha WITH CTOD(;
			                              SUBSTR(contenido, 7,2)+'-'+;
			                              SUBSTR(contenido, 5,2)+'-'+; 
			                              SUBSTR(contenido, 1,4) ) 
			      CASE campo='TIME_ON'
			           SELECT LOGADF
			           REPLACE hora  WITH SUBSTR(contenido, 1,2)+':'+;
			                              SUBSTR(contenido, 3,2) 
			      CASE campo='BAND'
			           SELECT LOGADF
			           DO CASE
			              case contenido='160M'
			                   REPLACE banda WITH 1.8
			              case contenido='80M'
			                   REPLACE banda WITH 3.5
			              case contenido='40M'
			                   REPLACE banda WITH 7
			              case contenido='20M'
			                   REPLACE banda WITH 14
			              case contenido='15M'
			                   REPLACE banda WITH 21
			              case contenido='10M'
			                   REPLACE banda WITH 28
			           ENDCASE

			      CASE campo='MODE'
			           SELECT LOGADF
			           REPLACE modo  WITH contenido

			      CASE campo='RST_RCVD'
			           SELECT LOGADF
			           REPLACE surst  WITH VAL(contenido)
			           
			      CASE campo='RST_SENT'
			           SELECT LOGADF
			           REPLACE mirst  WITH VAL(contenido)
			           
			      CASE campo='CONTEST_ID'
			           SELECT LOGADF
			           REPLACE COMENTARIO  WITH contenido
			           
			      CASE campo='COMMENT'
			           SELECT LOGADF
			           REPLACE COMENTARIO  WITH ALLTR(comentario)+' '+contenido
			      CASE campo='SRX'
			           SELECT LOGADF
			           REPLACE TESTRX  WITH ALLTR(contenido)
			      CASE campo='STX'
			           SELECT LOGADF
			           REPLACE TESTTX  WITH ALLTR(contenido)
			      CASE campo='FREQ'
			           SELECT LOGADF
			           REPLACE FREQ  WITH ALLTR(contenido)
			      CASE campo='GRIDSQUARE'
			           SELECT LOGADF
			           REPLACE LOCATOR  WITH ALLTR(contenido)
			            
			   ENDCASE
			ELSE
			   ? LOGADF.CALL
			   
			ENDIF		
		ENDIF && campo
					
	ENDDO
*'NEXT
ENDSCAN