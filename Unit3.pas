unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, ExtCtrls, DB, DBTables, StdCtrls;

type
  TForm3 = class(TForm)
    DataSource1: TDataSource;
    Qk: TQuery;
    ControlBar1: TControlBar;
    BtnCancelK: TSpeedButton;
    BtnSaveK: TSpeedButton;
    BtnDelK: TSpeedButton;
    BtnEditK: TSpeedButton;
    BtnAddK: TSpeedButton;
    DBGridK: TDBGrid;
    ButtonOk: TSpeedButton;
    ButtonCancel: TSpeedButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Que: TQuery;
    procedure GetKab();
    procedure ButtonOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnAddKClick(Sender: TObject);
    procedure BtnEditKClick(Sender: TObject);
    procedure BtnDelKClick(Sender: TObject);
    procedure BtnCancelKClick(Sender: TObject);
    procedure BtnSaveKClick(Sender: TObject);
    procedure VisiBtnK(fl: boolean);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Qtxt: string;
   vozv_id2: integer;
  vozv_name2: string;
  KID: integer;
  rej:integer;
  errsoob:string;
  ID: string;
  end;

var
  Form3: TForm3;

implementation

procedure TForm3.GetKab();
Begin
Qtxt:=
'Select KabID, NameK '+
'From Kab';
With Qk do begin Sql.Clear; Sql.Add(Qtxt); Open; end;
end;

{$R *.dfm}

procedure TForm3.ButtonOkClick(Sender: TObject);
begin
If Qk.Eof then Exit;
  vozv_id2:= Qk['KabID'];
  vozv_name2:= Qk['NameK'];
  Close;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
getkab();
end;

procedure TForm3.BtnAddKClick(Sender: TObject);
begin
KID:=-1;
Edit1.Text:='';
rej:=1;
VisiBtnK(true);

end;

procedure TForm3.BtnEditKClick(Sender: TObject);
begin
KID:=QK['KabID'];
Edit1.Text:= QK['NameK'];
VisiBtnK(true);
rej:=2;
end;

procedure TForm3.BtnDelKClick(Sender: TObject);
var ssss: string;
    k: integer;
begin
ssss:= 'Вы собираетесь удалить кабинет "'+ Qk.fieldbyName ('NameK').AsString+'"?';
k:= MessageBoxEx(Self.Handle, Pchar(ssss), 'Подтвердите намерения...',
   MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
    If k=IDNO then Exit;
    rej:=3;
    BtnSaveKClick(BtnCancelK);
    GetKab();


end;

procedure TForm3.BtnCancelKClick(Sender: TObject);
begin
getKab;
VisiBtnK(false);
end;

procedure TForm3.BtnSaveKClick(Sender: TObject);
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
   Qtxt:='Select IsNull(max(KabID)+1, 1) As NewID From Kab';
   With Que do begin SQl.Clear; SQL.Add(Qtxt);Open;end;
   ID:=Que.FieldByName('NewID').AsString;
   Qtxt:=
   'Insert Into Kab (KabID, NameK )'+
   'Values('+ID+','''+Trim(Edit1.Text)+''')';
   With Que do begin SQl.clear; Sql.add(Qtxt);execsql;end;
   GetKab;
  end;
If rej=2 then begin
     Qtxt:=
    'Update Kab '+
    'Set NameK ='''+Trim(Edit1.Text)+'''  '+
    'Where KabID='+Qk.FieldByName('KabID').AsString;
    With Qk do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
    GetKab;
  end;

  If rej=3 then begin
  Qtxt:=
  'Delete From Kab'+
  ' Where KabId = '+Qk.FieldByName('KabId').AsString;
  With Qk do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
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
GetKab;
end;

end;


procedure TForm3.VisiBtnK(fl: boolean); // управление доступностью компонентов ведения списка товаров в приходном документе
begin
  BtnAddK.Enabled:= not fl; BtnEditK.Enabled:= not fl; BtnDelK.Enabled:= not fl;
  DBGridK.Enabled:= not fl;
  BtnSaveK.Enabled:= fl; BtnCancelK.Enabled:= fl; GroupBox1.Visible:= fl;
  If fl then Edit1.SetFocus;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
GroupBox1.Visible:= false;
VisiBtnK(false);
end;

procedure TForm3.ButtonCancelClick(Sender: TObject);
begin
Close;
end;

end.
