function varargout = Identification(varargin)
% IDENTIFICATION MATLAB code for Identification.fig
%      IDENTIFICATION, by itself, creates a new IDENTIFICATION or raises the existing
%      singleton*.
%
%      H = IDENTIFICATION returns the handle to a new IDENTIFICATION or the handle to
%      the existing singleton*.
%
%      IDENTIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IDENTIFICATION.M with the given input arguments.
%
%      IDENTIFICATION('Property','Value',...) creates a new IDENTIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Identification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Identification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Identification

% Last Modified by GUIDE v2.5 07-Jun-2016 13:34:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Identification_OpeningFcn, ...
                   'gui_OutputFcn',  @Identification_OutputFcn, ...
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


% --- Executes just before Identification is made visible.
function Identification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Identification (see VARARGIN)

% Choose default command line output for Identification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Identification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Identification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(imaqfind);

facedetector = vision.CascadeObjectDetector();

try
    vid = videoinput('winvideo',2);
catch
    vid = videoinput('winvideo',1);
end

vid.FramesPerTrigger = 1;
vid.ReturnedColorSpace = 'rgb';

start(vid);

If = getdata(vid);

bbox = facedetector.step(If);

if size(bbox,1)==1

    If = imcrop(rgb2gray(If),bbox);

    axes(handles.axes1)
    imshow(If);
    title('Input Face Image');
    
    Person = Recognize_Person(If);

    set(handles.text2,'String',Person);
    ss=serial('COM4')
    fopen(ss)
    fprintf(ss,'%s','@1FM')
    fclose(ss)
else

    axes(handles.axes1)
    imshow(If);
    title('Input Face Image');
    
    warndlg(['Face could not be detected, May lead to wrong output']);
ss=serial('COM4')
    fopen(ss)
    fprintf(ss,'%s','@1FRN000000')
    fclose(ss)
    run('mainfunction.m')
end

