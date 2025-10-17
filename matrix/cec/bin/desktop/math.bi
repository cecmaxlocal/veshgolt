' ******************************************************************
' Incomplete Gamma function and Error function
' Translated from C code in Cephes library (http://www.moshier.net)
' ******************************************************************

' ------------------------------------------------------------------
' Error codes
' ------------------------------------------------------------------

#DEFINE MathCool 0  
' No error

#DEFINE FDomain -1  
' Argument domain error

#DEFINE FUnderflow -4  
' Underflow range error

' ------------------------------------------------------------------
' Machine-dependent constants
' ------------------------------------------------------------------

#DEFINE MachEp 2.220446049250313D-16  
' Floating point precision: 2^(-52)

#DEFINE Big 4.503599627370496D15 
' 1 / MachEp

#DEFINE MaxLog 709.782712893384#        
' Max. argument for Exp

#DEFINE MinLog -708.3964185322641#
' Min. argument for Exp

' ------------------------------------------------------------------
' Global variable
' ------------------------------------------------------------------

COMMON SHARED AgentErrCodeMath AS INTEGER
' Error code from the latest function evaluation

' ------------------------------------------------------------------
' External function
' ------------------------------------------------------------------

DECLARE FUNCTION LnGammaMath (BYVAL X AS DOUBLE) AS DOUBLE
' Ln of Gamma function

' ******************************************************************

FUNCTION IGamma (BYVAL A AS DOUBLE, BYVAL X AS DOUBLE) AS DOUBLE
' Incomplete Gamma function

DIM AS DOUBLE Ans, AX, C, R, T

IF X < 0 OR A <= 0 THEN
    ErrCode = FDomain
    RETURN 0
ELSEIF X = 0 THEN
    ErrCode = MathCool
    RETURN 0
END IF
    
AX = A * LOG(X) - X - LnGamma(A)

IF MaxLog < -AX THEN
    ErrCode = FUnderflow
    RETURN 0
END IF

AX = EXP(AX)
R = A
C = 1
Ans = 1
DO
    R = R + 1
    C = C * X / R
    Ans = Ans + C
LOOP WHILE MachEp * Ans < C 

ErrCode = MathCool
RETURN Ans * AX / A

END FUNCTION

FUNCTION JGamma (BYVAL A AS DOUBLE, BYVAL X AS DOUBLE) AS DOUBLE
' Complement of incomplete Gamma function

  DIM AS DOUBLE Ans, C, Yc, Ax, Y, Z, R, T
  DIM AS DOUBLE Pk, Pkm1, Pkm2, Qk, Qkm1, Qkm2

  ErrCode = MathCool

  IF X <= 0 OR A <= 0 THEN RETURN 1

  IF X < 1 OR X < A THEN RETURN 1 - IGamma(A, X)

  Ax = A * LOG(X) - X - LnGamma(A)

  IF Ax < MinLog THEN
    ErrCode = FUnderflow
    RETURN 0
  END IF

  Ax = EXP(Ax)

  ' Continued fraction 
  Y = 1 - A
  Z = X + Y + 1
  C = 0
  Pkm2 = 1
  Qkm2 = X
  Pkm1 = X + 1
  Qkm1 = Z * X
  Ans = Pkm1 / Qkm1

  DO
    C = C + 1
    Y = Y + 1
    Z = Z + 2
    Yc = Y * C
    Pk = Pkm1 * Z - Pkm2 * Yc
    Qk = Qkm1 * Z - Qkm2 * Yc
    IF Qk <> 0 THEN
      R = Pk / Qk
      T = ABS((Ans - R) / R)
      Ans = R
    ELSE
      T = 1
    END IF
    Pkm2 = Pkm1
    Pkm1 = Pk
    Qkm2 = Qkm1
    Qkm1 = Qk
    IF ABS(Pk) > Big THEN
      Pkm2 = Pkm2 * MachEp
      Pkm1 = Pkm1 * MachEp
      Qkm2 = Qkm2 * MachEp
      Qkm1 = Qkm1 * MachEp
    END IF
  LOOP WHILE T > MachEp

  RETURN Ans * Ax
END FUNCTION

#ifdef USE_PREFIX
FUNCTION fbErf (BYVAL X AS DOUBLE) AS DOUBLE
#else    
FUNCTION Erf (BYVAL X AS DOUBLE) AS DOUBLE
#endif
    
' Error function

IF X < 0 THEN
    RETURN -IGamma(0.5, X * X)
ELSE
    RETURN IGamma(0.5, X * X)
END IF
END FUNCTION

#ifdef USE_PREFIX
FUNCTION fbErfc (BYVAL X AS DOUBLE) AS DOUBLE
#else    
FUNCTION Erfc (BYVAL X AS DOUBLE) AS DOUBLE
#endif

' Complement of error function

IF X < 0 THEN
    RETURN 1 + IGamma(0.5, X * X)
ELSE
    RETURN JGamma(0.5, X * X)
END IF
END FUNCTION
