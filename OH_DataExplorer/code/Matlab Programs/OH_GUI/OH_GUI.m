function [h] = OH_GUI(varargin)
% OH_GUI - Execute graphic updates at regular intervals
%   MATLAB code for OH_GUI.fig
%      OH_GUI, by itself, creates a new OH_GUI 
%      or raises the existing singleton*.
%
%      H = OH_GUI returns the handle to a new OH_GUI
%      or the handle to the existing singleton*.
%
%      OH_GUI('CALLBACK',hObject,eventData,handles,...) calls
%      the local function named CALLBACK in OH_GUI.M with 
%      the given input arguments.
%
%      OH_GUI('Property','Value',...) creates a new 
%      OH_GUI or raises the existing singleton*.
%      Starting from the left, property value pairs are applied to the 
%      GUI before OH_GUI_OpeningFcn gets called.
%      An unrecognized property name or invalid value makes property
%      application stop.  All inputs are passed to 
%      OH_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows
%      only one instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES, TIMER

% Last Modified by GUIDE v2.5 09-Apr-2015 12:56:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OH_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @OH_GUI_OutputFcn, ...
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


% --- Executes just before OH_GUI is made visible.
function OH_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OH_GUI (see VARARGIN)

% Choose default command line output for OH_GUI
handles.output = hObject;
% getting our data loaded into the handles structure
% START USER CODE
% Create a timer object to fire at 1/10 sec intervals
% Specify function handles for its start and run callbacks
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly
    'Period', 1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@update_display,hObject}); % Specify callback function
% Initialize slider and its readout text field
%{
set(handles.periodsldr,'Min',0.01,'Max',2)
set(handles.periodsldr,'Value',get(handles.timer,'Period'))
set(handles.slidervalue,'String',...
    num2str(get(handles.periodsldr,'Value')))
%}
% Create an animatedline plot with no data. Store handle to it.

%handles.surf = surf(handles.display,peaks);
% END USER CODE

% Update handles structure
guidata(hObject,handles);


% --- Outputs from this function are returned to the command line.
function varargout = OH_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startbtn.
function startbtn_Callback(hObject, eventdata, handles)
% hObject    handle to startbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% START USER CODE
% Only start timer if it is not running
if strcmp(get(handles.timer, 'Running'), 'off')
    start(handles.timer);
end
% END USER CODE


% --- Executes on button press in stopbtn.
function stopbtn_Callback(hObject, eventdata, handles)
% hObject    handle to stopbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% START USER CODE
% Only stop timer if it is running
if strcmp(get(handles.timer, 'Running'), 'on')
    stop(handles.timer);
end
% END USER CODE


% --- Executes on slider movement.
function periodsldr_Callback(hObject, eventdata, handles)
% hObject    handle to periodsldr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% START USER CODE
%{
% Read the slider value
period = get(handles.periodsldr,'Value');
% Timers need the precision of periods to be greater than about
% 1 millisecond, so truncate the value returned by the slider
period = period - mod(period,.01);
% Set slider readout to show its value
set(handles.slidervalue,'String',num2str(period))
% If timer is on, stop it, reset the period, and start it again.
if strcmp(get(handles.timer, 'Running'), 'on')
    stop(handles.timer);
    set(handles.timer,'Period',period)
    start(handles.timer)
else               % If timer is stopped, reset its period only.
    set(handles.timer,'Period',period)
end
% END USER CODE
%}

% START USER CODE
function update_display(hObject,eventdata,hfigure)
% Timer timer1 callback, called each time timer iterates.
% Gets surface Z data, adds noise, and writes it back to surface object.
%{
handles = guidata(hfigure);
Z = get(handles.surf,'ZData');
Z = Z + 0.1*randn(size(Z));
set(handles.surf,'ZData',Z);
%}
% END USER CODE


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% START USER CODE
% Necessary to provide this function to prevent timer callback
% from causing an error after GUI code stops executing.
% Before exiting, if the timer is running, stop it.
if strcmp(get(handles.timer, 'Running'), 'on')
    stop(handles.timer);
end
% Destroy timer
delete(handles.timer)
% END USER CODE

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.txtHold,'visible','on')
cla()
contents=cellstr(get(hObject,'String'));
castNo=contents{get(hObject,'Value')};
castNo=str2num(castNo(1));
handles.castNo=castNo;
lat = extractfield(handles.ctd,'lat');
lon = extractfield(handles.ctd,'lon');
n = handles.castNo;
[myH]=plotCoord(lat,lon,n);
set(handles.txtHold,'visible','off')
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
% Update handles structure
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%keyboard
ctd=handles.ctd;
castNo=cell(0);
for i =1:size(ctd,2)
    cord={sprintf('%i. %2.3f, %2.3f',i,ctd(i).lat,ctd(i).lon)};
   castNo=[castNo cord]; 
end
handles.castNo=1; % setting our default cast number
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',castNo);
guidata(hObject,handles);

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents=cellstr(get(hObject,'String'));
handles.x=contents{get(hObject,'Value')};
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
% Update handles structure
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

load realCTD
handles.ctd=ctd;
handles.x = 'Fluorescence'; % setting default plotting value
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {'Fluorescence', 'Temperature', 'Salinity'});
% Update handles structure
guidata(hObject,handles);


% --- Executes on button press in Deploy.
function Deploy_Callback(hObject, eventdata, handles)
% hObject    handle to Deploy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ctd=handles.ctd;
cla()
h=animatedline('Marker','*','LineStyle','none');
n=20; % number of points to average together
cN=handles.castNo;
y=ctd(cN).depth;
x=handles.x;
xlab=x;
y=getavg(y,n);

switch x
    case 'Fluorescence' 
        u = ' (rfu)';
        x=ctd(cN).fluor;
        c=[0,1,0];
    case 'Temperature'
        u= sprintf(' (%cC)',char(176));
        x=ctd(cN).temp;
        c=[1,0,0];
    case 'Salinity'
        u=' (psu)';
        x=ctd(cN).salt;
        c=[0.1,0.4,1];
end
x=getavg(x,n);
h.Color = c;
set(gca,'Color',[0,0,0],'YDir','reverse','XAxisLocation','top','XColor',[1,1,1],'YColor',[1,1,1])
grid on
set(gca,'Xlim',[min(x) max(x)],'Ylim',[min(y) max(y)])
ylabel('Depth (m)'); xlabel([xlab u]);
set(handles.txtPlotting,'visible','on')
for k = 1:length(x)
   addpoints(h,x(k),y(k));
   drawnow limitrate
   pause(0.05)
end
set(handles.txtPlotting,'visible','off')
handles.h=h;
% Update handles structure
guidata(hObject,handles);
