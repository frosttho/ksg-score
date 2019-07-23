unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label2: TLabel;
    ListView1: TListView;
    procedure Button1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
  private

  public

  end;

var
  Form6: TForm6;
  nummer: integer;

implementation

{$R *.lfm}

{ TForm6 }

procedure TForm6.ListView1DblClick(Sender: TObject);
begin
  Edit2.Enabled := true;
  Button1.Enabled := true;
  nummer := ListView1.ItemIndex;
  Edit1.Text := ListView1.Items.Item[ListView1.ItemIndex].Caption;
  if ListView1.Items.Item[ListView1.ItemIndex].SubItems.Count > 0 then
  begin
    Edit2.Text := ListView1.Items.Item[ListView1.ItemIndex].SubItems[0];
  end;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
  ListView1.Items.Item[nummer].SubItems[0] := Edit2.Text;
  Edit2.Enabled := false;
  Button1.Enabled := false;
  Edit1.Text := '';
  Edit2.Text := '';
end;

end.

