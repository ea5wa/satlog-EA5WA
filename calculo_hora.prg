&&log.txthora.value=TIME() &&Hora EA
log.TXTHORA.VALUE= TTOC(DATETIME()-7200) &&Hora UTC Verano
&&log.TXTHORA.VALUE= STRTRAN(SUBSTR(TTOC(DATETIME()-3600),12,5),':','') &&Hora UTC Invierno