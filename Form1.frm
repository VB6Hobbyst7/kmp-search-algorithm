VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3015
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   ScaleHeight     =   3015
   ScaleWidth      =   4560
   StartUpPosition =   3  'Windows �⺻��
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Function getPi(Pattern As String) As Long()
Dim i&, x&, horizon&
Dim PI() As Long
Dim Temp$
ReDim PI(Len(Pattern)) As Long

PI(0) = -1
For i = 1 To Len(Pattern) '//ã�� ���ڿ��� ���̸�ŭ �ݺ�
    Temp = Left$(Pattern, i) '//ã�� ���ڿ����� �ѱ�¥�� ���ذ��鼭 �ű������ pi���� ã�ƿ;� �Ǳ⿡ �ڸ���.
    
    For x = 1 To Len(Temp) - 1
        '//�߶�Դ� ������ ����� ���̰� �ִ밡 �Ǵ� ���κ��� ���̸� ���Ѵ�.
        '//���ʿ��� ���� ���̸�ŭ �߶�ͼ� ���ϸ� ������ �翬����. �׷��Ƿ� 1�� ���ش�.
        
        If Left$(Temp, x) = Right$(Temp, x) Then
            horizon = Len(Temp) - (Len(Left$(Temp, x)) * 2)
            '//����� ���̴� ��ü���� - ���κ��Ǳ���*2 (���κο� ���̺ΰ� ������ Ȯ���߱⿡)
            If PI(i) = 0 And horizon > 0 Then PI(i) = x
            '//����� ���̰� 0�� ���� �����Ѵ�.
            '//for x �� ����ɼ��� ����� ���̴� �پ��Ƿ� pi(i) ���� �ʱⰪ�϶� �ѹ���! �־��ش�.
        End If
        
    Next x
Next i

getPi = PI
End Function

Private Function KMP(Str As String, Tofind As String, PI() As Long)
Dim i&, x&
Dim MatchedLength&
Dim Temp$

For x = 1 To Len(Str) '//ã�� ���ڿ��� ����ִ� ���ڿ��� ���̸�ŭ �ݺ�
Temp = Right$(Str, Len(Str) - x + 1) '//ã�� ���ڿ��� ���������� �̵��ϴ°��� ����
MatchedLength = 0 '//��ġ ���κ��� ���̰� ��� ����
For i = 1 To Len(Tofind)
    If Left$(Temp, i) = Left$(Tofind, i) Then
        MatchedLength = i '//��ġ ���κ��� ���̸� ���Ѵ�.
    End If
Next i
If MatchedLength = Len(Tofind) Then MsgBox x & " ��°���� �߰�!"
'//��ġ ���κ��� ���̰� ã�� ���ڿ��� ���̶�� ��ġ�ϴ� ��.
x = x + MatchedLength - PI(MatchedLength) - 1
'//���Ŀ� ���� ����� �̵��Ÿ��� �����ش�. Next x �� x�� 1�� ���ϹǷ� �̸� ���ش�.
Next x

End Function

Private Sub Form_Load()
Dim PI() As Long
Dim Str$, Tofind$

Str = "BABAABABAABABAABBBABAABABAABABBAAB"
Tofind = "BAABAB"
PI = getPi(Tofind)
Call KMP(Str, Tofind, PI)

End
End Sub
