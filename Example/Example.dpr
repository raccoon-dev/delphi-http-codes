program Example;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.net.HttpClient,
  HTTPCodes in '..\HTTPCodes.pas';

const
  //URL = 'https://www.google.com/search?q=funny+cat&udm=2';
  URL = 'https://www.google.com/sssearch?q=funny+cat&udm=2';

begin
  try
    var client := THTTPClient.Create;
    try

      var resp1 := client.Head(URL);
      if resp1.StatusCode = THTTPCode.OK then
      begin
        WriteLn('Response 1 returned ok');
      end else
      begin
        WriteLn(Format('Response 1 returned code %d: %s', [
          resp1.StatusCode,
          THTTPCode.ToString(resp1.StatusCode)
        ]));
      end;

      var resp2 := client.Head(URL);
      if THTTPCode.IsOk(resp2) then
      begin
        WriteLn('Response 2 returned ok');
      end else
      begin
        WriteLn(Format('Response 2 returned code %d: %s', [
          resp2.StatusCode,
          THTTPCode.ToString(resp2.StatusCode)
        ]));
      end;

    finally
      client.Free;
    end;

    WriteLn('Type Enter key to finish...');
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
