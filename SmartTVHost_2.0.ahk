
{ ; Flags
	
	
	#NoEnv
	#SingleInstance, Force
	#WinActivateForce
	#Persistent
	SetWorkingDir, %A_ScriptDir%
	global Main := new MainType
	Main.AutoRun()
	return
}

{ ; Includes
#Include, C:\Users\MkZee\Documents\Commands\HomeTheater\Chrome.ahk\Chrome.ahk
}

Class MainType {
	debug := true
	
	__New() {
	}
	AutoRun() {
		this.ChrWin := new ChromeWindowType("about:blank")
		sleep,5000
		this.ChrWin.Navigate("http://example.com")
	}
}

Class ChromeWindowType {
		
	__New(Url := "about:blank") {
		this.Inst := new Chrome("ChromeProfile",Url, Main.debug ? "" : "--kiosk")
		
		tmp := ObjBindMethod(this, "CloseOldTabs") ;bind method
		;SetTimer, %tmp%, 2000
	}
	Navigate(Url) {
		page := this.Inst.GetPage()
		page.Call("Page.navigate", {"url": Url})
		page.Disconnect()
	}
	
	JS(page, js) {
		;(LTrim
		;	{
		;	
		;	}
		;)
	}
	
	
	CloseOldTabs() {
		MsgBox,,,hello
		page := this.Inst.GetPage(1)
		page.Evaluate("window.close()")
		page.Disconnect()
	}
}