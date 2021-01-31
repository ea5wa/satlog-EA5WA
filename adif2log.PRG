CLOS DATA
SET DATE ITALIAN
CLEA
USE LOGADF EXCLU
ZAP

fimporta= getfile()

create cursor adf( tira c(250))

APPEND FROM &fimporta SDF
replace ALL tira WITH UPPER(tira)

DELETE ALL FOR !'<CALL' $ UPPER(tira)
GO TOP
set dele on
set escape on
SCAN 
	SELECT LOGADF
	APPEND BLANK
	* evalúa un registro. caracter a caracter
	II=0
	SELECT adf
	DO WHILE  ii<= LEN(ALLTR(tira))
	   ii=ii+1
	    car= SUBSTR(tira,ii,1)
*wait window car
		* nuevo campo
		IF car='<'
		
		   * nombre del campo
		   fin=0
		   campo=''
		   DO WHILE car#':' and car#'>' and fin<100
			  ii=ii+1
	          car= SUBSTR(tira,ii,1)
		      fin= fin+1
		      IF car #':'
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
		          car= SUBSTR(tira,ii,1)
			   ENDDO		   
			
			   * CONTENIDO
			   contenido=''
			   fin=0
			   DO WHILE car#'<' and fin<300
			      fin= fin+1
			      ii=ii+1
		          car= SUBSTR(tira,ii,1)
		          IF car#'<'
		             contenido = contenido +car
		          ENDIF
			   ENDDO
			   ii=ii-1


			   * Grabando campos importados
			   DO CASE
			      CASE campo='CALL'
			           SELECT LOGADF
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
			            
			   ENDCASE
			   SELECT ADF
			ELSE
			   ? LOGADF.CALL
			   
			ENDIF		
		ENDIF && campo
					
	ENDDO
ENDSCAN