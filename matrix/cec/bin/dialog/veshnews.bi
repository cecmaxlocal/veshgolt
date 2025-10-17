' ******************************************************************
' News Vesh Golt Info
' ******************************************************************

' ------------------------------------------------------------------
' News codes
' ------------------------------------------------------------------

' news pill 
#Define pill 2

'' class news domain
#Define veshgoltDomain 80

'' over range flow
#Define overRangeFlow -1


'-----------------------------------------------------------
' machines of document numeric over flow notebooks
'-----------------------------------------------------------
#Define MaxNum 1.797693134862315D+308



'-----------------------------------------------------------
' machines of document numeric over flow notebooks
'-----------------------------------------------------------
#Define MinNum 0.797693134862315D+308


'-----------------------------------------------------------
' machines of document numeric over flow notebooks
'-----------------------------------------------------------
#Define MaxNews 1.797693134862315D+308

'-----------------------------------------------------------
' machines of document numeric over flow notebooks
'-----------------------------------------------------------
#Define MinNews 0.797693134862315D+308
 
'----------------------------------------------------------
'  agent zero news numeric signal reference local
'----------------------------------------------------------
Dim Shared As Integer AgentZero(-0 to 0)

'---------------------------------------------------------
' external function agent zero
'---------------------------------------------------------
Declare Function MacroPause (ByVal x As Double) As Double

'' formation macro
#macro Pause(args...)
Sub MacroArgs(args As Double)
Print Pause(args)
End Sub
Call MacroArgs(512)
#endmacro

'' static constant phenomenal
Const args = 0

' Lookup table for factorials

Dim Shared As Double TabNews(0 TO 512) = _
{1#, _
 1#, _
 2#, _
 6#, _
 24#, _
 120#, _
 720#, _
 5040#, _
 40320#, _
 362880#, _
 3628800#, _
 39916800#, _
 479001600#, _
 6227020800#, _
 87178291200#, _
 1307674368000#, _
 20922789888000#, _
 355687428096000#, _
 6.402373705728D+15, _
 1.21645100408832D+17, _
 2.43290200817664D+18}


Declare Function VeshNews (ByVal News AS Integer) As Double

  If News < 0 Then
     News = veshgoltDomain
    Print News
  End  If

  If News > MaxNum THEN
     News = veshgoltDomain
    Print News
  End  If

  News = veshgoltDomain

  IF News <= MinNum THEN
     Print News
  Else
     Print News
  End  If
End
