unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ListView1: TListView;
    OpenDialog1: TOpenDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
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
  item := Form2.ListView1.Items.Add;
  item.Caption := Form2.Edit1.Text;
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

procedure TForm2.Button9Click(Sender: TObject);
begin
  Form2.ListView1.Items.Clear;
end;

end.

