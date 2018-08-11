function! myconf#rsync#Upload(filename, target)
	if !exists("b:myconf_rsync_target") || b:myconf_rsync_target == ""
		return
	endif

	let b:myconf_rsync_status = "running"
	let b:myconf_rsync_filename = a:filename
	let b:myconf_rsync_target = a:target
	call timer_start(0, 'myconf#rsync#UploadAsync')
endfunction

function! myconf#rsync#UploadAsync(timer)
	" let start_time = reltimefloat(reltime())
	execute 'python3 MyconfRsyncUpload()'
	" echo printf('Time: %f', reltimefloat(reltime()) - start_time)
	let &ro = &ro " update statusline
endfunction

function! myconf#rsync#Save()
	if exists("b:myconf_rsync_target") && b:myconf_rsync_target != ""
		call myconf#rsync#Upload(expand("%:p"), b:myconf_rsync_target)
	endif
endf

function! myconf#rsync#Init()
	if !exists('b:myconf_rsync_target')
		let b:myconf_rsync_target = 'test'
		let b:myconf_rsync_status = 'ready'
	endif
endfunction

function! myconf#rsync#Cycle()
	if b:myconf_rsync_target == 'test'
		let b:myconf_rsync_target=""
		unlet b:myconf_rsync_status
	else
		let b:myconf_rsync_target = 'test'
		let b:myconf_rsync_status = 'ready'
	endif
endfunction
