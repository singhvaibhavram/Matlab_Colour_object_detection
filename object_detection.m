function varargout = object_detection(varargin)
% OBJECT_DETECTION MATLAB code for object_detection.fig
%      OBJECT_DETECTION, by itself, creates a new OBJECT_DETECTION or raises the existing
%      singleton*.
%
%      H = OBJECT_DETECTION returns the handle to a new OBJECT_DETECTION or the handle to
%      the existing singleton*.
%
%      OBJECT_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OBJECT_DETECTION.M with the given input arguments.
%
%      OBJECT_DETECTION('Property','Value',...) creates a new OBJECT_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before object_detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to object_detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help object_detection

% Last Modified by GUIDE v2.5 23-Mar-2016 10:37:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @object_detection_OpeningFcn, ...
                   'gui_OutputFcn',  @object_detection_OutputFcn, ...
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


% --- Executes just before object_detection is made visible.
function object_detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to object_detection (see VARARGIN)

% Choose default command line output for object_detection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Variable in the projecct

global rmin rmax gmin gmax bmin bmax imgr imgb imgg out_img c gest_data index min_pix
last_data = fileread('last_object_data.txt');
last_data = str2num(last_data);
min_pix = last_data(7);
index = 1;
rmin = last_data(1);
rmax = last_data(2);
gmin = last_data(3);
gmax = last_data(4);
bmin = last_data(5);
bmax = last_data(6);

set(handles.rmin_val,'String',rmin);
set(handles.rmax_val,'String',rmax);
set(handles.gmin_val,'String',gmin);
set(handles.gmax_val,'String',gmax);
set(handles.bmin_val,'String',bmin);
set(handles.bmax_val,'String',bmax);
set(handles.opti_val,'String',min_pix);

set(handles.rmin,'Value',rmin/255);
set(handles.gmin,'Value',gmin/255);
set(handles.bmin,'Value',bmin/255);
set(handles.rmax,'Value',rmax/255);
set(handles.gmax,'Value',gmax/255);
set(handles.bmax,'Value',bmax/255);
set(handles.optimize_slider,'Value',min_pix/1000);

c = webcam();
c.Resolution = '320x240';
preview(c);


% UIWAIT makes object_detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = object_detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Click_image_button.
function Click_image_button_Callback(hObject, eventdata, handles)
% hObject    handle to Click_image_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%y = get(handles.rmax,'Value');
global rmin rmax gmin gmax bmin bmax imgr imgb imgg out_img c


img = snapshot(c);
%img = imread('tide.jpg');
imgr = img(:,:,1);
imgg = img(:,:,2);
imgb = img(:,:,3);
out_img = imgr > rmin & imgr < rmax & imgg > gmin & imgg < gmax & imgb > bmin & imgb < bmax;

imshow(out_img);
%preview(c);
%figure, imshow(img);





% --- Executes on slider movement.
function rmax_Callback(hObject, eventdata, handles)
% hObject    handle to rmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global rmin rmax gmin gmax bmin bmax out_img imgr imgb imgg
rmax = get(handles.rmax,'Value')*255;
set(handles.rmax_val,'String',rmax);

out_img = imgr > rmin & imgr < rmax & imgg > gmin & imgg < gmax & imgb > bmin & imgb < bmax;
imshow(out_img);


% --- Executes during object creation, after setting all properties.
function rmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end







% --- Executes on slider movement.
function rmin_Callback(hObject, eventdata, handles)
% hObject    handle to rmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global rmin rmax gmin gmax bmin bmax out_img imgr imgb imgg
rmin = get(handles.rmin,'Value')*255;
set(handles.rmin_val,'String',rmin);

out_img = imgr > rmin & imgr < rmax & imgg > gmin & imgg < gmax & imgb > bmin & imgb < bmax;
imshow(out_img);

% --- Executes during object creation, after setting all properties.
function rmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gmin_Callback(hObject, eventdata, handles)
% hObject    handle to gmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global rmin rmax gmin gmax bmin bmax out_img imgr imgb imgg
gmin = get(handles.gmin,'Value')*255;
set(handles.gmin_val,'String',gmin);

out_img = imgr > rmin & imgr < rmax & imgg > gmin & imgg < gmax & imgb > bmin & imgb < bmax;
imshow(out_img);

% --- Executes during object creation, after setting all properties.
function gmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gmax_Callback(hObject, eventdata, handles)
% hObject    handle to gmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global rmin rmax gmin gmax bmin bmax out_img imgr imgb imgg
gmax = get(handles.gmax,'Value')*255;
set(handles.gmax_val,'String',gmax);

out_img = imgr > rmin & imgr < rmax & imgg > gmin & imgg < gmax & imgb > bmin & imgb < bmax;
imshow(out_img);

% --- Executes during object creation, after setting all properties.
function gmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmin_Callback(hObject, eventdata, handles)
% hObject    handle to bmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global rmin rmax gmin gmax bmin bmax out_img imgr imgb imgg
bmin = get(handles.bmin,'Value')*255;
set(handles.bmin_val,'String',bmin);

out_img = imgr > rmin & imgr < rmax & imgg > gmin & imgg < gmax & imgb > bmin & imgb < bmax;
imshow(out_img);

% --- Executes during object creation, after setting all properties.
function bmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmax_Callback(hObject, eventdata, handles)
% hObject    handle to bmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global rmin rmax gmin gmax bmin bmax out_img imgr imgb imgg
bmax = get(handles.bmax,'Value')*255;
set(handles.bmax_val,'String',bmax);

out_img = imgr > rmin & imgr < rmax & imgg > gmin & imgg < gmax & imgb > bmin & imgb < bmax;
imshow(out_img);

% --- Executes during object creation, after setting all properties.
function bmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in fill_hole.
function fill_hole_Callback(hObject, eventdata, handles)
% hObject    handle to fill_hole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
get_stats;
global out_img
imshow(out_img);


% --- Executes on button press in detect_object.
function detect_object_Callback(hObject, eventdata, handles)
% hObject    handle to detect_object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stats data c rmin rmax bmax bmin gmin gmax out_img gest_datax gest_datay index min_pix dx dy txt
l_data = [rmin,rmax,gmin,gmax,bmin,bmax,min_pix];
l_data = num2str(l_data);
f = fopen('last_object_data.txt','w');
fprintf(f,'%s',l_data);
fclose(f);
i = 1;
while i < 100000;
    img = snapshot(c);
    img = flipdim(img,2);
    imgr = img(:,:,1);
    imgg = img(:,:,2);
    imgb = img(:,:,3);
    out_img = imgr > rmin & imgr < rmax & imgg > gmin & imgg < gmax & imgb > bmin & imgb < bmax;
    
    imshow(img);
    
    get_stats;
    set(handles.obj_det,'String',length(stats));
    for object = 1:length(stats);
        hold on
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        gest_datax(index) = bc(1);
        gest_datay(index) = bc(2);
        index = index + 1;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2);
        
        if index > 20;
            dx = gest_datax(index-20:index-1);
            dy = gest_datay(index-20:index-1);
           
            %plot(dx,dy,'g','LineWidth',3); %trace path of object
             %test_pattern;
%            
             %set(handles.det_txt,'String',txt.Text);
%           
            
        end
    end
    
    hold off
    i = i+1;
    pause(0.05);
end


% --- Executes on button press in stop_cam.
function stop_cam_Callback(hObject, eventdata, handles)
% hObject    handle to stop_cam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c gest_datax gest_datay dx dy
datax = num2str(dx);
datay = num2str(dy);
f = fopen('data.txt','w');
fprintf(f,'%s\n%s',datax,datay);
fclose(f);
closePreview(c);
clear all;


% --- Executes on slider movement.
function optimize_slider_Callback(hObject, eventdata, handles)
% hObject    handle to optimize_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global min_pix

min_pix = floor(get(handles.optimize_slider,'Value')*1000);
set(handles.opti_val,'String',min_pix);


% --- Executes during object creation, after setting all properties.
function optimize_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to optimize_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
