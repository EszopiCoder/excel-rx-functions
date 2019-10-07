Attribute VB_Name = "modAddInMenu"
Option Explicit
Dim RxFxList(0 To 12) As Variant

'*********************************XML CODE*********************************
'<customUI xmlns="http://schemas.microsoft.com/office/2009/07/customui">
'   <ribbon>
'      <tabs>
'         <tab idMso="TabFormulas">
'            <group id="RxFxLib" label="Rx Function Library">
'               <gallery id="RxFx"
'                   label="Rx Functions" columns="1"
'                   imageMso = "GroupFunctionLibrary"
'                   getItemCount = "RxFx_getItemCount"
'                   getItemLabel = "RxFx_getItemLabel"
'                   getItemScreentip = "RxFx_getItemScreentip"
'                   getItemSupertip = "RxFx_getItemSupertip"
'                   onAction = "RxFx_Click"
'                   showItemLabel = "true"
'                   size="large">
'                 <button id="insertFx"
'                    imageMso = "GroupFunctionLibrary"
'                    label = "Insert Function"
'                    screentip="Insert Function (Shift+F3)"
'                    supertip = "Work with the formula in the current cell. You can easily pick functions to use and get help on how to fill out the input values."
'                    onAction="insertFx_Click"/>
'               </gallery>
'               <button id="getInfo"
'                   imageMso = "ARMPreviewButton"
'                   label = "Info"
'                   screentip="Information"
'                   supertip = "Return contact information."
'                   onAction = "getInfo_Click"
'                   size="large"/>
'            </group>
'         </tab>
'      </tabs>
'   </ribbon>
'</customUI>
'*********************************XML CODE*********************************

Sub Auto_Open()

    ' Populate RxFxList
    RxFxList(0) = "RxCalc_AdjBW(Height,Weight,Female,Metric)"
    RxFxList(1) = "RxCalc_IBW(Height,Female,Metric)"
    RxFxList(2) = "RxCalc_IBW_Intuitive(Height,Female,Metric)"
    RxFxList(3) = "RxCalc_IBW_Baseline(Height,Female,Metric)"
    RxFxList(4) = "RxCalc_IBW_Hume(Height,Weight,Female,Metric)"
    RxFxList(5) = "RxCalc_BMI(Height,Weight)"
    RxFxList(6) = "RxCalc_BMI_Class(BMI)"
    RxFxList(7) = "RxCalc_BSA_DuBois(Height,Weight,Metric)"
    RxFxList(8) = "RxCalc_BSA_Mosteller(Height,Weight,Metric)"
    RxFxList(9) = "RxCalc_CrCl(Age,Weight,sCr,Female,Metric)"
    RxFxList(10) = "RxCalc_GFR_CKDEPI(Age,sCr,Female,Black)"
    RxFxList(11) = "RxCalc_GFR_MDRD(Age,sCr,Female,Black)"
    RxFxList(12) = "RxCalc_GFR_Class(eGFR)"
    
End Sub

Sub getInfo_Click(control As IRibbonControl)

    MsgBox "The 'Rx Fx Library' was created by EszopiCoder, PharmD Student." & vbNewLine & _
        "Open Source (https://github.com/EszopiCoder/excel-rx-fx-library)" & vbNewLine & _
        "Please report bugs and send suggestions to pharm.coder@gmail.com", vbInformation
        
End Sub

Sub RxFx_getItemCount(control As IRibbonControl, ByRef returnedVal)
    ' Return the number of functions in the array
    returnedVal = UBound(RxFxList) - LBound(RxFxList) + 1
End Sub

Sub RxFx_getItemLabel(control As IRibbonControl, index As Integer, ByRef returnedVal)
    On Error Resume Next
    ' Return the name of the function without arguments
    returnedVal = Left(RxFxList(index), InStr(1, RxFxList(index), "(") - 1)
    On Error GoTo 0
End Sub

Sub RxFx_getItemScreentip(control As IRibbonControl, index As Integer, ByRef returnedVal)
    On Error Resume Next
    ' Return the name of the function with arguments
    returnedVal = RxFxList(index)
    On Error GoTo 0
End Sub

Sub RxFx_getItemSupertip(control As IRibbonControl, index As Integer, ByRef returnedVal)
    Dim Supertip As Variant
    Supertip = _
    Array("Return the adjusted body weight of a person (Devine equation).", _
          "Return the ideal body weight of a person 60 inches or greater (Devine equation).", _
          "Return the ideal body weight of a person under 60 inches (Intuitive method).", _
          "Return the ideal body weight of a person under 60 inches (Baseline method).", _
          "Return the ideal body weight of a person under 60 inches (Hume equation).", _
          "Return the BMI of a person.", _
          "Return the BMI class of a person.", _
          "Return the BSA of a person (Du Bois equation).", _
          "Return the BSA of a person (Mosteller equation).", _
          "Return the Cockcroft-Gault creatinine clearance of a person.", _
          "Return the eGFR of a person (CKDEPI equation).", _
          "Return the eGFR of a person (MDRD equation).", _
          "Return the eGFR class of a person.")

    On Error Resume Next
    returnedVal = Supertip(index)
    On Error GoTo 0
End Sub

Sub insertFx_Click(control As IRibbonControl)

    ActiveCell.FunctionWizard

End Sub

Sub RxFx_Click(control As IRibbonControl, id As String, index As Integer)
    On Error Resume Next
    ' Insert function into active cell (same as the other built-in functions)
    If InStr(1, ActiveCell.Formula, "=") > 0 Then
        ActiveCell.Formula = ActiveCell.Formula & "+" & RxFxList(index)
    Else
        ActiveCell.Formula = "=" & RxFxList(index)
    End If
    On Error GoTo 0
End Sub
