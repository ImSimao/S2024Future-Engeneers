



setfreq m32


inici:

low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3


'debug

if w1>224 and w1<294 and w2>429 and w2<509 and w3>92 and w3<141 then laranja_in

if w1>17 and w1<77 and w2>288 and w2<349 and w3>40 and w3<100 then azul_in

if w1<1000 and w2<1000 and w3<1000 then inici

goto inici




laranja_in:
high 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
pause 500  'tempo de passar em cima da cor
low 5
goto pergunta 



azul_in:
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
pause 500  'tempo de passar em cima da cor
low c.1
goto pergunta


'#########################################################################

'################################################################################



pergunta:
if pinc.0=0 then relogio       'laranja
if pinc.0=1 then anti_relogio    'azul




relogio:
high 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
high c.1   'informa��o  azul para placa m�e no pino c.2 'lede verde
pause 40000 
low c.1 
low 5
goto inicio11




anti_relogio:
high 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
high c.1   'informa��o  azul para placa m�e no pino c.2 'lede verde
pause 40000 
low c.1 
low 5
goto inicio




'#########################################################################
'#########################################################################�############
'################################################################################
'#########################################################################
'#########################################################################�############
'################################################################################
'#########################################################################
'#########################################################################�############
'################################################################################


inicio:     '�NTI REL�GIO

low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3

'debug


if w1>224 and w1<294 and w2>429 and w2<509 and w3>92 and w3<141 then laranja

if w1>17 and w1<77 and w2>288 and w2<349 and w3>40 and w3<100 then azul

if w1<1000 and w2<1000 and w3<1000 then inicio


goto inicio




laranja:
high 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
pause 2000  'tempo de passar em cima da cor
low 5
goto inicio 




azul:
let b0=b0+1
if b0=7  then informa   'anti rel�gio
'if b0<12 then contar_1
goto contar_1


contar_1:
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
'low 3    'informa��o para placa n�e no alterar ascores  pino b,1 'luz amarelo
'high 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
'high 2    'rel� de parar
pause 40000   'tempo de passar em cima da cor
low c.1
'low 3
low 5
low 2
goto inicio


informa:     'anti rel�gio
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
high 3    'informa��o para placa n�e no pino b,1 'luz amarelo 2 voltas
'high 5    'informa��o para placa n�e no pino b,2 'luz vermelho
'high 2     'rel� de parar
pause 6000   'tempo de passar em cima da cor
'low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto inicio2








'#########################################################################
'#########################################################################�############
'################################################################################
'#########################################################################
'#########################################################################�############
'################################################################################
'#########################################################################
'#########################################################################�############
'################################################################################
'#########################################################################
'#########################################################################�############
'################################################################################


inicio11:     'REL�GIO

low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3

'debug


if w1>224 and w1<294 and w2>429 and w2<509 and w3>92 and w3<141 then laranja_11

if w1>17 and w1<77 and w2>288 and w2<349 and w3>40 and w3<100 then azul_11

if w1<1000 and w2<1000 and w3<1000 then inicio11

goto inicio11




azul_11:
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
pause 2000  'tempo de passar em cima da cor
low c.1
goto inicio11 




laranja_11:
let b0=b0+1
if b0=7  then informa_11
'if b0<12 then contar_1
goto contar_11


contar_11:
'high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
'low 3    'informa��o para placa n�e no alterar ascores  pino b,1 'luz amarelo
high 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
'high 2    'rel� de parar
pause 30000   'tempo de passar em cima da cor
low c.1
'low 3
low 5
low 2
goto inicio11


informa_11:
'high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
high 3    'informa��o para placa n�e no pino b,1 'luz amarelo 2 voltas
high 5    'informa��o para placa n�e no pino b,2 'luz vermelho
'high 2     'rel� de parar
pause 6000   'tempo de passar em cima da cor
'low c.1
low 3                                        'desliga o led amarelo
'low 5
low 2
goto inicio22





'#########################################################################
'#########################################################################�############
'################################################################################


'#########################################################################
'#########################################################################�############
'################################################################################




inicio2:
if pinc.0=0 then parar_no_azul_1
if pinc.0=1 then parar_no_laranja_1



inicio22:
if pinc.0=0 then parar_no_laranja_11
if pinc.0=1 then parar_no_azul_11


'#########################################################################�############
'################################################################################

  'vem do anti rel�gio

parar_no_azul_1:
let b1=0
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
low 3    'informa��o para placa n�e no pino b,1 'luz amarelo 2 voltas
low 5    'informa��o para placa n�e no pino b,2 'luz vermelho
'high 2     'rel� de parar
pause 20000   'tempo de passar em cima da cor
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto parar_no_azul


parar_no_laranja_1:
let b1=1
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
low 3    'informa��o para placa n�e no pino b,1 'luz amarelo 2 voltas
low 5    'informa��o para placa n�e no pino b,2 'luz vermelho
'high 2     'rel� de parar
pause 20000   'tempo de passar em cima da cor
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto parar_no_laranja


'#########################################################################�############
'################################################################################

 'vem do rel�gio
 
 
parar_no_laranja_11:
let b1=0
low c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
low 3    'informa��o para placa n�e no pino b,1 'luz amarelo 2 voltas
high 5    'informa��o para placa n�e no pino b,2 'luz vermelho
'high 2     'rel� de parar
pause 20000   'tempo de passar em cima da cor
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto parar_no_laranja

parar_no_azul_11:
let b1=1
low c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
low 3    'informa��o para placa n�e no pino b,1 'luz amarelo 2 voltas
high 5    'informa��o para placa n�e no pino b,2 'luz vermelho
'high 2     'rel� de parar
pause 20000   'tempo de passar em cima da cor
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto parar_no_azul




'#########################################################################�############
'################################################################################



parar_no_laranja:
low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3



if w1>224 and w1<294 and w2>429 and w2<509 and w3>92 and w3<141 then laranja_2

if w1>17 and w1<77 and w2>288 and w2<349 and w3>40 and w3<100 then azul_2

if w1<1000 and w2<1000 and w3<1000 then parar_no_laranja


goto parar_no_laranja




azul_2:
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
pause 3000  'tempo de passar em cima da cor
low c.1
goto parar_no_laranja 




laranja_2:
if B1=0 then laranja_2a
if B1=1 then laranja_2b



laranja_2a:
let b1=b1+1
if b1=4  then parar_laranja
'if b0<12 then contar_1
goto contar_2


laranja_2b:
let b1=b1+1
if b1=3  then parar_laranja
'if b0<12 then contar_1
goto contar_2


contar_2:
low c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
'low 3    'informa��o para placa n�e no alterar ascores  pino b,1 'luz amarelo
high 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
'high 2    'rel� de parar
pause 50000   'tempo de passar em cima da cor
'low 3
low 5
low 2
goto parar_no_laranja

parar_laranja:
'low 3    'informa��o para placa n�e no alterar ascores  pino b,1 'luz amarelo
high 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
'high 2    'rel� de parar
pause 3000   'tempo de passar em cima da cor
'low 3
low 5
low 2
goto parar_final_azul


'#########################################################################
'#########################################################################

parar_final_azul:
low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3



'if w1>224 and w1<294 and w2>429 and w2<509 and w3>92 and w3<141 then laranja

if w1>17 and w1<77 and w2>288 and w2<349 and w3>40 and w3<100 then parar 'azul_final

if w1<1000 and w2<1000 and w3<1000 then parar_final_azul
goto parar_final_azul






'#########################################################################
'#########################################################################�############
'################################################################################





parar_no_azul:
low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3


if w1>224 and w1<294 and w2>429 and w2<509 and w3>92 and w3<141 then laranja_3

if w1>17 and w1<77 and w2>288 and w2<349 and w3>40 and w3<100 then azul_3

if w1<1000 and w2<1000 and w3<1000 then parar_no_azul

goto parar_no_azul




laranja_3:
high 5 'informa��o para placa n�e no pino b,2 'luz vermelho
pause 3000  'tempo de passar em cima da cor
low 5
goto parar_no_azul



azul_3:
if B1=0 then azul_2a
if B1=1 then azul_2b


azul_2a:
let b1=b1+1
if b1=4 then parar_azul
'if b1<10 then contar_2
goto contar_3


azul_2b:
let b1=b1+1
if b1=3 then parar_azul
'if b1<10 then contar_2
goto contar_3


contar_3:
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
'low 3    'informa��o para placa n�e no alterar ascores  pino b,1 'luz amarelo
'low 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
'high 2    'rel� de parar
pause 50000   'tempo de passar em cima da cor
low c.1 
'low 3
low 5
low 2
goto parar_no_azul

parar_azul:
high c.1 'informa��o  azul para placa m�e no pino c.2 'lede verde
'low 3    'informa��o para placa n�e no alterar ascores  pino b,1 'luz amarelo
'low 5    'informa��o  laranja para placa n�e no pino b,2 'luz vermelho
'high 2    'rel� de parar
pause 3000   'tempo de passar em cima da cor
low c.1 
'low 3
low 5
low 2
goto parar_final_laranja


'#########################################################################
'#########################################################################

parar_final_laranja:
low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3



if w1>224 and w1<294 and w2>429 and w2<509 and w3>92 and w3<141 then parar 'laranja_final

'if w1>17 and w1<77 and w2>288 and w2<349 and w3>40 and w3<100 then azul

if w1<1000 and w2<1000 and w3<1000 then parar_final_laranja

goto parar_final_laranja

'#########################################################################
'#########################################################################�############
'################################################################################
'#########################################################################�############
'################################################################################





parar: 'PARAR
high c.1 ' led azul
high 5   'led vermelho
low 2     
pause 25000 ' TEMPO A AJUSTAR ANTES DE PARAR     !!!!!!!!!!!(m�ximo 60000)
high 2       'rel� de parar
low c.1
low 5
pause 10000
end



















  