; cdsdm_remote.il
;

procedure( cdsdm_remote(lib)
  let( ( path cid irp repo master (return nil) )

    path = ddGetObjReadPath(ddGetObj(lib))

    cid = ipcBatchProcess( sprintf(nil "cd %s ; %s config remote.origin.url" path cdsdm_git->git)  "" "" )
    ipcWaitForProcess( cid )

    when( (irp=ipcReadProcess( cid 10 ))
      repo = buildString(parseString(irp "\n") "/")
      master = car(last(parseString(repo "/")))
      when( substring(master -4 4) == ".git"
        master = substring(master 1 strlen(master)-4)
      )

      when( lib == master
	return=t
      )
    )

    return

  )
)

;
;
