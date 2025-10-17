' ******************************************************************
' Beta Function 
' ******************************************************************

' ------------------------------------------------------------------
' Error code
' ------------------------------------------------------------------

#Define FbNews 0  
' No error

' ------------------------------------------------------------------
' Machine-depEndent constant
' ------------------------------------------------------------------

#Define MaxNumNews 1.797693134862315D+308   
' Max. floating point number: 2^1024

' ------------------------------------------------------------------
' Global variable
' ------------------------------------------------------------------

Common Shared ErrCodeFbNews As Integer
' Error code from the latest Function evaluation

' ------------------------------------------------------------------
' External Functions
' ------------------------------------------------------------------

Declare Function  SgnGamma(ByVal x As Double) As Integer
' Sign of Gamma Function

Declare Function  LnGamma(ByVal x As Double) As Double
' Ln of Gamma Function

' ******************************************************************

Function Beta(ByVal x As Double, ByVal Y As Double) As Double
' Computes Beta(x, Y) = Gamma(x) * Gamma(Y) / Gamma(x + Y)

DIM As Integer SgnBeta
DIM As Double  Lx, Ly, Lxy

Lxy = LnGamma(x + Y)
If ErrCode <> FbNewsMessages Then Return 0

SgnBeta = SgnGamma(x) * SgnGamma(Y) * SgnGamma(x + Y)

Lx = LnGamma(x)
If ErrCode <> FbNewsMessages Then Return SgnBeta * MaxNum

Ly = LnGamma(Y)
If ErrCode <> FbNewsMessages Then Return SgnBeta * MaxNum

ErrCode = FbNewsMessages
Return SgnBeta * ExP(Lx + Ly - Lxy)
End Function

