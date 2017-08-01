function varargout = teleBCI(varargin)
% TELEBCI MATLAB code for teleBCI.fig
%      TELEBCI, by itself, creates a new TELEBCI or raises the existing
%      singleton*.
%
%      H = TELEBCI returns the handle to a new TELEBCI or the handle to
%      the existing singleton*.
%
%      TELEBCI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TELEBCI.M with the given input arguments.
%
%      TELEBCI('Property','Value',...) creates a new TELEBCI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before teleBCI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to teleBCI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help teleBCI

% Last Modified by GUIDE v2.5 31-Aug-2016 15:53:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @teleBCI_OpeningFcn, ...
    'gui_OutputFcn',  @teleBCI_OutputFcn, ...
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


% --- Executes just before teleBCI is made visible.
function teleBCI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to teleBCI (see VARARGIN)
temp = get(hObject,'Position');
set(hObject,'Position',[100 100 temp(3) temp(4)]);
%Identify if this is testing or install
[~, inst] = regexp(cd,'\Program Files\');
[~, inst2] = regexp(cd,'\Desktop');
if isempty(inst) && isempty(inst2) %testing
    handles.guidefold = cd;
else %installed
    pcusr=getenv('USERNAME');
    if strcmp(pcusr,'ageronimo') || strcmp('BCIcomputer01',pcusr) % For testing on 'ageronimo' and 'BCIcomputer'
        busr = 'Shared teleBCI Folders\';
    else
        busr = '';
    end
    fldr = dir(['C:\Users\' pcusr '\Box Sync\' busr]);
    fldr_loc = find(cell2mat(cellfun(@(x) ~isempty(strfind(x,'teleBCI')),{fldr.name},'UniformOutput',false)));
    if isempty(fldr_loc) %Maybe using the miniputer?
        fldr_loc = find(cell2mat(cellfun(@(x) ~isempty(strfind(x,'BCIminiputer')),{fldr.name},'UniformOutput',false)));
    end
    handles.guidefold = ['C:\Users\' pcusr '\Box Sync\'  busr fldr(fldr_loc(1)).name '\teleBCI Guide\Logs']
    
    
    %     %Identify the user (BCIcomputer01 eg.), specify associated Box folder
    %
    %     if strcmp(pcusr,'ageronimo') || strcmp('BCIcomputer01',pcusr) % For testing on 'ageronimo' and 'BCIcomputer'
    %         busr = 'Shared teleBCI Folders\teleBCI01';
    %     else
    %         busr = ['teleBCI' pcusr(end-1:end)];
    %     end
    %     handles.guidefold = ['C:\Users\' pcusr '\Box Sync\'...
    %         busr '\teleBCI Guide\Logs'];
end

% Choose default command line output for teleBCI
handles.output = hObject;
handles.LogData = cell(1,2);
handles.Timer = now;
set(handles.axes2,'units','normalized')
handles.currposition = get(handles.figure1,'position');
set(handles.figure1,'position',round(handles.currposition))
handles.OrigSize = round(temp);
set(handles.edit2,'Enable','inactive','String','SUBJECT CODE (P44)','BackgroundColor',[1 .6 .6]);
set(handles.edit3,'Enable','off','String','SESSION NUMBER (001)','BackgroundColor',[1 .6 .6]);

% Update handles structure
guidata(hObject, handles);
UpdateWindow('TeleBCI User Guide',{'Slide1'},1,[],handles,hObject)
% set(hObject,'Color','k')
% UIWAIT makes teleBCI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
temp = get(hObject,'Position');
set(hObject,'Position',[100 100 temp(3) temp(4)]);
%Create a cell to hold log data




% --- Outputs from this function are returned to the command line.
function varargout = teleBCI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Turn on the Computer',{'Slide2'},1,'pushbutton2',handles,hObject)
% handles.pushbutton1.Enable = 'off';
handles.pushbutton1.ForegroundColor = [0 0 0];


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Launch Adobe Connect',{'Slide3','Slide4'},1,'pushbutton3',handles,hObject)
% handles.pushbutton2.Enable = 'off';
handles.pushbutton1.ForegroundColor = [0 0 0];
handles.pushbutton2.ForegroundColor = [0 0 0];


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Calibrate Eye Tracker',{'Slide5','Slide6','Slide7'},...
    1,'pushbutton5',handles,hObject)
% handles.pushbutton3.Enable = 'off';
handles.pushbutton2.ForegroundColor = [0 0 0];
handles.pushbutton3.ForegroundColor = [0 0 0];






% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Apply Cap',{'Slide8','Slide9'},1,'pushbutton6',handles,hObject)
% handles.pushbutton5.Enable = 'off';
handles.pushbutton3.ForegroundColor = [0 0 0];
handles.pushbutton5.ForegroundColor = [0 0 0];



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Apply Electrodes',{'Slide10'},1,'pushbutton4',handles,hObject)
% handles.pushbutton6.Enable = 'off';
handles.pushbutton5.ForegroundColor = [0 0 0];
handles.pushbutton6.ForegroundColor = [0 0 0];

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('OpenBCI2000',{'Slide11','Slide12'},1,'pushbutton7',handles,hObject)
% handles.pushbutton4.Enable = 'off';
handles.pushbutton6.ForegroundColor = [0 0 0];
handles.pushbutton4.ForegroundColor = [0 0 0];

%This isnt currently working, but had to modify the batch file to get it
%this far.
%[status, result] = system('call C:\Users\ageronimo\Documents\BCI2000_5181\batch\test.bat&')


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Check Impedances',{'Slide13','Slide14','Slide15'},1,'pushbutton8',handles,hObject)
% handles.pushbutton7.Enable = 'off';
handles.pushbutton4.ForegroundColor = [0 0 0];
handles.pushbutton7.ForegroundColor = [0 0 0];



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Perform a P300 Run',{'Slide16','Slide17','Slide18'},1,'pushbutton9',handles,hObject)
% handles.pushbutton8.Enable = 'off';
handles.pushbutton7.ForegroundColor = [0 0 0];
handles.pushbutton8.ForegroundColor = [0 0 0];


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Update Classifier',{'Slide19','Slide20','Slide21'},1,'pushbutton10',handles,hObject)
% handles.pushbutton9.Enable = 'off';
handles.pushbutton8.ForegroundColor = [0 0 0];
handles.pushbutton9.ForegroundColor = [0 0 0];


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindow('Clean System',{'Slide22'},1,[],handles,hObject)
% handles.pushbutton10.Enable = 'off';
handles.pushbutton9.ForegroundColor = [0 0 0];
handles.pushbutton10.ForegroundColor = [0 0 0];




% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
secs = datevec(now-handles.Timer)*[0;0;24*60*60;60*60;60;1];
handles.LogData(end,2) = {round(secs)};
handles.Timer = now;
handles.LogData = [handles.LogData; {'SYSTEM RESET', []}];

UpdateWindow('TeleBCI User Guide',{'Slide1'},1,[],handles,hObject);


handles.pushbutton1.Enable = 'off'; handles.pushbutton1.ForegroundColor = [0 0 0];
handles.pushbutton2.Enable = 'off'; handles.pushbutton2.ForegroundColor = [0 0 0];
handles.pushbutton3.Enable = 'off'; handles.pushbutton3.ForegroundColor = [0 0 0];
handles.pushbutton4.Enable = 'off'; handles.pushbutton4.ForegroundColor = [0 0 0];
handles.pushbutton5.Enable = 'off'; handles.pushbutton5.ForegroundColor = [0 0 0];
handles.pushbutton6.Enable = 'off'; handles.pushbutton6.ForegroundColor = [0 0 0];
handles.pushbutton7.Enable = 'off'; handles.pushbutton7.ForegroundColor = [0 0 0];
handles.pushbutton8.Enable = 'off'; handles.pushbutton8.ForegroundColor = [0 0 0];
handles.pushbutton9.Enable = 'off'; handles.pushbutton9.ForegroundColor = [0 0 0];
handles.pushbutton10.Enable = 'off'; handles.pushbutton10ForegroundColor = [0 0 0];
handles.pushbutton14.ForegroundColor = [0 0 0];
handles.pushbutton15.ForegroundColor = [0 0 0];
set(handles.edit2,'String','SUBJECT CODE (P44)','Enable','inactive','BackgroundColor',[1 .6 .6])
set(handles.edit3,'String','SESSION NUMBER (001)','Enable','off');

% --- Executes during object deletion, before destroying properties.
function pushbutton13_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
secs = datevec(now-handles.Timer)*[0;0;24*60*60;60*60;60;1];
handles.LogData(end,2) = {round(secs)};

if isfield(handles,'participant_id') && isfield(handles,'session_num')
    saveloc = [handles.guidefold '\LogData_' ...
        handles.participant_id handles.session_num '_' datestr(datetime,30) '.txt'];
    fid = fopen(saveloc, 'wt');
    if fid == -1
        msgbox(sprintf('%s\n','Could not save log file, ',saveloc,' is not a valid path.  Saving to current directory.'))
        saveloc = [cd '\LogData_' ...
        handles.participant_id handles.session_num '_' datestr(datetime,30) '.txt'];
        fid = fopen(saveloc,'wt');
    else
        LL = handles.LogData';
        fprintf(fid, '%s\n%g\n', LL{:});
        fclose(fid);
    end
end



function UpdateWindow(TaskName,Images,CurrSlide,nextseg,handles,hObject)
% figure1_fixprop(handles);
secs = datevec(now-handles.Timer)*[0;0;24*60*60;60*60;60;1];
if isfield(handles,'TaskName')
    if strcmp(TaskName,handles.TaskName) && CurrSlide == handles.CurrSlide %Slide has not changed (just resizing)
        
        
    else
        
        handles.LogData(end,2) = {round(secs)};
        handles.LogData = [handles.LogData; {TaskName, CurrSlide}];
        handles.Timer = now;
    end
end
handles.TaskName = TaskName;
handles.TaskSlides = Images;
handles.CurrSlide = CurrSlide;

handles.nextseg = nextseg;
handles.text6.String = [num2str(CurrSlide) '/' num2str(length(handles.TaskSlides))];



if CurrSlide == length(Images) % Grey out Next button
    handles.pushbutton14.Enable = 'off'; %Next
    handles.pushbutton14.ForegroundColor = [0 0 0];
    
    if ~isempty(handles.nextseg)
        eval(['handles.' handles.nextseg '.Enable = ''on'';']);
        eval(['handles.' handles.nextseg '.ForegroundColor = [1 0 0];';])
    end
else
    if ~isempty(handles.nextseg)
        if eval(['strcmp(handles.' handles.nextseg '.Enable,''on'')'])
            handles.pushbutton14.Enable = 'on';
        else
            handles.pushbutton14.ForegroundColor = [1 0 0];
            handles.pushbutton14.Enable = 'on';
        end
    end
end

if CurrSlide == 1 %Grey out prev button
    handles.pushbutton15.Enable = 'off';
    
else
    handles.pushbutton15.Enable = 'on';
end
guidata(hObject, handles);

[x,map]=imread(['GUIImages\teleBCI UserGuideSlides\' Images{CurrSlide} '.png']);
if size(x,3)==1
    X2 = ind2rgb(x,map);
else
    X2 = x;
end

%Resize the image
Isz = size(X2);
Iax = get(handles.axes2,'position');
Ifg = get(handles.figure1,'position');
scale = (Ifg(4)*Iax(4))/Isz(1);
X2 = imresize(X2,scale);
axes(handles.axes2);
image(X2); axis off;




% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.CurrSlide = handles.CurrSlide+1;
UpdateWindow(handles.TaskName,handles.TaskSlides,handles.CurrSlide,handles.nextseg,handles,hObject)



% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.CurrSlide = handles.CurrSlide-1;
UpdateWindow(handles.TaskName,handles.TaskSlides,handles.CurrSlide,handles.nextseg,handles,hObject);




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
handles.participant_id = get(hObject,'String');
set(handles.edit2,'BackgroundColor',[1 1 1]);
if ~isempty(get(handles.edit2,'String'))
    set(handles.edit3,'Enable','inactive','BackgroundColor',[1 .6 .6]);
end


guidata(hObject, handles);
%
% if isfield(handles,'session_num') && isfield(handles,'participant_id')
% handles.pushbutton3.Enable = 'on';
% end

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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
handles.session_num = get(hObject,'String');
if isnan(str2double(handles.session_num))
    set(handles.edit3,'Enable','inactive','String','Enter a 3 digit number (001)');
else
    handles.session_num = [repmat('0',1,3-length(handles.session_num)) num2str(handles.session_num)];
    guidata(hObject, handles);
    set(handles.edit3,'BackgroundColor',[1 1 1]);
    
    if isfield(handles,'session_num') && isfield(handles,'participant_id')
        handles.pushbutton1.Enable = 'on';
        handles.pushbutton1.ForegroundColor = [1 0 0];
    end
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% % --- Executes on slider movement.
% function slider1_Callback(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% guisize = get(hObject,'Value');
% newpos = get(handles.figure1,'position');
% newsize = handles.OrigSize; newsize = newsize(3:4);
% FS1 = [8 8 9 9 10 10 11 12 13 14 14 15];
% FS2 = [7 7 8 8 8 8 9 9 10 11 12];
% scale = 50;
% newsize = newsize+(guisize-5)*[scale scale*newsize(2)/newsize(1)];
% set(handles.figure1,'position',[newpos(1:2) newsize]);
% set(handles.pushbutton1,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton2,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton3,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton4,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton5,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton6,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton7,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton8,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton9,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton10,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton13,'FontSize',FS1(1+round(guisize)));
% set(handles.pushbutton14,'FontSize',FS2(1+round(guisize)));
% set(handles.pushbutton15,'FontSize',FS2(1+round(guisize)));
% set(handles.text7,'FontSize',FS2(1+round(guisize)));
% set(handles.edit2,'FontSize',FS2(1+round(guisize)));
% set(handles.edit3,'FontSize',FS2(1+round(guisize)));
%
% if isfield(handles,'TaskName')
% UpdateWindow(handles.TaskName,handles.TaskSlides,handles.CurrSlide,handles.nextseg,handles,hObject)
% end


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit2.
function edit2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit2,'Enable','on','String','');
uicontrol(handles.edit2);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit3.
function edit3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.edit3,'Enable'),'inactive')
    set(handles.edit3,'Enable','on','String','');
    uicontrol(handles.edit3);
end



% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

maxheight = 900; minheight = 200;
temp = handles.figure1.Position;
if temp(4)>maxheight
    temp(4) = maxheight;
end
if temp(4)<minheight
    temp(4) = minheight;
end
axtemp = handles.axes2.Position;
handles.currposition = fix([temp(1:2) temp(4)*axtemp(4)/.75/axtemp(3) temp(4)]);

FS1 = handles.currposition(3)/90; FS2 = handles.currposition(3)/120;

set(handles.pushbutton1,'FontSize',FS1);
set(handles.pushbutton2,'FontSize',FS1);
set(handles.pushbutton3,'FontSize',FS1);
set(handles.pushbutton4,'FontSize',FS1);
set(handles.pushbutton5,'FontSize',FS1);
set(handles.pushbutton6,'FontSize',FS1);
set(handles.pushbutton7,'FontSize',FS1);
set(handles.pushbutton8,'FontSize',FS1);
set(handles.pushbutton9,'FontSize',FS1);
set(handles.pushbutton10,'FontSize',FS1);
set(handles.pushbutton13,'FontSize',FS1);
set(handles.pushbutton14,'FontSize',FS2);
set(handles.pushbutton15,'FontSize',FS2);
set(handles.edit2,'FontSize',FS2);
set(handles.edit3,'FontSize',FS2);
set(handles.text6,'FontSize',FS1);

handles.figure1.Position = handles.currposition;
if isfield(handles,'TaskName')
    UpdateWindow(handles.TaskName,handles.TaskSlides,handles.CurrSlide,handles.nextseg,handles,hObject);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
button = questdlg(sprintf('%s\n','Are you sure you want to close','the teleBCI guide?'),'Close guide?');
if strcmp(button,'Yes')
    delete(hObject);
end

