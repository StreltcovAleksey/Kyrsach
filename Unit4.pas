unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, Buttons, DB, DBTables, StdCtrls;

type
  TForm4 = class(TForm)
    DataSource4: TDataSource;
    Qs: TQuery;
    ButtonOk: TSpeedButton;
    ButtonCancel: TSpeedButton;
    DBGrids: TDBGrid;
    ControlBar1: TControlBar;
    BtnCancelS: TSpeedButton;
    BtnSaveS: TSpeedButton;
    BtnDelS: TSpeedButton;
    BtnEditS: TSpeedButton;
    BtnAddS: TSpeedButton;
    Que: TQuery;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    procedure GetStrach();
    procedure FormActivate(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure BtnAddsClick(Sender: TObject);
    procedure BtnEditSClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnDelSClick(Sender: TObject);
    procedure BtnSaveSClick(Sender: TObject);
    procedure BtnCancelSClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
     procedure VisiBtnS(fl: boolean);
   
  private
    { Private declarations }
  public
    { Public declarations }
    vozv_id3: integer;
  vozv_name3: string;
  Qtxt: string;
  SID: integer;
  rej:integer;
  errsoob:string;
  ID: string;
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.GetStrach();
Begin
Qtxt:=
'Select StrachID, Vid '+
'From Strach';
With Qs do begin Sql.Clear; Sql.Add(Qtxt); Open; end;
end;

procedure TForm4.FormActivate(Sender: TObject);
begin
GetStrach();
end;

procedure TForm4.ButtonOkClick(Sender: TObject);
begin
If Qs.Eof then Exit;
  vozv_id3:= Qs['StrachID'];
  vozv_name3:= Qs['Vid'];
  Close;
end;

procedure TForm4.BtnAddSClick(Sender: TObject);
begin
SID:=-1;
Edit1.Text:='';
rej:=1;
VisiBtnS(true);
end;

procedure TForm4.BtnEditSClick(Sender: TObject);
begin
SID:=Qs['StrachID'];
Edit1.Text:= Qs['Vid'];
VisiBtnS(true);
rej:=2;
 end;

procedure TForm4.BtnDelSClick(Sender: TObject);

var ssss: string;
    k: integer;
begin
ssss:= '�� ����������� ������� ��� ��������� "'+ Qs.fieldbyName ('Vid').AsString+'"?';
k:= MessageBoxEx(Self.Handle, Pchar(ssss), '����������� ���������...',
   MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
    If k=IDNO then Exit;
    rej:=3;
    BtnSaveSClick(BtnCancelS);
    GetStrach();

end;

procedure TForm4.BtnCancelSClick(Sender: TObject);
begin
getStrach;
VisiBtnS(false);
end;

procedure TForm4.BtnSaveSClick(Sender: TObject);
function ContVvoda(): boolean;
var sss : string;

  begin
    Result:= true; sss:='';
   if length(Trim(Edit1.Text))<2 then sss:=sss+ '-������� �������� ��������'+#13#10;
   if sss<>'' then begin
 result:=false;
 messageboxex(self.handle, PChar(' ��� ������� �������� ��������� ������ ���������� ������: '+#13#10+'��������� ��������� ������ ����� � ����������� �����: '+#13#10+#13#10+sss),'�������� �����������', MB_OK or MB_ICONERROR, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
 end;
 end;
 begin
 //ContVvoda();
  If rej <> 3 then If not ContVvoda() then Exit;
Try
ErrSoob:='';
If rej=1 then begin
   Qtxt:='Select IsNull(max(StrachID)+1, 1) As NewID From Strach';
   With Que do begin SQl.Clear; SQL.Add(Qtxt);Open;end;
   ID:=Que.FieldByName('NewID').AsString;
   Qtxt:=
   'Insert Into Strach (StrachID, Vid, Sum)'+
   'Values('+ID+','''+Trim(Edit1.Text)+''','+'10000)';
   With Que do begin SQl.clear; Sql.add(Qtxt);execsql;end;
   GetStrach;
  end;
If rej=2 then begin
     Qtxt:=
    'Update Strach '+
    'Set Vid ='''+Trim(Edit1.Text)+'''  '+
    'Where StrachID='+Qs.FieldByName('StrachID').AsString;
    With Qs do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
    GetStrach;
  end;

  If rej=3 then begin
  Qtxt:=
  'Delete From Strach'+
  ' Where StrachId = '+Qs.FieldByName('StrachId').AsString;
  With Qs do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
  end;
  except
on E:EDatabaseError do ErrSoob:= E.Message+#10#13#10#13+Qtxt;
else ErrSoob:= '������ �� ����������'+#10#13#10#13+Qtxt;
end;
if ErrSoob>'' then begin
MessageBoxEx(Self.Handle,PCHAR('����� ��� ������� ����������� ������.'+#10#13+#10#13+ErrSoob),
'��� ���������� ������� ����������� ��������� ������', MB_OK or MB_ICONERROR,
(SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
exit;
GetStrach;
end;
end;

procedure TForm4.VisiBtnS(fl: boolean); // ���������� ������������ ����������� ������� ������ ������� � ��������� ���������
begin
  BtnAddS.Enabled:= not fl; BtnEditS.Enabled:= not fl; BtnDelS.Enabled:= not fl;
  DBGridS.Enabled:= not fl;
  BtnSaveS.Enabled:= fl; BtnCancelS.Enabled:= fl; GroupBox1.Visible:= fl;
  If fl then Edit1.SetFocus;
end;


procedure TForm4.FormCreate(Sender: TObject);
begin
GroupBox1.Visible:= false;
VisiBtnS(false);
end;

procedure TForm4.ButtonCancelClick(Sender: TObject);
begin
Close;
end;


end.
