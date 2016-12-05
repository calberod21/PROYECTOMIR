function varargout = GUI_UNIAJC_MIR(varargin)
% GUI_UNIAJC_MIR MATLAB code for GUI_UNIAJC_MIR.fig
%      GUI_UNIAJC_MIR, by itself, creates a new GUI_UNIAJC_MIR or raises the existing
%      singleton*.
%
%      H = GUI_UNIAJC_MIR returns the handle to a new GUI_UNIAJC_MIR or the handle to
%      the existing singleton*.
%
%      GUI_UNIAJC_MIR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_UNIAJC_MIR.M with the given input arguments.
%
%      GUI_UNIAJC_MIR('Property','Value',...) creates a new GUI_UNIAJC_MIR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_UNIAJC_MIR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_UNIAJC_MIR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_UNIAJC_MIR

% Last Modified by GUIDE v2.5 23-Nov-2016 12:23:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_UNIAJC_MIR_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_UNIAJC_MIR_OutputFcn, ...
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


% --- Executes just before GUI_UNIAJC_MIR is made visible.
function GUI_UNIAJC_MIR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_UNIAJC_MIR (see VARARGIN)

% Choose default command line output for GUI_UNIAJC_MIR
handles.output = hObject;
clc;
addpath(genpath('Resources'));
addpath(genpath('MIRLib'));
rutaLogoPrincipal = 'logoPrincipal.png';
axes(handles.EjeLogo);
imshow(imread(rutaLogoPrincipal));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_UNIAJC_MIR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_UNIAJC_MIR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in botonTonal.
function botonTonal_Callback(hObject, eventdata, handles)
% hObject    handle to botonTonal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
addpath(genpath('GUI_TONAL'));
Comando = 'GUI_TONAL';
eval(Comando);

% --- Executes on button press in botonAcordes.
function botonAcordes_Callback(hObject, eventdata, handles)
% hObject    handle to botonAcordes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in botonBeatTracking.
function botonBeatTracking_Callback(hObject, eventdata, handles)
% hObject    handle to botonBeatTracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
addpath(genpath('GUI_BEATTRACKING'));
Comando = 'GUI_BEATTRACKING';
eval(Comando);
% --- Executes on button press in botonMelodico.
function botonMelodico_Callback(hObject, eventdata, handles)
% hObject    handle to botonMelodico (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in botonAyuda.
function botonAyuda_Callback(hObject, eventdata, handles)
% hObject    handle to botonAyuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('https://github.com/calberod21/PROYECTOMIR');

% --- Executes on button press in botonSalir.
function botonSalir_Callback(hObject, eventdata, handles)
% hObject    handle to botonSalir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --- Executes during object creation, after setting all properties.
function botonAyuda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonAyuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Help.png', 'png'), 0.2));


% --- Executes during object creation, after setting all properties.
function botonSalir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonSalir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('Exit.png', 'png'), 0.2));


% --- Executes during object creation, after setting all properties.
function botonTonal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonTonal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('tonalLogo.png', 'png'), 0.1));


% --- Executes during object creation, after setting all properties.
function botonBeatTracking_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonBeatTracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('beatLogo.png', 'png'), 0.15));


% --- Executes during object creation, after setting all properties.
function botonAcordes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonAcordes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('chordLogo.png', 'png'), 0.2));


% --- Executes during object creation, after setting all properties.
function botonMelodico_CreateFcn(hObject, eventdata, handles)
% hObject    handle to botonMelodico (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject, 'CData', imresize(imread('melodyLogo.png', 'png'), 0.2));
