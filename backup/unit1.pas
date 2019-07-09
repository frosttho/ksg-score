unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, ExtCtrls, Menus, ComCtrls, Buttons, IdTCPClient, IdHTTP, fpjson,
  jsonparser, Unit2, Unit3, Unit4, Unit5, Unit6;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    IdHTTP1: TIdHTTP;
    Image4: TImage;
    ListView2: TListView;
    MenuItem11: TMenuItem;
    ProgressBar1: TProgressBar;
    TCP: TIdTCPClient;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListView1: TListView;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    StatusBar1: TStatusBar;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  ipaddr, port, spielplanserver: string;
  jsonSettings, jsondataTeams, jsondataGames: TJSONData;
  ServerTeams: array of array[0..1] of String;

implementation

{$R *.lfm}

{ TForm1 }


function Mannschaftsname(id: String): String;
begin
 if id <> '0' then
 begin
   result := trim(ServerTeams[StrToInt(id)-1,1]);
 end
 else
 begin
   result := 'entfaellt';
 end;
end;








procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  // Teste, ob die Zeit von externem Signalgeber kommt oder nicht
  if CheckBox1.Checked = true then
  begin
    //Aktiviere die Bedienung des eigenen Zeitgebers
    SpinEdit1.Enabled := true;
    SpinEdit2.Enabled := true;
    Button1.Enabled := true;
    Button2.Enabled := true;
    Button3.Enabled := true;
    Edit1.Enabled := true;
    Edit2.Enabled := true;
  end;
  if CheckBox1.Checked = false then
  begin
    //Deaktiviere die Bedienung des eigenen Zeitgebers
    SpinEdit1.Enabled := false;
    SpinEdit2.Enabled := false;
    Button1.Enabled := false;
    Button2.Enabled := false;
    Button3.Enabled := false;
    Edit1.Enabled := false;
    Edit2.Enabled := false;

    //Hier die Schleife für Aktualisierung von Remote-Timer einfügen

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  //Teste, ob im Spielplan eine Begegnung ausgewählt wurde
  if ListView1.ItemIndex <> -1 then
  begin
    //Übertrage die Begegnung aus dem Spielplan in die Textfelder
    Form1.Edit6.Text := ListView1.Items.Item[ListView1.ItemIndex].SubItems[0];
    Form1.ComboBox1.Text := ListView1.Items.Item[ListView1.ItemIndex].SubItems[2];
    Form1.Combobox2.Text := ListView1.Items.Item[ListView1.ItemIndex].SubItems[3];
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  http: TIdHTTP;
  URL, resp: String;
  i: integer;
  item: TListItem;
  jsonitem: TJSONData;
  jsonobject: TJSONObject;
begin
  http := TIdHttp.Create();
  http.ReadTimeout := 5000;


  URL := spielplanserver + '/getSettings.php';
  try
    http.Request.ContentType := 'application/json';
    http.Request.Accept := 'application/json';
    resp := http.Get(URL);
    jsonSettings := getJSON(resp);
  finally
  end;
  jsonitem := jsonSettings.Items[0];
  jsonobject := TJSONObject(jsonitem);
  Groupbox5.Caption := 'Spielplan: ' + jsonobject.Get('name');




  URL := spielplanserver + '/getTeams.php';
  try
    http.Request.ContentType := 'application/json';
    http.Request.Accept := 'application/json';
    resp := http.Get(URL);
    jsondataTeams := getJSON(resp);
  finally
  end;
  //ShowMessage('geladen 1');
  URL := spielplanserver + '/updateGames.php';
  try
    http.Request.ContentType := 'application/json';
    http.Request.Accept := 'application/json';
    resp := http.Get(URL);
    jsondataGames := getJSON(resp);
  finally
  end;
  SetLength(ServerTeams, jsonDataTeams.Count);
  for i := 0 to jsondataTeams.Count-1 do
    begin
      jsonitem := jsondataTeams.Items[i];
      jsonobject := TJSONObject(jsonitem);
      ServerTeams[i,0] := jsonobject.Get('ID');
      ServerTeams[i,1] := jsonobject.Get('name');
    end;
  ListView1.Items.Clear;
  ProgressBar1.Max := jsondataGames.Count;
  for i := 0 to jsondataGames.Count-1 do
  begin
    jsonitem := jsondataGames.Items[i];
    jsonobject := TJSONObject(jsonitem);
    item := ListView1.Items.Add;
    item.Caption := jsonobject.Get('gamenumber');
    item.SubItems.Add(copy(jsonobject.Get('time'),12,5));
    item.SubItems.Add(jsonobject.Get('field'));
    item.SubItems.Add(Mannschaftsname(jsonobject.Get('teamHome')));
    item.SubItems.Add(Mannschaftsname(jsonobject.Get('teamAway')));
    item.SubItems.Add(jsonobject.Get('phRef'));
    ProgressBar1.Position := i;
  end;
  ProgressBar1.Position := 0;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  if Button12.Caption = 'Verbinden' then
  begin
    TCP.Connect;
    Button12.Caption := 'Trennen';
    Image4.Picture.LoadFromFile('./gruen.png');
    Form1.StatusBar1.Panels.Items[0].Text := 'CasparCG: verbunden';
  end
  else if Button12.Caption = 'Trennen' then
  begin
    TCP.Disconnect;
    Button12.Caption := 'Verbinden';
    Image4.Picture.LoadFromFile('./rot.png');
    Form1.StatusBar1.Panels.Items[0].Text := 'CasparCG: nicht verbunden';
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if ListView2.ItemIndex <> -1 then
  begin
    TCP.Socket.WriteLn(ListView2.Items.Item[ListView2.ItemIndex].SubItems[0]);
  end;

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  TCP.Socket.WriteLn('CG 1-20 STOP 1');
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  item: TListItem;
begin
  item := ListView2.Items.Add;
  item.Caption := 'L3 2 | ' + Edit3.Text + ' | ' + Edit4.Text;
  item.SubItems.Add('CG 1-20 ADD 1 "LOW3RD_2_50FPS" 1 "<templateData><componentData id=\"f0\"><data id=\"text\" value=\"' + Edit3.Text + '\"/></componentData><componentData id=\"f1\"><data id=\"text\" value=\"' + Edit4.Text + '\"/></componentData></templateData>"\r\n');
end;

procedure TForm1.Button8Click(Sender: TObject);
var
  item: TListItem;
begin
  item := ListView2.Items.Add;
  item.Caption := 'L3 1 | ' + Edit5.Text;
  item.SubItems.Add('CG 1-20 ADD 1 "LOW3RD_1_50FPS" 1 "<templateData><componentData id=\"f0\"><data id=\"text\" value=\"' + Edit5.Text + '\"/></componentData></templateData>"\r\n');
end;

procedure TForm1.Button9Click(Sender: TObject);
//Generieren der Preview
var
  i: integer;
begin
  Image2.Picture.Clear;   //Leeren der Wimpel-Vorschau
  Image3.Picture.Clear;
  Label9.Caption := Edit6.Text;        //Uhrzeit-Preview
  Label7.Caption := ComboBox1.Text;    //Team 1-Preview
  Label8.Caption := ComboBox2.Text;    //Team 2-Preview
  for i := 0 to Form2.ListView1.Items.Count-1 do
  begin
    //Laden der Wimpel aus dem Verwalter-ListView
    if Form2.ListView1.Items.Item[i].Caption = Label7.Caption then
    begin
      Image2.Picture.LoadFromFile(Form2.ListView1.Items.Item[i].SubItems[0]);
    end;
    if Form2.ListView1.Items.Item[i].Caption = Label8.Caption then
    begin
      Image3.Picture.LoadFromFile(Form2.ListView1.Items.Item[i].SubItems[0]);
    end;
  end;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
//Laden der Teams aus dem Verwalter-ListView in die Dropdown-Menüs
var
  i: integer;
begin
  ComboBox1.Clear;
  ComboBox1.Text := 'Team 1';
  ComboBox2.Clear;
  ComboBox2.Text := 'Team 2';
  for i := 0 to Form2.ListView1.Items.Count-1 do
  begin
    ComboBox1.Items.Add(Form2.ListView1.Items.Item[i].Caption);
    ComboBox2.Items.Add(Form2.ListView1.Items.Item[i].Caption);
  end;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  Form6.Show;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
//Öffnen des Verwalter-Forms
begin
  Form2.Show;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Form5.Show;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  Form3.Show;
end;

end.

