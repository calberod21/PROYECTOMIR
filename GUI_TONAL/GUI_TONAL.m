function varargout = GUI_TONAL(varargin)
% GUI_TONAL MATLAB code for GUI_TONAL.fig
%      GUI_TONAL, by itself, creates a new GUI_TONAL or raises the existing
%      singleton*.
%
%      H = GUI_TONAL returns the handle to a new GUI_TONAL or the handle to
%      the existing singleton*.
%
%      GUI_TONAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TONAL.M with the given input arguments.
%
%      GUI_TONAL('Property','Value',...) creates a new GUI_TONAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_TONAL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_TONAL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_TONAL

% Last Modified by GUIDE v2.5 23-Nov-2016 21:20:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_TONAL_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_TONAL_OutputFcn, ...
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


% --- Executes just before GUI_TONAL is made visible.
function GUI_TONAL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_TONAL (see VARARGIN)

% Choose default command line output for GUI_TONAL
handles.output = hObject;
clc;
addpath(genpath('../Resources'));
addpath(genpath('../MIRLib'));

Fs = 44100;
t = 0:1.0/Fs:10;
x = sin(Fs*t);
axes(handles.EjeSenal); plot(t,x); xlabel('Tiempo (s)'); ylabel('Amp. Normalizada'); title('Señal de Audio');

cfftlen=str2double(get(handles.editLongitudBloque, 'String'));
overlap=str2double(get(handles.editLongitudSolape, 'String'));

axes(handles.EjeSpectrograma);
NFFT = 1024;
spectrogram(x,cfftlen,overlap,NFFT,Fs,'yaxis'); xlabel('Tiempo (s)'); ylabel('Frecuencia (Hz)');

C = chromagram_IF(x, Fs, cfftlen);
tt = [1:size(C,2)]*cfftlen/4/Fs;
axes(handles.EjeCromagrama);
imagesc(tt,[1:12],20*log10(C+eps));
axis xy;
caxis(max(caxis)+[-60 0]);
title('Cromagrama');

% [cKey] = ComputeKey (x, Fs, [], cfftlen, overlap);
% set(handles.textoResultado, 'String', cKey);

% axes(handles.EjeSpectrograma);
% spectrogram(x,128,120,128,1e3,'yaxis'); xlabel('Tiempo (s)'); ylabel('Frecuencia (Hz)');
% title('Espectrograma');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_TONAL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_TONAL_OutputFcn(hObject, eventdata, handles) 
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
   
    plot(t, signal);
    
    
    %axes(handles.EjeSpectrograma);
    %spectrogram(signal,128,120,128,1e3,'yaxis'); xlabel('Tiempo (s)'); ylabel('Frecuencia (Hz)');
    
    handles.Senal = signal;
    handles.FS = Fs;
    handles.LongitudSenal = numdata;
    handles.Ruta = ruta;
end

guidata(hObject, handles);

% --- Executes on button press in botonGuardar.
function botonGuardar_Callback(hObject, eventdata, handles)
% hObject    handle to botonGuardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in botonHelp.
function botonHelp_Callback(hObject, eventdata, handles)
% hObject    handle to botonHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('https://github.com/calberod21/PROYECTOMIR');

% --- Executes on button press in botonExit.
function botonExit_Callback(hObject, eventdata, handles)
% hObject    handle to botonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --- Executes on button press in botonEjecutar.
function botonEjecutar_Callback(hObject, eventdata, handles)
% hObject    handle to botonEjecutar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cfftlen=str2double(get(handles.editLongitudBloque, 'String'));
overlap=str2double(get(handles.editLongitudSolape, 'String'));

axes(handles.EjeSpectrograma);
NFFT = 1024;
spectrogram(handles.Senal,cfftlen,overlap,NFFT,handles.FS,'yaxis'); xlabel('Tiempo (s)'); ylabel('Frecuencia (Hz)');

C = chromagram_IF(handles.Senal, handles.FS, cfftlen);
tt = [1:size(C,2)]*cfftlen/4/handles.FS;
axes(handles.EjeCromagrama);
imagesc(tt,[1:12],20*log10(C+eps));
axis xy;
caxis(max(caxis)+[-60 0]);
title('Cromagrama');

[cKey] = ComputeKey (handles.Senal, handles.FS, []);
set(handles.textoResultado, 'String', cKey);


% --- Executes during object creation, after setting all properties.
function botonHelp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Help.png', 'png'), 0.2));


% --- Executes during object creation, after setting all properties.
function botonExit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Exit.png', 'png'), 0.2));


% --- Executes during object creation, after setting all properties.
function botonEjecutar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonEjecutar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Ejecutar.png', 'png'), 0.15));


% --- Executes during object creation, after setting all properties.
function botonCargar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonCargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('AbrirAudioLogo.png', 'png'), 0.15));



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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



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


% --- Executes during object creation, after setting all properties.
function botonGuardar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonGuardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Save.png', 'png'), 0.2));
