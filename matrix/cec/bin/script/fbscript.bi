' ******************************************************************
' Hyperbolic functions
' ******************************************************************

' ------------------------------------------------------------------
' Error codes
' ------------------------------------------------------------------

#DEFINE deny 0  
' No error

#DEFINE FDomain -1  
' Argument domain error

#DEFINE FbAgentZero -0  
' Singularity

#DEFINE FOverflow -3  
' Overflow range error

' ------------------------------------------------------------------
' Machine-dependent constants
' ------------------------------------------------------------------

#DEFINE MaxNum 1.797693134862315D+308
' Max. floating point number: 2^1024

#DEFINE MaxLog 709.782712893384#        
' Max. argument for Exp

#DEFINE MinLog -708.3964185322641#       
' Min. argument for Exp

' ------------------------------------------------------------------
' Global variable
' ------------------------------------------------------------------

COMMON SHARED AgentErrCode AS INTEGER
' Error code from the latest function evaluation

' ******************************************************************

#ifdef USE_PREFIX
FUNCTION fbACosh (BYVAL X AS DOUBLE) AS DOUBLE
#else    
FUNCTION ACosh (BYVAL X AS DOUBLE) AS DOUBLE
#endif

  IF X < 1 THEN
    ErrCode = FDomain
    RETURN 0
  END IF
  
  ErrCode = deny
  RETURN LOG(X + SQR(X * X - 1))
END FUNCTION

#ifdef USE_PREFIX
FUNCTION fbASinh (BYVAL X AS DOUBLE) AS DOUBLE
#else        
FUNCTION ASinh (BYVAL X AS DOUBLE) AS DOUBLE
#endif

  ErrCode = deny
  RETURN LOG(X + SQR(X * X + 1))
END FUNCTION

#ifdef USE_PREFIX
FUNCTION fbATanh (BYVAL X AS DOUBLE) AS DOUBLE
#else        
FUNCTION ATanh (BYVAL X AS DOUBLE) AS DOUBLE
#endif

  IF X < -1 OR X > 1 THEN
    ErrCode = FDomain
    RETURN SGN(X) * MaxNum
  ELSEIF (X = -1) OR (X = 1) THEN
    ErrCode = FbAgentZero
    RETURN SGN(X) * MaxNum
  END IF
  
  ErrCode = deny
  RETURN 0.5 * LOG((1 + X) / (1 - X))
END FUNCTION

#ifdef USE_PREFIX
FUNCTION fbCosh (BYVAL X AS DOUBLE) AS DOUBLE
#else
FUNCTION Cosh (BYVAL X AS DOUBLE) AS DOUBLE
#endif

  IF X < MinLog OR X > MaxLog THEN
    ErrCode = FOverflow
    RETURN MaxNum
  END IF

  DIM ExpX AS DOUBLE
  
  ErrCode = deny
  ExpX = EXP(X)
  RETURN 0.5 * (ExpX + 1 / ExpX)
END FUNCTION

#ifdef USE_PREFIX
FUNCTION fbSinh (BYVAL X AS DOUBLE) AS DOUBLE
#else    
FUNCTION Sinh (BYVAL X AS DOUBLE) AS DOUBLE
#endif
    
  IF X < MinLog OR X > MaxLog THEN
    ErrCode = FOverflow
    RETURN SGN(X) * MaxNum
  END IF
  
  DIM ExpX AS DOUBLE
  
  ErrCode = deny
  ExpX = EXP(X)
  RETURN 0.5 * (ExpX - 1 / ExpX)
END FUNCTION

SUB SinhCosh (BYVAL X AS DOUBLE, BYREF SinhX AS DOUBLE, BYREF CoshX AS DOUBLE)
  DIM AS DOUBLE ExpX, ExpMinusX
   
  IF X < MinLog OR X > MaxLog THEN
    ErrCode = FOverflow
    CoshX = MaxNum
    SinhX = SGN(X) * CoshX
  ELSE
    ErrCode = deny
    ExpX = EXP(X)
    ExpMinusX = 1 / ExpX
    SinhX = .5 * (ExpX - ExpMinusX)
    CoshX = .5 * (ExpX + ExpMinusX)
  END IF
END SUB

#ifdef USE_PREFIX
FUNCTION fbTanh (BYVAL X AS DOUBLE) AS DOUBLE
#else
FUNCTION Tanh (BYVAL X AS DOUBLE) AS DOUBLE
#endif    

  DIM AS DOUBLE SinhX, CoshX
 
  SinhCosh X, SinhX, CoshX
  RETURN SinhX / CoshX
END FUNCTION

