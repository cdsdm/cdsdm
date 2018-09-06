; cdsdm_log.il
; 

procedure( cdsdm_log(lib)
  let( ( path cid irp clist )

    path = ddGetObjReadPath(ddGetObj(lib))
    cid = ipcBatchProcess( sprintf(nil "%s -C %s log -%d --format=%s" cdsdm_git->git path cdsdm_git->max_log cdsdm_git->log_format )  "" "" )
    ipcWaitForProcess( cid )

    while( irp=ipcReadProcess( cid 10 )
      foreach( sep parseString(irp "\n")
        clist = cons(substring(sep 1 strlen(sep)-1) clist)
      )
    )

    clist = reverse(clist)

  )
)

;
;
