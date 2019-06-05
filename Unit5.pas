unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Grids, DBGrids, ExtCtrls, Buttons;

type
  TForm5 = class(TForm)
    ButtonOk: TSpeedButton;
    ButtonCancel: TSpeedButton;
    ControlBar1: TControlBar;
    BtnSaveS: TSpeedButton;
    BtnDelS: TSpeedButton;
    BtnEditS: TSpeedButton;
    BtnAddS: TSpeedButton;
    BtnCancelS: TSpeedButton;
    DBGridS: TDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    DataSource1: TDataSource;
    Qs: TQuery;
    Que: TQuery;
    Label2: TLabel;
    Edit2: TEdit;
    procedure GetSpec();
    procedure ButtonOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnAddSClick(Sender: TObject);
    procedure BtnEditSClick(Sender: TObject);
    procedure BtnDelSClick(Sender: TObject);
    procedure BtnCancelSClick(Sender: TObject);
    procedure BtnSaveSClick(Sender: TObject);
    procedure VisiBtnS(fl: boolean);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    vozv_id1: integer;
  vozv_name1: string;
  vozv_name2: string;
  Qtxt: string;
  PrID: integer;
  rej:integer;
  errsoob:string;
  ID: string;
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.GetSpec();
Begin
Qtxt:=
'Select PrId, Name, Stoim '+
'From Pr';
With Qs do begin Sql.Clear; Sql.Add(Qtxt); Open; end;
end;

procedure TForm5.ButtonOkClick(Sender: TObject);
begin
If Qs.Eof then Exit;
  vozv_id1:= Qs['PrID'];
  vozv_name1:= Qs['Name'];
  vozv_name2:= Qs['Stoim'];
  Close;
end;

procedure TForm5.FormActivate(Sender: TObject);
begin
GetSpec();
end;

procedure TForm5.BtnAddSClick(Sender: TObject);
begin
PrID:=-1;
Edit1.Text:='';
Edit2.Text:='';
rej:=1;
VisiBtnS(true);
end;

procedure TForm5.BtnEditSClick(Sender: TObject);
begin
PrID:=Qs['PrID'];
 Edit1.Text:= Qs['Name'];
 Edit2.Text:= Qs['Stoim'];
 VisiBtnS(true);
rej:=2;
 end;

procedure TForm5.BtnDelSClick(Sender: TObject);

var ssss: string;
    k: integer;
begin
ssss:= 'Вы собираетесь удалить процедуру "'+ Qs.fieldbyName ('Name').AsString+'"?';
k:= MessageBoxEx(Self.Handle, Pchar(ssss), 'Подтвердите намерения...',
   MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
    If k=IDNO then Exit;
    rej:=3;
    BtnSaveSClick(BtnCancelS);
    GetSpec();

end;

procedure TForm5.BtnCancelSClick(Sender: TObject);
begin
getSpec;
VisiBtnS(false);
end;

procedure TForm5.BtnSaveSClick(Sender: TObject);
function ContVvoda(): boolean;
var sss : string;

  begin
    Result:= true; sss:='';
   if length(Trim(Edit1.Text))<2 then sss:=sss+ '-Слишком короткое название'+#13#10;
   if sss<>'' then begin
 result:=false;
 messageboxex(self.handle, PChar(' При входном контроле введенных данных обнаружены ошибки: '+#13#10+'исправьте указанные ошибки ввода и попытайтесь снова: '+#13#10+#13#10+sss),'операция невыполнима', MB_OK or MB_ICONERROR, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
 end;
 end;
 begin
 //ContVvoda();
  If rej <> 3 then If not ContVvoda() then Exit;
Try
ErrSoob:='';
If rej=1 then begin
   Qtxt:='Select IsNull(max(PrID)+1, 1) As NewID From Pr';
   With Que do begin SQl.Clear; SQL.Add(Qtxt);Open;end;
   ID:=Que.FieldByName('NewID').AsString;
   Qtxt:=
   'Insert Into Pr (PrID, Name, Stoim )'+
   'Values('+ID+','''+Trim(Edit1.Text)+''' , '''+Trim(Edit2.Text)+''')';
   With Que do begin SQl.clear; Sql.add(Qtxt);execsql;end;
   GetSpec;
  end;
If rej=2 then begin
     Qtxt:=
    'Update Pr '+
    'Set Name ='''+Trim(Edit1.Text)+''','+
    'Set Stoim ='''+Trim(Edit2.Text)+'''  '+
    'Where PrID='+Qs.FieldByName('PrID').AsString;
    With Qs do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
    GetSpec;
  end;

  If rej=3 then begin
  Qtxt:=
  'Delete From Pr'+
  ' Where PrId = '+Qs.FieldByName('PrId').AsString;
  With Qs do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
  end;
  except
on E:EDatabaseError do ErrSoob:= E.Message+#10#13#10#13+Qtxt;
else ErrSoob:= 'Ошибка не распознана'+#10#13#10#13+Qtxt;
end;
if ErrSoob>'' then begin
MessageBoxEx(Self.Handle,PCHAR('Отказ при попытке модификации данных.'+#10#13+#10#13+ErrSoob),
'При исполнении команды модификации произошла ошибка', MB_OK or MB_ICONERROR,
(SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
exit;
GetSpec;
end;
end;

procedure TForm5.VisiBtnS(fl: boolean); // управление доступностью компонентов ведения списка товаров в приходном документе
begin
  BtnAddS.Enabled:= not fl; BtnEditS.Enabled:= not fl; BtnDelS.Enabled:= not fl;
  DBGridS.Enabled:= not fl;
  BtnSaveS.Enabled:= fl; BtnCancelS.Enabled:= fl; GroupBox1.Visible:= fl;
  If fl then Edit1.SetFocus;
end;


procedure TForm5.FormCreate(Sender: TObject);
begin
GroupBox1.Visible:= false;
VisiBtnS(false);
end;

procedure TForm5.ButtonCancelClick(Sender: TObject);
begin
Close;
end;

end.
