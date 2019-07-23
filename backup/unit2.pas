unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, Buttons, IdHTTP, fpjson, jsonparser;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    IdHTTP1: TIdHTTP;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListView1: TListView;
    OpenDialog1: TOpenDialog;
    TreeView1: TTreeView;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button8Click(Sender: TObject);
var
  item: TListItem;
begin
  item := Form2.ListView1.Items.Item[Form2.ListView1.ItemIndex];
  item.SubItems.Add(Form2.OpenDialog1.FileName);
  Button8.Enabled := false;
  Form2.OpenDialog1.CleanupInstance;
  Form2.Label1.Caption := 'kein Bild ausgewählt';
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  Form2.ListView1.Items.Delete(Form2.ListView1.ItemIndex);
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  if Form2.OpenDialog1.Execute then
  begin
    Form2.Label1.Caption := OpenDialog1.FileName;
    Form2.Button8.Enabled := true;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  http: TIdHTTP;
  URL, resp: String;
  i, j: integer;
  jsonobject, jObject: TJSONObject;
  jsondataPlayers, team, teamname, players, player: TJSONData;
  teamnode, damen1, herren1, herren2: TTreeNode;
  ListItem: TListItem;
begin
  http := TIdHttp.Create();
  http.ReadTimeout := 5000;

  TreeView1.Items.Clear;
  ListView1.Items.Clear;
  damen1 := TreeView1.Items.Add(nil, '1. Damen-Bundesliga');
  herren1 := TreeView1.Items.Add(nil, '1. Herren-Bundesliga');
  herren2 := TreeView1.Items.Add(nil, '2. Herren-Bundesliga');


  //DAMEN
  URL := 'https://kaelteschutzgebiet.de' + '/kpdata-klon/showDataJSON.php?klasse=damen1';
  try
    http.Request.ContentType := 'application/json';
    http.Request.Accept := 'application/json';
    resp := http.Get(URL);
    jsondataPlayers := getJSON(resp);
  finally
  end;
  for i := 0 to jsondataPlayers.Count-1 do
    begin
      team := jsondataPlayers.Items[i];
      jobject := TJSONObject(team);
      teamnode := TreeView1.Items.AddChild(damen1, jobject.Get('team'));
      ListItem := ListView1.Items.Add;
      ListItem.Caption := jobject.Get('teamshort');

      players := team.Items[1];
      for j := 0 to players.Count-1 do
        begin
          player := players.Items[j];
          jsonobject := TJSONObject(player);
          TreeView1.Items.AddChild(teamnode, jsonobject.Get('trikot') + '  ' + jsonobject.Get('name'));
        end;
    end;

  //HERREN 1
  URL := 'https://kaelteschutzgebiet.de' + '/kpdata-klon/showDataJSON.php?klasse=herren1';
  try
    http.Request.ContentType := 'application/json';
    http.Request.Accept := 'application/json';
    resp := http.Get(URL);
    jsondataPlayers := getJSON(resp);
  finally
  end;
  for i := 0 to jsondataPlayers.Count-1 do
    begin
      team := jsondataPlayers.Items[i];
      jobject := TJSONObject(team);
      teamnode := TreeView1.Items.AddChild(herren1, jobject.Get('team'));
      ListItem := ListView1.Items.Add;
      ListItem.Caption := jobject.Get('teamshort');

      players := team.Items[1];
      for j := 0 to players.Count-1 do
        begin
          player := players.Items[j];
          jsonobject := TJSONObject(player);
          TreeView1.Items.AddChild(teamnode, jsonobject.Get('trikot') + '  ' + jsonobject.Get('name'));
        end;
    end;

  //HERREN 2
  URL := 'https://kaelteschutzgebiet.de' + '/kpdata-klon/showDataJSON.php?klasse=herren2';
  try
    http.Request.ContentType := 'application/json';
    http.Request.Accept := 'application/json';
    resp := http.Get(URL);
    jsondataPlayers := getJSON(resp);
  finally
  end;
  for i := 0 to jsondataPlayers.Count-1 do
    begin
      team := jsondataPlayers.Items[i];
      jobject := TJSONObject(team);
      teamnode := TreeView1.Items.AddChild(herren2, jobject.Get('team'));
      ListItem := ListView1.Items.Add;
      ListItem.Caption := jobject.Get('teamshort');

      players := team.Items[1];
      for j := 0 to players.Count-1 do
        begin
          player := players.Items[j];
          jsonobject := TJSONObject(player);
          TreeView1.Items.AddChild(teamnode, jsonobject.Get('trikot') + '  ' + jsonobject.Get('name'));
        end;
    end;

end;

procedure TForm2.Button9Click(Sender: TObject);
begin
  Form2.ListView1.Items.Clear;
end;

procedure TForm2.ListView1Click(Sender: TObject);
begin
  Edit1.Text := ListView1.Items.Item[ListView1.ItemIndex].Caption;
end;

end.

