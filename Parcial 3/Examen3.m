clc, clear all, close all

%% Inicio Graficar Nodos
% Posiciones de los nodos---------------------------------------------------
nodesCoordinates=zeros(30,2);
nodesCoordinates(1,1)=34; nodesCoordinates(1,2)=14; nodesCoordinates(2,1)=34; nodesCoordinates(2,2)=10;
nodesCoordinates(3,1)=24; nodesCoordinates(3,2)=38; nodesCoordinates(4,1)=2; nodesCoordinates(4,2)=3;
nodesCoordinates(5,1)=1; nodesCoordinates(5,2)=28; nodesCoordinates(6,1)=24; nodesCoordinates(6,2)=5;
nodesCoordinates(7,1)=32; nodesCoordinates(7,2)=25; nodesCoordinates(8,1)=3; nodesCoordinates(8,2)=3;
nodesCoordinates(9,1)=6; nodesCoordinates(9,2)=32; nodesCoordinates(10,1)=4; nodesCoordinates(10,2)=10;
nodesCoordinates(11,1)= 10;nodesCoordinates(11,2)=5; nodesCoordinates(12,1)=35; nodesCoordinates(12,2)=28;
nodesCoordinates(13,1)=30; nodesCoordinates(13,2)=27; nodesCoordinates(14,1)=21; nodesCoordinates(14,2)=14;
nodesCoordinates(15,1)=27; nodesCoordinates(15,2)=5; nodesCoordinates(16,1)=6; nodesCoordinates(16,2)=1;
nodesCoordinates(17,1)=39; nodesCoordinates(17,2)=39; nodesCoordinates(18,1)=5; nodesCoordinates(18,2)=19;
nodesCoordinates(19,1)=27; nodesCoordinates(19,2)=12; nodesCoordinates(20,1)=31; nodesCoordinates(20,2)=23;
nodesCoordinates(21,1)=18; nodesCoordinates(21,2)=11; nodesCoordinates(22,1)=31; nodesCoordinates(22,2)=36;
nodesCoordinates(23,1)=30; nodesCoordinates(23,2)=17; nodesCoordinates(24,1)=38; nodesCoordinates(24,2)=11;
nodesCoordinates(25,1)=22; nodesCoordinates(25,2)=39; nodesCoordinates(26,1)=11; nodesCoordinates(26,2)=11;
nodesCoordinates(27,1)=38; nodesCoordinates(27,2)=3; nodesCoordinates(28,1)=12; nodesCoordinates(28,2)=24;
nodesCoordinates(29,1)=9; nodesCoordinates(29,2)=26; nodesCoordinates(30,1)=32; nodesCoordinates(30,2)=21;

RC = 10; % Radio de cobertura
for i=1:length(nodesCoordinates)
    for j=1:length(nodesCoordinates)
        
        dij=sqrt( ( nodesCoordinates(i,1)-nodesCoordinates(j,1) )^2+( nodesCoordinates(i,2)-nodesCoordinates(j,2) )^2);
        if(dij<=RC) & i~=j
            
            matrLinks(i,j)=dij;
            
            line([nodesCoordinates(i,1), nodesCoordinates(j,1)], [nodesCoordinates(i,2), nodesCoordinates(j,2)],'LineStyle',':', 'Color','k', 'LineWidth',1);
            hold on;
        else
            matrLinks(i,j)=inf;
        end
        
    end
end

for i=1:length(nodesCoordinates)
    x=nodesCoordinates(i,1);
    y=nodesCoordinates(i,2);
    plot(nodesCoordinates(i,1), nodesCoordinates(i,2), 'o', 'LineWidth',1,'MarkerEdgeColor','k', 'MarkerFaceColor','k', 'MarkerSize',7);
    text(x+1, y+0.5, num2str(i), 'FontSize',8, 'FontWeight', 'bold', 'Color','k');
    title('Red Celular')
    % axis([0 110 0 60])
end

%% Fin Graficar Nodos

%% SIMULADOR DE EVENTOS DISCRETOS
% Inicializacion de variables
%Cantidad nodos
cantidadNodos= length(nodesCoordinates);
% Nodo fuente
inicio= 9;
% Nodo destino
destino= 17;

% Centinela que me permite terminar la ejecucion de la simulacion
parar = 0;

% Arreglo que contiene a los vecinos que ya se visitaron, estos despues se
% pintan de azul o rojo dependiendo si se usaron o no
ruta_vecinos =[];


% Inicializaci�n del tiempo de simulaci�n
t=0;

%Arreglo que me sirve para agregar el padre de los nodos vecinos que se
%visitan para luego mostrar la ruta que se tomo
padre = [];
actual = [];



% Programacion del evento inicial o los eventos iniciales.
evt.t= t ;
evt.type='A';
evt.value = inicio;

% Adiciono el evento inicial o los eventos iniciales a la cola de eventos.
evtQueue=evt;



% Desarrollo de la simulacion
while length(evtQueue)>0
    
    evtAct=evtQueue(1);
    
    evtQueue(1)=[];
    t=evtAct.t;
    ruta_vecinos =[ruta_vecinos inicio];
    
    %Aqui se esta pintando el nodo inicio
    plot(nodesCoordinates(inicio,1), nodesCoordinates(inicio,2), 'o', 'LineWidth',1,'MarkerEdgeColor','r', 'MarkerFaceColor','r', 'MarkerSize',7);
    
    % Procesamiento del evento A
    if evtAct.type=='A'
        
        for j =1:cantidadNodos
            
            
            if matrLinks(evtAct.value,j) < inf
                
                %Si ya llegu� al destino entonces se debe detener la
                %simulaci�n y se debe pintar el camino recorrido.
                if j == destino
                    parar =1;
                    actual = [actual j];
                    padre = [padre evtAct.value];
                elseif parar ==0 && ~any( arrayfun( @(x) isequal( j, x ), ruta_vecinos ) )
                    %for z=1:length(vecinos_visitados)
                    %if vecinos_visitados(z)~=j
                    newEvt.value = j;
                    actual = [actual j];
                    padre = [padre evtAct.value];
                    
                    %Aqu� se le a�ade el tiempo de enviar un paquete desde
                    %un nodo a otro.
                    
                    newEvt.t=t+ matrLinks(evtAct.value,j)*3.333;
                    
                    %Se crea un nuevo evento tipo A y este recorrer� sus
                    %vecinos y sus vecinos recorrer�n sus vecinos y as�
                    %sucesivamente hasta encontrar el nodo destino
                    newEvt.type='A';
                    evtQueue=[evtQueue newEvt];
                    ruta_vecinos =[ruta_vecinos j ];
                    %Se pintan los vecinos de azul. Mas tarde se pintaran
                    %de rojo los que en realidad se utilicen.
                    plot(nodesCoordinates(j,1), nodesCoordinates(j,2), 'o', 'LineWidth',1,'MarkerEdgeColor','b', 'MarkerFaceColor','b', 'MarkerSize',7);
                end
            end
        end
    end
    
    
    if parar ==1
        break;
    end
    
    % Organizacion de la cola de eventos
    flag=1;
    while flag==1
        flag=0;
        for i=1:(length(evtQueue)-1)
            if evtQueue(i).t>evtQueue(i+1).t
                temp=evtQueue(i);
                evtQueue(i)=evtQueue(i+1);
                evtQueue(i+1)=temp;
                flag=1;
            end
        end
    end
    % Mostrado de la cola de eventos:
    fprintf('\nCola de eventos:\n');
    for i=1:length(evtQueue)
        fprintf('Evento %s en t=%f\n',evtQueue(i).type,evtQueue(i).t);
    end
    fprintf('----------------\n');
    % pause;
end

fprintf('Tiempo transcurrido: %f  \n',t);
nodoEval = destino;
while nodoEval ~= inicio
    plot(nodesCoordinates(nodoEval,1), nodesCoordinates(nodoEval,2), 'o', 'LineWidth',1,'MarkerEdgeColor','r', 'MarkerFaceColor','r', 'MarkerSize',7);
    indicePadre = actual==nodoEval;
    nodoEval= padre(indicePadre);
end








