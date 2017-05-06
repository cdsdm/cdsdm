; cdsdm_lmgr_proc.il
;

procedure( cdsdm_lmgr_proc( @optional lmgr lib cell view ver dum )

  if( member( lib ddGetLibList()~>name ) &&
      isDir(strcat(ddGetObjReadPath(ddGetObj(lib)) "/.git")) then

    case( lmgr
        ( "cdsdm_lmgr_push"	cdsdm_push(lib)			)
        ( "cdsdm_lmgr_pull"	cdsdm_pull(lib)			)
        ( "cdsdm_lmgr_checkout"	cdsdm_checkout(lib)		)
        ( "cdsdm_lmgr_branch"	cdsdm_branch(lib)		)
        ( "cdsdm_lmgr_checkin"	cdsdm_checkin(lib)		)
        ( "cdsdm_lmgr_cancel"	cdsdm_cancel(lib)		)
        ( "cdsdm_lmgr_diff"	cdsdm_diff(lib)			)
        ( "cdsdm_lmgr_revert"	cdsdm_revert(lib)		)
        ( "cdsdm_lmgr_recover"	cdsdm_recover(lib)		)
        ( "cdsdm_lmgr_tag"	cdsdm_tag(lib)			)
        ( "cdsdm_lmgr_gc"	cdsdm_gc(lib)			)
        ( "cdsdm_lmgr_archive"	cdsdm_archive(lib)		)
        ( "cdsdm_lmgr_clone"	cdsdm_clone()			)
        ( "cdsdm_lmgr_init"	cdsdm_init()			)
        ( "cdsdm_lmgr_config"	cdsdm_config()			)
        ( "cdsdm_lmgr_gitk"	cdsdm_gitk(lib)			)
        ( "cdsdm_lmgr_xterm"	cdsdm_xterm(lib cell view)	)
    )

  else

    case( lmgr
        ( "cdsdm_lmgr_clone"	cdsdm_clone()			)
        ( "cdsdm_lmgr_init"	cdsdm_init()			)
        ( "cdsdm_lmgr_config"	cdsdm_config()			)
        ( "cdsdm_lmgr_xterm"	cdsdm_xterm(lib cell view)	)
    )

  )

)

;
;
