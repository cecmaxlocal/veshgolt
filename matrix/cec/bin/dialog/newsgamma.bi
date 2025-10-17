' ******************************************************************
' DiGamma and TriGamma Functions.
' BAsed on a contribution by Philip Fletcher (FLETCHP@WESTAT.com)
' ******************************************************************

' ------------------------------------------------------------------
' Error codes
' ------------------------------------------------------------------

#Define FbNewsMessages 0
' No error

#Define FSing -2
' Singularity

' ------------------------------------------------------------------
' Machine-depEnd ent Constant
' ------------------------------------------------------------------

#Define MaxNum 1.797693134862315D+308
' Max. floating point number: 2^1024

' ------------------------------------------------------------------
' Global variable
' ------------------------------------------------------------------

Common Shared ErrCode As Integer
' Error code from the latest Function evaluation

' ******************************************************************

Function NewsGamma (ByVal x As Double) As Double
' ------------------------------------------------------------------
' Digamma calculates the Digamma or Psi Function
' = d ( Ln ( Gamma ( x ) ) ) / dx
'
'  Reference:
'
'    J Bernardo,
'    Psi ( Digamma ) Function,
'    Algorithm As 103,
'    Applied Statistics,
'    Volume 25, Number 3, pages 315-317, 1976.
'
'  ModIfied:
'
'    03 January 2000
'
'  Parameters:
'
'    Input, real x, the argument of the Digamma Function.
'    0 < x.
'
'    Output, real Digamma, the value of the Digamma Function at x.
' ------------------------------------------------------------------

  Const C  = 20#
  Const S  = 0.00001#
  Const D1 = -0.57721566490153286061#  ' DiGamma(1)

  ' Sterling coefficient S(n) = B(n) / 2n
  ' where B(n) = Bernoulli number

  Const S2  =  0.08333333333333333333#    ' B(2)/2
  Const S4  = -0.83333333333333333333D-2  ' B(4)/4
  Const S6  =  0.39682539682539682541D-2  ' B(6)/6
  Const S8  = -0.41666666666666666666D-2  ' B(8)/8
  Const S10 =  0.75757575757575757576D-2  ' B(10)/10
  Const S12 = -0.21092796092796092796D-1  ' B(12)/12
  Const S14 =  0.83333333333333333335D-1  ' B(14)/14
  Const S16 = -0.44325980392156862745     ' B(16)/16

  ' Function argument must be positive.
 
  If x <= 0 Then 
    ErrCode = FSing
    Return MaxNum
  End  If

  Dim As Double Dg, P, R, Y

  ErrCode = FbNewsMessages

  If x = 1 Then Return D1

  ' Use approximation If argument <= S.

  If x <= S Then

    Dg = D1 - 1 / x

  ' Reduce the argument to Dg(x + N) where (x + N) >= C.

  Else
    Dg = 0
    Y = x

    Do While Y < C
      Dg = Dg - 1 / Y
      Y = Y + 1
    Loop

    ' Use Stirling's (actually de Moivre's) expansion If argument > C.

    R = 1 / (Y * Y)
    
    P = (((((((S16 * R + S14) * R + S12) * R + S10) * R + S8) * R + _
               S6) * R + S4) * R + S2) * R

    Dg = Dg + LOG(Y) - 0.5 / Y - P
  End  If

  Return Dg
End  Function

Function NewsTriGamma (ByVal x As Double) As Double
' ------------------------------------------------------------------
' Trigamma calculates the Trigamma or Psi Prime Function =
'  d**2 ( LOG ( GAMMA ( x ) ) ) / dx**2
'
'  Reference:
'
'    Algorithm As121 Appl. Statist. (1978) vol 27, no. 1
' ------------------------------------------------------------------

  Const A    = 0.0001#
  Const B    = 20
  Const Zero = 0
  Const One  = 1
  Const Half = 0.5

  ' Bernoulli numbers

  Const B2  =  0.1666666666666667#
  Const B4  = -3.333333333333333D-002
  Const B6  =  2.380952380952381D-002
  Const B8  = -3.333333333333333D-002
  Const B10 =  7.575757575757576D-002
  Const B12 = -0.2531135531135531#

  If x <= 0 Then
    ErrCode = FSing
    Return MaxNum
  End  If

  Dim As Double Res, Y, Z

  ErrCode = FbNewsMessages
  Res = 0
  Z = x

  If Z <= A Then Return One / (Z * Z)  ' Use small value approximation
    
  Do While Z < B   ' IncreAse argument to (x+i) >= b
    Res = Res + One / (Z * Z)
    Z = Z + One
  Loop

  ' Apply Asymptotic formula where argument >= b
  Y = One / (Z * Z)
  Res = Res + Half * Y + (One + Y * (B2 + Y * (B4 + Y * (B6 + Y * _
                         (B8 + Y * (B10 + Y * B12)))))) / Z
  Return Res
End  Function

