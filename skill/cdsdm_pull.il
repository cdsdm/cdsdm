; cdsdm_pull.il
;

procedure( cdsdm_pull(lib)
  let( ( path branch master cid irp (return nil) )

    path = ddGetObjReadPath(ddGetObj(lib))
    branch = cdsdm_check_branch(lib)
    master = cdsdm_git->master

    when( branch==master && cdsdm_remote(lib)
      if( cdsdm_check_remote(lib) == "local out of date"  then
	cdsdm_permission(path "+")

	cid = ipcBatchProcess( sprintf(nil "%s -C %s pull" cdsdm_git->git path)  "" "" )
	ipcWaitForProcess( cid )
	while( irp=ipcReadProcess( cid 10 )
	  lmgrDisplayMessage(sprintf(nil "[pull] %s" irp) )
	)

	cdsdm_permission(path "-")

	cdsdm_cdslib(lib "checkin")
	return = t
      else
	lmgrDisplayMessage( "[pull] Already up-to-date.\n" )
	return = nil
      )
      ddUpdateLibList()
    )

    return

  )
)

;
;
