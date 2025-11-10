В этой задаче я делала небольшой веб-прототип на Delphi + IIS + SQL Server.

Смысл был в том, чтобы реализовать обработчик, который по запросу (GET) 
возвращает список туров в формате JSON. 

Я использовала ISAPI-модуль в Delphi. 
Подключение к базе выполняла через ADOConnection.

Фрагмент кода (для понимания логики):

procedure TWebModule1.GetTours(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var Q: TADOQuery; J: TJSONArray; O: TJSONObject;
begin
  Q := TADOQuery.Create(nil);
  try
    Q.Connection := ADOConnection1;
    Q.SQL.Text := 'SELECT Id, StartDate, EndDate, Price FROM Tours ORDER BY StartDate';
    Q.Open;

    J := TJSONArray.Create;
    while not Q.Eof do
    begin
      O := TJSONObject.Create;
      O.AddPair('id',        TJSONNumber.Create(Q.FieldByName('Id').AsInteger));
      O.AddPair('startDate', Q.FieldByName('StartDate').AsString);
      O.AddPair('endDate',   Q.FieldByName('EndDate').AsString);
      O.AddPair('price',     TJSONNumber.Create(Q.FieldByName('Price').AsFloat));
      J.AddElement(O);
      Q.Next;
    end;

    Response.ContentType := 'application/json; charset=utf-8';
    Response.Content := J.ToJSON;
  finally
    Q.Free;
  end;
  Handled := True;
end;

Запуск:
- проект запускался через IIS (ISAPI),
- проверка ответа в браузере: http://localhost/.../api/tours
- в отчёте есть скрин с JSON-ответом.

Файлы проекта не загружаю сюда, так как запускался локально.
Главное — логика и демонстрация работы обработчика.
