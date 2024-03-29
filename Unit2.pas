unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, ExtCtrls, DB, DBTables, StdCtrls;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    Qs: TQuery;
    ControlBar1: TControlBar;
    BtnSaveS: TSpeedButton;
    BtnDelS: TSpeedButton;
    BtnEditS: TSpeedButton;
    BtnAddS: TSpeedButton;
    DBGridS: TDBGrid;
    ButtonOk: TSpeedButton;
    ButtonCancel: TSpeedButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    BtnCancelS: TSpeedButton;
    Que: TQuery;
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
  Qtxt: string;
  SID: integer;
  rej:integer;
  errsoob:string;
  ID: string;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.GetSpec();
Begin
Qtxt:=
'Select SpecID, NameS '+
'From Spec';
With Qs do begin Sql.Clear; Sql.Add(Qtxt); Open; end;
end;

procedure TForm2.ButtonOkClick(Sender: TObject);
begin
If Qs.Eof then Exit;
  vozv_id1:= Qs['SpecID'];
  vozv_name1:= Qs['NameS'];
  Close;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
GetSpec();
end;

procedure TForm2.BtnAddSClick(Sender: TObject);
begin
SID:=-1;
Edit1.Text:='';
rej:=1;
VisiBtnS(true);
end;

procedure TForm2.BtnEditSClick(Sender: TObject);
begin
SID:=Qs['SpecID'];
 Edit1.Text:= Qs['NameS'];
VisiBtnS(true);
rej:=2;
 end;

procedure TForm2.BtnDelSClick(Sender: TObject);

var ssss: string;
    k: integer;
begin
ssss:= '�� ����������� ������� ������������� "'+ Qs.fieldbyName ('NameS').AsString+'"?';
k:= MessageBoxEx(Self.Handle, Pchar(ssss), '����������� ���������...',
   MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
    If k=IDNO then Exit;
    rej:=3;
    BtnSaveSClick(BtnCancelS);
    GetSpec();

end;

procedure TForm2.BtnCancelSClick(Sender: TObject);
begin
getSpec;
VisiBtnS(false);
end;

procedure TForm2.BtnSaveSClick(Sender: TObject);
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
   Qtxt:='Select IsNull(max(SpecID)+1, 1) As NewID From Spec';
   With Que do begin SQl.Clear; SQL.Add(Qtxt);Open;end;
   ID:=Que.FieldByName('NewID').AsString;
   Qtxt:=
   'Insert Into Spec (SpecID, NameS )'+
   'Values('+ID+','''+Trim(Edit1.Text)+''')';
   With Que do begin SQl.clear; Sql.add(Qtxt);execsql;end;
   GetSpec;
  end;
If rej=2 then begin
     Qtxt:=
    'Update Spec '+
    'Set NameS ='''+Trim(Edit1.Text)+'''  '+
    'Where SpecID='+Qs.FieldByName('SpecID').AsString;
    With Qs do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
    GetSpec;
  end;

  If rej=3 then begin
  Qtxt:=
  'Delete From Spec'+
  ' Where SpecId = '+Qs.FieldByName('SpecId').AsString;
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
GetSpec;
end;
end;

procedure TForm2.VisiBtnS(fl: boolean); // ���������� ������������ ����������� ������� ������ ������� � ��������� ���������
begin
  BtnAddS.Enabled:= not fl; BtnEditS.Enabled:= not fl; BtnDelS.Enabled:= not fl;
  DBGridS.Enabled:= not fl;
  BtnSaveS.Enabled:= fl; BtnCancelS.Enabled:= fl; GroupBox1.Visible:= fl;
  If fl then Edit1.SetFocus;
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
GroupBox1.Visible:= false;
VisiBtnS(false);
end;

procedure TForm2.ButtonCancelClick(Sender: TObject);
begin
Close;
end;

end.
