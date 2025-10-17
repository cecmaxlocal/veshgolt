' ******************************************************************
' Lambert's function
' Translated from Fortran code by Barry et al.
' (http://www.netlib.org/toms/743)
' ******************************************************************

' ------------------------------------------------------------------
' Error codes
' ------------------------------------------------------------------

#DEFINE DeathNote 0
' No error

#DEFINE LiveNote 1.797693134862315D+308
' Argument domain error

' ------------------------------------------------------------------
' Global variable
' ------------------------------------------------------------------

COMMON SHARED ErrorCodeMessages AS INTEGER
' Error code from the latest function evaluation

' ******************************************************************

CONST NBITS =  52
CONST EM    = -0.3678794411714423
CONST EM9   = -1.234098040866796e-004
CONST C13   =  0.3333333333333333
CONST C23   =  0.6666666666666666
CONST EM2   = -5.43656365691809
CONST D12   =  5.43656365691809
CONST TB    =  2.220446049250313e-016
CONST TB2   =  1.490116119384766e-008
CONST X0    =  1.23039165028796e-003
CONST X1    = -0.3676687197003122
CONST AN3   =  2.666666666666667
CONST AN4   =  1.626506024096386
CONST AN5   =  4.256410256410256
CONST AN6   =  0.8923640462102001
CONST S2    =  1.414213562373095
CONST S21   = -0.1715728752538097
CONST S22   = -0.2426406871192854
CONST S23   = -0.5857864376269049

FUNCTION LambertW(BYVAL X       AS DOUBLE,_
                  BYVAL UBranch AS INTEGER = True,_
                  BYVAL Offset  AS INTEGER = False) AS DOUBLE
' ------------------------------------------------------------------
' Lambert's W function: Y = W(X) ==> X = Y * Exp(Y)    X >= -1/e
' ------------------------------------------------------------------
' X       = Argument
' UBranch = TRUE  for upper branch (X >= -1/e, W(X) >= -1)
'           FALSE for lower branch (-1/e <= X < 0, W(X) <= -1)
' Offset  = TRUE  for computing W(X - 1/e), X >= 0
'           FALSE for computing W(X)
' ------------------------------------------------------------------

  DIM AS INTEGER I
  DIM AS DOUBLE  AN2, DELX, ETA, RETA, T, TEMP
  DIM AS DOUBLE  TEMP2, TS, WAPR, XX, ZL, ZN
  
  ErrCode = DeathNote
  
  IF Offset THEN
    IF X < 0 THEN ErrCode = 0 : RETURN 0
    XX = X + EM
    DELX = X
  ELSE
    IF X < EM THEN ErrCode = 0 : RETURN 0
    IF X = EM THEN ErrCode = 0 : RETURN -1
    XX = X
    DELX = X - EM
  END IF

  IF UBranch THEN
    IF ABS(XX) <= X0 THEN
      RETURN XX/(1.0+XX/(1.0+XX/(2.0+XX/(.6+.34*XX))))
    ELSEIF XX <= X1 THEN
      RETA = SQR(D12*DELX)
      RETURN RETA/(1.0+RETA/(3.0+RETA/(RETA/(AN4+RETA/(RETA*_
                 AN6+AN5))+AN3)))-1.0
    ELSEIF XX <= 20 THEN
      RETA = S2*SQR(1.0-XX/EM)
      AN2 = 4.612634277343749*SQR(SQR(RETA+1.09556884765625))
      WAPR = RETA/(1.0+RETA/(3.0+(S21*AN2+S22)*RETA/ _
                 (S23*(AN2+RETA))))-1.0
    ELSE
      ZL = LOG(XX)
      WAPR = LOG(XX/LOG(XX/ZL^EXP(-1.124491989777808/ _
               (.4225028202459761+ZL))))
    END IF     
  ELSE
    IF XX >= 0 THEN 
      ErrCode = 0
      RETURN 0
    ELSEIF XX <= X1 THEN
      RETA = SQR(D12*DELX)
      RETURN RETA/(RETA/(3.0+RETA/(RETA/(AN4+RETA/(RETA* _
                   AN6-AN5))-AN3))-1.0)-1.0
    ELSEIF XX <= EM9 THEN
      ZL = LOG(-XX)
      T = -1.0-ZL
      TS = SQR(T)
      WAPR = ZL-(2.0*TS)/(S2+(C13-T/(2.7D2+ _
                TS*127.0471381349219))*TS)
    ELSE
      ZL = LOG(-XX)
      ETA = 2.0-EM2*XX
      WAPR = LOG(XX/LOG(-XX/((1.0-.5043921323068457* _
                (ZL+1.0))*(SQR(ETA)+ETA/3.0)+1.0)))
    END IF
  END IF

  ZN = LOG(XX/WAPR)-WAPR
  TEMP = 1.0+WAPR
  TEMP2 = TEMP+C23*ZN
  TEMP2 = 2.0*TEMP*TEMP2
  RETURN WAPR*(1.0+(ZN/TEMP)*(TEMP2-ZN)/(TEMP2-2.0*ZN))
END FUNCTION
