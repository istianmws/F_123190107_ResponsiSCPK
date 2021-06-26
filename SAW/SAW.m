function varargout = SAW(varargin)
% SAW MATLAB code for SAW.fig
%      SAW, by itself, creates a new SAW or raises the existing
%      singleton*.
%
%      H = SAW returns the handle to a new SAW or the handle to
%      the existing singleton*.
%
%      SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW.M with the given input arguments.
%
%      SAW('Property','Value',...) creates a new SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW

% Last Modified by GUIDE v2.5 26-Jun-2021 11:18:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_OutputFcn, ...
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


% --- Executes just before SAW is made visible.
function SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW (see VARARGIN)

% Choose default command line output for SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Tampil.
function Tampil_Callback(hObject, eventdata, handles)
% hObject    handle to Tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%untuk membaca data dari file (xlsx)
data = xlsread('DATA_RUMAH.xlsx');
%hanya mengambil atau membaca data dari file (xlsx) pada kolom yang
%dibuuthkan
data = [data(:,1) data(:,3) data(:,4) data(:,5) data(:,6) data(:,7) data(:,8)];
%menampilkan dalam uitable3 sementara
set(handles.uitable2,'data',data);

% --- Executes on button press in Proses.
function Proses_Callback(hObject, eventdata, handles)
% hObject    handle to Proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%untuk membaca data dari file (xlsx)
data = readtable('DATA_RUMAH.xlsx');

%menyimpan nama rumah
nama = [data(:,2)];
%hanya mengambil atau membaca data dari file (xlsx) pada kolom yang
%dibutuhkan
data = [data(:,3) data(:,4) data(:,5) data(:,6) data(:,7) data(:,8)];

%mengubah menjadi array
data = table2array(data);
nama = table2array(nama);
%pemberian nilai atribut
k=[0,1,1,1,1,1];
%pemberian bobot tiap kriteria
w=[0.3,0.2,0.23,0.1,0.07,0.1];

%normalisasi matriks
[m n]=size(data); %membuat matriks mxn seukuran dimensi data
A=zeros(m,n); %membuat matriks Kosong A
B=zeros(m,n); %membuat matriks Kosong B

for x=1:n,
    if k(x)==1,
        A(:,x)=data(:,x)./max(data(:,x));
    else
        A(:,x)=min(data(:,x))./data(:,x);
    end;
end;

%proses perangkingan
for y=1:m,
    V(y)=sum(w.*A(y,:));
end;

%membuat tabel perangkingan
[vektorV, index] = maxk(V,20);
%mengurutkan nama rumah
nama=nama(index); 
vektorV = transpose(num2cell(vektorV));
%menampilkan dalam tabel
set(handles.uitable3,'data',[nama vektorV]);