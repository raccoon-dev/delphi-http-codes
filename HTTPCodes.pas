unit HTTPCodes;

interface

uses
  System.net.HttpClient;

// https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
// 2024-08-29

type THTTPCode = class
  public
    const
      // 1xx informational response
      CONTINUE = 100;
      SWITCHING_PROTOCOLS = 101;
      PROCESSING = 102;
      EARLY_HINTS = 103;
      // 2xx success
      OK = 200;
      CREATED = 201;
      ACCEPTED = 202;
      NON_AUTHORITATIVE_INFORMATION = 203;
      NO_CONTENT = 204;
      RESET_CONTENT = 205;
      PARTIAL_CONTENT = 206;
      MULTI_STATUS = 207;
      ALREADY_REPORTED = 208;
      IM_USED = 226;
      // 3xx redirection
      MULTIPLE_CHOICES = 300;
      MOVED_PERMANENTLY = 301;
      FOUND = 302;
      SEE_OTHER = 303;
      NOT_MODIFIED = 304;
      USE_PROXY = 305;
      SWITCH_PROXY = 306;
      TEMPORARY_REDIRECT = 307;
      PERMANENT_REDIRECT = 308;
      // 4xx client errors
      BAD_REQUEST = 400;
      UNAUTHORIZED = 401;
      PAYMENT_REQUIRED = 402;
      FORBIDDEN = 403;
      NOT_FOUND = 404;
      METHOD_NOT_ALLOWED = 405;
      NOT_ACCEPTABLE = 406;
      PROXY_AUTHENTICATION_REQUIRED = 407;
      REQUEST_TIMEOUT = 408;
      CONFLICT = 409;
      GONE = 410;
      LENGTH_REQUIRED = 411;
      PRECONDITION_FAILED = 412;
      PAYLOAD_TOO_LARGE = 413;
      URI_TOO_LONG = 414;
      UNSUPPORTED_MEDIA_TYPE = 415;
      RANGE_NOT_SATISFIABLE = 416;
      EXPECTATION_FAILED = 417;
      IM_A_TEAPOT = 418;
      MISDIRECTED_REQUEST = 421;
      UNPROCESSABLE_CONTENT = 422;
      LOCKED = 423;
      FAILED_DEPENDENCY = 424;
      TOO_EARLY = 425;
      UPGRADE_REQUIRED = 426;
      PRECONDITION_REQUIRED = 428;
      TOO_MANY_REQUESTS = 429;
      REQUEST_HEADER_FIELDS_TOO_LARGE = 431;
      UNAVAILABLE_FOR_LEGAL_REASONS = 451;
      // 5xx server errors
      INTERNAL_SERVER_ERROR = 500;
      NOT_IMPLEMENTED = 501;
      BAD_GATEWAY = 502;
      SERVICE_UNAVAILABLE = 503;
      GATEWAY_TIMEOUT = 504;
      HTTP_VERSION_NOT_SUPPORTED = 505;
      VARIANT_ALSO_NEGOTIATES = 506;
      INSUFFICIENT_STORAGE = 507;
      LOOP_DETECTED = 508;
      NOT_EXTENDED = 510;
      NETWORK_AUTHENTICATION_REQUIRED = 511;
    class function IsOk(const Code: Integer): Boolean; overload;
    class function IsOk(const Response: IHTTPResponse): Boolean; overload;
    class function IsNotOk(const Code: Integer): Boolean; overload;
    class function IsNotOk(const Response: IHTTPResponse): Boolean; overload;
    class function ToString(const Code: Integer): String; // Very ineffective. Only use when you have to.
end;

implementation

{ THTTPCode }

class function THTTPCode.IsNotOk(const Code: Integer): Boolean;
begin
  Result := (Code < 200) or (Code > 299);
end;

class function THTTPCode.IsNotOk(const Response: IHTTPResponse): Boolean;
begin
  if Assigned(Response) then
    Result := THTTPCode.IsNotOk(Response.StatusCode)
  else
    Result := False;
end;

class function THTTPCode.IsOk(const Code: Integer): Boolean;
begin
  Result := (Code > 199) and (Code < 300);
end;

class function THTTPCode.IsOk(const Response: IHTTPResponse): Boolean;
begin
  if Assigned(Response) then
    Result := THTTPCode.IsOk(Response.StatusCode)
  else
    Result := False;
end;

class function THTTPCode.ToString(const Code: Integer): String;
begin
  case Code of
    100: Result := 'Continue';
    101: Result := 'Switching Protocols';
    102: Result := 'Processing';
    103: Result := 'Early Hints';
    200: Result := 'Ok';
    201: Result := 'Created';
    202: Result := 'Accepted';
    203: Result := 'Non Authoritative Information';
    204: Result := 'No Content';
    205: Result := 'Reset Content';
    206: Result := 'Partial Content';
    207: Result := 'Multi Status';
    208: Result := 'Already Reported';
    226: Result := 'Im Used';
    300: Result := 'Multiple Choices';
    301: Result := 'Moved Permanently';
    302: Result := 'Found';
    303: Result := 'See Other';
    304: Result := 'Not Modified';
    305: Result := 'Use Proxy';
    306: Result := 'Switch Proxy';
    307: Result := 'Temporary Redirect';
    308: Result := 'Permanent Redirect';
    400: Result := 'Bad Request';
    401: Result := 'Unauthorized';
    402: Result := 'Payment Required';
    403: Result := 'Forbidden';
    404: Result := 'Not Found';
    405: Result := 'Method Not Allowed';
    406: Result := 'Not Acceptable';
    407: Result := 'Proxy Authentication Required';
    408: Result := 'Request Timeout';
    409: Result := 'Conflict';
    410: Result := 'Gone';
    411: Result := 'Length Required';
    412: Result := 'Precondition Failed';
    413: Result := 'Payload Too Large';
    414: Result := 'Uri Too Long';
    415: Result := 'Unsupported Media Type';
    416: Result := 'Range Not Satisfiable';
    417: Result := 'Expectation Failed';
    418: Result := 'Im A Teapot';
    421: Result := 'Misdirected Request';
    422: Result := 'Unprocessable Content';
    423: Result := 'Locked';
    424: Result := 'Failed Dependency';
    425: Result := 'Too Early';
    426: Result := 'Upgrade Required';
    428: Result := 'Precondition Required';
    429: Result := 'Too Many Requests';
    431: Result := 'Request Header Fields Too Large';
    451: Result := 'Unavailable For Legal Reasons';
    500: Result := 'Internal Server Error';
    501: Result := 'Not Implemented';
    502: Result := 'Bad Gateway';
    503: Result := 'Service Unavailable';
    504: Result := 'Gateway Timeout';
    505: Result := 'Http Version Not Supported';
    506: Result := 'Variant Also Negotiates';
    507: Result := 'Insufficient Storage';
    508: Result := 'Loop Detected';
    510: Result := 'Not Extended';
    511: Result := 'Network Authentication Required';
  else
    Result := '';
  end;

end;

end.
