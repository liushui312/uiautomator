'android:contentDescription="list"


Dim currentFolderFullPath
Dim allsubdir
Dim arrsubdir


Dim fso,fMe
Dim  myFolder, myFile, curFolder
Dim iLoop

Dim xDoc,xNode,xNodes
dim pFile
dim i,n
Dim dt1, dt2
Dim sReplace

dt1 = Now

currentFolderFullPath="C:\FORLANHAI\工作20140101\lanhai\android自动化\standardversion"

allsubdir=GetSubFolders(currentFolderFullPath)
arrsubdir=split(allsubdir,";")
For i1=LBound(arrsubdir) to UBound(arrsubdir)
	If (UCase(Right(arrsubdir(i1),6))="LAYOUT") Then
		MsgBox arrsubdir(i1)
		
		Set fso = CreateObject("Scripting.FileSystemObject")
		fMe = fso.GetFile(Wscript.scriptfullname).name
		'MsgBox "file1=" & fMe
		
		iLoop=0
		Set curFolders = fso.getfolder(arrsubdir(i1))
		For Each myFile In curFolders.Files
		  If ((Instr(myFile.name, fMe)=0) And (UCase(Right(myFile.name,3)))="XML") Then
		  	iLoop=0
		  	'MsgBox iLoop & ":" & myFile.Name
		
				GetXml arrsubdir(i1) & "\" & myFile.Name,""
				
				set xNode=nothing
				set xNodes=nothing
				set xDoc=nothing
		  	
		  End If
		Next
		Set fso=nothing



	End If
Next






dt2 = Now
MsgBox "执行完成，总共用时：" & DateDiff("s", dt1, dt2) & "秒"




Function GetXml (ByVal strXmlFilePath,ByVal xmlNodeName)
Dim xmlDoc,xmlRoot

Set xmlDoc = CreateObject("Microsoft.XMLDOM") '创建XML DOM对象
xmlDoc.async = False '控制加载模式为同步模式（xml树加载完毕后再执行后续代码）
xmlDoc.load strXmlFilePath '载入xml文件
If xmlDoc.parseError.errorCode <> 0 Then
	MsgBox "XML文件格式不对，原因是：" & Chr(13) & xmlDoc.parseError.reason
	Exit Function
End If

Set xmlRoot = xmlDoc.documentElement
'MsgBox xmlRoot.nodeName & "|" & xmlNodeName
xmlNodeName=xmlRoot.nodeName
xmlRecursion xmlRoot,xmlNodeName '调用xml递归函数传入指定的根和节点名
GetXml = True 'xmlRecursion (xmlRoot)
Call xmlDoc.save(strXmlFilePath & ".1")
'MsgBox strXmlFilePath & ".1 被保存了"


Set fso1 = CreateObject("Scripting.FileSystemObject")
set sfile1=fso.getfile(strXmlFilePath)
sfile1.delete
'MsgBox strXmlFilePath & " 被删除了"
Set sfile2 = fso1.GetFile(strXmlFilePath & ".1")
sfile2.Move(strXmlFilePath)
'MsgBox strXmlFilePath & ".1 被改名了"

Set sfile1=nothing
Set sfile2=nothing
Set fso1=nothing

End Function


Function xmlRecursion(byval xmlNode,byval strNodeName)
'MsgBox "xmlNode.nodeName=" & xmlNode.nodeName & "  strNodeName=" & strNodeName & "   xmlNode.hasChildNodes=" & xmlNode.hasChildNodes
'If xmlNode.nodeName = strNodeName And xmlNode.hasChildNodes Then
		'MsgBox "xmlNode.hasChildNodes=" & xmlNode.childNodes.item(0).nodeName
		'strXML = strXML & xmlNode.nodeName & ":" & xmlNode.childNodes.item(0).nodeName & Chr(13)
		'MsgBox strXML
		'MsgBox "xmlNode.nodeName=" & xmlNode.nodeName

'End If

'MsgBox "xmlNode.nodeName=" & xmlNode.nodeName	
If IsNull(xmlNode.getAttribute("android:id")) Then
	'MsgBox "getAttribute(""android:id"")=null"
	iLoop=iLoop+1
	If xmlNode.nodeName = "EditText" Then
		If IsNull(xmlNode.getAttribute("android:hint")) Then
			Call xmlNode.setAttribute("android:textColorHint", "@android:color/transparent")
			Call xmlNode.setAttribute("android:hint", xmlNode.nodeName & iLoop)
		End If
	Else
		Call xmlNode.setAttribute("android:contentDescription", xmlNode.nodeName & iLoop)
	End If
		
Else
	'MsgBox xmlNode.getAttribute("android:id")
	sReplace=xmlNode.getAttribute("android:id")
	sReplace=replace(sReplace,"@+id/","")	
	If xmlNode.nodeName = "EditText" Then
		If IsNull(xmlNode.getAttribute("android:hint")) Then
			sReplace="hint" & replace(sReplace,"@android:id/","")
			Call xmlNode.setAttribute("android:textColorHint", "@android:color/transparent")
			Call xmlNode.setAttribute("android:hint", sReplace)
		End If
	Else
		sReplace="cs" & replace(sReplace,"@android:id/","")
		Call xmlNode.setAttribute("android:contentDescription", sReplace)
	End If
End If

'MsgBox "xmlNode.hasChildNodes=" & xmlNode.hasChildNodes
If xmlNode.hasChildNodes Then
	'MsgBox "xmlNode.hasChildNodes=" & xmlNode.hasChildNodes
	For Each childNodeItem In xmlNode.ChildNodes
	  'MsgBox "childNodeItem.nodeName=" & childNodeItem.nodeName & "  childNodeItem.hasChildNodes=" & childNodeItem.hasChildNodes
		If childNodeItem.hasChildNodes Then
			xmlRecursion childNodeItem,childNodeItem.nodeName
		Else
			'MsgBox "into end childNodeItem.nodeName=" & childNodeItem.nodeName

			If (childNodeItem.nodeName<>"#comment" And childNodeItem.nodeName<>"include" And childNodeItem.nodeName<>"#text") Then
				If IsNull(childNodeItem.getAttribute("android:id")) Then
					'MsgBox "getAttribute(""android:id"")=null"
					iLoop=iLoop+1
					If childNodeItem.nodeName = "EditText" Then
							If IsNull(childNodeItem.getAttribute("android:hint")) Then
								Call childNodeItem.setAttribute("android:textColorHint", "@android:color/transparent")
								Call childNodeItem.setAttribute("android:hint", childNodeItem.nodeName & iLoop)
							End If
					Else
						Call childNodeItem.setAttribute("android:contentDescription", childNodeItem.nodeName & iLoop)
					End If
				Else
					'MsgBox xmlNode.getAttribute("android:id")
					sReplace=childNodeItem.getAttribute("android:id")
					sReplace=replace(sReplace,"@+id/","")					
					If childNodeItem.nodeName = "EditText" Then
						If IsNull(childNodeItem.getAttribute("android:hint")) Then
							sReplace="hint" & replace(sReplace,"@android:id/","")
							Call childNodeItem.setAttribute("android:textColorHint", "@android:color/transparent")
							Call childNodeItem.setAttribute("android:hint", sReplace)
						End If
					Else
						sReplace="cs" & replace(sReplace,"@android:id/","")
						Call childNodeItem.setAttribute("android:contentDescription", sReplace)
					End If
				End If
			End If
		End If
	Next
Else
End If

End Function


Function GetSubFolders(currentFolderFullPath)
    Set fso = CreateObject("Scripting.FileSystemObject")  
    Set currentFolder = fso.GetFolder(currentFolderFullPath)  
    Set subFolderSet = currentFolder.SubFolders  
    For Each subFolder in subFolderSet  
        'MsgBox "subFolder.Path=" & subFolder.Path  
        GetSubFolders = subFolder.Path & ";" & GetSubFolders(subFolder.Path) &  GetSubFolders   
    Next  
End Function