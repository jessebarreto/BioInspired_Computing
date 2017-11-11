function Gerador_Amostras(varargin)
% GERADOR_AMOSTRAS MATLAB code for Gerador_Amostras.fig
%      GERADOR_AMOSTRAS, by itself, creates a new GERADOR_AMOSTRAS or raises the existing
%      singleton*.
%
%      H = GERADOR_AMOSTRAS returns the handle to a new GERADOR_AMOSTRAS or the handle to
%      the existing singleton*.
%
%      GERADOR_AMOSTRAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GERADOR_AMOSTRAS.M with the given input arguments.
%
%      GERADOR_AMOSTRAS('Property','Value',...) creates a new GERADOR_AMOSTRAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gerador_Amostras_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gerador_Amostras_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gerador_Amostras

% Last Modified by GUIDE v2.5 09-May-2017 12:01:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gerador_Amostras_OpeningFcn, ...
                   'gui_OutputFcn',  @Gerador_Amostras_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT


% --- Executes just before Gerador_Amostras is made visible.
function Gerador_Amostras_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gerador_Amostras (see VARARGIN)
set(handles.distribuicao,'UserData',1);

set(handles.nr_amostras,'string','32','UserData',32);
set(handles.media,'string','0.0','UserData',0);
set(handles.dv_padrao,'string','1.0','UserData',1);

set(handles.nr_amostras_c,'string','32','UserData',32);
set(handles.gama_c,'string','0.0','UserData',0); %Alfa na equação
set(handles.beta_c,'string','1.0','UserData',1);

set(handles.nr_amostras_l,'string','32','UserData',32);
set(handles.mi,'string','0.0','UserData',0); %Alfa na equação
set(handles.alfa,'string','1.0','UserData',1);

set(handles.nr_amostras_u,'string','32','UserData',32);
set(handles.lim_inf,'string','0.0','UserData',0); %Alfa na equação
set(handles.lim_sup,'string','1.0','UserData',1);
% Choose default command line output for Gerador_Amostras
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gerador_Amostras wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gerador_Amostras_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in distribuicao.
function distribuicao_Callback(hObject, eventdata, handles)
% hObject    handle to distribuicao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'Value');
set(handles.distribuicao,'UserData', val);
% Hints: contents = cellstr(get(hObject,'String')) returns distribuicao contents as cell array
%        contents{get(hObject,'Value')} returns selected item from distribuicao

if (val == 1)
    set(handles.uipanel_cauchy,'visible','off')  
    set(handles.uipanel_levy,'visible','off')  
    set(handles.uipanel_unif,'visible','off')
    set(handles.uipanel_normal,'visible','on')  

elseif (val == 2)
    set(handles.uipanel_normal,'visible','off')  
    set(handles.uipanel_levy,'visible','off')
    set(handles.uipanel_unif,'visible','off')
    set(handles.uipanel_cauchy,'visible','on')  
    set(handles.uipanel_cauchy,'position',get(handles.uipanel_normal,'position'))  
    
elseif (val == 3)
    set(handles.uipanel_normal,'visible','off')  
    set(handles.uipanel_cauchy,'visible','off')
    set(handles.uipanel_unif,'visible','off')
    set(handles.uipanel_levy,'visible','on')  
    set(handles.uipanel_levy,'position',get(handles.uipanel_normal,'position'))  

elseif (val == 4)
    set(handles.uipanel_normal,'visible','off')  
    set(handles.uipanel_cauchy,'visible','off')  
    set(handles.uipanel_levy,'visible','off')  
    set(handles.uipanel_unif,'visible','on')  
    set(handles.uipanel_unif,'position',get(handles.uipanel_normal,'position'))
    
end


% --- Executes during object creation, after setting all properties.
function distribuicao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distribuicao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nr_amostras_Callback(hObject, eventdata, handles)
% hObject    handle to nr_amostras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nr_amostras as text
%        str2double(get(hObject,'String')) returns contents of nr_amostras as a double


% --- Executes during object creation, after setting all properties.
function nr_amostras_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nr_amostras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function media_Callback(hObject, eventdata, handles)
% hObject    handle to media (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of media as text
%        str2double(get(hObject,'String')) returns contents of media as a double


% --- Executes during object creation, after setting all properties.
function media_CreateFcn(hObject, eventdata, handles)
% hObject    handle to media (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dv_padrao_Callback(hObject, eventdata, handles)
% hObject    handle to dv_padrao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dv_padrao as text
%        str2double(get(hObject,'String')) returns contents of dv_padrao as a double


% --- Executes during object creation, after setting all properties.
function dv_padrao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dv_padrao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tipo_amostra = get(handles.distribuicao,'UserData');


if tipo_amostra == 1
    media = str2double(get(handles.media,'String'));
    dv_padrao = str2double(get(handles.dv_padrao,'String'));
    qt_amostras = str2double(get(handles.nr_amostras,'String'));
    %x = zeros(qt_amostras,1);               %Inicializa a variável x
    x_normal = media + dv_padrao*randn(qt_amostras,1)
    str_name = ['normal_dist_' 'media_' get(handles.media,'String') '_dv_' get(handles.dv_padrao,'String') '.mat'];
    save(str_name,'x_normal')
elseif tipo_amostra == 2
    n = str2double(get(handles.nr_amostras_c,'String'));
    gama = str2double(get(handles.gama_c,'String'));
    beta = str2double(get(handles.beta_c,'String'));
    u = rand(n,1);
    cauchy = zeros(n,1);
    for i = 1:n
        cauchy(i,1) = beta*tan(pi*(u(i,1)-0.5))+ gama
    end
    str_name = ['cauchy_dist_' 'gama_' get(handles.gama_c,'String') '_beta_' get(handles.dv_padrao,'String') '.mat'];
    save(str_name,'cauchy')
elseif tipo_amostra == 3
    disp('Implementação em andamento!')
elseif tipo_amostra == 4    
    n = str2double(get(handles.nr_amostras_c,'String'));
    inf = str2double(get(handles.lim_inf,'String'));
    sup = str2double(get(handles.lim_sup,'String'));
    uniforme = inf + (sup-inf)*rand(n,1)
    str_name = ['uniform_dist_' 'inf_' get(handles.lim_inf,'String') '_sup_' get(handles.lim_sup,'String') '.mat'];
    save(str_name,'uniforme')    
end

function nr_amostras_c_Callback(hObject, eventdata, handles)
% hObject    handle to nr_amostras_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nr_amostras_c as text
%        str2double(get(hObject,'String')) returns contents of nr_amostras_c as a double


% --- Executes during object creation, after setting all properties.
function nr_amostras_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nr_amostras_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gama_c_Callback(hObject, eventdata, handles)
% hObject    handle to gama_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gama_c as text
%        str2double(get(hObject,'String')) returns contents of gama_c as a double


% --- Executes during object creation, after setting all properties.
function gama_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gama_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_c_Callback(hObject, eventdata, handles)
% hObject    handle to beta_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta_c as text
%        str2double(get(hObject,'String')) returns contents of beta_c as a double


% --- Executes during object creation, after setting all properties.
function beta_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nr_amostras_l_Callback(hObject, eventdata, handles)
% hObject    handle to nr_amostras_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nr_amostras_l as text
%        str2double(get(hObject,'String')) returns contents of nr_amostras_l as a double


% --- Executes during object creation, after setting all properties.
function nr_amostras_l_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nr_amostras_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mi_Callback(hObject, eventdata, handles)
% hObject    handle to mi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mi as text
%        str2double(get(hObject,'String')) returns contents of mi as a double


% --- Executes during object creation, after setting all properties.
function mi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alfa_Callback(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alfa as text
%        str2double(get(hObject,'String')) returns contents of alfa as a double


% --- Executes during object creation, after setting all properties.
function alfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nr_amostras_u_Callback(hObject, eventdata, handles)
% hObject    handle to nr_amostras_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nr_amostras_u as text
%        str2double(get(hObject,'String')) returns contents of nr_amostras_u as a double


% --- Executes during object creation, after setting all properties.
function nr_amostras_u_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nr_amostras_u (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lim_inf_Callback(hObject, eventdata, handles)
% hObject    handle to lim_inf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lim_inf as text
%        str2double(get(hObject,'String')) returns contents of lim_inf as a double


% --- Executes during object creation, after setting all properties.
function lim_inf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lim_inf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lim_sup_Callback(hObject, eventdata, handles)
% hObject    handle to lim_sup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lim_sup as text
%        str2double(get(hObject,'String')) returns contents of lim_sup as a double


% --- Executes during object creation, after setting all properties.
function lim_sup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lim_sup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
