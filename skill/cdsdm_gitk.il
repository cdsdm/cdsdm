; cdsdm_gitk.il
;

procedure( cdsdm_gitk( lib )
  let( ( path )

    path = ddGetObjReadPath(ddGetObj(lib))
    ipcBatchProcess( sprintf(nil "cd %s && %s" path cdsdm_git->gitk )  "" "" )

  )
)

;
;
