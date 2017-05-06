; cdsdm_xterm.il
;

procedure( cdsdm_xterm( lib cell view )
  let( ( path )

    path = ddGetObjReadPath(ddGetObj(lib cell view))
    ipcBatchProcess( sprintf(nil "cd %s && %s" path cdsdm_git->xterm )  "" "" )

  )
)

;
;
