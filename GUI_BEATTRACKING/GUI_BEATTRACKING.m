function varargout = GUI_BEATTRACKING(varargin)
% GUI_BEATTRACKING MATLAB code for GUI_BEATTRACKING.fig
%      GUI_BEATTRACKING, by itself, creates a new GUI_BEATTRACKING or raises the existing
%      singleton*.
%
%      H = GUI_BEATTRACKING returns the handle to a new GUI_BEATTRACKING or the handle to
%      the existing singleton*.
%
%      GUI_BEATTRACKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_BEATTRACKING.M with the given input arguments.
%
%      GUI_BEATTRACKING('Property','Value',...) creates a new GUI_BEATTRACKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_BEATTRACKING_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_BEATTRACKING_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_BEATTRACKING

% Last Modified by GUIDE v2.5 05-Dec-2016 12:15:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_BEATTRACKING_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_BEATTRACKING_OutputFcn, ...
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


% --- Executes just before GUI_BEATTRACKING is made visible.
function GUI_BEATTRACKING_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_BEATTRACKING (see VARARGIN)

% Choose default command line output for GUI_BEATTRACKING
handles.output = hObject;
% Choose default command line output for GUI_TONAL
handles.output = hObject;
clc;
addpath(genpath('../Resources'));
addpath(genpath('../MIRLib'));

Fs = 44100;
t = 0:1.0/Fs:10;
x = sin(Fs*t);
axes(handles.EjeSenal); plot(t,x); xlabel('Tiempo (s)'); ylabel('Amp. Normalizada'); title('Señal de Audio');
grid on;

axes(handles.EjeBeat);
plot(t, zeros(1, length(t)), 'ro'); xlabel('Tiempo (s)'); ylabel('Amp. Normalizada'); title('Beats');
grid on;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_BEATTRACKING wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_BEATTRACKING_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in botonCargar.
function botonCargar_Callback(hObject, eventdata, handles)
% hObject    handle to botonCargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.wav', 'Selecciona un archivo de Audio (WAV)');
if isequal(filename,0) || isequal(pathname,0)
    uiwait(msgbox('No se seleccionó ningun archivo de Audio','Advertencia','modal'));
else
    ruta = fullfile(pathname, filename);
    [Data, Fs] = audioread(ruta);
    InfoAudio = audioinfo(ruta);
    
    [numdata, channels] = size(Data);
    if channels > 1
        uiwait(msgbox('El audio es de tipo estéreo y será convertido a mono','Advertencia','modal'));
        signal = Data(:,1);
    else
        signal = Data;
    end
    
    set(handles.editNumeroMuestras, 'String', sprintf('%d', numdata));
    set(handles.editFrecuenciaMuestreo, 'String', sprintf('%d', Fs));
    
    set(handles.editRuta, 'String', sprintf('Ruta: %s', InfoAudio.Filename));
    set(handles.editChannels, 'String', sprintf('%d', InfoAudio.NumChannels));
    set(handles.editBitSample, 'String', sprintf('%d', InfoAudio.BitsPerSample));
    set(handles.editDuracion, 'String', sprintf('%.3f', InfoAudio.Duration));
        
    t = 0:1.0/Fs:(numdata-1)/Fs;   
    axes(handles.EjeSenal);
   
    plot(t, signal);xlabel('Tiempo (s)'); ylabel('Amp. Normalizada'); title('Señal de Audio');
    grid on;
    
    
    %axes(handles.EjeSpectrograma);
    %spectrogram(signal,128,120,128,1e3,'yaxis'); xlabel('Tiempo (s)'); ylabel('Frecuencia (Hz)');
    
    handles.Senal = signal;
    handles.FS = Fs;
    handles.LongitudSenal = numdata;
    handles.Ruta = ruta;
end

guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in botonEjecutar.
function botonEjecutar_Callback(hObject, eventdata, handles)
% hObject    handle to botonEjecutar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b=beat(handles.Senal, handles.FS);

t=0:1.0/handles.FS:(length(handles.Senal) - 1)/handles.FS;

axes(handles.EjeBeat);

plot(t, handles.Senal); xlabel('Tiempo (s)'); ylabel('Amp. Normalizada'); title('Señal de Audio (-) + Beats (o)');
hold on;
plot(b', zeros(1, length(b)), 'ro');
grid on;
handles.Beats = b';
set(handles.botonGuardar, 'Enable', 'on');
guidata(hObject, handles);

% --- Executes on button press in botonExit.
function botonExit_Callback(hObject, eventdata, handles)
% hObject    handle to botonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in botonCargar.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to botonCargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in botonGuardar.
function botonGuardar_Callback(hObject, eventdata, handles)
% hObject    handle to botonGuardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile('*.txt', 'Guardar Archivo TXT');
if isequal(filename,0) || isequal(pathname,0)
    uiwait(msgbox('No se guardó el archivo.','Advertencia','modal'));
else
    beats = handles.Beats;
    A = [beats*handles.FS, beats];
    dlmwrite(fullfile(pathname, filename), A,'delimiter','\t','precision',6);

end



% --- Executes on button press in botonHelp.
function botonHelp_Callback(hObject, eventdata, handles)
% hObject    handle to botonHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('https://github.com/calberod21/PROYECTOMIR');

% --- Executes on button press in botonExit.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to botonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in botonEjecutar.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to botonEjecutar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function editLongitudBloque_Callback(hObject, eventdata, handles)
% hObject    handle to editLongitudBloque (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLongitudBloque as text
%        str2double(get(hObject,'String')) returns contents of editLongitudBloque as a double


% --- Executes during object creation, after setting all properties.
function editLongitudBloque_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLongitudBloque (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLongitudSolape_Callback(hObject, eventdata, handles)
% hObject    handle to editLongitudSolape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLongitudSolape as text
%        str2double(get(hObject,'String')) returns contents of editLongitudSolape as a double


% --- Executes during object creation, after setting all properties.
function editLongitudSolape_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLongitudSolape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editChannels_Callback(hObject, eventdata, handles)
% hObject    handle to editChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editChannels as text
%        str2double(get(hObject,'String')) returns contents of editChannels as a double


% --- Executes during object creation, after setting all properties.
function editChannels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editChannels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBitSample_Callback(hObject, eventdata, handles)
% hObject    handle to editBitSample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBitSample as text
%        str2double(get(hObject,'String')) returns contents of editBitSample as a double


% --- Executes during object creation, after setting all properties.
function editBitSample_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBitSample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDuracion_Callback(hObject, eventdata, handles)
% hObject    handle to editDuracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDuracion as text
%        str2double(get(hObject,'String')) returns contents of editDuracion as a double


% --- Executes during object creation, after setting all properties.
function editDuracion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDuracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRuta_Callback(hObject, eventdata, handles)
% hObject    handle to editRuta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRuta as text
%        str2double(get(hObject,'String')) returns contents of editRuta as a double


% --- Executes during object creation, after setting all properties.
function editRuta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRuta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editNumeroMuestras_Callback(hObject, eventdata, handles)
% hObject    handle to editNumeroMuestras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumeroMuestras as text
%        str2double(get(hObject,'String')) returns contents of editNumeroMuestras as a double


% --- Executes during object creation, after setting all properties.
function editNumeroMuestras_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumeroMuestras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editFrecuenciaMuestreo_Callback(hObject, eventdata, handles)
% hObject    handle to editFrecuenciaMuestreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFrecuenciaMuestreo as text
%        str2double(get(hObject,'String')) returns contents of editFrecuenciaMuestreo as a double


% --- Executes during object creation, after setting all properties.
function editFrecuenciaMuestreo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFrecuenciaMuestreo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function botonExit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Exit.png', 'png'), 0.2));


% --- Executes during object creation, after setting all properties.
function botonHelp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Help.png', 'png'), 0.2));


% --- Executes during object creation, after setting all properties.
function botonGuardar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonGuardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Save.png', 'png'), 0.2));


% --- Executes during object creation, after setting all properties.
function botonEjecutar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonEjecutar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Ejecutar.png', 'png'), 0.15));
