function varargout = pag1(varargin)
% pag1 MATLAB code for pag1.fig
%      pag1, by itself, creates a new pag1 or raises the existing
%      singleton*.
%
%      H = pag1 returns the handle to a new pag1 or the handle to
%      the existing singleton*.
%
%      pag1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in pag1.M with the given input arguments.
%
%      pag1('Property','Value',...) creates a new pag1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pag1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pag1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pag1

% Last Modified by GUIDE v2.5 24-Aug-2018 10:50:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @pag1_OpeningFcn, ...
    'gui_OutputFcn',  @pag1_OutputFcn, ...
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


% --- Executes just before pag1 is made visible.
function pag1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pag1 (see VARARGIN)

% Choose default command line output for pag1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pag1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pag1_OutputFcn(hObject, eventdata, handles)
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




% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sel_txt_Callback(hObject, eventdata, handles)
% hObject    handle to sel_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% personal_cell=table2cell(LISTADODEPERSONALSISTEMAS);

[filename, pathname] = uigetfile({'*.txt'},'File Selector');
fullpathname=strcat(pathname,filename);
set(handles.text2,'String',strcat('El archivo seleccionado es: ',fullpathname));
filename=fullfile(fullpathname);
Loaded_file=readtable(filename);
assignin('base','Loaded_file',Loaded_file);

clean_clock=sortrows(Loaded_file(:,[3 6 7]),1);
assignin('base','clean_clock',clean_clock);

personal_table=evalin('base', 'LISTADODEPERSONALSISTEMAS');

sorted_table_CI=sortrows(personal_table,1);
sorted_table_Name=sortrows(personal_table,2);
sorted_table_ID=sortrows(personal_table,3);

personal_table_CI_first=[personal_table(:,1) personal_table(:,2) personal_table(:,3)];
personal_table_Name_first=[personal_table(:,2) personal_table(:,1) personal_table(:,3)];
personal_table_ID_first=[personal_table(:,3) personal_table(:,2) personal_table(:,1)];
assignin('base','personal_table_ID_first',personal_table_ID_first);
assignin('base','personal_table_CI_first',personal_table_CI_first);
assignin('base','sorted_table_CI',sorted_table_CI);
assignin('base','sorted_table_Name',sorted_table_Name);
assignin('base','sorted_table_ID',sorted_table_ID);

CIs=personal_table(:,1);
Names=personal_table(:,2);
IDs=personal_table(:,3);

assignin('base','clean_personal',personal_table);
assignin('base','CIs',CIs);
assignin('base','IDs',IDs);
assignin('base','Names',Names);
guidata(hObject,handles);

% populate pops
set(handles.ID_popupmenu,'String',table2cell(IDs));
set(handles.CI_popupmenu,'String',table2cell(CIs));
set(handles.name_popupmenu,'String',table2cell(Names));
% set(handles.horario_popupmenu,'String',(Horarios));

% pop_ID to edit_ID
pop_ID_index=get(handles.ID_popupmenu,'Value');
assignin('base','pop_ID_index',pop_ID_index);
pop_ID_items=get(handles.ID_popupmenu,'String');
assignin('base','pop_ID_items',pop_ID_items);
pop_sel_item_ID = pop_ID_items{pop_ID_index};
assignin('base','pop_sel_item_ID',pop_sel_item_ID);
set(handles.ID_edit_box,'String',pop_sel_item_ID);

% pop_CI to edit_CI
pop_CI_index=get(handles.CI_popupmenu,'Value');
pop_CI_items=get(handles.CI_popupmenu,'String');
pop_sel_item_CI = pop_CI_items{pop_CI_index};
set(handles.CI_edit_box,'String',pop_sel_item_CI);

% pop_ID to pop_CI
CI_list_index = find(table2array(IDs)==str2double(pop_sel_item_ID));
assignin('base','CI_list_index',CI_list_index);
sel_CI=personal_table_ID_first(CI_list_index,3);
assignin('base','sel_CI',sel_CI);
set(handles.CI_popupmenu,'Value',CI_list_index);

% pop_CI to CI_show
set(handles.CI_show,'String',table2array(personal_table_ID_first(CI_list_index,2)));
assignin('base','nombre_trabajador',table2array(table2array(personal_table_ID_first(CI_list_index,2))));




% pop_ID to table
clean_db_sel_indexes = find(table2array(clean_clock(:,1))==str2double(pop_sel_item_ID));
assignin('base','clean_db_sel_indexes',clean_db_sel_indexes);
% set(handles.uitable1,'Data',table2cell(clean_clock(clean_db_sel_indexes,:)));
clean_db_sel_data=clean_clock(clean_db_sel_indexes,:);
assignin('base','clean_db_sel_data',clean_db_sel_data);

% pop_ID to name_popupmenu
set(handles.name_popupmenu,'Value',CI_list_index);




% --- Executes on selection change in ID_popupmenu.
function ID_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to ID_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ID_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ID_popupmenu

IDs=evalin('base', 'IDs');
personal_table_ID_first=evalin('base', 'personal_table_ID_first');
clean_clock=evalin('base', 'clean_clock');

% pop_ID to edit_ID
pop_ID_index=get(handles.ID_popupmenu,'Value');
pop_ID_items=get(handles.ID_popupmenu,'String');
pop_sel_item_ID = pop_ID_items{pop_ID_index};
assignin('base','pop_sel_item_ID',pop_sel_item_ID);
set(handles.ID_edit_box,'String',pop_sel_item_ID);

% pop_ID to pop_CI
CI_list_index = find(table2array(IDs)==str2double(pop_sel_item_ID));
assignin('base','CI_list_index',CI_list_index);
sel_CI=personal_table_ID_first(CI_list_index,3);
assignin('base','sel_CI',sel_CI);
set(handles.CI_popupmenu,'Value',CI_list_index);

% pop_CI to edit_CI
pop_CI_index=get(handles.CI_popupmenu,'Value');
pop_CI_items=get(handles.CI_popupmenu,'String');
pop_sel_item_CI = pop_CI_items{pop_CI_index};
set(handles.CI_edit_box,'String',pop_sel_item_CI);

% pop_CI to CI_show
set(handles.CI_show,'String',table2array(personal_table_ID_first(CI_list_index,2)));
assignin('base','nombre_trabajador',table2array(personal_table_ID_first(CI_list_index,2)));


% pop_ID to table
clean_db_sel_indexes = find(table2array(clean_clock(:,1))==str2double(pop_sel_item_ID));
assignin('base','clean_db_sel_indexes',clean_db_sel_indexes);
% set(handles.uitable1,'Data',table2cell(clean_clock(clean_db_sel_indexes,:)));
clean_db_sel_data=clean_clock(clean_db_sel_indexes,:);
assignin('base','clean_db_sel_data',clean_db_sel_data);

% pop_ID to name_popupmenu
set(handles.name_popupmenu,'Value',CI_list_index);

% Filtrar fecha
filtrar_fecha_Callback(handles.filtrar_fecha,[],handles);


% --- Executes during object creation, after setting all properties.
function ID_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ID_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ID_edit_box_Callback(hObject, eventdata, handles)
% hObject    handle to ID_edit_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ID_edit_box as text
%        str2double(get(hObject,'String')) returns contents of ID_edit_box as a double

search_str=get(handles.ID_edit_box,'String');
personal_table_ID_first=evalin('base', 'personal_table_ID_first');
clean_clock=evalin('base', 'clean_clock');

% edit_ID to pop_ID
ID_list_index = find(table2array(personal_table_ID_first)==search_str);
assignin('base','ID_list_index',ID_list_index);
set(handles.ID_popupmenu,'Value',ID_list_index);

% edit_ID to pop_CI
set(handles.CI_popupmenu,'Value',ID_list_index);

% pop_CI to edit_CI
pop_CI_index=get(handles.CI_popupmenu,'Value');
pop_CI_items=get(handles.CI_popupmenu,'String');
pop_sel_item_CI = pop_CI_items{pop_CI_index};
set(handles.CI_edit_box,'String',pop_sel_item_CI);

% pop_CI to CI_show
set(handles.CI_show,'String',table2array(personal_table_ID_first(ID_list_index,2)));
assignin('base','nombre_trabajador',table2array(personal_table_ID_first(ID_list_index,2)));


% pop_ID to table
clean_db_sel_indexes = find(table2array(clean_clock(:,1))==table2array(personal_table_ID_first(ID_list_index,1)));
assignin('base','clean_db_sel_indexes',clean_db_sel_indexes);
% set(handles.uitable1,'Data',table2cell(clean_clock(clean_db_sel_indexes,:)));
clean_db_sel_data=clean_clock(clean_db_sel_indexes,:);
assignin('base','clean_db_sel_data',clean_db_sel_data);

% pop_ID to name_popupmenu
set(handles.name_popupmenu,'Value',ID_list_index);

% Filtrar fecha
filtrar_fecha_Callback(handles.filtrar_fecha,[],handles);

% --- Executes during object creation, after setting all properties.
function ID_edit_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ID_edit_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CI_popupmenu.
function CI_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to CI_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CI_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CI_popupmenu

personal_table_ID_first=evalin('base', 'personal_table_ID_first');
clean_clock=evalin('base', 'clean_clock');

% pop_CI to edit_CI
pop_CI_index=get(handles.CI_popupmenu,'Value');
pop_CI_items=get(handles.CI_popupmenu,'String');
pop_sel_item_CI = pop_CI_items{pop_CI_index};
set(handles.CI_edit_box,'String',pop_sel_item_CI);

% pop_CI to CI_show
set(handles.CI_show,'String',table2array(personal_table_ID_first(pop_CI_index,2)));
assignin('base','nombre_trabajador',table2array(personal_table_ID_first(pop_CI_index,2)));


% pop_CI to pop_ID
set(handles.ID_popupmenu,'Value',pop_CI_index);

% pop_ID to edit_ID
pop_ID_index=get(handles.ID_popupmenu,'Value');
pop_ID_items=get(handles.ID_popupmenu,'String');
pop_sel_item_ID = pop_ID_items{pop_ID_index};
assignin('base','pop_sel_item_ID',pop_sel_item_ID);
set(handles.ID_edit_box,'String',pop_sel_item_ID);

% pop_ID to table
clean_db_sel_indexes = find(table2array(clean_clock(:,1))==table2array(personal_table_ID_first(pop_CI_index,1)));
assignin('base','clean_db_sel_indexes',clean_db_sel_indexes);
% set(handles.uitable1,'Data',table2cell(clean_clock(clean_db_sel_indexes,:)));
clean_db_sel_data=clean_clock(clean_db_sel_indexes,:);
assignin('base','clean_db_sel_data',clean_db_sel_data);

% pop_ID to name_popupmenu
set(handles.name_popupmenu,'Value',pop_CI_index);

% Filtrar fecha
filtrar_fecha_Callback(handles.filtrar_fecha,[],handles);


% --- Executes during object creation, after setting all properties.
function CI_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CI_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CI_edit_box_Callback(hObject, eventdata, handles)
% hObject    handle to CI_edit_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CI_edit_box as text
%        str2double(get(hObject,'String')) returns contents of CI_edit_box as a double

search_str=get(handles.CI_edit_box,'String');
personal_table_CI_first=evalin('base', 'personal_table_CI_first');
clean_clock=evalin('base', 'clean_clock');

% edit_CI to pop_CI
CI_list_index = find(table2array(personal_table_CI_first)==search_str);
assignin('base','ID_list_index',CI_list_index);
set(handles.CI_popupmenu,'Value',CI_list_index);

% edit_CI to pop_ID
set(handles.ID_popupmenu,'Value',CI_list_index);

% pop_ID to edit_ID
pop_ID_index=get(handles.ID_popupmenu,'Value');
pop_ID_items=get(handles.ID_popupmenu,'String');
pop_sel_item_ID = pop_ID_items{pop_ID_index};
set(handles.ID_edit_box,'String',pop_sel_item_ID);

% pop_ID to CI_show
set(handles.CI_show,'String',table2array(personal_table_CI_first(CI_list_index,2)));
assignin('base','nombre_trabajador',table2array(personal_table_CI_first(CI_list_index,2)));


% pop_ID to table
clean_db_sel_indexes = find(table2array(clean_clock(:,1))==table2array(personal_table_CI_first(CI_list_index,3)));
assignin('base','clean_db_sel_indexes',clean_db_sel_indexes);
% set(handles.uitable1,'Data',table2cell(clean_clock(clean_db_sel_indexes,:)));
clean_db_sel_data=clean_clock(clean_db_sel_indexes,:);
assignin('base','clean_db_sel_data',clean_db_sel_data);

% pop_ID to name_popupmenu
set(handles.name_popupmenu,'Value',CI_list_index);

% Filtrar fecha
filtrar_fecha_Callback(handles.filtrar_fecha,[],handles);



% --- Executes during object creation, after setting all properties.
function CI_edit_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CI_edit_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function in_date_Callback(hObject, eventdata, handles)
% hObject    handle to in_date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of in_date as text
%        str2double(get(hObject,'String')) returns contents of in_date as a double


% --- Executes during object creation, after setting all properties.
function in_date_CreateFcn(hObject, eventdata, handles)
% hObject    handle to in_date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_date_Callback(hObject, eventdata, handles)
% hObject    handle to end_date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of end_date as text
%        str2double(get(hObject,'String')) returns contents of end_date as a double


% --- Executes during object creation, after setting all properties.
function end_date_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filtrar_fecha.
function filtrar_fecha_Callback(hObject, eventdata, handles)
% hObject    handle to filtrar_fecha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

horario_popupmenu_Callback(handles.horario_popupmenu,[],handles);

in_date_raw=get(handles.in_date,'String');
end_date_raw=get(handles.end_date,'String');

assignin('base','end_date_raw',end_date_raw);
assignin('base','in_date_raw',in_date_raw);

in_date=datestr(in_date_raw,'yyyy-mm-dd');
t1=datetime(in_date);
assignin('base','t1',t1);

end_date=datestr(end_date_raw,'yyyy-mm-dd');
t2=datetime(end_date);
assignin('base','t2',t2);

% dates to be compared with
dates_between=datestr(t1:t2,'yyyy/mm/dd');
assignin('base','dates_between',dates_between);

% Displaying dates
clean_db_sel_data=evalin('base', 'clean_db_sel_data');
dates_between_cell=cellstr(dates_between);
size_dates_between_cell=size(dates_between_cell);
clean_db_sel_data_cell=table2cell(clean_db_sel_data);
assignin('base','size_dates_between_cell',size_dates_between_cell);

% Get indexes
for k = 1:size_dates_between_cell
    D.(sprintf('index_day%d', k)) = find(strcmp((clean_db_sel_data_cell(:,2)),dates_between_cell{k}));
end

m=transpose(struct2cell(D));
assignin('base','indexes_cell',m);

% Get data
for k = 1:size_dates_between_cell
    E.(sprintf('data_day%d', k)) = (clean_db_sel_data{m{k},3});
end

n=transpose(struct2cell(E));
assignin('base','data_day_cell',n);

% Making even row and column data cell
col = size(n,2);
row = cellfun('size',n,1);
out_p = cell(max(row),col);
for k = 1:col
    out_p(1:row(k),k) = n{k};
end

y=out_p;
size_y=size(y);
for j = 1:size_y(1)
    for i = 1:size_y(2)
        if isempty(y{j,i})
            y{j,i} = '00:00:00';
        end
    end
end

% timbradas duration
timbradas_all(size_y(1),size_y(2)) = duration([00 00 00]);
for j = 1:size_y(1)
    for i = 1:size_y(2)
        timbradas_all(j,i) = duration(str2num(cell2mat(strrep(y(j,i),':',' '))));
    end
end

final=sort(timbradas_all,'ascend');

% move 0s
size_y=size(final);
moved_r=final;

for i = 1:size_y(1)
    for j = 1:size_y(2)
        if final(i,j) == duration([00 00 00])
            vieja=moved_r;
            moved_r(1:end-1,j)=vieja(2:end,j);
            moved_r(end,j)=vieja(1,j);
            vieja=moved_r;
        end
    end
end

final=moved_r;
assignin('base','final',final);


assignin('base','out_p',out_p);
columns=transpose(cellstr(datestr(dates_between_cell,'ddd dd mmm yyyy','local')));
assignin('base','columns',columns);

size_old_data=size(out_p);

descartadas_data{size_old_data(1),size_old_data(2)}=[];

set(handles.descartadas_table,'Data',descartadas_data);
set(handles.data_table,'Data',cellstr(final));
set(handles.descuentos_table,'ColumnWidth',{'auto'});

set(handles.original_table,'Data',out_p);

set(handles.data_table,'ColumnName',columns);
set(handles.horario_full_table,'ColumnName',columns);
set(handles.descartadas_table,'ColumnName',columns);
set(handles.descuentos_table,'ColumnName',columns);
set(handles.original_table,'ColumnName',columns);
set(handles.horas_extras_table,'ColumnName',columns);

rnames_descuentos = {'D.E.','D.A.','D.S.','P.P','C.H.','Multa'};
assignin('base','rnames_descuentos',rnames_descuentos);
set(handles.descuentos_table,'RowName',rnames_descuentos);

set(handles.horario_popupmenu,'Value',1);

rnames_horas_extras_table = {'Normales','L-V 50%','L-V 25%','Mad 100%','S-D 100%','Fer. 100%'};
set(handles.horas_extras_table,'RowName',rnames_horas_extras_table);
assignin('base','rnames_horas_extras_table',rnames_horas_extras_table);


rnames_suma_extras_table = {'Normales','L-V 50%','L-V 25%','Mad 100%','S-D 100%','Fer. 100%'};
set(handles.suma_extras_table,'RowName',rnames_suma_extras_table);

horario=evalin('base', 'horario');

horario_full=repmat(horario,1,size_dates_between_cell(1));
assignin('base','horario_full',horario_full);

set(handles.horario_full_table,'Data',horario_full);





% names={'name1';'name2';'name3'};
% checkbox1={false;false;false};
C    = cell(size_dates_between_cell(1),1);
C(:) = {true};

yourdata =[transpose(columns) C] ;
columnname =   {'Día', 'Check'};
columnformat = {'char', 'logical'};
columneditable =  [false true];

set(handles.aut_extras_table,'Units','normalized',...
    'Data', yourdata,...
    'ColumnName', columnname,...
    'ColumnFormat', columnformat,...
    'ColumnEditable', columneditable,...
    'RowName',[],'BackgroundColor',[.7 .9 .8],'ForegroundColor',[0 0 0],...
    'ColumnWidth',{'auto'});

% aprobadas=get(handles.aut_extras_table,'Data');
% assignin('base','aprobadas',aprobadas);


% --- Executes on selection change in name_popupmenu.
function name_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to name_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns name_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from name_popupmenu

personal_table_ID_first=evalin('base', 'personal_table_ID_first');
personal_table_CI_first=evalin('base', 'personal_table_CI_first');
clean_clock=evalin('base', 'clean_clock');

% pop_name to edit_ID
pop_name_index=get(handles.name_popupmenu,'Value');
pop_name_items=get(handles.ID_popupmenu,'String');
pop_sel_item_name = pop_name_items{pop_name_index};
set(handles.ID_edit_box,'String',pop_sel_item_name);

% edit_ID to pop_ID
search_str=get(handles.ID_edit_box,'String');
ID_list_index = find(table2array(personal_table_ID_first)==search_str);
assignin('base','ID_list_index',ID_list_index);
set(handles.ID_popupmenu,'Value',ID_list_index);

% edit_ID to pop_CI
set(handles.CI_popupmenu,'Value',ID_list_index);

% pop_CI to edit_CI
pop_CI_index=get(handles.CI_popupmenu,'Value');
pop_CI_items=get(handles.CI_popupmenu,'String');
pop_sel_item_CI = pop_CI_items{pop_CI_index};
set(handles.CI_edit_box,'String',pop_sel_item_CI);

% pop_ID to table
clean_db_sel_indexes = find(table2array(clean_clock(:,1))==table2array(personal_table_CI_first(ID_list_index,3)));
assignin('base','clean_db_sel_indexes',clean_db_sel_indexes);
% set(handles.uitable1,'Data',table2cell(clean_clock(clean_db_sel_indexes,:)));
clean_db_sel_data=clean_clock(clean_db_sel_indexes,:);
assignin('base','clean_db_sel_data',clean_db_sel_data);

% pop_ID to CI_show
set(handles.CI_show,'String',table2array(personal_table_CI_first(ID_list_index,2)));
assignin('base','nombre_trabajador',table2array(personal_table_CI_first(ID_list_index,2)));


% Filtrar fecha
filtrar_fecha_Callback(handles.filtrar_fecha,[],handles);


% --- Executes during object creation, after setting all properties.
function name_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in horario_popupmenu.
function horario_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to horario_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns horario_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from horario_popupmenu

% size_dates_between_cell=evalin('base', 'size_dates_between_cell');

% Horarios = {'Profesor';'Administrativo';'Especial'};
%
% set(handles.horario_popupmenu,'String',Horarios);

pop_horario_index=get(handles.horario_popupmenu,'Value');
pop_horario_items=get(handles.horario_popupmenu,'String');
pop_sel_item_horario = pop_horario_items{pop_horario_index};

Profesor = cellstr(string(duration([8 00 00; 10 45 00; 11 00 00; 13 00 00; 13 45 00; 15 45 00; 16 00 00; 17 00 00])));
Administrativo = cellstr(string(duration([8 00 00; 13 00 00; 13 45 00; 16 45 00;])));
At_Cliente = cellstr(string(duration([8 00 00; 13 00 00; 13 00 00; 16 00 00;])));
Especial = cellstr(string(duration([5 00 00; 5 45 00; 5 00 00; 5 00 00; 5 45 00; 5 45 00; 5 00 00; 1 00 00])));

rnames_data = {'Entrada','S. Alm.','E. Alm.','Salida'};
assignin('base','rnames_data',rnames_data);

rnames_total_horas_duration = {'Mañana','Tarde','Total'};
assignin('base','rnames_total_horas_duration',rnames_total_horas_duration);

rnames_total_descuentos = {'D.E.','D.A.','D.S.','P.P','C.H.','Multa','Total'};
assignin('base','rnames_total_descuentos',rnames_total_descuentos);

rnames_horas_extras_table = {'Normales','L-V 50%','L-V 25%','Mad 100%','S-D 100%','Fer. 100%'};
assignin('base','rnames_horas_extras_table',rnames_horas_extras_table);

switch pop_sel_item_horario
    
    case 'Profesor'
        set(handles.Horario,'Data',Profesor);
        assignin('base','horario',Profesor);
        %         horario_full=repmat(Profesor,1,size_dates_between_cell(1));
        %         set(handles.horario_full_table,'Data',horario_full);
        %         assignin('base','horario_full',horario_full);
        
    case 'Administrativo'
        set(handles.Horario,'Data',Administrativo);
        set(handles.data_table,'RowName',rnames_data);
        set(handles.horario_full_table,'RowName',rnames_data);
        set(handles.suma_horas_table,'RowName',rnames_total_horas_duration);
        set(handles.suma_descuentos_table,'RowName',rnames_total_descuentos);
        set(handles.suma_extras_table,'RowName',rnames_horas_extras_table);
        assignin('base','horario',Administrativo);
        
        %         horario_full=repmat(Administrativo,1,size_dates_between_cell(1));
        %         set(handles.horario_full_table,'Data',horario_full);
        %         assignin('base','horario_full',horario_full);
        
    case 'Especial'
        set(handles.Horario,'Data',Especial);
        assignin('base','horario',Especial);
        
        %         horario_full=repmat(Especial,1,size_dates_between_cell(1));
        %         set(handles.horario_full_table,'Data',horario_full);
        %         assignin('base','horario_full',horario_full);
end


% --- Executes during object creation, after setting all properties.
function horario_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to horario_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Actualizar.
function Actualizar_Callback(hObject, eventdata, handles)
% hObject    handle to Actualizar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% filtrar_fecha_Callback(handles.filtrar_fecha,[],handles);
% horario_popupmenu_Callback(handles.horario_popupmenu,[],handles);


% aprobadas=get(handles.aut_extras_table,'Data');
% assignin('base','aprobadas',aprobadas);

% --- Executes when selected cell(s) is changed in data_table.
function data_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to data_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(eventdata.Indices)
    selectedRow = eventdata.Indices(1);
    selectedCol = eventdata.Indices(2);
    assignin('base','selectedRow',selectedRow);
    assignin('base','selectedCol',selectedCol);
end




% --- Executes on button press in insert_down.
function insert_down_Callback(hObject, eventdata, handles)
% hObject    handle to insert_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selectedRow=evalin('base', 'selectedRow');
selectedCol=evalin('base', 'selectedCol');

old_data = get(handles.data_table,'Data');
size_old_data=size(old_data);

old_column=old_data(:,selectedCol);

% Preallocate space for cell
new_column{size_old_data(1)+1,1}=[];

% Allocate 1st part
new_column(1:selectedRow)=old_column(1:selectedRow);

% Allocate last part
new_column(selectedRow+2:end)=old_column(selectedRow+1:end);

old_data{end+1,end}=[];

old_data(:,selectedCol)=new_column;

%Limpiar
out_final = old_data(~all(cellfun(@numel,old_data)==0,2),:);

set(handles.data_table,'Data',out_final);


% --- Executes on button press in insert_up.
function insert_up_Callback(hObject, eventdata, handles)
% hObject    handle to insert_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selectedRow=evalin('base', 'selectedRow');
selectedCol=evalin('base', 'selectedCol');

old_data = get(handles.data_table,'Data');
size_old_data=size(old_data);

old_column=old_data(:,selectedCol);

% Preallocate space for cell
new_column{size_old_data(1)+1,1}=[];

% Allocate 1st part
new_column(1:selectedRow-1)=old_column(1:selectedRow-1);

% Allocate last part
new_column(selectedRow+1:end)=old_column(selectedRow:end);

old_data{end+1,end}=[];

old_data(:,selectedCol)=new_column;

%Limpiar
out_final = old_data(~all(cellfun(@numel,old_data)==0,2),:);

set(handles.data_table,'Data',out_final);

% --- Executes on button press in move_up.
function move_up_Callback(hObject, eventdata, handles)
% hObject    handle to move_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selectedRow=evalin('base', 'selectedRow');
selectedCol=evalin('base', 'selectedCol');

old_data = get(handles.data_table,'Data');

size_old_data=size(old_data);
previous_value=old_data(selectedRow,selectedCol);

old_column=old_data(:,selectedCol);

% Preallocate space for cell
new_column{size_old_data(1),1}=[];

% Allocate 1st part
new_column(1:selectedRow-2)=old_column(1:selectedRow-2);

% Allocate last part
new_column(selectedRow+1:end)=old_column(selectedRow+1:end);

% Move value up
new_column(selectedRow-1)=previous_value;

old_data(:,selectedCol)=new_column;

%Limpiar
out_final = old_data(~all(cellfun(@numel,old_data)==0,2),:);

set(handles.data_table,'Data',out_final);


% --- Executes on button press in move_down.
function move_down_Callback(hObject, eventdata, handles)
% hObject    handle to move_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selectedRow=evalin('base', 'selectedRow');
selectedCol=evalin('base', 'selectedCol');

old_data = get(handles.data_table,'Data');

size_old_data=size(old_data);
previous_value=old_data(selectedRow,selectedCol);

old_column=old_data(:,selectedCol);

% Preallocate space for cell
new_column{size_old_data(1),1}=[];

% Allocate 1st part
new_column(1:selectedRow-1)=old_column(1:selectedRow-1);

% Allocate last part
new_column(selectedRow+2:end)=old_column(selectedRow+2:end);

% Move value up
new_column(selectedRow+1)=previous_value;

old_data(:,selectedCol)=new_column;

%Limpiar
out_final = old_data(~all(cellfun(@numel,old_data)==0,2),:);

set(handles.data_table,'Data',out_final);

% --- Executes when entered data in editable cell(s) in data_table.
function data_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to data_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function hora_edit_Callback(hObject, eventdata, handles)
% hObject    handle to hora_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hora_edit as text
%        str2double(get(hObject,'String')) returns contents of hora_edit as a double


% --- Executes during object creation, after setting all properties.
function hora_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hora_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in insertar.
function insertar_Callback(hObject, eventdata, handles)
% hObject    handle to insertar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

in_hour=get(handles.hora_edit,'String');
assignin('base','in_hour',in_hour);

selectedRow=evalin('base', 'selectedRow');
selectedCol=evalin('base', 'selectedCol');

old_data = get(handles.data_table,'Data');

old_data(selectedRow,selectedCol)=cellstr(in_hour);

%Limpiar
out_final = old_data(~all(cellfun(@numel,old_data)==0,2),:);

set(handles.data_table,'Data',out_final);


% --- Executes on button press in descartar.
function descartar_Callback(hObject, eventdata, handles)
% hObject    handle to descartar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selectedRow=evalin('base', 'selectedRow');
selectedCol=evalin('base', 'selectedCol');

% Data table
old_data = get(handles.data_table,'Data');
selected_value=old_data(selectedRow,selectedCol);
old_data(selectedRow,selectedCol)={''};

%Limpiar
out_final = old_data(~all(cellfun(@numel,old_data)==0,2),:);
set(handles.data_table,'Data',out_final);

% Descartadas table
old_data_descartadas = get(handles.descartadas_table,'Data');
old_data_descartadas(selectedRow,selectedCol)=selected_value;
set(handles.descartadas_table,'Data',old_data_descartadas);


% --- Executes on button press in contar.
function contar_Callback(hObject, eventdata, handles)
% hObject    handle to contar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% cellstr(table2array(sel_CI))
% sel_CI=evalin('base', 'sel_CI');
t1=evalin('base', 't1');
t2=evalin('base', 't2');
nombre_trabajador=evalin('base', 'nombre_trabajador');



set(handles.push_guardar,'Visible','On');

save_name=strcat(cellstr(nombre_trabajador),{', '},cellstr(t1),{', '},cellstr(t2));
assignin('base','save_name',save_name);

set(handles.text35,'String',save_name);

set(handles.contar_extras_entrada_check,'Value',0);
set(handles.contar_extras_salida_check,'Value',0);
set(handles.no_extras_check,'Value',0);
set(handles.ambas_check,'Value',0);

set(handles.descontar_doble_check,'Value',0);
set(handles.descuento_simple_check,'Value',1);

fixed_data = get(handles.data_table,'Data');
assignin('base','fixed_data',fixed_data);
size_dates_between_cell=evalin('base', 'size_dates_between_cell');
dates_between=evalin('base', 'dates_between');
horario_full=evalin('base', 'horario_full');


y=fixed_data;
size_y=size(y);

% timbradas duration
timbradas_all(size_y(1),size_y(2)) = duration([00 00 00]);
for j = 1:size_y(1)
    for i = 1:size_y(2)
        timbradas_all(j,i) = duration(str2num(cell2mat(strrep(y(j,i),':',' '))));
    end
end

assignin('base','timbradas_all',timbradas_all);

% horario duration
horario_all(size_y(1),size_y(2)) = duration([00 00 00]);
for j = 1:size_y(1)
    for i = 1:size_y(2)
        horario_all(j,i) = duration(str2num(cell2mat(strrep(horario_full(j,i),':',' '))));
    end
end

% assignin('base','timbradas_all',timbradas_all);


% Horas mañana y tarde
prior_lunch_duration_2(1,size_dates_between_cell(1)) = duration([00 00 00]);
after_lunch_duration_2(1,size_dates_between_cell(1)) = duration([00 00 00]);

% Total diario
total_diario(1,size_dates_between_cell(1)) = duration([00 00 00]);

% Diferencia almuerzos (duration)
diferencia_lunch_duration(1,size_dates_between_cell(1)) = duration([00 00 00]);

% Descuentos
descuentos_duration_2(6,size_dates_between_cell(1)) = duration([00 00 00]);

% horas extras
horas_50(1,size_dates_between_cell(1)) = duration([00 00 00]);
horas_25(1,size_dates_between_cell(1)) = duration([00 00 00]);
horas_100_madrugada(1,size_dates_between_cell(1)) = duration([00 00 00]);
horas_100_SD(1,size_dates_between_cell(1)) = duration([00 00 00]);
horas_100_fer(1,size_dates_between_cell(1)) = duration([00 00 00]);
extras_duration(4,size_dates_between_cell(1)) = duration([00 00 00]);

% Fines de semana
[DayNumber,DayName] = weekday(datenum(dates_between));
Index_Sat = find(contains(string(DayName),'Sat'));
Index_Sun = find(contains(string(DayName),'Sun'));

% Dates yyyy/mm/dd
% fer_all={'2018/01/07','2018/01/09','2018/01/10'};
% fer_all={''};
% 

% FERIADOS, COMENTAR SI NO HAY, INCLUIDO DENTRO DE LOOP
% fer_all={'2018/05/21'};
% Index_fer(1,length(fer_all))=0;
% assignin('base','fer_all',fer_all);
% 
% for i = 1: length(fer_all)
%     Index_fer(1,i)=find(contains(string(dates_between),fer_all{i}));
% end
% 


% Flag
sas(1,size_dates_between_cell(1))=0;

b=duration([00 45 00]);

% Horas
for k = 1:size_dates_between_cell(1)
    
    % Horas mañana y tarde
    prior_lunch_duration_2(1,k)=timbradas_all(2,k)-timbradas_all(1,k);
    after_lunch_duration_2(1,k)=timbradas_all(4,k)-timbradas_all(3,k);
    
    % Horas normales
    total_diario(1,k) = prior_lunch_duration_2(1,k) + after_lunch_duration_2(1,k);
    
    % Diferencia almuerzos
    diferencia_lunch_duration(1,k)=timbradas_all(3,k)-timbradas_all(2,k);
    
    % Descuentos Entrada
    if timbradas_all(1,k) >= horario_all(1,k)
        descuentos_duration_2(1,k)=timbradas_all(1,k) - horario_all(1,k);
    else
        descuentos_duration_2(1,k) = duration([00 00 00]);
    end
    
    % Descuentos Salida
    if timbradas_all(4,k) <= horario_all(4,k)
        descuentos_duration_2(3,k) = horario_all(4,k) - timbradas_all(4,k);
    else
        descuentos_duration_2(3,k) = duration([00 00 00]);
    end
    
    % Descuentos Almuerzos
    if diferencia_lunch_duration(1, k) >= b
        descuentos_duration_2(2,k) = diferencia_lunch_duration(1, k) - b;
    else
        descuentos_duration_2(2,k) = duration([00 00 00]);
    end
    
    % horas_50
    if timbradas_all(4,k) >= duration([16 45 00])
        horas_50(1,k)= timbradas_all(4,k) - duration([16 45 00]);
        a(1,k)=1;
        
    else
        a(1,k)=0;
        horas_50(1,k)=duration([00 00 00]);
    end
    
    % horas_25
    if timbradas_all(4,k) >= duration([19 00 00])
        horas_25(1,k)= timbradas_all(4,k) - duration([19 00 00]);
        a(2,k)=1;
    else
        a(2,k)=0;
        horas_25(1,k)=duration([00 00 00]);
    end
    
    % horas_100_madrugada
    if timbradas_all(4,k) <= duration([08 00 00]) && timbradas_all(4,k) >= duration([00 00 01])
        horas_100_madrugada(1,k)= timbradas_all(4,k);
        horas_50(1,k)= duration([24 00 00]) - duration([16 45 00]);
        horas_25(1,k)= duration([24 00 00]) - duration([19 00 00]);
        a(3,k)=1;
    else
        a(3,k)=0;
        horas_100_madrugada(1,k)=duration([00 00 00]);
    end
    
    % Sábados
    if ismember(k,Index_Sat)
        sas(1,k) = 1;
        horas_25(1,k)=duration([00 00 00]);
        horas_50(1,k)=duration([00 00 00]);
        extras_duration([1 2 3 4],k)=duration([00 00 00]);
        horas_100_SD(1,k)=prior_lunch_duration_2(1,k) + after_lunch_duration_2(1,k);
    end
    
    % Domingos
    if ismember(k,Index_Sun)
        sas(1,k) = 1;
        horas_25(1,k)=duration([00 00 00]);
        horas_50(1,k)=duration([00 00 00]);
        extras_duration([1 2 3 4],k)=duration([00 00 00]);
        horas_100_SD(1,k)=prior_lunch_duration_2(1,k) + after_lunch_duration_2(1,k);
    end
    
%     % Feriados
%     if ismember(k,Index_fer)
%         horas_25(1,k)=duration([00 00 00]);
%         horas_50(1,k)=duration([00 00 00]);
%         extras_duration([1 2 3 4],k)=duration([00 00 00]);
%         horas_100_fer(1,k)=prior_lunch_duration_2(1,k) + after_lunch_duration_2(1,k);
%     end
    
end

extras_duration(1,:)=total_diario;
extras_duration(2,:)=horas_50;
extras_duration(3,:)=horas_25;
extras_duration(4,:)=horas_100_madrugada;
extras_duration(5,:)=horas_100_SD;
extras_duration(6,:)=horas_100_fer;

% Calcular suma de descuentos
total_descuentos_duration(7,1)=sum(descuentos_duration_2(:));
for k = 1:6
    total_descuentos_duration(k,1)=sum(descuentos_duration_2(k,:));
end

% Calcular suma de extras
total_extras_duration(6,1)=duration([00 00 00]);
for k = 1:6
    total_extras_duration(k,1)=sum(extras_duration(k,:));
end

% Sumar horas normales
total_manana_duration=sum(prior_lunch_duration_2(:));
total_tarde_duration=sum(after_lunch_duration_2(:));
total_mes_duration=sum(prior_lunch_duration_2(:) + after_lunch_duration_2(:));

% Total mañana + tarde = mes
total_horas_duration(1,:)=total_manana_duration;
total_horas_duration(2,:)=total_tarde_duration;
total_horas_duration(3,:)=total_mes_duration;

cell_descuentos=cellstr(descuentos_duration_2);
cell_extras=cellstr(extras_duration);

cell_total_extras=cellstr(total_extras_duration);
cell_total_descuentos=cellstr(total_descuentos_duration);
cell_total_horas_duration=cellstr(total_horas_duration);

set(handles.descuentos_table,'Data',cell_descuentos);
set(handles.horas_extras_table,'Data',cell_extras);
set(handles.suma_descuentos_table,'Data',cell_total_descuentos);
set(handles.suma_extras_table,'Data',cell_total_extras);
set(handles.suma_horas_table,'Data',cell_total_horas_duration);

assignin('base','descuentos_duration_2',descuentos_duration_2);
assignin('base','extras_duration',extras_duration);
assignin('base','total_extras_duration',total_extras_duration);
assignin('base','total_descuentos_duration',total_descuentos_duration);
assignin('base','total_horas_duration',total_horas_duration);

assignin('base','total_diario',total_diario);

assignin('base','cell_descuentos',cell_descuentos);
assignin('base','cell_extras',cell_extras);
assignin('base','cell_total_extras',cell_total_extras);
assignin('base','cell_total_descuentos',cell_total_descuentos);
assignin('base','cell_total_horas_duration',cell_total_horas_duration);



% --- Executes on button press in contar_extras_entrada_check.
function contar_extras_entrada_check_Callback(hObject, eventdata, handles)
% hObject    handle to contar_extras_entrada_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of contar_extras_entrada_check
set(handles.contar_extras_entrada_check,'Value',1);
set(handles.contar_extras_salida_check,'Value',0);
set(handles.no_extras_check,'Value',0);
set(handles.ambas_check,'Value',0);

cell_extras=evalin('base', 'cell_extras');
total_extras_duration=evalin('base', 'total_extras_duration');

new_sum(1,1)=total_extras_duration(1,1);
new_sum(2,1)=duration([00 00 00]);
new_sum(3,1)=sum(new_sum);

previous_extras=cell_extras;
empty_data=repmat(cellstr(duration([00 00 00])),1,length(previous_extras));
data(1,:)=previous_extras(1,:);
data(2,:)=empty_data;

set(handles.horas_extras_table,'Data',data);
set(handles.suma_extras_table,'Data',cellstr(new_sum));




% --- Executes on button press in contar_extras_salida_check.
function contar_extras_salida_check_Callback(hObject, eventdata, handles)
% hObject    handle to contar_extras_salida_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of contar_extras_salida_check
set(handles.contar_extras_entrada_check,'Value',0);
set(handles.contar_extras_salida_check,'Value',1);
set(handles.no_extras_check,'Value',0);
set(handles.ambas_check,'Value',0);

cell_extras=evalin('base', 'cell_extras');
total_extras_duration=evalin('base', 'total_extras_duration');

previous_extras=cell_extras;
new_sum(1,1)=duration([00 00 00]);
new_sum(2,1)=total_extras_duration(2,1);
new_sum(3,1)=sum(new_sum);

empty_data=repmat(cellstr(duration([00 00 00])),1,length(previous_extras));
data(1,:)=empty_data;
data(2,:)=previous_extras(2,:);
set(handles.horas_extras_table,'Data',data);
set(handles.suma_extras_table,'Data',cellstr(new_sum));


% --- Executes on button press in no_extras_check.
function no_extras_check_Callback(hObject, eventdata, handles)
% hObject    handle to no_extras_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of no_extras_check

set(handles.contar_extras_entrada_check,'Value',0);
set(handles.contar_extras_salida_check,'Value',0);
set(handles.no_extras_check,'Value',1);
set(handles.ambas_check,'Value',0);

cell_extras=evalin('base', 'cell_extras');

previous_extras=cell_extras;
empty_data=repmat(cellstr(duration([00 00 00])),1,length(previous_extras));
data(1,:)=empty_data;
data(2,:)=empty_data;
set(handles.horas_extras_table,'Data',data);

new_sum(1,1)=duration([00 00 00]);new_sum(2,1)=duration([00 00 00]);
new_sum(3,1)=duration([00 00 00]);
set(handles.suma_extras_table,'Data',cellstr(new_sum));


% --- Executes on button press in ambas_check.
function ambas_check_Callback(hObject, eventdata, handles)
% hObject    handle to ambas_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ambas_check
set(handles.contar_extras_entrada_check,'Value',0);
set(handles.contar_extras_salida_check,'Value',0);
set(handles.no_extras_check,'Value',0);
set(handles.ambas_check,'Value',1);

cell_extras=evalin('base', 'cell_extras');
total_extras_duration=evalin('base', 'total_extras_duration');

set(handles.suma_extras_table,'Data',cellstr(total_extras_duration));
set(handles.horas_extras_table,'Data',cell_extras);


% --- Executes on button press in descontar_doble_check.
function descontar_doble_check_Callback(hObject, eventdata, handles)
% hObject    handle to descontar_doble_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of descontar_doble_check

set(handles.descuento_simple_check,'Value',0);

size_dates_between_cell=evalin('base', 'size_dates_between_cell');

descuentos_cell_old = get(handles.descuentos_table,'Data');

descuentos_duration=evalin('base', 'descuentos_duration_2');
total_descuentos_duration=evalin('base', 'total_descuentos_duration');

descuentos_duration_double(1,size_dates_between_cell(1))=duration([00 00 00]);
for k = 1:size_dates_between_cell(1)
    if descuentos_duration(1,k) >= duration([00 06 00])
        descuentos_duration_double(1,k) = descuentos_duration(1,k) * 2;
    else
        descuentos_duration_double(1,k)=descuentos_duration(1,k);
    end
end
descuentos_new(1,:)=cellstr(descuentos_duration_double);
descuentos_new(2,:)=descuentos_cell_old(2,:);
descuentos_new(3,:)=descuentos_cell_old(3,:);
descuentos_new(4,:)=descuentos_cell_old(4,:);
descuentos_new(5,:)=descuentos_cell_old(5,:);

total_descuentos_duration(1,1)=sum(descuentos_duration_double);
total_descuentos_duration(6,1)=sum(total_descuentos_duration(1:5));

set(handles.descuentos_table,'Data',descuentos_new);
set(handles.suma_descuentos_table,'Data',cellstr(total_descuentos_duration));


% --- Executes on button press in descuento_simple_check.
function descuento_simple_check_Callback(hObject, eventdata, handles)
% hObject    handle to descuento_simple_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of descuento_simple_check

set(handles.descontar_doble_check,'Value',0);

descuentos_duration=evalin('base', 'descuentos_duration_2');
total_descuentos_duration=evalin('base', 'total_descuentos_duration');

set(handles.descuentos_table,'Data',cellstr(descuentos_duration));
set(handles.suma_descuentos_table,'Data',cellstr(total_descuentos_duration));


function edit_new_hour_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_hour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_hour as text
%        str2double(get(hObject,'String')) returns contents of edit_new_hour as a double


% --- Executes during object creation, after setting all properties.
function edit_new_hour_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_hour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_insertar_horario.
function push_insertar_horario_Callback(hObject, eventdata, handles)
% hObject    handle to push_insertar_horario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


in_hour_horario=get(handles.edit_new_hour,'String');
assignin('base','in_hour_horario',in_hour_horario);

selectedRow_horario=evalin('base', 'selectedRow_horario');
selectedCol_horario=evalin('base', 'selectedCol_horario');

horario_full=get(handles.horario_full_table,'Data');

horario_full(selectedRow_horario,selectedCol_horario)=cellstr(in_hour_horario);

out_final=horario_full;

set(handles.horario_full_table,'Data',out_final);
assignin('base','horario_full',out_final);

% contar_Callback(handles.contar,[],handles);


% --- Executes when selected cell(s) is changed in horario_full_table.
function horario_full_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to horario_full_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(eventdata.Indices)
    selectedRow_horario = eventdata.Indices(1);
    selectedCol_horario = eventdata.Indices(2);
    assignin('base','selectedRow_horario',selectedRow_horario);
    assignin('base','selectedCol_horario',selectedCol_horario);
end


% --- Executes when selected cell(s) is changed in descuentos_table.
function descuentos_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to descuentos_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(eventdata.Indices)
    selectedRow_descuentos = eventdata.Indices(1);
    selectedCol_descuentos = eventdata.Indices(2);
    assignin('base','selectedRow_descuentos',selectedRow_descuentos);
    assignin('base','selectedCol_descuentos',selectedCol_descuentos);
    
    % Permiso Personal
    if selectedRow_descuentos == 4 || selectedRow_descuentos == 5 || selectedRow_descuentos == 6
        set(handles.push_insertar_descuento,'Visible','On');
        set(handles.nuevo_descuento_txt,'Visible','On');
    else
        set(handles.push_insertar_descuento,'Visible','Off');
        set(handles.nuevo_descuento_txt,'Visible','Off');
    end
    
    %     % Permiso Personal
    %     if selectedRow_descuentos == 5
    %         set(handles.push_insertar_descuento,'Visible','On');
    %         set(handles.nuevo_descuento_txt,'Visible','On');
    %     else
    %         set(handles.push_insertar_descuento,'Visible','Off');
    %         set(handles.nuevo_descuento_txt,'Visible','Off');
    %     end
    %
    
end



function nuevo_descuento_txt_Callback(hObject, eventdata, handles)
% hObject    handle to nuevo_descuento_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nuevo_descuento_txt as text
%        str2double(get(hObject,'String')) returns contents of nuevo_descuento_txt as a double


% --- Executes during object creation, after setting all properties.
function nuevo_descuento_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nuevo_descuento_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_insertar_descuento.
function push_insertar_descuento_Callback(hObject, eventdata, handles)
% hObject    handle to push_insertar_descuento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

in_hour_descuento=get(handles.nuevo_descuento_txt,'String');
assignin('base','in_hour_descuento',in_hour_descuento);

selectedRow_descuentos=evalin('base', 'selectedRow_descuentos');
selectedCol_descuentos=evalin('base', 'selectedCol_descuentos');
descuentos_duration_2=evalin('base', 'descuentos_duration_2');

descuentos_duration_2(selectedRow_descuentos,selectedCol_descuentos)=duration(str2num(cell2mat(strrep(cellstr(in_hour_descuento),':',' '))));

% Calcular suma de descuentos
total_descuentos_duration(7,1)=sum(descuentos_duration_2(:));
for k = 1:6
    total_descuentos_duration(k,1)=sum(descuentos_duration_2(k,:));
end

cell_descuentos=cellstr(descuentos_duration_2);
cell_total_descuentos=cellstr(total_descuentos_duration);

assignin('base','cell_descuentos',cell_descuentos);
assignin('base','cell_total_descuentos',cell_total_descuentos);
assignin('base','descuentos_duration_2',descuentos_duration_2);
assignin('base','total_descuentos_duration',total_descuentos_duration);

set(handles.suma_descuentos_table,'Data',cell_total_descuentos);
set(handles.descuentos_table,'Data',cell_descuentos);


% --- Executes when selected cell(s) is changed in aut_extras_table.
function aut_extras_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to aut_extras_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% aprobadas=get(handles.aut_extras_table,'Data');
% assignin('base','aprobadas',aprobadas);


% --- Executes when entered data in editable cell(s) in aut_extras_table.
function aut_extras_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to aut_extras_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

aprobadas=get(handles.aut_extras_table,'Data');
assignin('base','aprobadas',aprobadas);

extras_duration=evalin('base', 'extras_duration');



for k = 1:length(aprobadas)
    if aprobadas{k,2} == 0
        extras_duration(:,k)=duration([00 00 00]);
    else
        extras_duration(:,k)=extras_duration(:,k);
    end
    
end

% Calcular suma de extras
total_extras_duration(5,1)=duration([00 00 00]);
for k = 1:5
    total_extras_duration(k,1)=sum(extras_duration(k,:));
end



cell_extras=cellstr(extras_duration);

cell_total_extras=cellstr(total_extras_duration);

set(handles.horas_extras_table,'Data',cell_extras);
set(handles.suma_extras_table,'Data',cell_total_extras);



% --- Executes on button press in push_insertar_libre.
function push_insertar_libre_Callback(hObject, eventdata, handles)
% hObject    handle to push_insertar_libre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selectedRow_horario=evalin('base', 'selectedRow_horario');
selectedCol_horario=evalin('base', 'selectedCol_horario');

horario_full=get(handles.horario_full_table,'Data');

horario_full(:,selectedCol_horario)=cellstr('00:00:00');

out_final=horario_full;

set(handles.horario_full_table,'Data',out_final);
assignin('base','horario_full',out_final);



% --- Executes on button press in horario_libre_check.
function horario_libre_check_Callback(hObject, eventdata, handles)
% hObject    handle to horario_libre_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of horario_libre_check

value = get(handles.horario_libre_check, 'Value');


if value ==1
    set(handles.contar,'Visible','Off');
    set(handles.horario_full_table,'Visible','Off');
    set(handles.text32,'Visible','Off');
    set(handles.edit_new_hour,'Visible','Off');
    set(handles.push_insertar_horario,'Visible','Off');
    set(handles.push_insertar_libre,'Visible','Off');
    set(handles.horario_popupmenu,'Visible','Off');
    set(handles.Horario,'Visible','Off');
    set(handles.contar_libre,'Visible','On');
    
else
    set(handles.contar,'Visible','On');
    set(handles.horario_full_table,'Visible','On');
    set(handles.text32,'Visible','On');
    set(handles.edit_new_hour,'Visible','On');
    set(handles.push_insertar_horario,'Visible','On');
    set(handles.push_insertar_libre,'Visible','On');
    set(handles.horario_popupmenu,'Visible','On');
    set(handles.Horario,'Visible','On');
    set(handles.contar_libre,'Visible','Off');
end








%


% --- Executes on button press in contar_libre.
function contar_libre_Callback(hObject, eventdata, handles)
% hObject    handle to contar_libre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.descontar_doble_check,'Value',0);
set(handles.descuento_simple_check,'Value',1);

fixed_data = get(handles.data_table,'Data');
assignin('base','fixed_data',fixed_data);
size_dates_between_cell=evalin('base', 'size_dates_between_cell');
dates_between=evalin('base', 'dates_between');
horario_full=evalin('base', 'horario_full');

y=fixed_data;
size_y=size(y);

% timbradas duration
timbradas_all(size_y(1),size_y(2)) = duration([00 00 00]);
for j = 1:size_y(1)
    for i = 1:size_y(2)
        timbradas_all(j,i) = duration(str2num(cell2mat(strrep(y(j,i),':',' '))));
    end
end

% horario duration
horario_all(size_y(1),size_y(2)) = duration([00 00 00]);
for j = 1:size_y(1)
    for i = 1:size_y(2)
        horario_all(j,i) = duration(str2num(cell2mat(strrep(horario_full(j,i),':',' '))));
    end
end

assignin('base','timbradas_all',timbradas_all);


% Horas mañana y tarde
prior_lunch_duration_2(1,size_dates_between_cell(1)) = duration([00 00 00]);
after_lunch_duration_2(1,size_dates_between_cell(1)) = duration([00 00 00]);

% Diferencia almuerzos (duration)
diferencia_lunch_duration(1,size_dates_between_cell(1)) = duration([00 00 00]);

% Descuentos
descuentos_duration_2(6,size_dates_between_cell(1)) = duration([00 00 00]);

% horas extras
horas_50(1,size_dates_between_cell(1)) = duration([00 00 00]);
horas_25(1,size_dates_between_cell(1)) = duration([00 00 00]);
horas_100_madrugada(1,size_dates_between_cell(1)) = duration([00 00 00]);
horas_100_SD(1,size_dates_between_cell(1)) = duration([00 00 00]);
horas_100_fer(1,size_dates_between_cell(1)) = duration([00 00 00]);
extras_duration(4,size_dates_between_cell(1)) = duration([00 00 00]);

% Fines de semana
[DayNumber,DayName] = weekday(datenum(dates_between));
Index_Sat = find(contains(string(DayName),'Sat'));
Index_Sun = find(contains(string(DayName),'Sun'));

% Dates yyyy/mm/dd
% fer_all={'2018/01/07','2018/01/09','2018/01/10'};
fer_all={'2018/05/19'};
% fer_all={''};
Index_fer(1,length(fer_all))=0;

for i = 1: length(fer_all)
    Index_fer(1,i)=find(contains(string(dates_between),fer_all{i}));
end

% Flag
sas(1,size_dates_between_cell(1))=0;

b=duration([00 45 00]);

% Horas
for k = 1:size_dates_between_cell(1)
    
    % Horas mañana y tarde
    prior_lunch_duration_2(1,k)=timbradas_all(2,k)-timbradas_all(1,k);
    after_lunch_duration_2(1,k)=timbradas_all(4,k)-timbradas_all(3,k);
    
    % horas_50
    if timbradas_all(4,k) >= duration([16 45 00])
        horas_50(1,k)= timbradas_all(4,k) - duration([16 45 00]);
        a(1,k)=1;
        
    else
        a(1,k)=0;
        horas_50(1,k)=duration([00 00 00]);
    end
    
    % horas_25
    if timbradas_all(4,k) >= duration([19 00 00])
        horas_25(1,k)= timbradas_all(4,k) - duration([19 00 00]);
        a(2,k)=1;
    else
        a(2,k)=0;
        horas_25(1,k)=duration([00 00 00]);
    end
    
    % horas_100_madrugada
    if timbradas_all(4,k) <= duration([08 00 00]) && timbradas_all(4,k) >= duration([00 00 01])
        horas_100_madrugada(1,k)= timbradas_all(4,k);
        horas_50(1,k)= duration([24 00 00]) - duration([16 45 00]);
        horas_25(1,k)= duration([24 00 00]) - duration([19 00 00]);
        a(3,k)=1;
    else
        a(3,k)=0;
        horas_100_madrugada(1,k)=duration([00 00 00]);
    end
    
    % Sábados
    if ismember(k,Index_Sat)
        sas(1,k) = 1;
        horas_25(1,k)=duration([00 00 00]);
        horas_50(1,k)=duration([00 00 00]);
        extras_duration([1 2 3],k)=duration([00 00 00]);
        horas_100_SD(1,k)=prior_lunch_duration_2(1,k) + after_lunch_duration_2(1,k);
    end
    
    % Domingos
    if ismember(k,Index_Sun)
        sas(1,k) = 1;
        horas_25(1,k)=duration([00 00 00]);
        horas_50(1,k)=duration([00 00 00]);
        extras_duration([1 2 3],k)=duration([00 00 00]);
        horas_100_SD(1,k)=prior_lunch_duration_2(1,k) + after_lunch_duration_2(1,k);
    end
    
    % Feriados
    if ismember(k,Index_fer)
        horas_25(1,k)=duration([00 00 00]);
        horas_50(1,k)=duration([00 00 00]);
        extras_duration([1 2 3 4],k)=duration([00 00 00]);
        horas_100_fer(1,k)=prior_lunch_duration_2(1,k) + after_lunch_duration_2(1,k);
    end
    
end

extras_duration(1,:)=horas_50;
extras_duration(2,:)=horas_25;
extras_duration(3,:)=horas_100_madrugada;
extras_duration(4,:)=horas_100_SD;
extras_duration(5,:)=horas_100_fer;

% Calcular suma de descuentos
total_descuentos_duration(7,1)=sum(descuentos_duration_2(:));
for k = 1:6
    total_descuentos_duration(k,1)=sum(descuentos_duration_2(k,:));
end

% Calcular suma de extras
total_extras_duration(5,1)=duration([00 00 00]);
for k = 1:5
    total_extras_duration(k,1)=sum(extras_duration(k,:));
end

% Sumar horas normales
total_manana_duration=sum(prior_lunch_duration_2(:));
total_tarde_duration=sum(after_lunch_duration_2(:));
total_mes_duration=sum(prior_lunch_duration_2(:) + after_lunch_duration_2(:));

% Total mañana + tarde = mes
total_horas_duration(1,:)=total_manana_duration;
total_horas_duration(2,:)=total_tarde_duration;
total_horas_duration(3,:)=total_mes_duration;

cell_descuentos=cellstr(descuentos_duration_2);
cell_extras=cellstr(extras_duration);

cell_total_extras=cellstr(total_extras_duration);
cell_total_descuentos=cellstr(total_descuentos_duration);
cell_total_horas_duration=cellstr(total_horas_duration);

set(handles.descuentos_table,'Data',cell_descuentos);
set(handles.horas_extras_table,'Data',cell_extras);
set(handles.suma_descuentos_table,'Data',cell_total_descuentos);
set(handles.suma_extras_table,'Data',cell_total_extras);
set(handles.suma_horas_table,'Data',cell_total_horas_duration);

assignin('base','descuentos_duration_2',descuentos_duration_2);
assignin('base','extras_duration',extras_duration);
assignin('base','total_extras_duration',total_extras_duration);
assignin('base','total_descuentos_duration',total_descuentos_duration);
assignin('base','total_horas_duration',total_horas_duration);

assignin('base','cell_descuentos',cell_descuentos);
assignin('base','cell_extras',cell_extras);
assignin('base','cell_total_extras',cell_total_extras);
assignin('base','cell_total_descuentos',cell_total_descuentos);
assignin('base','cell_total_horas_duration',cell_total_horas_duration);












%


% --- Executes on button press in push_guardar.
function push_guardar_Callback(hObject, eventdata, handles)
% hObject    handle to push_guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

save_name=evalin('base', 'save_name');
columns=evalin('base', 'columns');
final=evalin('base', 'final');
horario_full=evalin('base', 'horario_full');
descuentos_duration_2=evalin('base', 'descuentos_duration_2');
cell_extras=evalin('base', 'cell_extras');
rnames_data=evalin('base', 'rnames_data');
rnames_descuentos=evalin('base', 'rnames_descuentos');
rnames_horas_extras_table=evalin('base', 'rnames_horas_extras_table');
rnames_total_horas_duration=evalin('base', 'rnames_total_horas_duration');
cell_total_horas_duration=evalin('base', 'cell_total_horas_duration');
cell_total_descuentos=evalin('base', 'cell_total_descuentos');
cell_total_extras=evalin('base', 'cell_total_extras');
rnames_total_descuentos=evalin('base', 'rnames_total_descuentos');




timbradas=vertcat(columns,cellstr(final));
horario=vertcat(columns,horario_full);

size_timbradas=size(timbradas);

vacia(1,size_timbradas(2)) = {''};

completa=vertcat(horario,vacia,cellstr(final),vacia,cellstr(descuentos_duration_2),vacia,cell_extras,vacia);
assignin('base','completa',completa);

size_completa=size(completa);
assignin('base','size_completa',size_completa);

completa_f(size_completa(1),42) = {''};
assignin('base','completa_f',completa_f);


completa_f(1:size_completa(1),1:size_completa(2))=completa(1:size_completa(1),1:size_completa(2));

a=1;
b=size_completa(1);
c=1;
d=14;
p=0;
for k=1:3
    completa_t(a:b,1:14)=completa_f(1:size_completa(1),c:d);
    p=p+1;
    a=a+size_completa(1);
    b=b+size_completa(1);
    c=c+14;
    d=d+14;
    if a >= 56
        break
    end
end

m=vertcat({''},rnames_data',{''},rnames_data',{''},rnames_descuentos',{''},rnames_horas_extras_table',{''});
m=repmat(m,3,1);
size_m=size(m);
n{size_m(1),1}={''};
n{2,1}=('HORARIO');
n{7,1}=('TIMBRADAS');
n{12,1}=('DESCUENTOS');
n{19,1}=('EXTRAS');

n{25,1}=('HORARIO');
n{31,1}=('TIMBRADAS');
n{36,1}=('DESCUENTOS');
n{43,1}=('EXTRAS');

n{50,1}=('HORARIO');
n{55,1}=('TIMBRADAS');
n{60,1}=('DESCUENTOS');
n{67,1}=('EXTRAS');

assignin('base','m',m);
assignin('base','n',n);
assignin('base','completa_t',completa_t);

completa_e=horzcat(n,m,completa_t);

completa_e_1=completa_e(1:48,:);
completa_e_2=completa_e(49:end,:);

total_horas_e=horzcat(rnames_total_horas_duration',cell_total_horas_duration);

total_descuentos_e=horzcat(rnames_total_descuentos',cell_total_descuentos);

total_extras_e=horzcat(rnames_horas_extras_table',cell_total_extras);

filename = char(save_name);
sheet1 = 1;
sheet2 = 2;

xlRange_1 = 'A1';

xlswrite(filename,completa_e_1,sheet1,xlRange_1)
assignin('base','completa_e_1',completa_e_1);


xlswrite(filename,completa_e_2,sheet2,xlRange_1)
xlswrite(filename,total_horas_e,sheet2,'H2')
xlswrite(filename,total_descuentos_e,sheet2,'H7')
xlswrite(filename,total_extras_e,sheet2,'H16')

xlsAutoFitCol(filename,'Hoja1','A:AZ')
xlsAutoFitCol(filename,'Hoja2','A:AZ')



















%
