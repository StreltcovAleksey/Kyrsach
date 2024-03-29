unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBTables, ExtCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Database1: TDatabase;
    Qu: TQuery;
    DBGridVrach: TDBGrid;
    Qu1: TQuery;
    DataSource2: TDataSource;
    DBGridP: TDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    Que: TQuery;
    DBGriPac: TDBGrid;
    DataSource3: TDataSource;
    Qu2: TQuery;
    ControlBar2: TControlBar;
    BtnCancelP: TSpeedButton;
    BtnSaveP: TSpeedButton;
    BtnDelP: TSpeedButton;
    BtnEditP: TSpeedButton;
    BtnAddP: TSpeedButton;
    ControlBar1: TControlBar;
    BtnCancelPrc: TSpeedButton;
    BtnSavePrc: TSpeedButton;
    BtnDelPrc: TSpeedButton;
    BtnEditPrc: TSpeedButton;
    BtnAddPrc: TSpeedButton;
    Label5: TLabel;
    Edit3: TEdit;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Panel4: TPanel;
    SpeedButton13: TSpeedButton;
    Query1: TQuery;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    ControlBar3: TControlBar;
    BtnCancelVr1: TSpeedButton;
    BtnSaveVr1: TSpeedButton;
    BtnDelVr1: TSpeedButton;
    BtnEditVr1: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit7: TEdit;
    Panel3: TPanel;
    SpeedButton8: TSpeedButton;
    Edit5: TEdit;
    BtnAddVr1: TSpeedButton;
    procedure GetVr();
    procedure GetPac();
    procedure GetPrc();
    procedure FormActivate(Sender: TObject);

    procedure BtnAddVr1Click(Sender: TObject);
    procedure BtnEditVr1Click(Sender: TObject);
    procedure BtnDelVr1Click(Sender: TObject);
    procedure BtnCancelVr1Click(Sender: TObject);
    procedure BtnSaveVr1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure BtnAddPClick(Sender: TObject);
    procedure BtnEditPClick(Sender: TObject);
    procedure BtnDelPClick(Sender: TObject);
    procedure BtnSavePClick(Sender: TObject);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure VisiBtnV(fl: boolean);
    procedure VisiBtnP(fl: boolean);
    procedure VisiBtnPr(fl: boolean);

    procedure BtnCancelPDblClick(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure BtnCancelPClick(Sender: TObject);
    procedure BtnAddPrcClick(Sender: TObject);
    procedure BtnEditPrcClick(Sender: TObject);
    procedure BtnDelPrcClick(Sender: TObject);
    procedure BtnCancelPrcClick(Sender: TObject);
    procedure BtnSavePrcClick(Sender: TObject);


   private    { Private declarations }
    Qtxt: string;
    rej: integer;
    VrachID: integer;
    PrId:integer;
    ID:string;
    errsoob:string;
    SpecID:integer;
    KabID:integer;
    StrachID:integer;
    PrcID:integer;
    StrID:integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4, Unit5;

{$R *.dfm}

procedure TForm1.GetVr();
Begin
Qtxt:=
'Select VrachID, FIO, Dol, NameS, NameK '+
'From Vrach as V, Spec as C, Kab as K  '+
'Where V.SpecID = C.SpecID And V.KabID  = K.KabID';
With Qu do begin Sql.Clear; Sql.Add(Qtxt); Open; end;
end;

procedure TForm1.GetPac();
begin
  Qtxt:=
   'Select PacID, FIO, Vid, DateBirth '+
   'From Pac as P, Strach as S '+
   'Where S.StrachID = P.StrachID';
  With Query1 do begin Sql.Clear; Sql.Add(Qtxt); Open; end;
end;

procedure TForm1.GetPrc();
begin
If Qu.Fields[0].IsNull then Exit;
 //If Query1.Fields[0].IsNull then Exit;
  Qtxt:=
   ' Select NameP, Stoim, Data '+
   ' From Prc as P  '+
   ' Where VrachID = '+IntToStr(Qu['VrachID'])+ ' and  PacID = '+IntToStr(Query1['PacID'])+'';
  With Qu2 do begin  Sql.Clear; Sql.Add(Qtxt); Open; end;
end;

procedure TForm1.VisiBtnV(fl: boolean); // ���������� ������������ ����������� ������� ������ ������� � ��������� ���������
begin
  BtnAddVr1.Enabled:= not fl; BtnEditVr1.Enabled:= not fl; BtnDelVr1.Enabled:= not fl;
  DBGridVrach.Enabled:= not fl;
  BtnSaveVr1.Enabled:= fl; BtnCancelVr1.Enabled:= fl; GroupBox1.Visible:= fl;
  If fl then Edit1.SetFocus;
end;

procedure TForm1.VisiBtnP(fl: boolean); // ���������� ������������ ����������� ������� ������ ������� � ��������� ���������
begin
  BtnAddP.Enabled:= not fl; BtnEditP.Enabled:= not fl; BtnDelP.Enabled:= not fl;
  DBGridP.Enabled:= not fl;
  BtnSaveP.Enabled:= fl; BtnCancelP.Enabled:= fl; GroupBox2.Visible:= fl;
  If fl then Edit3.SetFocus;
end;

procedure TForm1.VisiBtnPr(fl: boolean); // ���������� ������������ ����������� ������� ������ ������� � ��������� ���������
begin
  BtnAddPrc.Enabled:= not fl; BtnEditPrc.Enabled:= not fl; BtnDelPrc.Enabled:= not fl;
  DBGridP.Enabled:= not fl;
  BtnSavePrc.Enabled:= fl; BtnCancelPrc.Enabled:= fl; GroupBox3.Visible:= fl;
  If fl then Edit5.SetFocus;
end;




procedure TForm1.FormActivate(Sender: TObject);
begin
If database1.Connected=false then database1.Connected:=true;
getvr();
getpac();
GroupBox1.Visible:= false;
GroupBox2.Visible:= false;
GroupBox3.Visible:= false;
VisiBtnV(false);
VisiBtnP(false);
VisiBtnPr(false);
getprc();
end;



procedure TForm1.DataSource2DataChange(Sender: TObject; Field: TField);
begin
getprc();
end;




procedure TForm1.BtnAddVr1Click(Sender: TObject);
begin
 VrachID:=-1;
 Edit1.Text:= '';
 Edit2.Text:= '';
 Panel1.Caption:= '';
 Panel2.Caption:= '';
 rej:=1;
 VisiBtnV(true);
end;

procedure TForm1.BtnEditVr1Click(Sender: TObject);
begin
VrachID:=Qu['VrachID'];
 Edit1.Text:= Qu['FIO'];
 Edit2.Text:= Qu['Dol'];
 Panel1.Caption:= Qu['NameS'];
 Panel2.Caption:= Qu['NameK'];
 rej:=2;
 VisiBtnV(true);
end;

procedure TForm1.BtnDelVr1Click(Sender: TObject);

var ssss: string;
    k: integer;
begin
ssss:= '�� ����������� ������� ���������� "'+ Qu.fieldbyName ('FIO').AsString+'"?';
k:= MessageBoxEx(Self.Handle, Pchar(ssss), '����������� ���������...',
   MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
    If k=IDNO then Exit;
    rej:=3;
    BtnSaveVr1Click(BtnCancelvr1);
    Getvr();
end;

procedure TForm1.BtnCancelVr1Click(Sender: TObject);
begin
getVr;
VisiBtnV(false);
end;

procedure TForm1.BtnSaveVr1Click(Sender: TObject);
function ContVvoda(): boolean;
var sss : string;

  begin
    Result:= true; sss:='';
   if length(Trim(Edit1.Text))<10 then sss:=sss+ '-������� �������� ���'+#13#10;
   if length(Trim(Edit2.Text))<5 then sss:=sss+'-������� ������� ���������'+#13#10;
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
   Qtxt:='Select IsNull(max(VrachID)+1, 1) As NewID From Vrach';
   With Que do begin SQl.Clear; SQL.Add(Qtxt);Open;end;
   ID:=Que.FieldByName('NewID').AsString;
   Qtxt:=
   'Insert Into Vrach (VrachID,FIO,Dol,SpecID,KabID)'+
   'Values('+ID+','''+Trim(Edit1.Text)+''','''+Trim(Edit2.Text)+''','+IntToStr(SpecID)+','+IntToStr(KabID)+')';
   With Que do begin SQl.clear; Sql.add(Qtxt);execsql;end;
   Getvr;
  end;
If rej=2 then begin
     Qtxt:=
    'Update Vrach '+
    'Set FIO ='''+Trim(Edit1.Text)+''','+
    'Dol= '''+Trim(Edit2.Text)+''' '+
    'SpecID= '+IntToStr(SpecID)+','+
    'KabID= '+IntToStr(KabID)+'  '+
    'Where VrachID='+Qu.FieldByName('VrachID').AsString;
    With Qu do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
    Getvr;
  end;

  If rej=3 then begin
  Qtxt:=
  'Delete From Vrach'+
  ' Where VrachId = '+Qu.FieldByName('VrachId').AsString;
  With Qu do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
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
Getvr;
end;
end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Form2.ShowModal;
  If Form2.vozv_id1 > 0 then begin
    Panel1.Caption:= Form2.vozv_name1;
    SpecID:= Form2.vozv_id1;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
Form3.ShowModal;
  If Form3.vozv_id2 > 0 then begin
    Panel2.Caption:= Form3.vozv_name2;
    KabID:= Form3.vozv_id2;
  end;
end;



procedure TForm1.SpeedButton13Click(Sender: TObject);
begin
Form4.ShowModal;
  If Form4.vozv_id3 > 0 then begin
    Panel4.Caption:= Form4.vozv_name3;
    StrachID:= Form4.vozv_id3;
  end;
end;

procedure TForm1.BtnAddPClick(Sender: TObject);
begin
StrachID:=-1;
 Edit3.Text:= '';
 Edit4.Text:= '';
 Panel4.Caption:= '';
 rej:=1;
 VisiBtnP(true);
end;

procedure TForm1.BtnEditPClick(Sender: TObject);
begin
StrachID:=Query1['StrachID'];
 Edit1.Text:= Query1['FIO'];
 Edit2.Text:= Query1['DateBirth'];
 Panel1.Caption:= Query1['Vid'];
 rej:=2;  VisiBtnP(true);

end;

procedure TForm1.BtnDelPClick(Sender: TObject);
var ssss: string;
    k: integer;
begin
ssss:= '�� ����������� ������� �������� "'+ Qu1.fieldbyName ('FIO').AsString+'"?';
k:= MessageBoxEx(Self.Handle, Pchar(ssss), '����������� ���������...',
   MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
    If k=IDNO then Exit;
    rej:=3;
    BtnSavePClick(BtnCancelP);
    GetPac();
end;

procedure TForm1.BtnSavePClick(Sender: TObject);
function ContVvoda1(): boolean;
var sss : string;

  begin
    Result:= true; sss:='';
   if length(Trim(Edit3.Text))<10 then sss:=sss+ '-������� �������� ���'+#13#10;
   if length(Trim(Edit4.Text))<>10 then sss:=sss+'-������� ������� ����'+#13#10;
   if sss<>'' then begin
 result:=false;
 messageboxex(self.handle, PChar(' ��� ������� �������� ��������� ������ ���������� ������: '+#13#10+'��������� ��������� ������ ����� � ����������� �����: '+#13#10+#13#10+sss),'�������� �����������', MB_OK or MB_ICONERROR, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
 end;
 end;
 begin
 //ContVvoda1();
  If rej <> 3 then If not ContVvoda1() then Exit;
Try
ErrSoob:='';
If rej=1 then begin
   Qtxt:='Select IsNull(max(PacID)+1, 1) As NewID From Pac';
   With Que do begin SQl.Clear; SQL.Add(Qtxt);Open;end;
   ID:=Que.FieldByName('NewID').AsString;
   Qtxt:=
   'Insert Into Pac (PacID,FIO,StrachID,DateBirth)'+
   'Values('+ID+','''+Trim(Edit3.Text)+''','+IntToStr(StrachID)+','''+Trim(Edit4.Text)+''')';
   With Que do begin SQl.clear; Sql.add(Qtxt);execsql;end;
   Getpac;
  end;
If rej=2 then begin
     Qtxt:=
    'Update Pac '+
    'Set FIO ='''+Trim(Edit3.Text)+''','+
    'DateBirth= '''+Trim(Edit4.Text)+''' '+
    'StrachID= '+IntToStr(StrachID)+' '+
    'Where PacID='+Qu1.FieldByName('PacID').AsString;
    With Query1 do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
    Getpac;
  end;

  If rej=3 then begin
  Qtxt:=
  'Delete From Pac'+
  ' Where PacId = '+Qu1.FieldByName('PacId').AsString;
  With Query1 do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
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
Getpac;
end;
end;


procedure TForm1.BtnCancelPDblClick(Sender: TObject);
begin
getPac;
VisiBtnP(false);
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
Form5.ShowModal;
  If Form5.vozv_id1 > 0 then begin
    Panel3.Caption:= Form5.vozv_name1;
    Edit5.text:= Form5.vozv_name2;
    PrID:= Form5.vozv_id1;
  end;
end;



procedure TForm1.BtnCancelPClick(Sender: TObject);
begin
getPac;
VisiBtnP(false);
end;

procedure TForm1.BtnAddPrcClick(Sender: TObject);
begin
PrcID:=-1;
 Edit1.Text:= '';
 Edit2.Text:= '';
 Panel1.Caption:= '';
 rej:=1;
 VisiBtnPr(true);
end;

procedure TForm1.BtnEditPrcClick(Sender: TObject);
begin
 PrID:=Qu2['PrcID'];
 Edit5.Text:= Qu2['Stoim'];
 Edit7.Text:= Qu2['Data'];
 Panel3.Caption:= Qu2['NameP'];

 rej:=2;
 VisiBtnPr(true);
end;

procedure TForm1.BtnDelPrcClick(Sender: TObject);
var ssss: string;
    k: integer;
begin
ssss:= '�� ����������� ������� ��������� "'+ Qu.fieldbyName ('FIO').AsString+'"?';
k:= MessageBoxEx(Self.Handle, Pchar(ssss), '����������� ���������...',
   MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2, (SUBLANG_DEFAULT shl 10) or LANG_RUSSIAN);
    If k=IDNO then Exit;
    rej:=3;
    BtnSavePrcClick(BtnCancelPrc);
    Getprc();
end;

procedure TForm1.BtnCancelPrcClick(Sender: TObject);
begin
getprc;
VisiBtnpr(false);
end;

procedure TForm1.BtnSavePrcClick(Sender: TObject);
function ContVvoda(): boolean;
var sss : string;

  begin
    Result:= true; sss:='';
   if length(Trim(Edit5.Text))<2 then sss:=sss+ '-������� ��������� ���������'+#13#10;
   if length(Trim(Edit2.Text))>11 then sss:=sss+'-������� ������� ����'+#13#10;
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
   Qtxt:='Select IsNull(max(PrcID)+1, 1) As NewID From Prc';
   With Que do begin SQl.Clear; SQL.Add(Qtxt);Open;end;
   ID:=Que.FieldByName('NewID').AsString;
   Qtxt:=
  'Insert Into Prc (PrcID,NameP,Stoim,Data,PacID,VrachID)'+
  'Values('+ID+','''+Panel3.Caption+''','''+Trim(Edit5.Text)+''','''+Trim(Edit7.Text)+''','+IntToStr(Query1['PacID'])+','+IntToStr(Qu['VrachID'])+' )';
   With Que do begin SQl.clear; Sql.add(Qtxt);execsql;end;
   Getprc;
  end;
If rej=2 then begin
    Qtxt:=
 'Update Prc '+
    'Set NameP ='''+Panel3.Caption+''','+
    'Stoim= '''+Trim(Edit5.Text)+''', '+
    'Data= '''+Trim(Edit7.Text)+''' '+
    'Where PrcID='+Qu2.FieldByName('PrcID').AsString;
    With Qu2 do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
    Getprc;
  end;

  If rej=3 then begin
  Qtxt:=
  'Delete From Prc'+
  ' Where PrcId = '+Qu2.FieldByName('PrcId').AsString;
  With Qu2 do begin SQL.Clear;SQL.Add(Qtxt);ExecSQl;end;
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
Getprc;
end;
end;



end.
