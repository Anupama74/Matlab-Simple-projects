function varargout = Database_Management(varargin)
% DATABASE_MANAGEMENT MATLAB code for Database_Management.fig
%      DATABASE_MANAGEMENT, by itself, creates a new DATABASE_MANAGEMENT or raises the existing
%      singleton*.
%
%      H = DATABASE_MANAGEMENT returns the handle to a new DATABASE_MANAGEMENT or the handle to
%      the existing singleton*.
%
%      DATABASE_MANAGEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATABASE_MANAGEMENT.M with the given input arguments.
%
%      DATABASE_MANAGEMENT('Property','Value',...) creates a new DATABASE_MANAGEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Database_Management_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Database_Management_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Database_Management

% Last Modified by GUIDE v2.5 11-Apr-2016 12:48:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Database_Management_OpeningFcn, ...
                   'gui_OutputFcn',  @Database_Management_OutputFcn, ...
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


% --- Executes just before Database_Management is made visible.
function Database_Management_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Database_Management (see VARARGIN)

% Choose default command line output for Database_Management
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Database_Management wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% update the popupmenu
Folder_Names = Get_Folders();
    
% Update the Popupmenu
set(handles.popupmenu1,'String',Folder_Names);

% --- Outputs from this function are returned to the command line.
function varargout = Database_Management_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Enter_Frames.
function Enter_Frames_Callback(hObject, eventdata, handles)
% hObject    handle to Enter_Frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global F;

string_display = {'Enter the No. of Frames'};
F = inputdlg(string_display,'Input');
F = str2num(F{1});

% --- Executes on button press in Start_Camera.
function Start_Camera_Callback(hObject, eventdata, handles)
% hObject    handle to Start_Camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global F Data_Face;

delete(imaqfind);

% Create an object to detect faces
facedetector = vision.CascadeObjectDetector();

vid = videoinput('winvideo');

vid.TriggerRepeat = Inf;
triggerconfig(vid,'manual');
vid.FramesPerTrigger = 1;
vid.ReturnedColorSpace = 'rgb';

start(vid);
j = 1;
Data_Face = [];

for i = 1:F
    
    trigger(vid);
    
    Data_Set(:,:,:,i) = getdata(vid);
    bbox = facedetector.step(Data_Set(:,:,:,i));
    if isempty(bbox)
        continue;
    end
    if size(bbox,1)>1
        continue;
    end
    Face = imcrop(rgb2gray(Data_Set(:,:,:,i)),bbox);
    Data_Face(:,:,:,j) = imresize(Face,[112,92]);
    axes(handles.axes1);
    imshow(uint8(Data_Face(:,:,:,j)));
    title([num2str(j),'th Frame']);
    pause(1);
    j = j+1;
end

stop(vid);
delete(vid);

% --- Executes on button press in Save_Data.
function Save_Data_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Data_Face;

Data_Face = uint8(Data_Face);

% Get selected value from the popup menu
val = get(handles.popupmenu1,'Value');

% Get all the contents of the popupmenu
Contents = cellstr(get(handles.popupmenu1,'String'));

if val==1
    
    % Call the Function Make_new_Entry() to Create new database
    Make_New_Entry(Data_Face);
    
    % Call the funtion Get_Folders() to get all the Folder contents to 
    % update the popupmenu
    Folder_Names = Get_Folders();
    
    % Update the Popupmenu
    set(handles.popupmenu1,'String',Folder_Names);
    
    % Notify User
    msgbox('Database is Created');
    
else
    
    % Get the folder name
    Existing_Folder = Contents{val};
    
    % Call te function Updating Exist to update the database
    Update_Existing(Existing_Folder,Data_Face);
    
    % Notify to user
    msgbox('Database is Updated');
    
end

Data_Face = [];

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


% --- Executes on button press in Train.
function Train_Callback(hObject, eventdata, handles)
% hObject    handle to Train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Extract_face_features();
% Extract_palm_features();
train_Classifier();

% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.figure1);
% Data_Face = [];
Main_GUI;

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all;
% Data_Face = [];

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
