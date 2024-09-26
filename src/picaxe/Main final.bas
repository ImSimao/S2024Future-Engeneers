'no sharp a 400 o robot está mais perto do objeto que a 200
'no sonar a 400 o robot está mais longe do objeto que a 200



#no_data
#no_table

b30=22

inicio:
low c.3              'led testes
serout c.5, N2400,(00)
servo 0, 125             '120
pause 100
goto primeira_parte




'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################




primeira_parte:

if pinb.3=0 and pinb.2=0 then frente_primeira_vez           'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 and pinb.2=0 then informa_rgb_ar                'AZUL
if pinb.3=0 and pinb.2=1 then informa_rgb_r                 'LARANJA



informa_rgb_ar:
high c.2                        'envia informação do inverter a marcha para a placa do RGB
gosub parado_return
pause 200
low c.2
goto anti_relogio



informa_rgb_r:
low c.2                         'envia informação do inverter a marcha para a placa do RGB
gosub parado_return
pause 200
low c.2
goto relogio



frente_primeira_vez:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores  
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores



seguir_parede:


readadc10 0, w4  'esquerda
readadc10 1, w5  'frente
readadc10 2, w6  'direita


if w4<420 and w5<100 and w6<420 then frente
if w4>420 and w5<100 and w6>420 then frente
if w4>420 and w5>100 and w6>420 then frente
if w4>420 and w5<100 and w6<420 then direita
if w4<420 and w5>100 and w6<420 then frente
if w4<420 and w5<100 and w6>420 then esquerda
if w4>420 and w5>100 and w6<420 then direita
if w4<420 and w5>100 and w6>420 then esquerda



'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################


frente:
serout c.5, N2400,(b30)
servo 0, 125                 '125 no centro
pause 1
goto primeira_parte



direita:
readadc10 1, w5  'frente

if w5<350 then direita_desvio
if w5>349 then recua_especial_dir


recua_especial_dir:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 800          
low c.1

serout c.5, N2400,(22)
servo 0, 170
pause 300
goto primeira_parte    'ciclo do contornar verde



direita_desvio:
serout c.5, N2400,(b30)
servo 0,155      
pause 1
goto primeira_parte



esquerda:
readadc10 1, w5  'frente

if w5<350 then esquerda_desvio
if w5>349 then recua_especial_esq


recua_especial_esq:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 800          
low c.1

serout c.5, N2400,(22)
servo 0, 80
pause 300
goto primeira_parte    'ciclo do contornar verde



esquerda_desvio:
serout c.5, N2400,(b30)
servo 0, 95
pause 1
goto primeira_parte



'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################


cores:
if pinb.7=1 and pinc.6=1 then seguir_parede
if pinb.7=0 and pinc.6=1 then contornar_verde
if pinb.7=1 and pinc.6=0 then contornar_vermelho
if pinb.7=0 and pinc.6=0 then seguir_parede


'###########################################################################################
'###########################################################################################
'###########################################################################################


contornar_verde:
if pinb.3=0 and pinb.2=0 then segue_cortornar_verde           'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 and pinb.2=0 then informa_rgb_ar                'AZUL
if pinb.3=0 and pinb.2=1 then informa_rgb_r                 'LARANJA


  
segue_cortornar_verde:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then verificar_verde
if pinb.4=0 and pinb.5=1 and pinb.6=0  then deviar_verde    
if pinb.4=0 and pinb.5=0 and pinb.6=1  then deviar_verde
if pinb.4=1 and pinb.5=0 and pinb.6=0  then deviar_verde



deviar_verde:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1          'sonar da frente

if w1<250 then recua_temporizada_verde 
if w1>249 then deviar_verde_3


deviar_verde_3:
serout c.5, N2400,(b30)
servo 0, 80               'vira para esquerda
pause 1
goto contornar_verde    'ciclo do contornar verde


recua_temporizada_verde:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 900          
low c.1
goto contornar_verde    'ciclo do contornar verde



verificar_verde:
for b0=1 to 70
gosub verificar_verde_3
next b0
goto frente       'vai para o inicio


verificar_verde_3:
if pinb.3=0 and pinb.2=0 then segue_verificar_verde           'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 and pinb.2=0 then informa_rgb_ar                'AZUL
if pinb.3=0 and pinb.2=1 then informa_rgb_r                 'LARANJA



segue_verificar_verde:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_pos_verde
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores    
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores 




'###########################################################################################
'###########################################################################################
'###########################################################################################



contornar_vermelho:
if pinb.3=0 and pinb.2=0 then segue_cortornar_vermelho           'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 and pinb.2=0 then informa_rgb_ar                'AZUL
if pinb.3=0 and pinb.2=1 then informa_rgb_r 



segue_cortornar_vermelho:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then verificar_vermelho
if pinb.4=0 and pinb.5=1 and pinb.6=0  then desviar_vermelho
if pinb.4=0 and pinb.5=0 and pinb.6=1  then desviar_vermelho     
if pinb.4=1 and pinb.5=0 and pinb.6=0  then desviar_vermelho



desviar_vermelho:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<250 then recua_temporizada_vermelho
if w1>249 then desviar_vermelho_3



desviar_vermelho_3:
readadc10 0, w6         'SHARP esquerda                          'testar
if w6<250 then desviar_vermelho_3_2
if w6>250 then frente


desviar_vermelho_3_2:
serout c.5, N2400,(b30)
servo 0, 150               'vira para esquerda
pause 1
goto contornar_vermelho    'ciclo do contornar vermelho


recua_temporizada_vermelho:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                      '125 no centro
pause 900
low c.1
goto contornar_vermelho    'ciclo do contornar vermelho



verificar_vermelho:
for b0=1 to 82     
gosub verificar_vermelho_3
next b0
goto frente      'vai para o inicio


verificar_vermelho_3:
if pinb.3=0 and pinb.2=0 then segue_verificar_vermelho           'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 and pinb.2=0 then informa_rgb_ar                'AZUL
if pinb.3=0 and pinb.2=1 then informa_rgb_r                 'LARANJA


segue_verificar_vermelho:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_pos_vermelho
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores     
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores 



'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################




relogio:                               'direita
if pina.3=0 then seguir_r
if pina.3=1 then estacionamento_r



seguir_r:
if pinb.1=1 then pergunta_flag_r       'pergunta led amarelo - se tem 2 voltas está ligado
if pinb.1=0 then continuar_relogio



pergunta_flag_r:
if b1=1 then inverter_marcha_r         'pergunta a FLAG b1                      c,3 é a flag
if b1=0 then continuar_relogio



continuar_relogio:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_r
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores_r
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores_r
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores_r


seguir_parede_r:
readadc10 0, w4  'esquerda
readadc10 1, w5  'frente
readadc10 2, w6  'direita



if w4<80 and w5<100 and w6<120 then frente_r
if w4>80 and w5<100 and w6>120 then frente_r
if w4>80 and w5>100 and w6>120 then frente_r
if w4>80 and w5<100 and w6<120 then direita_r
if w4<80 and w5>100 and w6<120 then confirmar_canto_r                'direita_canto_r
if w4<80 and w5<100 and w6>120 then esquerda_r
if w4>80 and w5>100 and w6<120 then direita_r
if w4<80 and w5>100 and w6>120 then esquerda_r



'###########################################################################################
'###########################################################################################
'###########################################################################################



frente_r:
serout c.5, N2400,(b30)
servo 0, 125                 '125 no centro
pause 1
goto relogio


direita_r:
readadc10 1, w5  'frente

if w5<350 then direita_desvio_r
if w5>349 then recua_especial_dir_r


recua_especial_dir_r:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 800          
low c.1

serout c.5, N2400,(22)
servo 0, 170
pause 300
goto relogio    'ciclo do contornar verde



direita_desvio_r:
serout c.5, N2400,(b30)
servo 0,155      
pause 1
goto relogio


esquerda_r:
readadc10 1, w5  'frente

if w5<350 then esquerda_desvio_r
if w5>349 then recua_especial_esq_r


recua_especial_esq_r:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 800          
low c.1

serout c.5, N2400,(22)
servo 0, 80
pause 300
goto relogio    'ciclo do contornar verde



esquerda_desvio_r:
serout c.5, N2400,(b30)
servo 0, 95
pause 1
goto relogio



confirmar_canto_r:
readadc10 2, w6        'SHARP direita

if w6<100 then direita_canto_r
if w6>100 then frente_r


direita_canto_r:
serout c.5, N2400,(25)            
servo 0,170           
pause 600
goto relogio

'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################


cores_r:

if pinb.7=1 and pinc.6=1 then relogio
if pinb.7=0 and pinc.6=1 then contornar_verde_r
if pinb.7=1 and pinc.6=0 then contornar_vermelho_r
if pinb.7=0 and pinc.6=0 then relogio



'###########################################################################################
'###########################################################################################
'###########################################################################################



contornar_verde_r: 
let b1=0                    'carregar a flag   

if pinb.4=0 and pinb.5=0 and pinb.6=0  then verificar_verde_r
if pinb.4=0 and pinb.5=1 and pinb.6=0  then deviar_verde_r     
if pinb.4=0 and pinb.5=0 and pinb.6=1  then deviar_verde_r
if pinb.4=1 and pinb.5=0 and pinb.6=0  then deviar_verde_r



deviar_verde_r:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1          'sonar da frente

if w1<250 then recua_temporizada_verde_r 
if w1>249 then deviar_verde_3_r


deviar_verde_3_r:
serout c.5, N2400,(b30)
servo 0, 80               'vira para esquerda
pause 1
goto contornar_verde_r    'ciclo do contornar verde


recua_temporizada_verde_r:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 600          
low c.1
goto contornar_verde_r    'ciclo do contornar verde



verificar_verde_r:
for b0=1 to 100
gosub verificar_verde_3_r
next b0
goto frente_r       'vai para o inicio


verificar_verde_3_r:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_pos_verde_r
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores_r
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores_r     
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores_r 



'###########################################################################################
'###########################################################################################
'###########################################################################################




contornar_vermelho_r:
let b1=1                     'carregar a flag

if pinb.4=0 and pinb.5=0 and pinb.6=0  then verificar_vermelho_r
if pinb.4=0 and pinb.5=1 and pinb.6=0  then desviar_vermelho_r
if pinb.4=0 and pinb.5=0 and pinb.6=1  then desviar_vermelho_r     
if pinb.4=1 and pinb.5=0 and pinb.6=0  then desviar_vermelho_r



desviar_vermelho_r:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<250 then recua_temporizada_vermelho_r 
if w1>249 then desviar_vermelho_3_r



desviar_vermelho_3_r:
readadc10 2, w6         'SHARP direita                          'testar
if w6<300 then desviar_vermelho_3_r2
if w6>300 then desvia_da_parede_r



desviar_vermelho_3_r2:
serout c.5, N2400,(b30)
servo 0, 150               'vira para esquerda
pause 1
goto contornar_vermelho_r    'ciclo do contornar vermelho



desvia_da_parede_r:
serout c.5, N2400,(b30)
servo 0,125                 'andar em frente
pause 1
goto  contornar_vermelho_r    'ciclo do contornar vermelho



recua_temporizada_vermelho_r:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                      '125 no centro
pause 600
low c.1
goto contornar_vermelho_r  'ciclo do contornar vermelho



verificar_vermelho_r:
for b0=1 to 100     
gosub verificar_vermelho_3_r
next b0
goto frente_r    'vai para o inicio


verificar_vermelho_3_r:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_pos_vermelho_r
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores_r
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores_r     
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores_r 




'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################


inverter_marcha_r:

high c.2                     'informa inverter a marcha para a placa do RGB 

gosub parado_return
pause 100

gosub frente_return_r
pause 1400

gosub recua_inverter_r

gosub frentecontrol_inverter_r


recua_inverter_r:
high c.1
serout c.5, N2400,(25)
servo 0, 175
pause 1700             'esquerda6
low c.1
return


frentecontrol_inverter_r:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1          'sonar da frente

if w1<250 then recua_torto_inverter_r
if w1>250 then frente_inverter_r



frente_inverter_r:
serout c.5, N2400,(25)
servo 0, 125 
pause 1            'esquerda6
goto frentecontrol_inverter_r


recua_torto_inverter_r:
high c.1
serout c.5, N2400,(25)
servo 0, 175
pause 1400             'esquerda6
low c.1
goto anti_relogio




'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################



estacionamento_r:
high c.1                    
serout c.5, N2400,(25)   
servo 0,125                    'recuar
pause 700
low c.1

serout c.5, N2400,(25)         'direita 
servo 0,70      
pause 1300
goto procura_parede_r



procura_parede_r:
for b0=1 to 256      
gosub frente_parede_r
next b0


frente_parede_r:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<200 then recua_estacionamento_r 
if w1>200 then frente_ate_parede_r 



frente_ate_parede_r:
serout c.5, N2400,(25)
servo 0,125      
pause 1
goto frente_parede_r



recua_estacionamento_r:              'recuar torto
high c.1                    
serout c.5, N2400,(21)   
servo 0,70
pause 1400          
low c.1
goto frente_contorlado_r    



frente_contorlado_r:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<500 then seguir_direita_r
if w1>500 then frente_reto_r 



frente_reto_r:
serout c.5, N2400,(25)
servo 0,125      
pause 1
goto frente_contorlado_r



seguir_direita_r:                'para ficar paralelo à parede
serout c.5, N2400,(25)
servo 0, 155
pause 1500
goto seguir_estacionamento_r



seguir_estacionamento_r:
if pinb.2=0 then seguir_estacionamento_r2           'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.2=1 then canto_laranja_r                'AZUL


canto_laranja_r:
serout c.5, N2400,(25)
servo 0, 150                 '125 no centro
pause 700
goto frente_laranja_r


frente_laranja_r:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<350 then virar_laranja_r
if w1>350 then frente_reto_laranja_r 


virar_laranja_r:
serout c.5, N2400,(25)
servo 0, 155                 '125 no centro
pause 1000
goto seguir_estacionamento_r



frente_reto_laranja_r:
serout c.5, N2400,(25)
servo 0,125      
pause 1
goto frente_laranja_r



seguir_estacionamento_r2:

if pinc.7=0 then seguir_estacionamento_ver_r
if pinc.7=1 then estacionar_final_r




seguir_estacionamento_ver_r:
readadc10 0, w4         'SHARP esquerda
pause 1

if w4<450 then esquerda_ligeiro_r 
if w4>450 and w4<550 then frente_ligeiro_r
if w4>550 then direita_ligeiro_r



direita_ligeiro_r:
serout c.5, N2400,(b30)
servo 0,155      
pause 1
goto seguir_estacionamento_r



frente_ligeiro_r:
serout c.5, N2400,(b30)
servo 0,125      
pause 1
goto seguir_estacionamento_r



esquerda_ligeiro_r:
serout c.5, N2400,(b30)
servo 0,95      
pause 1
goto seguir_estacionamento_r



estacionar_final_r:
readadc10 1, w5  'frente

if w5<450 then frente_ate_rosa_r
if w5>450 then entrar_estacionamento_r



frente_ate_rosa_r:
readadc10 0, w4         'SHARP esquerda
pause 1

if w4<450 then esquerda_final_r 
if w4>450 and w4<550 then frente_final_r
if w4>550 then direita_final_r



direita_final_r:
serout c.5, N2400,(b30)
servo 0,155      
pause 1
goto estacionar_final_r



frente_final_r:
serout c.5, N2400,(b30)
servo 0,125      
pause 1
goto estacionar_final_r



esquerda_final_r:
serout c.5, N2400,(b30)
servo 0,95      
pause 1
goto estacionar_final_r




entrar_estacionamento_r:
high c.1                    
serout c.5, N2400,(25)   
servo 0,80
pause 800          
low c.1

serout c.5, N2400,(25)
servo 0,170      
pause 600

serout c.5, N2400,(25)
servo 0,80      
pause 2900

serout c.5, N2400,(25)
servo 0,125      
pause 100

goto parar_ar



'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################





anti_relogio: 'esquerda
if pina.3=0 then seguir_ar
if pina.3=1 then estacionamento_ar



seguir_ar:
if pinb.1=1 then pergunta_flag_ar       'pergunta led amarelo - se tem 2 voltas está ligado
if pinb.1=0 then continuar_anti_relogio



pergunta_flag_ar:
if b1=1 then inverter_marcha_ar         'pergunta a FLAG b1         c,3 é a flag
if b1=0 then continuar_anti_relogio



continuar_anti_relogio:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_ar
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores_ar       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores_ar
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores_ar



seguir_parede_ar:
readadc10 0, w4  'esquerda
readadc10 1, w5  'frente
readadc10 2, w6  'direita


if w4<100 and w5<100 and w6<100 then frente_ar
if w4>100 and w5<100 and w6>100 then frente_ar
if w4>100 and w5>100 and w6>100 then frente_ar
if w4>100 and w5<100 and w6<100 then direita_ar
if w4<100 and w5>100 and w6<100 then confirmar_canto_ar
if w4<100 and w5<100 and w6>100 then esquerda_ar
if w4>100 and w5>100 and w6<100 then direita_ar
if w4<100 and w5>100 and w6>100 then esquerda_ar



'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################



frente_ar:
serout c.5, N2400,(b30)
servo 0, 125                 '125 no centro
pause 1
goto anti_relogio


direita_ar:
readadc10 1, w5  'frente

if w5<350 then direita_desvio_ar
if w5>349 then recua_especial_dir_ar


recua_especial_dir_ar:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 800          
low c.1

serout c.5, N2400,(22)
servo 0, 170
pause 300
goto anti_relogio    'ciclo do contornar verde



direita_desvio_ar:
serout c.5, N2400,(b30)
servo 0,155      
pause 1
goto anti_relogio


esquerda_ar:
readadc10 1, w5  'frente

if w5<350 then esquerda_desvio_ar
if w5>349 then recua_especial_esq_ar


recua_especial_esq_ar:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 800          
low c.1

serout c.5, N2400,(22)
servo 0, 80
pause 300
goto anti_relogio    'ciclo do contornar verde



esquerda_desvio_ar:
serout c.5, N2400,(b30)
servo 0, 95
pause 1
goto anti_relogio


confirmar_canto_ar:
readadc10 0, w4        'SHARP esquerda                          'testar
if w4<80 then esquerda_canto_ar
if w4>80 then frente_ar


esquerda_canto_ar:
serout c.5, N2400,(25)
servo 0,85
pause 500
goto anti_relogio


'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################


cores_ar:

if pinb.7=1 and pinc.6=1 then anti_relogio
if pinb.7=0 and pinc.6=1 then contornar_verde_ar
if pinb.7=1 and pinc.6=0 then contornar_vermelho_ar
if pinb.7=0 and pinc.6=0 then anti_relogio


'###########################################################################################
'###########################################################################################
'###########################################################################################



contornar_verde_ar: 
let b1=0                    'carregar a flag   

if pinb.4=0 and pinb.5=0 and pinb.6=0  then verificar_verde_ar
if pinb.4=0 and pinb.5=1 and pinb.6=0  then deviar_verde_ar     
if pinb.4=0 and pinb.5=0 and pinb.6=1  then deviar_verde_ar
if pinb.4=1 and pinb.5=0 and pinb.6=0  then deviar_verde_ar



deviar_verde_ar:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1          'sonar da frente

if w1<250 then recua_temporizada_verde_ar 
if w1>249 then deviar_verde_3_ar


deviar_verde_3_ar:
readadc10 0, w4         'SHARP esquerda                          'testar
if w4<300 then deviar_verde_3_ar2
if w4>300 then desvia_da_parede_ar



deviar_verde_3_ar2:
serout c.5, N2400,(b30)
servo 0, 90               'vira para esquerda
pause 1
goto contornar_verde_ar    'ciclo do contornar verde



desvia_da_parede_ar:
serout c.5, N2400,(b30)
servo 0,125                 'andar em frente
pause 1
goto  contornar_verde_ar    'ciclo do contornar verde



recua_temporizada_verde_ar:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                '125 no centro
pause 700          
low c.1
goto contornar_verde_ar    'ciclo do contornar verde



verificar_verde_ar:
for b0=1 to 100
gosub verificar_verde_3_ar
next b0
goto frente_ar       'vai para o inicio


verificar_verde_3_ar:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_pos_verde_ar
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores_ar
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores_ar     
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores_ar 




'###########################################################################################
'###########################################################################################
'###########################################################################################



contornar_vermelho_ar:
let b1=1                     'carregar a flag

if pinb.4=0 and pinb.5=0 and pinb.6=0  then verificar_vermelho_ar
if pinb.4=0 and pinb.5=1 and pinb.6=0  then desviar_vermelho_ar
if pinb.4=0 and pinb.5=0 and pinb.6=1  then desviar_vermelho_ar     
if pinb.4=1 and pinb.5=0 and pinb.6=0  then desviar_vermelho_ar



desviar_vermelho_ar:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<250 then recua_temporizada_vermelho_ar 
if w1>249 then desviar_vermelho_3_ar



desviar_vermelho_3_ar:
serout c.5, N2400,(b30)
servo 0,160                 'vira para direita
pause 1
goto  contornar_vermelho_ar   'ciclo do contornar vermelho



recua_temporizada_vermelho_ar:
high c.1                    
serout c.5, N2400,(22)   
servo 0,125                      '125 no centro
pause 700
low c.1
goto contornar_vermelho_ar  'ciclo do contornar vermelho



verificar_vermelho_ar:
for b0=1 to 100     
gosub verificar_vermelho_3_ar
next b0
goto frente_ar    'vai para o inicio


verificar_vermelho_3_ar:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_pos_vermelho_ar
if pinb.4=0 and pinb.5=1 and pinb.6=0  then cores_ar
if pinb.4=0 and pinb.5=0 and pinb.6=1  then cores_ar     
if pinb.4=1 and pinb.5=0 and pinb.6=0  then cores_ar 





'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################


inverter_marcha_ar:

high c.2   'informa inverter a marcha para a placa do RGB 

gosub parado_return
pause 100

gosub frente_return_ar
pause 1400

gosub recua_inverter_ar

gosub frentecontrol_inverter_ar



recua_inverter_ar:
high c.1
serout c.5, N2400,(25)
servo 0, 75
pause 1700             'esquerda6
low c.1
return



frentecontrol_inverter_ar:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<300 then recua_torto_inverter_ar 
if w1>300 then frente_inverter_ar



frente_inverter_ar:
serout c.5, N2400,(25)
servo 0, 125 
pause 1
goto frentecontrol_inverter_ar



recua_torto_inverter_ar:
high c.1
serout c.5, N2400,(25)
servo 0, 75
pause 1800             'esquerda6
low c.1
goto relogio



'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################
'###########################################################################################



estacionamento_ar:
high c.1                    
serout c.5, N2400,(25)   
servo 0,125                    'recuar
pause 700
low c.1

serout c.5, N2400,(25)         'direita 
servo 0,180      
pause 1000
goto procura_parede_ar



procura_parede_ar:
for b0=1 to 256      
gosub frente_parede_ar
next b0


frente_parede_ar:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<200 then recua_estacionamento_ar 
if w1>200 then frente_ate_parede_ar 



frente_ate_parede_ar:
serout c.5, N2400,(25)
servo 0,125      
pause 1
goto frente_parede_ar



recua_estacionamento_ar:
high c.1                    
serout c.5, N2400,(21)   
servo 0,180
pause 1500          
low c.1
goto frente_contorlado_ar    



frente_contorlado_ar:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<500 then seguir_esquerda_ar
if w1>500 then frente_reto_ar 



frente_reto_ar:
serout c.5, N2400,(25)
servo 0,125      
pause 1
goto frente_contorlado_ar



seguir_esquerda_ar:
serout c.5, N2400,(25)
servo 0, 98
pause 1300
goto seguir_estacionamento_ar



seguir_estacionamento_ar:
if pinb.3=0 then seguir_estacionamento_ar2           'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 then canto_azul_ar                'AZUL


canto_azul_ar:
serout c.5, N2400,(25)
servo 0, 95                 '125 no centro
pause 700
goto frente_azul_ar


frente_azul_ar:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                  'sonar da frente

if w1<350 then virar_azul_ar
if w1>350 then frente_reto_azul_ar 


virar_azul_ar:
serout c.5, N2400,(25)
servo 0, 95                 '125 no centro
pause 1000
goto seguir_estacionamento_ar



frente_reto_azul_ar:
serout c.5, N2400,(25)
servo 0,125      
pause 1
goto frente_azul_ar



seguir_estacionamento_ar2:            'CEGA do sonar da frente

if pinc.7=0 then seguir_estacionamento_ver_ar
if pinc.7=1 then estacionar_final_ar



seguir_estacionamento_ver_ar:
readadc10 2, w6         'SHARP direita
pause 1

if w6<450 then direita_ligeiro_ar
if w6>450 and w6<550 then frente_ligeiro_ar
if w6>550 then esquerda_ligeiro_ar



direita_ligeiro_ar:
serout c.5, N2400,(b30)
servo 0,155      
pause 1
goto seguir_estacionamento_ar



frente_ligeiro_ar:
serout c.5, N2400,(25)
servo 0,125      
pause 1
goto seguir_estacionamento_ar



esquerda_ligeiro_ar:
serout c.5, N2400,(25)
servo 0,95      
pause 1
goto seguir_estacionamento_ar



estacionar_final_ar:
readadc10 1, w5  'frente

if w5<450 then frente_ate_rosa_ar
if w5>450 then entrar_estacionamento_ar



frente_ate_rosa_ar:
readadc10 2, w6         'SHARP direita
pause 1

if w6<450 then direita_final_ar
if w6>450 and w6<550 then frente_final_ar
if w6>550 then esquerda_final_ar



direita_final_ar:
serout c.5, N2400,(b30)
servo 0,155      
pause 1
goto estacionar_final_ar



frente_final_ar:
serout c.5, N2400,(25)
servo 0,125      
pause 1
goto estacionar_final_ar



esquerda_final_ar:
serout c.5, N2400,(25)
servo 0,95      
pause 1
goto estacionar_final_ar



entrar_estacionamento_ar:
high c.1                    
serout c.5, N2400,(25)   
servo 0,180
pause 700          
low c.1

serout c.5, N2400,(25)
servo 0,80      
pause 600

serout c.5, N2400,(25)
servo 0,170      
pause 2300

serout c.5, N2400,(25)
servo 0,125      
pause 100

goto parar_ar



'###########################################################################################
'###########################################################################################



frente_return_ar:
serout c.5, N2400,(24)
servo 0, 125                 '125 no centro
pause 1
return


parar:
serout c.5, N2400,(00)
servo 0, 125             
pause 1
end


parado_return:
serout c.5, N2400,(00)
servo 0, 125             
pause 1
return


frente_return:
serout c.5, N2400,(b30)
servo 0, 125                 '125 no centro
pause 1
return


parar_ar:
serout c.5, N2400,(00)
servo 0, 125             
pause 1
end


frente_pos_verde:
serout c.5, N2400,(24)
servo 0, 125                 '125 no centro
pause 1
return



frente_pos_vermelho:
serout c.5, N2400,(24)
servo 0, 125                 '125 no centro
pause 1
return



frente_pos_verde_r:
serout c.5, N2400,(24)
servo 0, 125                 '125 no centro
pause 1
return


frente_pos_verde_ar:
serout c.5, N2400,(24)
servo 0, 125                 '125 no centro
pause 1
return




frente_pos_vermelho_r:
serout c.5, N2400,(24)
servo 0, 125                 '125 no centro
pause 1
return


frente_return_r:
serout c.5, N2400,(24)
servo 0, 125                 '125 no centro
pause 1
return

frente_pos_vermelho_ar:
serout c.5, N2400,(24)
servo 0, 125                 '125 no centro
pause 1
return
