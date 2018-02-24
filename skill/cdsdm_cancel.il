; cdsdm_cancel.il
;

procedure( cdsdm_cancel(lib)
  let( ( path branch master db cid irp )

    when( cdsdm_config_check()
      path = ddGetObjReadPath(ddGetObj(lib))
      branch = cdsdm_check_branch(lib)
      master = cdsdm_git->master

      when( branch != master
        when( hiDisplayAppDBox(
                ?name           'cdsdm_cancel
                ?dboxBanner     "cdsDM: Cancel Checkout"
                ?dboxText       sprintf(nil "OK to discard '%s' branch?\n" branch )
                ?dialogType     4
                ?dialogStyle    'modal
              )

	  ; purge DB 
          foreach( cell ddGetObj(lib)~>cells
            foreach( view cell~>views
              db = dbFindOpenCellView( ddGetObj(lib) cell~>name view~>name )
              when( db  dbPurge( db ))
	    )
	  )

	  cid = ipcBatchProcess( sprintf(nil "%s -C %s checkout %s" cdsdm_git->git path branch ) "" "" )
	  ipcWaitForProcess(cid)
	  while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[cancel] %s" irp) ) )
	  cid = ipcBatchProcess( sprintf(nil "%s -C %s add --all" cdsdm_git->git path ) "" "" )
	  ipcWaitForProcess(cid)
	  while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[cancel] %s" irp) ) )
	  cid = ipcBatchProcess( sprintf(nil "%s -C %s commit -m '%s'" cdsdm_git->git path branch ) "" "" )
	  ipcWaitForProcess(cid)
	  while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[cancel] %s" irp) ) )
	  cid = ipcBatchProcess( sprintf(nil "%s -C %s checkout %s" cdsdm_git->git path master ) "" "" )
	  ipcWaitForProcess(cid)
	  while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[cancel] %s" irp) ) )
	  cid = ipcBatchProcess( sprintf(nil "%s -C %s branch -D %s" cdsdm_git->git path branch ) "" "" )
	  ipcWaitForProcess(cid)
	  while( irp=ipcReadProcess(cid 10) lmgrDisplayMessage(sprintf(nil "[cancel] %s" irp) ) )

	  cdsdm_cdslib( lib "checkin" )
    
	  ; permission
	  branch = cdsdm_check_branch(lib)
	  when( branch == master
	    shell(sprintf(nil "%s u-w %s" cdsdm_git->chmod path))
	    shell(sprintf(nil "%s -R u-w %s/[0-z]* %s" cdsdm_git->chmod path cdsdm_git->bg))
	  )

        )
      )
    )

  )
)

;
;
