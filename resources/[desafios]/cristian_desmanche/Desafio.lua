[O QUE FAZER]
Criar um desmanche que:
  - Não permita motos;
  - Não permita desmanchar dentro do carro;
  - Abra as portas do carro quando se pressiona E
  - Criar um texto em um porta (uma de cada vez, etapa por etapa)
  - Quando se pressiona E próximo a porta, agacha-se e depois de 5 segundos, levanta-se e a porta do carro sai e uma nova porta é criada e atachada na sua mão, seguida de uma animação
  - Um novo texto aparece e você precisa levar a porta até esse local e quando se pressiona E nele, a porta some e uma nova porta pede para ser removida;
  - Quando terminam as portas, o carro é deletado e avisa-se que o desmanche terminou;



[DADOS E INFORMAÇÕES]
[Localização do marker]
-1952.0517578125, 3306.4626464844, 32.960231781006
[Localização de onde se coloca as portas]
-1954.8822021484, 3301.7270507813, 32.960235595703
[Nome dos ossos das portas]
Dica: Você precisará pesquisar a respeito de ossos, como por exemplo, como localizar as coordenadas de ossos de veículos...
door_dside_f
door_pside_f
door_dside_r
door_pside_r
[Animação de agachar para pegar porta]
Dict: "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
Anim: "machinic_loop_mechandplayer"
[Animação de segurar porta]
Dict: "anim@heists@box_carry@"
Anim: "idle"
[Osso que a porta se atacha no ped]
28422
[Função que usei para criar um texto 3d]
function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.39, 0.39)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 235)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 270
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.04, 0, 0, 0, 145)
end
