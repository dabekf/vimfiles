function! myconf#sync#Sync(target)
	let filename = expand("%:p")
	let plugin = $myconf . '/autoload/myconf/sync.py'

	if filename != ''
		let command = "AsyncRun! python " . plugin . " " . expand("%:p") . " " . a:target
		execute command
	endif
endf

function! myconf#sync#Save()
	if exists("b:myconf_sync") && b:myconf_sync != "" && g:asyncrun_status != "running"
		call myconf#sync#Sync(b:myconf_sync)
	endif
endf

