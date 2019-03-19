unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, ExtCtrls, Menus, ComCtrls, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
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
    ListBox1: TListBox;
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
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
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

procedure TForm1.Button10Click(Sender: TObject);
begin
  if ListView1.ItemIndex <> -1 then
  begin
    Form1.Edit6.Text := ListView1.Items.Item[ListView1.ItemIndex].SubItems[0];
    Form1.ComboBox1.Text := ListView1.Items.Item[ListView1.ItemIndex].SubItems[1];
    Form1.Combobox2.Text := ListView1.Items.Item[ListView1.ItemIndex].SubItems[2];
  end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  i: integer;
begin
  Image2.Picture.Clear;
  Image3.Picture.Clear;
  Label9.Caption := Edit6.Text;
  Label7.Caption := ComboBox1.Text;
  Label8.Caption := ComboBox2.Text;
  for i := 0 to Form2.ListView1.Items.Count-1 do
  begin
    //ShowMessage(Form2.ListView1.Items.Item[i].Caption + '  ' + Label7.Caption);
    if Form2.ListView1.Items.Item[i].Caption = Label7.Caption then
    begin
      Image2.Picture.LoadFromFile(Form2.ListView1.Items.Item[i].SubItems[0]);
    end;
    //ShowMessage(Form2.ListView1.Items.Item[i].Caption + '  ' + Label8.Caption);
    if Form2.ListView1.Items.Item[i].Caption = Label8.Caption then
    begin
      Image3.Picture.LoadFromFile(Form2.ListView1.Items.Item[i].SubItems[0]);
    end;
  end;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
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

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Form2.Show;
end;

end.

