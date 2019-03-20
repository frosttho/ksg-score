unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation

uses
  Unit1;

{$R *.lfm}

{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
var
  protokoll: String;
begin
  Form1.StatusBar1.Panels.Items[2].Text := Edit1.Text + ':' + Edit2.Text;
  if CheckBox1.Checked = true then
  begin
    protokoll := 'https://'
  end
  else
  begin
    protokoll := 'http://';
  end;
  Unit1.spielplanserver := protokoll + Edit1.Text + ':' + Edit2.Text;
end;

end.

