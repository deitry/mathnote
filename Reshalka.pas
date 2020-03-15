unit Reshalka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, Menus, ComCtrls, DBCtrls;

const
  IdentCount = 3; //Количество цифр, предназначенных для идентификатора
  VeshMax = 6; //Сколько всего веществ
  VozdMax = 20; {kol-vo temperatur, dlya k-x privedenbl sv-va vozduxa}
  GazMax = 9; {kol-vo temperatur, dlya k-x privedenbl sv-va ostalbnblx gazov}
  VodaMax = 11;
  AMG10Max = 18;
  TrubyMax = 15;
  KEY_CTRL_B = 02; // Жирный
  KEY_CTRL_D = 04; // Создание конечного варианта документа
  KEY_CTRL_G = 07; // Решение (синий)
  KEY_CTRL_I = 09; // Курсив
  KEY_CTRL_L = 12; // Автоматическое "разукрашивание" текста
  KEY_CTRL_P = 16; // Сведение всех шрифтов к одному
  KEY_CTRL_S = 19; // Сохранение
  KEY_CTRL_T = 20; // Формула (красный)
  KEY_CTRL_U = 21; // Подчёркнутый
  KEY_CTRL_W = 23; // Исходный <> Конечный
  KEY_CTRL_Y = 25; // Комментарий (зелёный + курсив)
  KEY_CTRL_Z = 26; // Отмена

type

  Veshestva = (Vozduh, CO2, N2, H2, voda, AMG10);
  Svoistva = (T_K, ro, Cp, lambda, myu, nyu, a, Prand);
  SvVesh = array [Veshestva] of array of array [Svoistva] of real;

  ESyntaxError=class(Exception);  //для возникающих синтаксических ошибок

  TReshalkaMainForm = class(TForm)
    MainPanel: TPanel;
    CalculateAllButton: TButton;
    ListBoxVars: TListBox;
    ButtonSetValue: TButton;
    EditVarName: TEdit;
    EditVarValue: TEdit;
    EquationLabel: TLabel;
    MainMenu1: TMainMenu;
    NFile: TMenuItem;
    NSaveAs: TMenuItem;
    NHelp: TMenuItem;
    NExit: TMenuItem;
    NInsert: TMenuItem;
    NFormulaIns: TMenuItem;
    SaveMainDialog: TSaveDialog;
    OpenMainDialog: TOpenDialog;
    N1: TMenuItem;
    N2: TMenuItem;
    NOpen: TMenuItem;
    NEdit: TMenuItem;
    NCalcAll: TMenuItem;
    NIdent: TMenuItem;
    NFormula: TMenuItem;
    NUndo: TMenuItem;
    N3: TMenuItem;
    NOperators: TMenuItem;
    NEquals: TMenuItem;
    NSave: TMenuItem;
    N4: TMenuItem;
    NZnachenie: TMenuItem;
    MainMemo: TRichEdit;
    ChangeFontDialog: TFontDialog;
    PopupMenu1: TPopupMenu;
    NCopyText: TMenuItem;
    NCutText: TMenuItem;
    NPasteText: TMenuItem;
    ProcProgress: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ResultMemo: TRichEdit;
    ResultLabel: TLabel;
    SwapButton: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    NFont: TMenuItem;
    N5: TMenuItem;
    NCalc: TMenuItem;
    NOneStr: TMenuItem;
    NAbout: TMenuItem;
    NSettings: TMenuItem;
    NCreate: TMenuItem;
    N6: TMenuItem;
    NFontEd: TMenuItem;
    ProgressLabel: TLabel;
    TempMemo: TRichEdit;
    NCase: TMenuItem;
    NCaseEnd: TMenuItem;
    NBegin: TMenuItem;
    NEnd: TMenuItem;
    NProc: TMenuItem;
    NSyntax: TMenuItem;
    N7: TMenuItem;
    procedure ButtonSetValueClick(Sender: TObject);
    procedure ListBoxVarsClick(Sender: TObject);
    procedure CalculateAllButtonClick(Sender: TObject);
    procedure NExitClick(Sender: TObject);
    procedure NSaveAsClick(Sender: TObject);
    procedure NOpenClick(Sender: TObject);
    procedure NFormulaClick(Sender: TObject);
    procedure NUndoClick(Sender: TObject);
    procedure MainMemo1Enter(Sender: TObject);
    procedure NEqualsClick(Sender: TObject);
    procedure NSaveClick(Sender: TObject);
    procedure NZnachenieClick(Sender: TObject);
    procedure MainMemoKeyPress(Sender: TObject; var Key: Char);
    procedure SwapButtonClick(Sender: TObject);
    procedure NFontClick(Sender: TObject);
    procedure NCalcClick(Sender: TObject);
    procedure NOneStrClick(Sender: TObject);
    procedure NCreateClick(Sender: TObject);
    procedure NFontEdClick(Sender: TObject);
    procedure NCaseClick(Sender: TObject);
    procedure NCaseEndClick(Sender: TObject);
    procedure NBeginClick(Sender: TObject);
    procedure NEndClick(Sender: TObject);
    procedure NProcClick(Sender: TObject);
    procedure NSyntaxClick(Sender: TObject);
    procedure N7Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  MaxN : array [Veshestva] of byte = (VozdMax, GazMax, GazMax, GazMax, VodaMax, AMG10Max);

   Vozduh_Sv : array [1..VozdMax] of array [Svoistva] of real =
              {T}  {ro}   {Cp}  {lam}   {din vyaz} {kin vyaz}  {temppr}    {Pr}
({Vozduh}    (283  ,1.000, 1.009,0.0251, 0.0000210, 0.00001416, 0.00002006, 0.705),
             (293  ,1.000, 1.009,0.0259, 0.0000210, 0.00001506, 0.00002142, 0.703),
             (303  ,1.000, 1.009,0.0267, 0.0000210, 0.00001600, 0.00002254, 0.701),
             (313  ,1.000, 1.009,0.0275, 0.0000210, 0.00001696, 0.00002426, 0.699),
             (323  ,1.000, 1.009,0.0282, 0.0000210, 0.00001795, 0.00002572, 0.698),
             (333  ,1.000, 1.009,0.0289, 0.0000210, 0.00001897, 0.00002726, 0.696),
             (343  ,1.000, 1.009,0.0296, 0.0000210, 0.00002002, 0.00002885, 0.694),
             (353  ,1.000, 1.009,0.0305, 0.0000211, 0.00002109, 0.0000302 , 0.692),
             (373  ,0.946, 1.009,0.0321, 0.0000219, 0.00002313, 0.0000336 , 0.688),
             (393  ,0.898, 1.009,0.0334, 0.0000228, 0.00002545, 0.0000368 , 0.686),
             (413  ,0.854, 1.013,0.0349, 0.0000237, 0.0000278 , 0.0000403 , 0.684),
             (433  ,0.815, 1.017,0.0364, 0.0000245, 0.00003009, 0.0000439 , 0.682),
             (453  ,0.779, 1.022,0.0378, 0.0000258, 0.00003249, 0.0000475 , 0.681),
             (473  ,0.746, 1.016,0.0393, 0.0000260, 0.00003485, 0.0000514 , 0.680),
             (523  ,0.674, 1.058,0.0427, 0.0000284, 0.00004061, 0.0000610 , 0.677),
             (573  ,0.615, 1.047,0.0460, 0.0000297, 0.00004833, 0.0000716 , 0.674),
             (623  ,0.566, 1.059,0.0491, 0.0000314, 0.00005546, 0.0000819 , 0.676),
             (673  ,0.524, 1.068,0.0521, 0.0000330, 0.00006309, 0.0000931 , 0.678),
             (723  ,0.456, 1.093,0.0574, 0.0000362, 0.00007938, 0.0001153 , 0.687),
             (773  ,0.404, 1.114,0.0622, 0.0000391, 0.00009639, 0.0001383 , 0.699) );


   SvoistvaVesh : array [CO2..H2, 1..GazMax, Svoistva] of real =

 ( (    (300,1.773,0.851,0.0166,0.00001492,0.00000842,0.0000110,0.77),
        (350,1.517,0.900,0.0204,0.00001721,0.00001134,0.0000149,0.76),
        (400,1.326,0.942,0.0243,0.00001939,0.00001462,0.0000195,0.75),
        (450,1.176,0.981,0.0283,0.00002149,0.00001824,0.0000245,0.74),
        (500,1.059,1.02 ,0.0325,0.00002331,0.00002201,0.0000301,0.73),
        (550,0.962,1.05 ,0.0366,0.00002539,0.00002639,0.0000362,0.73),
        (600,0.883,1.08 ,0.0407,0.00002722,0.00003083,0.0000427,0.72),
        (650,0.814,1.10 ,0.0445,0.00002898,0.0000356 ,0.0000497,0.72),
        (700,0.756,1.13 ,0.0481,0.00003063,0.00004052,0.0000563,0.72) ),

  (     (300,1.123,1.041,0.0259,0.00001782,0.00001587,0.00002215,0.716),
        (350,0.962,1.042,0.0293,0.00002000,0.00002079,0.00002923,0.711),
        (400,0.842,1.045,0.0327,0.00002204,0.00002618,0.00003716,0.705),
        (450,0.749,1.05 ,0.0358,0.00002396,0.00003199,0.00004552,0.703),
        (500,0.674,1.056,0.0389,0.00002557,0.00003794,0.00005465,0.694),
        (550,0.612,1.065,0.0417,0.00002747,0.00004489,0.00006398,0.702),
        (600,0.561,1.075,0.0446,0.0002908 ,0.00005284,0.00007395,0.701),
        (650,0.518,1.086,0.0472,0.00003062,0.00005911,0.0000839 ,0.705),
        (700,0.481,1.098,0.0499,0.00003210,0.00006674,0.00009448,0.706) ),

  (     (300,0.0807,14.31,0.183,0.00000890,0.00011029,0.0001585,0.696),
        (350,0.0692,14.43,0.204,0.00000986,0.00014249,0.0002043,0.697),
        (400,0.0605,14.48,0.226,0.00001082,0.00017884,0.0002580,0.693),
        (450,0.0538,14.5 ,0.247,0.00001171,0.00022178,0.0003226,0.687),
        (500,0.0484,14.52,0.266,0.00001259,0.00026012,0.0003785,0.687),
        (550,0.0441,14.53,0.285,0.00001342,0.00030431,0.0004448,0.684),
        (600,0.0403,14.55,0.305,0.00001425,0.0003536 ,0.0005202,0.680),
        (650,0.0372,14.58,0.323,0.00001502,0.00040376,0.0005955,0.678),
        (700,0.0346,14.61,0.342,0.00001578,0.00045607,0.0006765,0.674)  )  );


   Voda_Sv : array [1..VodaMax,Svoistva] of real = (

        (273,999.9,4.212,0.560,0.001788 ,0.000001789,0.0000132,13.5),
        (283,999.7,4.191,0.580,0.001306 ,0.000001306,0.0000138,9.45),
        (293,998.2,4.183,0.597,0.001004 ,0.000001004,0.0000143,7.03),
        (303,995.7,4.174,0.612,0.0008015,0.000000805,0.0000147,5.45),
        (313,992.2,4.174,0.627,0.0006533,0.000000659,0.0000151,4.36),
        (323,988.1,4.174,0.640,0.0005494,0.000000556,0.0000155,3.59),
        (333,983.1,4.179,0.650,0.0004699,0.000000478,0.0000158,3.03),
        (343,977.8,4.187,0.662,0.0004061,0.000000415,0.0000161,2.58),
        (353,971.8,4.195,0.669,0.0003551,0.000000365,0.0000163,2.23),
        (363,965.3,4.208,0.676,0.0003149,0.000000326,0.0000165,1.97),
        (373,958.4,4.220,0.684,0.0002825,0.000000295,0.0000168,1.75)   );


    AMG10_Sv : array [1..AMG10Max,Svoistva] of real = (
        (253,859.4,1.647,0.1255,0.000928  ,0.000108  ,0.0000000887,1218),
        (263,851.4,1.694,0.1244,0.000511  ,0.000060  ,0.0000000863,695 ),
        (273,843.4,1.744,0.1234,0.000346  ,0.000041  ,0.0000000839,489 ),
        (283,835.4,1.794,0.1223,0.000242  ,0.000029  ,0.0000000816,355 ),
        (293,827.4,1.844,0.1213,0.000178  ,0.0000215 ,0.0000000795,270 ),
        (303,819.4,1.894,0.1203,0.000129  ,0.0000158 ,0.0000000775,204 ),
        (313,811.4,1.952,0.1192,0.000102  ,0.0000126 ,0.0000000758,167 ),
        (323,803.3,1.994,0.1182,0.0000856 ,0.00001065,0.0000000738,144 ),
        (333,795.3,2.045,0.1171,0.0000696 ,0.00000875,0.0000000720,122 ),
        (343,787.3,2.095,0.1161,0.0000563 ,0.00000715,0.0000000704,101 ),
        (353,779.3,2.145,0.1150,0.0468    ,0.000006  ,0.0000000688,87.2),
        (363,771.3,2.195,0.1140,0.0000401 ,0.0000052 ,0.0000000673,72.3),
        (373,763.3,2.245,0.1129,0.0000343 ,0.0000045 ,0.0000000659,68.3),
        (383,755.3,2.295,0.1119,0.0000302 ,0.000004  ,0.0000000646,61.9),
        (393,747.3,2.345,0.1109,0.00002658,0.00000355,0.0000000633,56.1),
        (403,739.0,2.395,0.1098,0.0000234 ,0.00000317,0.0000000620,51.0),
        (413,731.2,2.445,0.1088,0.000021  ,0.00000287,0.0000000609,41.6),
        (423,723.2,2.496,0.1087,0.000019  ,0.00000266,0.0000000600,44.4)  );

// -----------------------------
// Глобальные переменные проекта
// -----------------------------
var
  ReshalkaMainForm: TReshalkaMainForm;
  SvoistvaVeshestv: array [Veshestva] of array of array [Svoistva] of real;
  i,k,l: byte;
  SyntaxFail : boolean; // true -> в синтаксисе есть ошибки!

implementation

{$R *.dfm}

  function DeleteComments(st:string):string;
   var exam,vrem : string;
  begin
    exam:='//';
    if pos(exam,st)<>0 then
       vrem := copy(st,1,pos(exam,st)-1)
    else
       vrem:=st;
    DeleteComments := vrem;
  end;

  // Замена '#***' и '№***' на значения соответсвтуюших переменных
  // -> возможность работы с массивами (а вернее, их подобиями)
  procedure ValueInsert(var St:string);
  var VremName : string;
      k : byte;
  begin

   while pos('#',St)<>0 do
     begin
       VremName:='';
       k:=pos('#',St)+1;
       repeat begin
       VremName := VremName+St[k];
       inc(k);
       end; until (St[k]='#') or (St[k]='№')
               or (St[k]='|') or (k>=length(St))
               or (St[k]='[');
       k:=pos('#',St);
       delete(St,k,length(VremName)+1);
       try insert('['+ReshalkaMainForm.ListBoxVars.Items.Values[VremName]+']',
          St, k);
       except ShowMessage('Хреновина получается');
       end;
     end;

   while pos('№',St)<>0 do
     begin
       VremName:='';
       k:=pos('№',St)+1;
       repeat begin
       VremName := VremName+St[k];
       inc(k);
       end; until (St[k]='#') or (St[k]='№')
               or (St[k]='|') or (k>=length(St))
               or (St[k]='[');
       k:=pos('№',St);
       delete(St,k,length(VremName)+1);
       try insert(ReshalkaMainForm.ListBoxVars.Items.Values[VremName],
          St, k);
       except ShowMessage('Хреновина получается');
       end;
       while pos('|',St)<>0 do delete (St,pos('|',St),1);
     end;
  end;


  function DeleteIdents(st:string):string;
   var exam,vrem : string;

     procedure DelId(const ex:string {образец};var str:string{редакт. строка});
     begin  // Удаление отедьного идентификатора
       while pos(ex,str)<>0 do
            delete(str,pos(ex,str),length(ex));
     end; {DelId}

  begin         // (..) - чтобы даже с таким значком можно было производить вычисления
    vrem:=st;
    exam:='(..) ';
    DelId(exam,vrem);
    exam:='<( ';
    DelId(exam,vrem);
    exam:=' )>';
    DelId(exam,vrem);
    DeleteIdents := vrem;
  end;

  function ByteToVeshestva(chislo:byte):Veshestva;
   var Vrem : Veshestva;
   begin
     case chislo of
       1: Vrem := Vozduh;
       2: Vrem := CO2;
       3: Vrem := N2;
       4: Vrem := H2;
       5: Vrem := Voda;
       6: Vrem := AMG10;
       else raise ESyntaxError.Create('Нету такого вещества!');
     end; {case}
   ByteToVeshestva := Vrem;
   end;

  function ByteToSvoistva(chislo:byte):Svoistva;
   var Vrem : Svoistva;
   begin
     case chislo of
       1: Vrem := T_K;
       2: Vrem := ro;
       3: Vrem := Cp;
       4: Vrem := lambda;
       5: Vrem := myu;
       6: Vrem := nyu;
       7: Vrem := a;
       8: Vrem := Prand;
       else raise ESyntaxError.Create('Нету такого свойства!');
     end; {case}
   ByteToSvoistva := Vrem;
   end;

  function StrToVeshestva(stroka:string):Veshestva;
   var Vrem : Veshestva;
   begin
     if (stroka='Vozduh') or (stroka='vozduh') or (stroka='Vozdux') or (stroka='vozdux')
      or (stroka='Vozd') or (stroka='vozd') then Vrem := Vozduh;
     if (stroka='CO2') or (stroka='co2') or (stroka='CO_2') or (stroka='co_2')
         then Vrem := CO2;
     if (stroka='N2') or (stroka='n2') or (stroka='N_2') or (stroka='n_2')
         then Vrem := N2;
     if (stroka='H2') or (stroka='h2') or (stroka='H_2') or (stroka='h_2')
         then Vrem := H2;
     if (stroka='Voda') or (stroka='VODA') or (stroka='voda') or (stroka='H2O')
      or (stroka='h2o') then Vrem := Voda;
     if (stroka='AMG10') or (stroka='AMG_10') or (stroka='amg10') or (stroka='amg_10')
         then Vrem := AMG10;

   StrToVeshestva := Vrem;
   end;

  function StrToSvoistva(stroka:string):Svoistva;
   var Vrem : Svoistva;
   begin

       if (stroka='T_K') or (stroka='T') or (stroka='Temp') or (stroka='t')
         or (stroka='temp') then Vrem := T_K;
       if (stroka='Ro') or (stroka='ro') or (copy(stroka,1,4)='Plot')
           or (copy(stroka,1,4)='plot') then Vrem := ro;
       if (stroka='Cp') or (stroka='C_p') or (stroka='c_p') or (stroka='cp')
           or (copy(stroka,1,6)='Teploe') or (copy(stroka,1,6)='teploe')
         then Vrem := Cp;
       if (stroka='L') or (stroka='Lam') or (stroka='Lambda')
           or (stroka='l') or (stroka='lam') or (stroka='lambda')
           or (copy(stroka,1,6)='Teplop') or (copy(stroka,1,6)='teplop')
         then Vrem := lambda;
       if (stroka='M') or (stroka='Myu') or (stroka='Mu')
           or (stroka='m') or (stroka='myu') or (stroka='mu')
           or (copy(stroka,1,3)='Din') or (copy(stroka,1,3)='din')
         then Vrem := myu;
       if (stroka='N') or (stroka='Nyu') or (stroka='Nu')
           or (stroka='n') or (stroka='nyu') or (stroka='nu')
           or (copy(stroka,1,3)='Kin') or (copy(stroka,1,3)='Kin') then Vrem := nyu;
       if (stroka='A') or (stroka='a')
           or (copy(stroka,1,11)='Tempepaturo') or (copy(stroka,1,11)='tempepaturo')
         then Vrem := a;
       if (stroka='Pr') or (stroka='pr') or (copy(stroka,1,4)='Pran')
       or (copy(stroka,1,4)='pran') then  Vrem := Prand;

   StrToSvoistva := Vrem;
   end;

Function Znachenie(fluid:Veshestva; svoistvo: Svoistva; Temp:real):real;
  var         {Vozduh_Sv}
   i,m,n: byte;
   vrem:real;
  begin

        for i:=1 to (VozdMax-1) do begin
          m:=i;
          n:=i+1;
          if (Temp >= (SvoistvaVeshestv[fluid][m,T_K]) ) and (Temp < (SvoistvaVeshestv[fluid][n,T_K]) )
           then
             begin {Линейная аппроксимация}
               vrem:= SvoistvaVeshestv[fluid][m,svoistvo] +
                 (SvoistvaVeshestv[fluid][n,svoistvo] - SvoistvaVeshestv[fluid][m,svoistvo]) *
                 ( Temp - (SvoistvaVeshestv[fluid][m,T_K]) )/
                 (SvoistvaVeshestv[fluid][n,T_K]-SvoistvaVeshestv[fluid][m,T_K]);
             end;{if}
        end;{for}

  Znachenie:=vrem;

  end;{Znacheine svoistva veshestva}

//----------------------------------------------
//Калькуляторная часть:
//вычисления введённых формул
//----------------------------------------------

// Проверка символа на соответствие <Digit>
function IsDigit(Ch:Char):Boolean;
 begin
  Result:=Ch in ['0'..'9']
 end;

// Проверка символа на соответствие <Sign>
function IsSign(Ch:Char):Boolean;
 begin
  Result:=(Ch='+') or (Ch='-')
 end;

// Проверка символа на соответствие <Separator>
function IsSeparator(Ch:Char):Boolean;
 begin
  Result:=Ch=DecimalSeparator
 end;

// Проверка символа на соответствие <Exponent>
function IsExponent(Ch:Char):Boolean;
 begin
  Result:=(Ch='E') or (Ch='e')
 end;

// Выделение из строки подстроки, соответствующей
// определению <Number>, и вычисление этого числа
// S - строка, из которой выделяется подстрока
// P - номер позиции в строке, с которой должно
// начинаться число. После завершения работы функции
// этот параметр содержит номер первого после числа
// символа
function Number(const S:string;var P:Integer):Extended;
 var InitPos:Integer;
  begin
   // InitPos нам понадобиться для выделения подстроки,
   // которая будет передана в StrToFloat
   InitPos:=P;
   if (P>Length(S)) or not IsDigit(S[P]) then
    raise ESyntaxError.Create('Ожидается цифра в позиции '+IntToStr(P));
   repeat
    Inc(P)
   until (P>Length(S)) or not IsDigit(S[P]);
   if (P<=Length(S)) and IsSeparator(S[P]) then
    begin
     Inc(P);
     if (P>Length(S)) or not IsDigit(S[P]) then
      raise ESyntaxError.Create('Ожидается цифра в позиции '+IntToStr(P));
     repeat
      Inc(P)
     until (P>Length(S)) or not IsDigit(S[P]);
    end;
   if (P<=Length(S)) and IsExponent(S[P]) then
    begin
     Inc(P);
     if P>Length(S) then
      raise ESyntaxError.Create('Неожиданный конец строки');
     if IsSign(S[P]) then
      Inc(P);
     if (P>Length(S)) or not IsDigit(S[P]) then
      raise ESyntaxError.Create('Ожидается цифра в позиции '+IntToStr(P));
     repeat
      Inc(P)
     until (P>Length(S)) or not IsDigit(S[P]);
    end;
   Result:=StrToFloat(Copy(S,InitPos,P-InitPos))
  end;

// Проверка символа на соответствие <Operator1>
function IsOperator1(Ch:Char):Boolean;
 begin
  Result:=Ch in ['+','-']
 end;

// Проверка символа на соответствие <Operator2>
function IsOperator2(Ch:Char):Boolean;
 begin
  Result:=Ch in ['*','/','=','>','<'] // "Равно" добавлено для логических операций;
 end;                         // аналог 2+3=5 <-> 2+3*5

// Так как грамматика рекурсивна, функция Expr
// должна быть объявлена заранее
function Expr(const S:string;var P:Integer):Extended;
 forward;

// Вычисление функции, имя которой передаётся через FuncName
function Func(const FuncName,S:string;var P:Integer):Extended;
 var Arg:Extended;
  begin
   // Вычисляем аргумент
   Arg:=Expr(S,P);
   // Сравниваем имя функции с одним из допустимых
   if AnsiCompareText(FuncName,'sin')=0 then
    Result:=Sin(Arg)
   else if AnsiCompareText(FuncName,'cos')=0 then
    Result:=Cos(Arg)
   else if AnsiCompareText(FuncName,'sqrt')=0 then
    Result:=Sqrt(Arg)
   else if AnsiCompareText(FuncName,'ln')=0 then
      begin
       if Arg>0 then
       Result:=Ln(Arg)
       else Result:=-MaxInt+1000;
      end
   else if (AnsiCompareText(FuncName,'tg')=0) or
           (AnsiCompareText(FuncName,'tan')=0)  then
    Result:=tan(Arg)
   else if (AnsiCompareText(FuncName,'ctg')=0) or
           (AnsiCompareText(FuncName,'cot')=0)  then
    Result:=cot(Arg)
   else if AnsiCompareText(FuncName,'lg')=0 then
      begin
       if Arg>0 then
       Result:=Ln(Arg)/Ln(10)
       else Result:=-MaxInt+1000;
      end
   else if AnsiCompareText(FuncName,'abs')=0 then
    Result:=abs(Arg)
   else if AnsiCompareText(FuncName,'exp')=0 then
    Result:=exp(Arg)
   else if (AnsiCompareText(FuncName,'sh')=0) or
           (AnsiCompareText(FuncName,'sinh')=0) then
    Result:=sinh(Arg)
   else if (AnsiCompareText(FuncName,'ch')=0) or
           (AnsiCompareText(FuncName,'cosh')=0)  then
    Result:=cosh(Arg)
   else if (AnsiCompareText(FuncName,'th')=0) or
           (AnsiCompareText(FuncName,'tanh')=0) then
    Result:=tanh(Arg)
   else if (AnsiCompareText(FuncName,'cth')=0) or
            (AnsiCompareText(FuncName,'coth')=0)  then
    Result:=coth(Arg)
   else if (AnsiCompareText(FuncName,'arsh')=0) or
           (AnsiCompareText(FuncName,'ArSinH')=0)  then
    Result:=ArcSinH(Arg)
   else if (AnsiCompareText(FuncName,'arch')=0) or
           (AnsiCompareText(FuncName,'ArCosH')=0)  then
    Result:=ArcCosH(Arg)
   else if (AnsiCompareText(FuncName,'arth')=0) or
           (AnsiCompareText(FuncName,'ArTanH')=0)  then
    Result:=ArcTanH(Arg)
   else if (AnsiCompareText(FuncName,'arcth')=0) or
           (AnsiCompareText(FuncName,'ArCotH')=0)  then
    Result:=ArcCotH(Arg)
   else if AnsiCompareText(FuncName,'inc')=0  then
    Result:=(Arg)+1
   else if AnsiCompareText(FuncName,'dec')=0  then
    Result:=(Arg)-1
   else if AnsiCompareText(FuncName,'incm')=0  then
    Result:=(Arg)+0.1
   else if AnsiCompareText(FuncName,'decm')=0  then
    Result:=(Arg)-0.1

   else
    raise ESyntaxError.Create('Неизвестная функция '+FuncName)
  end;

// Выделение из строки идентификатора и определение,
// является ли он переменной или функцией
function Identifier(const S:string;var P:Integer):Extended;
 var InitP,k:Integer;
     IDStr,VarValue,VremName,VremValue:string;
     vrem:char; // Для выделения №*** и #***
  begin
   // Запоминаем начало идентификатора
   InitP:=P;
   // Первый символ был проверен ещё в функции Base.
   // Сразу переходим к следующему
   Inc(P);
   while (P<=Length(S)) and (S[P] in ['A'..'Z','a'..'z','_',
                             '0'..'9','А'..'Я','а'..'я','#','№','|']) do
    Inc(P);    // Символы '#','№' добавлен для возможности описания массивов:
    // ololo#i#k, к примеру, может означать ololo[1][3] при i=1, k=3;
    // ololo№i№k - ololo13

   // Выделяем идентификатор из строки
   IDStr:=Copy(S,InitP,P-InitP);

   // Заменяем №*** и #*** на соответствующие значения
   ValueInsert(IDStr);

   // Если за ним стоит открывающая скобка - это функция
   if (P<=Length(S)) and (S[P]='(') then
    begin
     Inc(P);
     Result:=Func(IDStr,S,P);
     // Проверяем, что скобка закрыта
     if (P>Length(S)) or (S[P]<>')') then
      raise ESyntaxError.Create('Ожидается ")" в позиции '+IntToStr(P));
     Inc(P)
    end
   // если скобки нет - переменная
   else
    begin
     if VarValue='' then VarValue:=ReshalkaMainForm.ListBoxVars.Items.Values[IDStr];
     if VarValue='' then
      raise ESyntaxError.Create('Необъявленная переменная '+IDStr+' в позиции '+IntToStr(P))
     else
      Result:=StrToFloat(VarValue)
    end
  end;

// Выделение подстроки, соответствующей <Base>,
// и её вычисление
function Base(const S:string;var P:Integer):Extended;
 begin
  if P>Length(S) then
   raise ESyntaxError.Create('Неожиданный конец строки');
  // По первому символу подстроки определяем,
  // какое это основание
  case S[P] of
   '(': // выражение в скобках
    begin
     Inc(P);
     Result:=Expr(S,P);
     // Проверяем, что скобка закрыта
     if (P>Length(S)) or (S[P]<>')') then
      raise ESyntaxError.Create('Ожидается ")" в позиции '+IntToStr(P));
     Inc(P)
    end;
   '0'..'9': // Числовая константа
    Result:=Number(S,P);
   'A'..'Z','a'..'z','_','А'..'Я','а'..'я': // Идентификатор (переменная или функция)
    Result:=Identifier(S,P)
   else
    raise ESyntaxError.Create('Некорректный символ в позиции '+IntToStr(P))
  end
 end;

// Выделение подстроки, соответствующей <Factor>,
// и её вычисление
function Factor(const S:string;var P:Integer):Extended;
 begin
  if P>Length(S) then
   raise ESyntaxError.Create('Неожиданный конец строки');
  // По первому символу подстроки определяем,
  // какой это множитель
  case S[P] of
   '+': // унарный "+"
    begin
     Inc(P);
     Result:=Factor(S,P)
    end;
   '-': // унарный "-"
    begin
     Inc(P);
     Result:=-Factor(S,P)
    end
   else
    begin
     Result:=Base(S,P);
     if (P<=Length(S)) and (S[P]='^') then
      begin
       Inc(P);
       Result:=Power(Result,Factor(S,P))
      end
    end
  end
 end;

// Выделение подстроки, соответствующей <Term>,
// и её вычисление
function Term(const S:string;var P:Integer):Extended;
 var OpSymb:Char;
     vrem:Extended;
  begin
   Result:=Factor(S,P);
   while (P<=Length(S)) and IsOperator2(S[P]) do
    begin
     OpSymb:=S[P];
     Inc(P);
     case OpSymb of
      '*':Result:=Result*Factor(S,P);
      '/':try
            vrem:=Result;
            Result:=Result/Factor(S,P);
          except
            on EZeroDivide do   //если делим на нуль
               if vrem>0 then //если +
                    Result:=MaxInt-1000;   //фигачим нечто ооочень большое
               else Result:=-MaxInt+1000;   //иначе - нечто ооочень маленькое
            end;
      '=':try
            if Result=Factor(S,P) then Result:=1
                 else Result:=0;
          except
            ShowMessage('Хрень с boolean');
          end;
      '>':try
            if S[P] <> '=' then begin
              if Result>Factor(S,P) then Result:=1
                 else Result:=0;
                 end
            else  begin
              inc(p);
              if Result>=Factor(S,P) then Result:=1
                 else Result:=0;
            end;
          except
            ShowMessage('Хрень с boolean');
          end;
      '<':try
            if S[P] <> '=' then begin
              if Result<Factor(S,P) then Result:=1
                 else Result:=0;
                 end
            else  begin
              inc(p);
              if Result<=Factor(S,P) then Result:=1
                 else Result:=0;
            end;
          except
            ShowMessage('Хрень с boolean');
          end;
       end
    end
  end;

// Выделение подстроки, соответствующей <Expr>,
// и её вычисление
function Expr(const S:string;var P:Integer):Extended;
 var OpSymb:Char;
  begin
   Result:=Term(S,P);
   while (P<=Length(S)) and IsOperator1(S[P]) do
    begin
     OpSymb:=S[P];
     Inc(P);
     case OpSymb of
      '+':Result:=Result+Term(S,P);
      '-':Result:=Result-Term(S,P)
     end
    end
  end;

function Space_delete(S:String):string;
//очищает строку от всех пробелов
var i:byte;
    s_vrem:string;
begin
s_vrem:='';
for i:=1 to length(S) do
   begin
    if S[i]<>' ' then s_vrem:=s_vrem+S[i];
  end;
Result:=S_vrem;
end;

// Вычисление выражения
function Calculate({const} S:string):Extended;
 var P:Integer;
  begin
   S:=Space_delete(S); //очищаем от пробелов
   ValueInsert(S);
   P:=1;
   Result:=Expr(S,P);
   if P<=Length(S) then
    raise ESyntaxError.Create('Некорректный символ в позиции '+IntToStr(P))

end;

procedure TReshalkaMainForm.ButtonSetValueClick(Sender: TObject);
 var Index:Integer;
  begin
   if EditVarName.Text='' then
    Exit;
   try
    StrToFloat(EditVarValue.Text)
   except
    on EConvertError do
     Exit
   end;
   Index:=ListBoxVars.Items.IndexOfName(EditVarName.Text);
   if Index>=0 then
    ListBoxVars.Items[Index]:=EditVarName.Text+'='+EditVarValue.Text
   else
    ListBoxVars.Items.Add(EditVarName.Text+'='+EditVarValue.Text)
  end;

//Конец калькуляторной части


procedure TReshalkaMainForm.ListBoxVarsClick(Sender: TObject);
var i:byte;
begin
i:=ListBoxVars.ItemIndex;
EditVarName.Text:=ListBoxVars.Items.Names[I];
EditVarValue.Text:=ListBoxVars.Items.ValueFromIndex[I];
end;

procedure TReshalkaMainForm.CalculateAllButtonClick(Sender: TObject);
var i,k,m,n,i1, m_str : integer;
   VremName,VremString,TempStr,st1 : string;
   VremValue : real;
   VremChar : char;
   VremInteger : integer;
   Fluid : Veshestva;
   Svoistvo : Svoistva;
   Temp : real;
   index, Nachalo:integer;
   IArr : array of integer;
   InProcedure : boolean; // Чтобы не печатать ненужные сведения
   Popali : boolean; // Маркер для Case
   StArr : array of string[20]; // Сюда будем запоминать названия переменных,
                            // которые управляют циклами. Необходимо
                            // для создания вложенных циклов
   CycArr : array of integer;
begin

  ProgressLabel.Caption := 'Идёт вычисление...';

  SyntaxFail := false;
  ReshalkaMainForm.NSyntaxClick(nil);
  if SyntaxFail then exit;

   i := -1;
   i1 := 0;
   m := 0; // счётчик вложенности бегинов-ендов
   m_str := 0; // счётчик вложенности циклов
   SetLength(IArr,30);    // !!! Сделать из чисел глобальные переменные
   SetLength(StArr,5);
   SetLength(CycArr,5);
   InProcedure := false;

   while i<MainMemo.Lines.Count do
     begin
       inc(i);

       if MainMemo.Lines.Strings[i] = '' then continue;

       ProcProgress.Max := MainMemo.Lines.Count;
       ProcProgress.Position := i;

       Nachalo := 1;
       if MainMemo.Lines.Strings[i][1] = ' ' then
         repeat inc(Nachalo)
         until MainMemo.Lines.Strings[i][Nachalo]<>' ';

       if pos ( '(..) ', copy(MainMemo.Lines.Strings[i],1,5) )<>0
         then Nachalo := Nachalo+5;

       // Проверка на процедуру
       if copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)=':: ' then
          begin
            // Выделение имени процедуры из строки
            VremName := copy( MainMemo.Lines.Strings[i],
                              pos(':: ',MainMemo.Lines.Strings[i])+IdentCount,
                              length(MainMemo.Lines.Strings[i])
                                -pos(':: ',MainMemo.Lines.Strings[i])
                                -IdentCount );
            ValueInsert(VremName);

            index:=ListBoxVars.Items.IndexOfName(VremName);
            TempStr := VremName+'='+IntToStr(i);
            if index>=0 then
            ListBoxVars.Items[index]:= TempStr
              else
            ListBoxVars.Items.Add(TempStr);
            repeat inc(i) until pos(')>',MainMemo.Lines.Strings[i])<>0;
            inc(i);
          end;

         // Проверка на выполнение процедуры
       if pos('&>',MainMemo.Lines.Strings[i])<>0 then
                 begin
                   k :=IdentCount+1;
                   VremChar := MainMemo.Lines.Strings[i][k];
                   VremName := '';
                   while (VremChar<>' ') and (VremChar<>';')
                     and (VremChar<>#0) and (VremChar<>#10) and (VremChar<>#13)
                        do
                     begin
                     VremName := VremName + VremChar;
                     inc(k);
                     VremChar := MainMemo.Lines.Strings[i][k];
                   end;
                   ValueInsert(VremName);
                   VremInteger:=StrToInt(ListBoxVars.Items.Values[VremName]);

                   inc(m);
                   InProcedure := true;
                   //SetLength(IArr,m);
                   IArr[m-1] := i;  // Сохраняем в стек тек. значение i
                   i := VremInteger+1;

                 end;
         // Проверка на конец процедуры
       if Space_Delete(MainMemo.Lines.Strings[i])=')>' then
          begin
            i:=IArr[m-1];
            dec(m);
            if m = 0 then InProcedure := false;
          end;

         //Проверка на формулу
       if copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)='>> ' then
          begin
            //Считываем название переменной
            k := IdentCount + Nachalo;
            VremChar:=MainMemo.Lines.Strings[i][k];
            VremName:='';
            repeat begin
                     VremName:=VremName + VremChar;
                     inc(k);
                     VremChar:=MainMemo.Lines.Strings[i][k];
                   end
            until (VremChar=' ') or (VremChar=':');
            ValueInsert(VremName);

            //Перебираемся через равно
            while VremChar<>'=' do begin
                                     inc(k);
                                     VremChar:=MainMemo.Lines.Strings[i][k];
                                   end;
            // Вычисление однострочной формулы.
            // Однострочность определяется длиной: все формулы меньше 20 знаков
            // считаются однострочными и могут вычисляться без ';' на конце

            if (length ( copy(MainMemo.Lines.Strings[i],
                             k+1,length(MainMemo.Lines.Strings[i])-k) ) < 20)
               and (pos(';',MainMemo.Lines.Strings[i])=0)
            then begin
              VremString := copy(MainMemo.Lines.Strings[i],
                             k+1,length(MainMemo.Lines.Strings[i])-k);

              TempStr := Space_delete(DeleteComments(VremString));


              end
            else // Вычисление многострочной формулы
              begin
            VremString := '';
            if pos(';',MainMemo.Lines.Strings[i]) = 0 then begin
              VremString := copy(MainMemo.Lines.Strings[i],k+1,length(MainMemo.Lines.Strings[i]) - k + 1);
              inc(i);

                while pos(';',MainMemo.Lines.Strings[i]) = 0 do begin
                     VremString := VremString + MainMemo.Lines.Strings[i];
                     inc(i);
                end; {while}
              end; {if-pos=0}

            if pos(';',MainMemo.Lines.Strings[i]) <> 0 then
               if pos(':=',MainMemo.Lines.Strings[i])<>0 then
                VremString := VremString +
                 copy(MainMemo.Lines.Strings[i],
                   pos(':=',MainMemo.Lines.Strings[i]) + 2,
                   pos(';',MainMemo.Lines.Strings[i])- pos(':=',MainMemo.Lines.Strings[i])-2 )
               else
                 VremString := VremString + copy(MainMemo.Lines.Strings[i], 1,
                   pos(';',MainMemo.Lines.Strings[i]) - 1);

            TempStr := Space_delete(DeleteComments(VremString));
            end; {else}

            if ( copy(TempStr,1,3)='Zna' ) or
               ( copy(TempStr,1,3)='zna' ) then
               //Проверка на получение значения свойств среды
               // Существует, пока не добавили сие в виде функции
               // - мешает
                 begin
                   m := pos('(',TempStr);
                   Delete(TempStr,1,m);
                   m := pos(',',TempStr);
                   Fluid := StrToVeshestva(copy(TempStr,1,m-1));

                   Delete(TempStr,1,m);
                   m := pos(',',TempStr);
                   Svoistvo := StrToSvoistva(copy(TempStr,1,m-1));

                   Delete(TempStr,1,m);
                   m := pos(')',TempStr);
                   Temp := StrToFloat(copy(TempStr,1,m-1));

                   VremValue := Znachenie (Fluid,Svoistvo,Temp);
                 end
               else try VremValue := Calculate(DeleteComments(VremString));
                    except on ESyntaxError do
                       ProgressLabel.Caption := 'Прервано';
                    end;

            // Проверяем, есть ли уже такая переменная и, соответственно,
            // изменяем или добавляем значение
            index:=ListBoxVars.Items.IndexOfName(VremName);
            TempStr := VremName+'='+FloatToStr(VremValue);
            if index>=0 then
            ListBoxVars.Items[index]:= TempStr
              else
            ListBoxVars.Items.Add(TempStr);

            //Подписываем следующей строчкой ответ
            if copy(DeleteIdents(MainMemo.Lines.Strings[i+1]),1,
                   pos('=',DeleteIdents(MainMemo.Lines.Strings[i+1]))-1 ) =
                 copy(TempStr,1,pos('=',TempStr)-1) then
                  begin
                    if (DeleteIdents(MainMemo.Lines.Strings[i+1]) <> TempStr)
                      then begin
                        if pos ('(..)',MainMemo.Lines.Strings[i+1])=0 then
                            MainMemo.Lines.Strings[i+1] := TempStr
                          else MainMemo.Lines.Strings[i+1] := '(..) '+TempStr;
                        end;
                  end
              else if InProcedure=false then
                   begin MainMemo.Lines.Insert(i+1,TempStr);
                         MainMemo.Lines.Insert(i+2,'');
                   end;
          end; // Работа с формулой


          // Проверка на оператор выбора
          if copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)=':> ' then
             begin
               k := IdentCount + Nachalo;
               st1 := MainMemo.Lines.Strings[i];
               VremString := copy(st1,k,length(st1)-k);
               VremValue := Calculate (VremString);

            repeat begin
              inc(i);
              st1 := Space_Delete( copy(MainMemo.Lines.Strings[i],2,
                  length(MainMemo.Lines.Strings[i])-1) );
              if Space_Delete(MainMemo.Lines.Strings[i][1])=':' then
                if (Calculate( copy(st1,1,pos(':',st1)-1)) = VremValue)
                then begin  // Если попали в нужный вариант -
              // находим следующее значение, которое уже не будет подходить,
              // и сохраняем его в стек наподобие того, как это делалось
              // для процедур
                   VremInteger := i;
                while Space_Delete(MainMemo.Lines.Strings[VremInteger])<>'<:' do
                   inc(VremInteger);
                   Popali := true;
                   inc(m);
                   InProcedure := true;
                   IArr[m-1] := VremInteger;  // Сохраняем в стек значение i,
                   // соответствующее окончанию цикла

                   end;
              end;
            until (pos('<:',MainMemo.Lines.Strings[i])<>0)
            or (MainMemo.Lines.Strings[i+1]='<:')
            or Popali;
             end; {logic}

          // i-циклы: '0> i := 1 -> 4 :'
          if (copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)='o> ')
            or (copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)='O> ')
            or (copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)='0> ')
            or (copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)='о> ')
            or (copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)='О> ') then
          begin
            // Учитываем, что мы нашли новый цикл
            inc(m_str);
            // Запоминаем обозначение цикла
            VremName := '';
            k:=Nachalo+IdentCount;
            repeat begin
            VremName := VremName + MainMemo.Lines.Strings[i][k];
            inc(k); end;
            until (MainMemo.Lines.Strings[i][k]=' ')
               or (MainMemo.Lines.Strings[i][k]=':');
            ValueInsert(VremName);

            StArr[m_str-1]:=VremName;

            //Перебираемся через равно
            VremChar:=MainMemo.Lines.Strings[i][k];
            while VremChar<>'=' do begin
                                     inc(k);
                                     VremChar:=MainMemo.Lines.Strings[i][k];
                                   end;
            inc(k);
            // Считываем число или переменную, ОТ которой предстоит считать
            VremString := '';
            repeat begin
            VremString := VremString + MainMemo.Lines.Strings[i][k];
            inc(k); end;
            until (MainMemo.Lines.Strings[i][k]='-')
              and (MainMemo.Lines.Strings[i][k+1]='>');

            VremValue := Calculate(VremString); // Вычисляем значение

            // Проверяем, есть ли уже такая переменная и, соответственно,
            // изменяем или добавляем значение
            index:=ListBoxVars.Items.IndexOfName(VremName);
            TempStr := VremName+'='+FloatToStr(VremValue);
            if index>=0 then
            ListBoxVars.Items[index]:= TempStr
              else
            ListBoxVars.Items.Add(TempStr);

            // Перебираемся через '->'
            while VremChar<>'>' do begin
                                     inc(k);
                                     VremChar:=MainMemo.Lines.Strings[i][k];
                                   end;
            inc(k);

            // Считываем число или переменную, ДО которой предстоит считать
            VremString:='';
            repeat begin
            VremString := VremString + MainMemo.Lines.Strings[i][k];
            inc(k); end;
            until (MainMemo.Lines.Strings[i][k]=':')
               or (k>=length(MainMemo.Lines.Strings[i]));
            // Вычисляем и запоминаем
            VremValue := Calculate(VremString);
            CycArr[m_str-1] := round(VremValue);

            // Запоминаем точку начала цикла
            inc(m);
            IArr[m-1]:=i;

            InProcedure := true;
          end; {i-cycles}

          // Проверка на конец цикла
          if (Space_delete(MainMemo.Lines.Strings[i])='0;')
            or (Space_delete(MainMemo.Lines.Strings[i])='o;')
            or (Space_delete(MainMemo.Lines.Strings[i])='O;')
            or (Space_delete(MainMemo.Lines.Strings[i])='о;')
            or (Space_delete(MainMemo.Lines.Strings[i])='О;') then
          begin
            if round(calculate(StArr[m_str-1])) = CycArr[m_str-1] then
                begin // Заканчиваем с этим циклом
                 // inc(i);
                  dec(m_str);
                  dec(m);
                  if m = 0 then InProcedure := false;
                end
              else
                begin
                  VremValue := Calculate(StArr[m_str-1]+'+1');
                  index:=ListBoxVars.Items.IndexOfName(StArr[m_str-1]);
                  TempStr := StArr[m_str-1]+'='+FloatToStr(VremValue);
                  ListBoxVars.Items[index]:= TempStr;
                  i:=IArr[m-1];
                end;
          end;

          (* // Проверка на таблицу
          if copy(MainMemo.Lines.Strings[i],Nachalo,IdentCount)='[> ' then
          begin
            // Запоминаем название переменной, которую нужно выразить
            VremName := '';
            k:=Nachalo+IdentCount;
            repeat begin
            VremName := VremName + MainMemo.Lines.Strings[i][k];
            inc(k); end;
            until (MainMemo.Lines.Strings[i][k]=' ');


            ValueInsert(VremName);
          end;{таблица} *)
     end; {end-for-i} //Проход по строчкам

ProcProgress.Position := 0;
ProgressLabel.Caption := '...Готово!';

end;



procedure TReshalkaMainForm.NExitClick(Sender: TObject);
begin
if MainMemo.Modified then
  case MessageBox(ReshalkaMainForm.Handle, 'Сохранить изменения перед выходом?','Выход из программы',35) of
    idYes: begin
            ReshalkaMainForm.NSaveClick(nil);
            if MainMemo.Modified=false then Close;
          end;
    idNo: Close;
    idCancel: Abort;
  end
else Close;
end;

procedure TReshalkaMainForm.NSaveAsClick(Sender: TObject);
begin
if SaveMainDialog.Execute then
     MainMemo.Lines.SaveToFile(SaveMainDialog.FileName);
MainMemo.Modified := false;
end;

procedure TReshalkaMainForm.NOpenClick(Sender: TObject);

  procedure OpenDoc;
  begin
    if OpenMainDialog.Execute then begin
     MainMemo.Lines.LoadFromFile(OpenMainDialog.FileName);
     SaveMainDialog.FileName := OpenMainDialog.FileName;
     end;
  end;

begin

if MainMemo.Modified then
  case MessageBox(ReshalkaMainForm.Handle, 'Сохранить изменения?',
                                          'Открытие нового файла',35) of
    idYes: begin
            ReshalkaMainForm.NSaveClick(nil);
            if not(MainMemo.Modified) then OpenDoc;
          end;
    idNo: OpenDoc;
    idCancel: Abort;
  end
else OpenDoc;

end;

procedure TReshalkaMainForm.NFormulaClick(Sender: TObject);
var p : integer;
begin
p := MainMemo.CaretPos.Y;
if copy(MainMemo.Lines.Strings[p],1,IdentCount)<>'>> ' then
  MainMemo.Lines.Strings[p] := '>> ' + MainMemo.Lines.Strings[p]
else MainMemo.Lines.Strings[p] := copy(MainMemo.Lines.Strings[p],IdentCount+1,
                                  length(MainMemo.Lines.Strings[p])-IdentCount);
end;

procedure TReshalkaMainForm.NUndoClick(Sender: TObject);
begin
MainMemo.Undo;
end;


procedure TReshalkaMainForm.MainMemo1Enter(Sender: TObject);
begin
//Теоретически, должно срабатывать при вводе текста, на данный момент работает
// и при запуске программы
{ReshalkaMainForm.NUndo.Enabled := True;}
end;

procedure TReshalkaMainForm.NEqualsClick(Sender: TObject);
var i_local : integer;
       leng : integer;
begin
i_local := MainMemo.CaretPos.Y;
leng := length(MainMemo.Lines.Strings[i_local]);

if copy(MainMemo.Lines.Strings[i_local],
      leng-3,4) <> ' := ' then
  MainMemo.Lines.Strings[i_local] := MainMemo.Lines.Strings[i_local] + ' := '
else  MainMemo.Lines.Strings[i_local] := copy(MainMemo.Lines.Strings[i_local],1,leng-4)

end;

procedure TReshalkaMainForm.NSaveClick(Sender: TObject);
begin
if SaveMainDialog.FileName='' then
      begin
        if SaveMainDialog.Execute then begin
          MainMemo.Lines.SaveToFile(SaveMainDialog.FileName);
          MainMemo.Modified := false;
          end
      end
   else begin
     MainMemo.Lines.SaveToFile(SaveMainDialog.FileName);
     MainMemo.Modified := false;
   end;
end;

procedure TReshalkaMainForm.NZnachenieClick(Sender: TObject);
var i_local : integer;
       leng : integer;
begin
i_local := MainMemo.CaretPos.Y;
leng := length(MainMemo.Lines.Strings[i_local]);
MainMemo.Lines.Strings[i_local] := MainMemo.Lines.Strings[i_local] + ' Znachenie(';
end;

// -------------------------------------
//Обработка форматирования текста
// -------------------------------------
procedure TReshalkaMainForm.MainMemoKeyPress(Sender: TObject;
  var Key: Char);
  var i,k,m:integer;
      vrem1,vrem2:integer;
      VremString:string;
      Nado:boolean;
begin

  ProgressLabel.Caption := 'Вводится текст';

  case Ord(Key) of
    KEY_CTRL_B:
      begin
        Key := #0;
        if fsBold in (Sender as TRichEdit).SelAttributes.Style then
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style - [fsBold]
        else
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style + [fsBold];
      end;
    KEY_CTRL_I:
      begin
        Key := #0;
        if fsItalic in (Sender as TRichEdit).SelAttributes.Style then
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style - [fsItalic]
        else
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style + [fsItalic];
      end;
    KEY_CTRL_S:
      begin
        Key := #0;
        if fsStrikeout in (Sender as TRichEdit).SelAttributes.Style then
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style-[fsStrikeout]
        else
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style+[fsStrikeout];
      end;
    KEY_CTRL_U:
      begin
        Key := #0;
        if fsUnderline in (Sender as TRichEdit).SelAttributes.Style then
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style-[fsUnderline]
        else
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style+[fsUnderline];
      end;
    KEY_CTRL_Y: //комментарий: делаем зелёный курсив
      begin
        Key := #0;
        if (Sender as TRichEdit).SelAttributes.Color <> clGreen then
          (Sender as TRichEdit).SelAttributes.Color := clGreen
        else
          (Sender as TRichEdit).SelAttributes.Color := clBlack;

        if fsItalic in (Sender as TRichEdit).SelAttributes.Style then
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style - [fsItalic]
        else
          (Sender as TRichEdit).SelAttributes.Style :=
          (Sender as TRichEdit).SelAttributes.Style + [fsItalic];
      end;
    KEY_CTRL_T: // формула: делаем красный
      begin
        Key := #0;
        if (Sender as TRichEdit).SelAttributes.Color <> clRed then
          (Sender as TRichEdit).SelAttributes.Color := clRed
        else
          (Sender as TRichEdit).SelAttributes.Color := clBlack;
      end;
    KEY_CTRL_G: // решение: делаем синий
      begin
        Key := #0;
        if (Sender as TRichEdit).SelAttributes.Color <> clBlue then
          (Sender as TRichEdit).SelAttributes.Color := clBlue
        else
          (Sender as TRichEdit).SelAttributes.Color := clBlack;
      end;
    KEY_CTRL_D: //Создание конечного варианта документа
      begin
        ProgressLabel.Caption := 'Идёт создание конечного варианта текста...';
        Key := #0;
        nado := true;
        ResultMemo.Lines.Clear;
        for i:=0 to (MainMemo.Lines.Count-1) do
          begin

             // Начало текста, не включаемого в конечный вариант
            if ( pos( '(*' ,MainMemo.Lines.Strings[i])<>0 ) and (nado)
               then begin
                     nado := false;
                    end;

             // Копируем текст с учётом возможности однострочного комментария
            if (nado) and (copy(MainMemo.Lines.Strings[i],1,4)<>'(..)')
               then ResultMemo.Lines.Add(MainMemo.Lines.Strings[i]);

             // Конец текста, не включаемого в конечный вариант
            if (pos('*)',MainMemo.Lines.Strings[i])<>0) and (nado=false)
                then nado := true

          end;
      end;
    KEY_CTRL_W: // Меняем местами исходный и конечный варианты документа
      begin
        ReshalkaMainForm.SwapButtonClick(nil);
      end;
    KEY_CTRL_L: // Авто-цвет
      begin
        Key := #0;
        // Проверка синтаксиса - чтобы не было ошибок
        SyntaxFail := false;
        ReshalkaMainForm.NSyntaxClick(nil);
        if SyntaxFail then exit;

        ProgressLabel.Caption := 'Идёт оформление текста...';
        k := 0;
        i := 0;
        while i<>MainMemo.Lines.Count do
          begin
            ProcProgress.Max := MainMemo.Lines.Count;
            ProcProgress.Position := i;

            //Формула
            if (pos('>>',MainMemo.Lines.Strings[i])<>0) then
              begin

            if (length ( copy(MainMemo.Lines.Strings[i],
                             pos(':=',MainMemo.Lines.Strings[i])+1,
                             length(MainMemo.Lines.Strings[i])-
                                pos(':=',MainMemo.Lines.Strings[i])+2) ) < 22)
               and (pos(';',MainMemo.Lines.Strings[i])=0)
            then begin
                m:=0;
                MainMemo.SelStart := k + pos('>>',MainMemo.Lines.Strings[i])-1;
                VremString := copy(MainMemo.Lines.Strings[i],
                                   pos('>>',MainMemo.Lines.Strings[i])+1,
                                   length(MainMemo.Lines.Strings[i])-
                                      pos('>>',MainMemo.Lines.Strings[i]));
              end
            else // Многострочная формула
            begin

                MainMemo.SelStart := k + pos('>>',MainMemo.Lines.Strings[i])-1;

                VremString := '';
                m:=0;
                if pos(';',MainMemo.Lines.Strings[i]) = 0 then begin
                  VremString := copy(MainMemo.Lines.Strings[i],1,length(MainMemo.Lines.Strings[i]));
                  k := k + length(MainMemo.Lines.Strings[i]);
                  m:=m+2;
                  inc(i);
                  while pos(';',MainMemo.Lines.Strings[i]) = 0 do begin
                       VremString := VremString + MainMemo.Lines.Strings[i];
                       k := k + length(MainMemo.Lines.Strings[i]);
                       m:=m+2;
                       inc(i);
                  end; {while}
                end; {if-pos=0}

                if pos(';',MainMemo.Lines.Strings[i]) <> 0 then
                 VremString := VremString +
                 copy(MainMemo.Lines.Strings[i],1,pos(';',MainMemo.Lines.Strings[i]) - 1);
            end; {else}
                MainMemo.SelLength := length(VremString) + m + 1;
                MainMemo.SelAttributes.Color := clRed;
                MainMemo.SelLength := 0;


                //Синий цвет - решение
                MainMemo.SelStart := k + length(MainMemo.Lines.Strings[i]) + 2;
                MainMemo.SelLength := length(MainMemo.Lines.Strings[i+1]);
                MainMemo.SelAttributes.Color := clBlue;

                MainMemo.SelLength:=0;

            end; {формула}

            // Голубой - операторы выбора
          if pos (':>', MainMemo.Lines.Strings[i])<>0 then
              begin    // Многострочный комментарий
                MainMemo.SelStart := k + pos(':>',MainMemo.Lines.Strings[i])-1;
                while pos ('<:',MainMemo.Lines.Strings[i])=0 do
                  begin // Отыскиваем конец
                    k := k + length (MainMemo.Lines.Strings[i]) + 2;
                    inc(i);
                  end;
                MainMemo.SelLength := k - MainMemo.SelStart +
                    pos('<:',MainMemo.Lines.Strings[i]);
                MainMemo.SelAttributes.Color := $FF8888;
                MainMemo.SelLength := 0;
              end;

            // Розовый - блок формул
          if pos ('<(', MainMemo.Lines.Strings[i])<>0 then
              begin    // Блок формул
                MainMemo.SelStart := k + pos('<(',MainMemo.Lines.Strings[i])-1;
                while pos (')>',MainMemo.Lines.Strings[i])=0 do
                  begin // Отыскиваем конец
                    k := k + length (MainMemo.Lines.Strings[i]) + 2;
                    inc(i);
                  end;
                MainMemo.SelLength := k - MainMemo.SelStart +
                    pos(')>',MainMemo.Lines.Strings[i]) + 1;
                MainMemo.SelAttributes.Color := MainMemo.SelAttributes.Color -
                    $220022;
                //MainMemo.SelAttributes.Style := MainMemo.SelAttributes.Style + [fsItalic];
                MainMemo.SelLength := 0;
              end;

            // Оранжевый - процедура
          if pos('::',MainMemo.Lines.Strings[i])<>0 then
              begin
                MainMemo.SelStart := k + pos('::',MainMemo.Lines.Strings[i])-1;
                MainMemo.SelLength := length(MainMemo.Lines.Strings[i]) -
                          pos('::',MainMemo.Lines.Strings[i]) + 1;
                MainMemo.SelAttributes.Color := $0088FF;
                MainMemo.SelLength := 0;
              end;
          if pos('&>',MainMemo.Lines.Strings[i])<>0 then
              begin
                MainMemo.SelStart := k + pos('&>',MainMemo.Lines.Strings[i])-1;
                MainMemo.SelLength := length(MainMemo.Lines.Strings[i]) -
                          pos('&>',MainMemo.Lines.Strings[i]) + 1;
                MainMemo.SelAttributes.Color := $0088FF;
                MainMemo.SelLength := 0;
              end;
            // Золотой цвет - цикл
          if (pos('0>',MainMemo.Lines.Strings[i])<>0) or
             (pos('o>',MainMemo.Lines.Strings[i])<>0) or
             (pos('O>',MainMemo.Lines.Strings[i])<>0) or
             (pos('о>',MainMemo.Lines.Strings[i])<>0) or
             (pos('О>',MainMemo.Lines.Strings[i])<>0) then
              begin
                MainMemo.SelStart := k + pos('>',MainMemo.Lines.Strings[i])-2;
                MainMemo.SelLength := length(MainMemo.Lines.Strings[i]) -
                          pos('>',MainMemo.Lines.Strings[i]);
                MainMemo.SelAttributes.Color := $00CCCC;
                MainMemo.SelLength := 0;
              end;
          if (pos('0;',MainMemo.Lines.Strings[i])<>0) or
             (pos('o;',MainMemo.Lines.Strings[i])<>0) or
             (pos('O;',MainMemo.Lines.Strings[i])<>0) or
             (pos('о;',MainMemo.Lines.Strings[i])<>0) or
             (pos('О;',MainMemo.Lines.Strings[i])<>0) then
              begin
                MainMemo.SelStart := k;
                MainMemo.SelLength := length(MainMemo.Lines.Strings[i]);
                MainMemo.SelAttributes.Color := $00CCCC;
                MainMemo.SelLength := 0;
              end;
            // Серый цвет - текст, не включаемый в конечный документ
          if copy(MainMemo.Lines.Strings[i],1,2)='(*' then
            begin
              MainMemo.SelStart := k + pos('(*',MainMemo.Lines.Strings[i])-1;

                VremString := '';
                m:=0;
                if pos('*)',MainMemo.Lines.Strings[i]) = 0 then begin
                  VremString := copy(MainMemo.Lines.Strings[i],1,length(MainMemo.Lines.Strings[i]));
                  k := k + length(MainMemo.Lines.Strings[i]);
                  m:=m+2;
                  inc(i);
                  while pos('*)',MainMemo.Lines.Strings[i]) = 0 do begin
                       VremString := VremString + MainMemo.Lines.Strings[i];
                       k := k + length(MainMemo.Lines.Strings[i]);
                       m:=m+2;
                       inc(i);
                  end; {while}
                end; {if-pos=0}

                if pos('*)',MainMemo.Lines.Strings[i]) <> 0 then
                 VremString := VremString +
                 copy(MainMemo.Lines.Strings[i],1,pos('*)',MainMemo.Lines.Strings[i]));

                MainMemo.SelLength := length(VremString) + m + 1;
                MainMemo.SelAttributes.Color := $888888;
                MainMemo.SelLength := 0;

          end; {grey}

          if copy(MainMemo.Lines.Strings[i],1,4)='(..)' then
            begin
              MainMemo.SelStart := k;
              MainMemo.SelLength := length(MainMemo.Lines.Strings[i]);
              MainMemo.SelAttributes.Color := $888888;
              MainMemo.SelLength := 0;
            end;

                //Комментарий
            if pos('//',MainMemo.Lines.Strings[i])<>0 then
              begin

                MainMemo.SelStart := k + pos('//',MainMemo.Lines.Strings[i])-1;
                MainMemo.SelLength := length(MainMemo.Lines.Strings[i]) -
                          pos('//',MainMemo.Lines.Strings[i]) + 1;
                MainMemo.SelAttributes.Color := clGreen;
                MainMemo.SelAttributes.Style := MainMemo.SelAttributes.Style + [fsItalic];
                MainMemo.SelLength := 0;

              end;
            if pos ('{', MainMemo.Lines.Strings[i])<>0 then
              begin    // Многострочный комментарий
                MainMemo.SelStart := k + pos('{',MainMemo.Lines.Strings[i])-1;
                while pos ('}',MainMemo.Lines.Strings[i])=0 do
                  begin // Отыскиваем конец
                    k := k + length (MainMemo.Lines.Strings[i]) + 2;
                    inc(i);
                  end;
                MainMemo.SelLength := k - MainMemo.SelStart +
                    pos('}',MainMemo.Lines.Strings[i]);
                MainMemo.SelAttributes.Color := clGreen;
                MainMemo.SelAttributes.Style := MainMemo.SelAttributes.Style + [fsItalic];
                MainMemo.SelLength := 0;
              end;

          k := k + length (MainMemo.Lines.Strings[i]) + 2;
          inc(i);

          end;
       ProcProgress.Position := 0;
      end;
    {KEY_CTRL_Z:    //отмена последнего действия
      begin
        Key:=#0;
        MainMemo.Undo;
      end;               }
  end;
 //Возврат к стандартному стилю
      MainMemo.SelAttributes.Color := clBlack;

      if fsItalic in MainMemo.SelAttributes.Style then
          MainMemo.SelAttributes.Style :=
          MainMemo.SelAttributes.Style - [fsItalic];
      if fsBold in MainMemo.SelAttributes.Style then
          MainMemo.SelAttributes.Style :=
          MainMemo.SelAttributes.Style - [fsBold];
      if fsUnderline in MainMemo.SelAttributes.Style then
          MainMemo.SelAttributes.Style :=
          MainMemo.SelAttributes.Style - [fsUnderline];
      if fsStrikeOut in MainMemo.SelAttributes.Style then
          MainMemo.SelAttributes.Style :=
          MainMemo.SelAttributes.Style - [fsStrikeOut];

ProgressLabel.Caption := '...Готово!';
end;

procedure TReshalkaMainForm.SwapButtonClick(Sender: TObject);
// Переставление местами конечного и исходного текста
begin
if ResultLabel.Caption = 'Конечный текст' then
    ResultLabel.Caption := 'Исходный текст'
  else ResultLabel.Caption := 'Конечный текст';

MainMemo.Lines.SaveToFile('Temp1.rtf');
ResultMemo.Lines.SaveToFile('Temp2.rtf');
ResultMemo.Lines.LoadFromFile('Temp1.rtf');
MainMemo.Lines.LoadFromFile('Temp2.rtf');

end;

//-------------------------------------------
// Одиночное решение формулы
//-------------------------------------------

procedure TReshalkaMainForm.NFontClick(Sender: TObject);
// Надо переделывать

begin
if ChangeFontDialog.Execute then
  begin

  MainMemo.SelAttributes.Name := ChangeFontDialog.Font.Name;
  MainMemo.SelAttributes.Color := ChangeFontDialog.Font.Color;
  MainMemo.SelAttributes.Style := ChangeFontDialog.Font.Style;
  MainMemo.SelAttributes.Pitch := ChangeFontDialog.Font.Pitch;
  MainMemo.SelAttributes.Charset := ChangeFontDialog.Font.Charset;
  end;
end;

procedure TReshalkaMainForm.NCalcClick(Sender: TObject);
var i,k,m,index : integer;
    VremChar : char;
    VremName : string;
    VremString, TempStr : string;
    Fluid : Veshestva;
    Svoistvo : Svoistva;
    Temp, VremValue : real;
  begin
        k := 0;
        i := MainMemo.CaretPos.Y;
         if copy(MainMemo.Lines.Strings[i],1,IdentCount)='>> ' then //Проверка на формулу
          begin
            //Считываем название переменной
            k := IdentCount + 1;
            VremChar:=MainMemo.Lines.Strings[i][k];
            VremName:='';
            repeat begin
                     VremName:=VremName + VremChar;
                     inc(k);
                     VremChar:=MainMemo.Lines.Strings[i][k];
                   end
            until (VremChar=' ') or (VremChar=':');

            //Перебираемся через равно
            while VremChar<>'=' do begin
                                     inc(k);
                                     VremChar:=MainMemo.Lines.Strings[i][k];
                                   end;

            VremString := '';
            TempStr := copy(MainMemo.Lines.Strings[i],k+1,length(MainMemo.Lines.Strings[i]) - k + 1);
            if pos('//',TempStr)<>0 then     // Очищаем от лишних комментариев
                TempStr := copy(TempStr,1,pos('//',TempStr));

            if pos(';',MainMemo.Lines.Strings[i]) = 0 then begin
               VremString := TempStr;
               inc(i);

               while pos(';',MainMemo.Lines.Strings[i]) = 0 do begin
                   TempStr := MainMemo.Lines.Strings[i];
                   if pos('//',TempStr)<>0 then     // Очищаем от лишних комментариев
                       TempStr := copy(TempStr,1,pos('//',TempStr));
                   VremString := VremString + TempStr;
                   inc(i);
                 end; {while}
              end; {if-pos=0}

            if pos(';',MainMemo.Lines.Strings[i]) <> 0 then
               if pos(':=',MainMemo.Lines.Strings[i])<>0 then
                VremString := VremString +
                 copy(MainMemo.Lines.Strings[i],
                   pos(':=',MainMemo.Lines.Strings[i]) + 2,
                   pos(';',MainMemo.Lines.Strings[i])- pos(':=',MainMemo.Lines.Strings[i])-2 )
               else
                 VremString := VremString + copy(MainMemo.Lines.Strings[i], 1,
                   pos(';',MainMemo.Lines.Strings[i]) - 1);

            TempStr := Space_delete(DeleteComments(VremString));

            if ( copy(TempStr,1,3)='Zna' ) or
               ( copy(TempStr,1,3)='zna' ) then
               //Проверка на получение значения свойств среды
                 begin
                   m := pos('(',TempStr);
                   Delete(TempStr,1,m);
                   m := pos(',',TempStr);
                   Fluid := StrToVeshestva(copy(TempStr,1,m-1));

                   Delete(TempStr,1,m);
                   m := pos(',',TempStr);
                   Svoistvo := StrToSvoistva(copy(TempStr,1,m-1));

                   Delete(TempStr,1,m);
                   m := pos(')',TempStr);
                   Temp := StrToFloat(copy(TempStr,1,m-1));

                   VremValue := Znachenie (Fluid,Svoistvo,Temp);
                 end
               else VremValue := Calculate(DeleteComments(VremString));


            index:=ListBoxVars.Items.IndexOfName(VremName);
            TempStr := VremName+'='+FloatToStr(VremValue);
            if index>=0 then
            ListBoxVars.Items[index]:= TempStr
              else
            ListBoxVars.Items.Add(TempStr);

            if copy(MainMemo.Lines.Strings[i+1],1, pos('=',MainMemo.Lines.Strings[i+1])-1 ) =
                 copy(TempStr,1,pos('=',TempStr)-1) then
                  begin
                    if MainMemo.Lines.Strings[i+1] <> TempStr
                      then MainMemo.Lines.Strings[i+1] := TempStr
                  end
              else begin MainMemo.Lines.Insert(i+1,TempStr);
                         MainMemo.Lines.Insert(i+2,'');
                   end;
          end; // Работа с формулой

 // Переход к следующей формуле
 // -> отключается в настройках (в недалёком будущем ;) )
 k := 0;
 repeat begin
          k := k + length(MainMemo.Lines.Strings[i]);
          inc(i);
        end
 until (pos('>>', MainMemo.Lines.Strings[i])<>0) or (i=MainMemo.Lines.Count);
 MainMemo.SelStart := MainMemo.SelStart + k;
  end;

procedure TReshalkaMainForm.NOneStrClick(Sender: TObject);
var p : integer;
begin
p := MainMemo.CaretPos.Y;
if copy(MainMemo.Lines.Strings[p],1,4)<>'(..)' then
  MainMemo.Lines.Strings[p] := '(..) ' + MainMemo.Lines.Strings[p]
else MainMemo.Lines.Strings[p] := copy(MainMemo.Lines.Strings[p],6,length(MainMemo.Lines.Strings[p])-5)
end;

procedure TReshalkaMainForm.N7Click(Sender: TObject);
var p : integer;
    x,x1 : integer;
    vrem:string;
begin
p := MainMemo.CaretPos.Y;
x := MainMemo.CaretPos.X;
x1 := MainMemo.SelStart;
vrem:=MainMemo.Lines.Strings[p];
insert(':',vrem,X+1);
MainMemo.Lines.Strings[p] := vrem;
MainMemo.SelStart := x1+IdentCount;
end;

procedure TReshalkaMainForm.NCreateClick(Sender: TObject);
begin
if MainMemo.Modified then
  case MessageBox(ReshalkaMainForm.Handle, 'Сохранить изменения?','Создание нового документа',35) of
    idYes: begin
            ReshalkaMainForm.NSaveClick(nil);
            MainMemo.Lines.Clear;
            SaveMainDialog.FileName:='';
          end;
    idNo: MainMemo.Lines.Clear;
    idCancel: Abort;
  end;
end;

procedure TReshalkaMainForm.NFontEdClick(Sender: TObject);
begin
  ReshalkaMainForm.NFontClick(nil);
end;

procedure TReshalkaMainForm.NCaseClick(Sender: TObject);
var p : integer;
begin
p := MainMemo.CaretPos.Y;
if copy(MainMemo.Lines.Strings[p],1,IdentCount)<>':> ' then
  MainMemo.Lines.Strings[p] := ':> ' + MainMemo.Lines.Strings[p]
else MainMemo.Lines.Strings[p] := copy(MainMemo.Lines.Strings[p],IdentCount+1,
                                  length(MainMemo.Lines.Strings[p])-IdentCount);
end;

procedure TReshalkaMainForm.NCaseEndClick(Sender: TObject);
var i_local : integer;
       leng : integer;
begin
i_local := MainMemo.CaretPos.Y;
leng := length(MainMemo.Lines.Strings[i_local]);

if copy(MainMemo.Lines.Strings[i_local],
      leng-2,3) <> ' <:' then
  MainMemo.Lines.Strings[i_local] := MainMemo.Lines.Strings[i_local] + ' <:'
else  MainMemo.Lines.Strings[i_local] := copy(MainMemo.Lines.Strings[i_local],1,leng-3)

end;

procedure TReshalkaMainForm.NBeginClick(Sender: TObject);
var p : integer;
    x,x1 : integer;
    vrem:string;
begin
p := MainMemo.CaretPos.Y;
x := MainMemo.CaretPos.X;
x1 := MainMemo.SelStart;
vrem:=MainMemo.Lines.Strings[p];
if pos('<( ',vrem)=0 then begin
  insert('<( ',vrem,X+1);
  MainMemo.Lines.Strings[p] := vrem;
  MainMemo.SelStart := x1+IdentCount;
  end
else begin delete(vrem, pos('<( ',vrem),IdentCount);
           MainMemo.Lines.Strings[p] := vrem;
           MainMemo.SelStart := x1-IdentCount;
     end;
end;

procedure TReshalkaMainForm.NEndClick(Sender: TObject);
var p : integer;
    x,x1 : integer;
    vrem:string;
begin
p := MainMemo.CaretPos.Y;
x := MainMemo.CaretPos.X;
x1 := MainMemo.SelStart;
vrem:=MainMemo.Lines.Strings[p];
if pos(' )>',vrem)=0 then begin
  insert(' )>',vrem,X+1);
  MainMemo.Lines.Strings[p] := vrem;
  MainMemo.SelStart := x1+IdentCount;
  end
else begin delete(vrem, pos(' )>',vrem),IdentCount);
           MainMemo.Lines.Strings[p] := vrem;
           MainMemo.SelStart := x1-IdentCount;
     end;
end;

procedure TReshalkaMainForm.NProcClick(Sender: TObject);
var p : integer;
    x,x1 : integer;
    vrem:string;
begin
p := MainMemo.CaretPos.Y;
x := MainMemo.CaretPos.X;
x1 := MainMemo.SelStart;
vrem:=MainMemo.Lines.Strings[p];
if pos(':: ',vrem)=0 then begin
  insert(':: ',vrem,X+1);
  MainMemo.Lines.Strings[p] := vrem;
  MainMemo.SelStart := x1+IdentCount;
  end
else begin delete(vrem, pos(':: ',vrem),IdentCount);
           MainMemo.Lines.Strings[p] := vrem;
           MainMemo.SelStart := x1-IdentCount;
     end;
end;

// -------------------------------------------
//             Проверка синтаксиса
// -------------------------------------------
procedure TReshalkaMainForm.NSyntaxClick(Sender: TObject);
var i,p,i1,p1,sum,m : integer;
    st : string;

   procedure Oshibka(st:string); overload;
   begin
    ShowMessage(st);
    MainMemo.SelStart := p;
    MainMemo.SelLength := length(st);
    SyntaxFail := true;
   end;

   procedure Oshibka(st:string;p:integer); overload;
   begin
    ShowMessage(st);
    MainMemo.SelStart := p;
    MainMemo.SelLength := length(MainMemo.Lines.Strings[i]);
    SyntaxFail := true;
   end;

   procedure Perehod;
   begin
     if i>=0 then  p := p + length (st) + 2;
     inc(i);
     st := MainMemo.Lines.Strings[i];
   end;

begin

   // Замена идентификаторов

   // Базовые проверки
   // 1. Количество begin = количеству end
   sum :=0;
   m := MainMemo.Lines.Count;
   for i:=0 to m do begin
     st := MainMemo.Lines.Strings[i];
     if pos('<(',st)<>0 then inc(sum);
     if pos(')>',st)<>0 then dec(sum);
   end;
   if sum <> 0 then begin
      Oshibka('Количество идентификаторов начала не равно количеству идентификаторов завершения!');
   end;

   // Проверки синтаксиса
   i := -1;
   p := 0; // Отсчёт выделения

   while i<>MainMemo.Lines.Count do
     begin
       Perehod;

       // Формула     '>> имя := выражение;'
       if pos('>> ',st)<>0 then
           begin
             if pos(' := ',st)=0 then begin
                Oshibka('Отсутствует оператор присвоения в формуле!');
                exit;
                end;
             if ( length( copy(st,pos(':= ',st),length(st)-pos(':= ',st)) )
               >= 20)
                and (st[length(st)]<>';') then
                  begin
                    Oshibka('Отсутствует '';'' в конце!');
                    exit;
                  end;
           end; {формула}

       //Описание процедуры   ':: имя :'
       if pos(':: ',st)<>0 then
         begin
           if (st[length(st)]<>':') then
            begin
             Oshibka('Отсутствует '':'' в конце!');
             exit;
            end;
           i1 := i;
           p1 := p;
           Perehod;
         if (st<>'<(') and (st<>'<( ') then
           begin
             Oshibka ('Отсутствует идентификатор начала процедуры!');
             exit;
           end;
         repeat begin
           Perehod;
           if (i=MainMemo.Lines.Count) then begin
             Oshibka('Не найден идентификатор конца процедуры',p1);
             exit;
           end;
         end
         until (st=')>') or (st=' )>');

         end; {описание процедуры}

       //Оператор выбора  ':> (...) :'
       if pos(':> ',st)<>0 then begin
         if st[length(st)]<>':' then begin
           Oshibka('Отсутствует '':'' в конце строки!');
           exit;
         end;
         Perehod;
         repeat begin // Проход по возможным значениям выбора
         if i=MainMemo.Lines.Count then begin
           Oshibka('Отсутствует идентификатор конца оператора выбора!');
           exit;
         end;

         if pos(':',st)=0 then begin
           Oshibka('Чушь какая-то!');
           exit; end;
         if pos(':',st)<>1 then begin
           Oshibka('Не хватает '':'' перед выбираемым значением!');
           exit; end;
         if pos('<(',st)=0 then // Однострочный код
              begin
                if (st[length(st)]<>';') and (pos('<:',st)=0) then begin
                  Oshibka('Отсутствует '';'' в конце строки!');
                  exit; end;
              end
            else // многострочный код
              begin
                repeat begin
                 if i=MainMemo.Lines.Count then begin
                   Oshibka('Отсутствует идентификатор завершения!');
                   exit;
                 end;
                 Perehod;
                end; until (Space_Delete(st)=')>');
              end;
         Perehod;
         end;
         until (Space_Delete(st)='<:');

       end; {оператор выбора}

       // Оператор цикла 0> i := 1 -> 5 : |  [...] | 0;
       // Идентификатор: ноль, русская или английская 'о'
       if (pos('0> ',st)<>0) or (pos('o> ',st)<>0)
       or (pos('O> ',st)<>0) or (pos('о> ',st)<>0) or (pos('О> ',st)<>0)
         then begin
           // Проверка на конечное значение
           if pos('->',st)=0 then begin
           Oshibka('Отсутствует результирующее значение!'); exit; end;
           // Проверка на начало отсчёта
           if (pos(':=',st)=0) or (Space_delete(
           copy(st,pos(':=',st)+2,pos('->',st)-(pos(':=',st)+2)) )='')
             then begin
            Oshibka('Отсутствует начало отсчёта!'); exit
           end;
           // Проверка на конец цикла
            repeat begin
           Perehod;
           if (i=MainMemo.Lines.Count) then begin
             Oshibka('Не найден идентификатор конца процедуры',p1);
             exit;
           end;
         end
         until (st='0;') or (st='o;') or (st='O;') or (st='о;') or (st='О;');

       end; {оператор цикла}
     end;{проход по строкам}

end;



initialization

SyntaxFail := false;

for i := 1 to VeshMax do
  SetLength(SvoistvaVeshestv[ByteToVeshestva(i)],MaxN[ByteToVeshestva(i)]);

  //Воздух
for i := 0 to MaxN[Vozduh]-1 do
  for k := 1 to 8 do
    SvoistvaVeshestv[Vozduh][i][ByteToSvoistva(k)] := Vozduh_Sv[i+1][ByteToSvoistva(k)];
  //CO2
for i := 0 to MaxN[CO2]-1 do
  for k := 1 to 8 do
    SvoistvaVeshestv[CO2][i][ByteToSvoistva(k)] := SvoistvaVesh[CO2][i+1][ByteToSvoistva(k)];
 //N2
for i := 0 to MaxN[N2]-1 do
  for k := 1 to 8 do
    SvoistvaVeshestv[N2][i][ByteToSvoistva(k)] := SvoistvaVesh[N2][i+1][ByteToSvoistva(k)];
 //СО2
for i := 0 to MaxN[H2]-1 do
  for k := 1 to 8 do
    SvoistvaVeshestv[H2][i][ByteToSvoistva(k)] := SvoistvaVesh[H2][i+1][ByteToSvoistva(k)];
//Вода
for i := 0 to MaxN[Voda]-1 do
  for k := 1 to 8 do
    SvoistvaVeshestv[Voda][i][ByteToSvoistva(k)] := Voda_Sv[i+1][ByteToSvoistva(k)];
//AMG10
for i := 0 to MaxN[AMG10]-1 do
  for k := 1 to 8 do
    SvoistvaVeshestv[AMG10][i][ByteToSvoistva(k)] := AMG10_Sv[i+1][ByteToSvoistva(k)];

finalization
DeleteFile('Temp1.rtf');
DeleteFile('Temp2.rtf');

end.
