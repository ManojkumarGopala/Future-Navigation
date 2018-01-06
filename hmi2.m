
function varargout = hmi2(varargin)
% HMI2 MATLAB code for hmi2.fig
%      HMI2, by itself, creates a new HMI2 or raises the existing
%      singleton*.
%
%      H = HMI2 returns the handle to a new HMI2 or the handle to
%      the existing singleton*.
%
%      HMI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HMI2.M with the given input arguments.
%
%      HMI2('Property','Value',...) creates a new HMI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hmi2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hmi2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hmi2

% Last Modified by GUIDE v2.5 15-Dec-2017 22:06:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hmi2_OpeningFcn, ...
                   'gui_OutputFcn',  @hmi2_OutputFcn, ...
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
end

% --- Executes just before hmi2 is made visible.
function hmi2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hmi2 (see VARARGIN)

% Choose default command line output for hmi2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hmi2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = hmi2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)

cla
set(handles.latbox, 'string', ' ' );
set(handles.lonbox, 'string', ' ' );
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
obj = VideoReader('IMG_3559.MOV');
for k = 1:100   %fill in the appropriate number
  global this_frame;
  this_frame = readFrame(obj);
  axes(handles.axes2);
imshow(this_frame);
 
end
end
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global this_frame;
I=this_frame; 
[output,output2]=car_numberplatefinal(I);
% disp(output)
% set(handles.myoutput, 'string', output );
axes(handles.axes3)
imshow(output2)

[latitude, longitude]= location();
latitude1= latitude(1);
  longitude1=longitude(1);
set(handles.latbox, 'string', latitude1 );
set(handles.lonbox, 'string', longitude1 );

fileID = fopen('NEWGEN_RESULTS.txt','a+');
fprintf(fileID,'SIGN Lat= %12.8f , Lon= %12.8f\n', latitude1,longitude1 );
fclose(fileID);

end
   




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over myoutput.
function myoutput_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to myoutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in Firebutton.
function Firebutton_Callback(hObject, eventdata, handles)
% hObject    handle to Firebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

obj = VideoReader('fireexaple1.mp4');
for k = 1:50   %fill in the appropriate number
  this_frame = readFrame(obj);
  axes(handles.axes2);
imshow(this_frame);
I=this_frame;
[out1,out2]= fire(I);
set(handles.firestatus, 'string', out1 );

axes(handles.axes3);
imshow(out2);
end

%if out1=='fire detected'
[latitude, longitude]= location();
latitude1= latitude(1);
  longitude1=longitude(1);
set(handles.latbox, 'string', latitude1 );
set(handles.lonbox, 'string', longitude1 );

%end
fileID = fopen('NEWGEN_RESULTS.txt','a+');
fprintf(fileID,'Fire Detected Lat= %12.8f , Lon= %12.8f\n', latitude1,longitude1 );
fclose(fileID);

end



% --- Executes on button press in Mapdata.
function Mapdata_Callback(hObject, eventdata, handles)
% hObject    handle to Mapdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[latitude, longitude]= location();
latitude1= latitude(1);
  longitude1=longitude(1);
set(handles.latbox, 'string', latitude1 );
set(handles.lonbox, 'string', longitude1 );


end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --- Executes on button press in numberplate.
function numberplate_Callback(hObject, eventdata, handles)
% hObject    handle to numberplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%open('vipwarningsigns.slx')

% video = 'IMG_3635.mp4';
% videoReader = VideoReader(video);
% fps = get(videoReader, 'FrameRate');
% %disp(fps); % the fps is correct: it's the same declared in the video file properties
% currAxes = handles.axes2;
% while hasFrame(videoReader)
%   vidFrame = readFrame(videoReader);
%   image(vidFrame, 'Parent', currAxes);
%   currAxes.Visible = 'off';
%   pause(1/videoReader.FrameRate);
% end
cla

set(handles.latbox, 'string', ' ' );
set(handles.lonbox, 'string', ' ' );

model = 'vipwarningsigns.slx';
  load_system(model)
  sim(model)
  
  [latitude, longitude]= location();
  latitude1= latitude(1);
  longitude1=longitude(1);
set(handles.latbox, 'string', latitude1 );
set(handles.lonbox, 'string', longitude1 );

fileID = fopen('NEWGEN_RESULTS.txt','a+');
fprintf(fileID,'Sign board Lat= %12.8f , Lon= %12.8f\n', latitude1,longitude1 );
fclose(fileID);


  
end


% --- Executes on button press in signstop.
function signstop_Callback(hObject, eventdata, handles)
% hObject    handle to signstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set_param('vipwarningsigns', 'SimulationCommand', 'stop');

end


% --- Executes on button press in collecteddata.
function collecteddata_Callback(hObject, eventdata, handles)
% hObject    handle to collecteddata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('NEWGEN_RESULTS.txt')
end
