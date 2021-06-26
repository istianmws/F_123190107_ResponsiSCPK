function varargout = WP(varargin)
% WP MATLAB code for WP.fig
%      WP, by itself, creates a new WP or raises the existing
%      singleton*.
%
%      H = WP returns the handle to a new WP or the handle to
%      the existing singleton*.
%
%      WP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WP.M with the given input arguments.
%
%      WP('Property','Value',...) creates a new WP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WP

% Last Modified by GUIDE v2.5 26-Jun-2021 08:33:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WP_OpeningFcn, ...
                   'gui_OutputFcn',  @WP_OutputFcn, ...
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


% --- Executes just before WP is made visible.
function WP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WP (see VARARGIN)

% Choose default command line output for WP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tampildata.
function tampildata_Callback(hObject, eventdata, handles)
% hObject    handle to tampildata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%untuk membaca data dari file (xlsx)
data = xlsread('Real_estate_valuation_data_set.xlsx');
%hanya mengambil atau membaca data dari file (xlsx) pada kolom 3,4,5, dan 8
data = [data(:,3) data(:,4) data(:,5) data(:,8)];
%hanya mengambil 50 data pertama dari file tersebut
data = data(1:50,:);
%menampilkan dalam tabel sementara
set(handles.tabeldata,'data',data);

% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%dipanggil lagi
data = xlsread('Real_estate_valuation_data_set.xlsx');
data = [data(:,3) data(:,4) data(:,5) data(:,8)];
data = data(1:50,:);
%pemberian nilai atribut
k = [0 0 0 1];
%pemberian nilai bobot
w = [3,5,4,1];
%pembuatan matriks kosong seukuran data dimensi 50x4
[m n] = size(data);
%pembagian nilai bobot tiap kriteria dengan seluruh nilai bobot
w=w./sum(w);

%inisiasi vektor S dan V unutk menyimpan nilai S dan V tiap alternatif
S= zeros(m,1);
V= zeros(m,1);

%melakukan perhintungan vektor S tiap alternatif
for x=1:n,
    if k(x)==0,
        w(x)=-1*w(x);
    end;
end;
for y=1:m,
    S(y,:)=prod(data(y,:).^w);
end; 

%melakukan perhitungan vektor V tiap alternatif
for x=1:m,
    V(x,:) = S(x,:)/(sum(S))*1.000;
end;

%memasukkan vektor V dan S kedalam matriks data
data=[V(:,1) S(:,1) data(:,1) data(:,2) data(:,3) data(:,4)];

%mengurutkan matriks data berdasarkan nilai V tertinggi
for x=m:-1:1,
    for y=1:x-1,
        if data(y,1)<data(y+1,1),
            temp = data(y,:);
            data(y,:) = data(y+1,:);
            data(y+1,:) = temp;
        end;
    end;
end;

%menampilkan hasil data jadi kedalam tabel
set(handles.tabelhasil,'data',data);  
