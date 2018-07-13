function varargout = Recognition(varargin)
% RECOGNITION MATLAB code for Recognition.fig
%      RECOGNITION, by itself, creates a new RECOGNITION or raises the existing
%      singleton*.
%
%      H = RECOGNITION returns the handle to a new RECOGNITION or the handle to
%      the existing singleton*.
%
%      RECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOGNITION.M with the given input arguments.
%
%      RECOGNITION('Property','Value',...) creates a new RECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Recognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Recognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Recognition

% Last Modified by GUIDE v2.5 11-Apr-2016 14:47:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Recognition_OpeningFcn, ...
                   'gui_OutputFcn',  @Recognition_OutputFcn, ...
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


% --- Executes just before Recognition is made visible.
function Recognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Recognition (see VARARGIN)

% Choose default command line output for Recognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Recognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Recognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Recognize.
function Recognize_Callback(hObject, eventdata, handles)
% hObject    handle to Recognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global If

if isempty(If)
    errordlg('Please choose Face Image');
else
    Person = Recognize_Person(If);
    set(handles.text2,'String',Person);
end

% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.figure1);
Main_GUI;

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all;

% --- Executes on button press in Palm.
function Palm_Callback(hObject, eventdata, handles)
% hObject    handle to Palm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global Ip
% 
% [fn,fp] = uigetfile('*.bmp','Select Palm Image');
% impath = [fp,fn];
% 
% Ip = imread(impath);
% 
% axes(handles.axes2)
% imshow(Ip);
% title('Input Palm Image');

% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global If
% 
% [fn,fp] = uigetfile('*.pgm','Select Palm Image');
% impath = [fp,fn];
% 
% If = imread(impath);
% 
% axes(handles.axes1)
% imshow(If);
% title('Input Face Image');

% --- Executes on button press in Face.
function Face_Callback(hObject, eventdata, handles)
% hObject    handle to Face (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global If

% if get(handles.radiobutton1,'Value')==1
    
    [fn,fp] = uigetfile('*.pgm','Select Palm Image');
    impath = [fp,fn];

    If = imread(impath);
    
% elseif get(handles.radiobutton2,'Value')==1
    
%     delete(imaqfind);
%     
%     facedetector = vision.CascadeObjectDetector();
%     
%     vid = videoinput('winvideo');
%     
%     vid.FramesPerTrigger = 1;
%     vid.ReturnedColorSpace = 'rgb';
%     
%     start(vid);
%     
%     If = getdata(vid);
%     
%     bbox = facedetector.step(If);
%     
%     if ~isempty(bbox)
%         
%         If = imcrop(rgb2gray(If),bbox);
%         
%         axes(handles.axes1)
%         imshow(If);
%         title('Input Face Image');
% 
%     else
%         
%         axes(handles.axes1)
%         imshow(If);
%         title('Input Face Image');
% 
%         warndlg(['Face could not be detected, May lead to wrong output']);
%     
%     end
%     
% end

% axes(handles.axes1)
imshow(If);
title('Input Face Image');
