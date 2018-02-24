; cdsdm_push.il
;

procedure( cdsdm_push(lib)
  let( ( path branch master (return nil) )

    path = ddGetObjReadPath(ddGetObj(lib))
    branch = cdsdm_check_branch(lib)
    master = cdsdm_git->master

    when( branch==master && cdsdm_remote(lib)
      if( cdsdm_check_remote(lib) == "local out of date"  then
	when( cdsdm_pull(lib)
	  cdsdm_push_cb(path)
	  return = t
	)
      else
	cdsdm_push_cb(path)
	return = t
      )

      when( cadr(cdsdm_check_add(lib))
        lmgrDisplayMessage( "[push] *ERROR* conflicting" )
	cdsdm_cdslib(lib "conflict")
      )
    )

    return

  )
)


procedure( cdsdm_push_cb( path )
  let( ( cid irp )

    cid = ipcBatchProcess( sprintf(nil "%s -C %s push origin master" cdsdm_git->git path)  "" "" )
    ipcWaitForProcess( cid )
    while( irp=ipcReadProcess( cid 10 )
      lmgrDisplayMessage(sprintf(nil "[push] %s" irp) )
    )

  )
)

;
;
