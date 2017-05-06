; cdsdm_check_add.il
;

procedure( cdsdm_check_add(lib)
  let( ( path cid irp fixed (add nil) (commit nil) )

    path = ddGetObjReadPath(ddGetObj(lib))

    cid = ipcBatchProcess( sprintf(nil "cd %s && %s status -s" path cdsdm_git->git )  "" "" )
    ipcWaitForProcess( cid )
    irp=ipcReadProcess( cid 10 )

    if( irp  then
      fixed = parseString(irp "\n")
      foreach( x  fixed
	if( substring( x 1 1 ) == " "  then
	  add = t
	else
	  if( substring( x 1 2 ) == "??"  then
	    add = t
	  else
	    commit = t
	) )
      )
    else
      add = commit = nil
    )

    list( add commit )

  )
)

;
;
