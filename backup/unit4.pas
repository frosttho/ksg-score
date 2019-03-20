unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation

uses
  Unit1;

{$R *.lfm}

{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  if (Edit1.Text <> '') and (Edit2.Text <> '') then
  begin
    Unit1.ipaddr := Edit1.Text;
    Unit1.port := Edit2.Text;
    Form1.TCP.Host := Unit1.ipaddr;
    Form1.TCP.Port := Unit1.port;
    Form1.StatusBar1.Panels.Items[1].Text := Unit1.ipaddr + ':' + Unit1.port;
    Form4.Close;
  end
  else
  begin
    ShowMessage('Bitte überprüfen Sie Ihre Eingabe!');
  end;
end;

end.

