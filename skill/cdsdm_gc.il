; cdsdm_gc.il
;

procedure( cdsdm_gc(lib)
  let( ( path branch master cid irp )

    path = ddGetObjReadPath(ddGetObj(lib))
    branch = cdsdm_check_branch(lib)
    master = cdsdm_git->master

    when( branch == master
      cid = ipcBatchProcess( sprintf(nil "%s -C %s gc --auto" cdsdm_git->git path)  "" "" )
      ipcWaitForProcess( cid )
      while( irp=ipcReadProcess( cid 10 )
	lmgrDisplayMessage(sprintf(nil "[gc] %s" irp) )
      )
    )

  )
)

;
;
