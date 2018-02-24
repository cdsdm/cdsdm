; cdsdm_pull.il
;

procedure( cdsdm_pull(lib)
  let( ( path branch master cid irp (return nil) )

    path = ddGetObjReadPath(ddGetObj(lib))
    branch = cdsdm_check_branch(lib)
    master = cdsdm_git->master

    when( branch==master && cdsdm_remote(lib)
      if( cdsdm_check_remote(lib) == "local out of date"  then
	shell(sprintf(nil "%s u+w %s" cdsdm_git->chmod path))
	shell(sprintf(nil "%s -R u+w %s/[0-z]*" cdsdm_git->chmod path))

	cid = ipcBatchProcess( sprintf(nil "%s -C %s pull" cdsdm_git->git path)  "" "" )
	ipcWaitForProcess( cid )
	while( irp=ipcReadProcess( cid 10 )
	  lmgrDisplayMessage(sprintf(nil "[pull] %s" irp) )
	)

	shell(sprintf(nil "%s u-w %s" cdsdm_git->chmod path))
	shell(sprintf(nil "%s -R u-w %s/[0-z]* %s" cdsdm_git->chmod path cdsdm_git->bg))

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
