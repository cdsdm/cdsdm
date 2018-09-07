; cdsdm_lmgr_cb.il
;

procedure( cdsdm_lmgr_cb(@optional lmgr lib cell view ver dum )
  let( ( libId branch )

    if( strlen(lib)>0 && (libId=ddGetObj(lib)) && member(lib ddGetLibList()~>name) &&
	isDir(strcat(ddGetObjReadPath(libId) "/.git")) && (branch=cdsdm_check_branch(lib))  then

      lmgrManageMenuItems( list("cdsdm_lmgr_push" "cdsdm_lmgr_pull"
				"cdsdm_lmgr_checkout" "cdsdm_lmgr_branch" "cdsdm_lmgr_checkin"
				"cdsdm_lmgr_cancel"
      				"cdsdm_lmgr_diff" "cdsdm_lmgr_revert" "cdsdm_lmgr_recover"
				"cdsdm_lmgr_tag" "cdsdm_lmgr_gc" "cdsdm_lmgr_archive"
				"cdsdm_lmgr_clone" "cdsdm_lmgr_init" "cdsdm_lmgr_setup" 
				"cdsdm_lmgr_gitk" "cdsdm_lmgr_xterm"
				) t )
      lmgrManageMenuItems( list("cdsdm_lmgr_jenkins") nil )

      if( branch == cdsdm_git->master  then
	  lmgrSensitizeMenuItems( list( "cdsdm_lmgr_push" "cdsdm_lmgr_pull" ) t )
	  lmgrSensitizeMenuItems( list( "cdsdm_lmgr_checkout" ) t )
	  lmgrSensitizeMenuItems( list( "cdsdm_lmgr_checkin" ) nil )
	  lmgrSensitizeMenuItems( list( "cdsdm_lmgr_cancel" ) nil )
	else
	  lmgrSensitizeMenuItems( list( "cdsdm_lmgr_push" "cdsdm_lmgr_pull" ) nil )
	  lmgrSensitizeMenuItems( list( "cdsdm_lmgr_checkout" ) nil )
	  lmgrSensitizeMenuItems( list( "cdsdm_lmgr_checkin" ) when(cdsdm_list_add(lib) t) )
	  lmgrSensitizeMenuItems( list( "cdsdm_lmgr_cancel" ) t )
      )
      lmgrSensitizeMenuItems( list( "cdsdm_lmgr_branch" ) nil )
      lmgrSensitizeMenuItems( list( "cdsdm_lmgr_diff" "cdsdm_lmgr_revert" "cdsdm_lmgr_recover" ) nil )
      lmgrSensitizeMenuItems( list( "cdsdm_lmgr_tag" "cdsdm_lmgr_archive" ) nil )

    else

      lmgrManageMenuItems( list("cdsdm_lmgr_push" "cdsdm_lmgr_pull"
				"cdsdm_lmgr_checkout" "cdsdm_lmgr_branch" "cdsdm_lmgr_checkin"
				"cdsdm_lmgr_cancel"
				"cdsdm_lmgr_diff" "cdsdm_lmgr_revert" "cdsdm_lmgr_recover"
				"cdsdm_lmgr_tag" "cdsdm_lmgr_gc" "cdsdm_lmgr_archive"
				"cdsdm_lmgr_gitk" "cdsdm_lmgr_xterm" ) nil )
      lmgrManageMenuItems( list( "cdsdm_lmgr_xterm" ) strlen(lib)>0 )
      lmgrManageMenuItems( list("cdsdm_lmgr_clone" "cdsdm_lmgr_init" "cdsdm_lmgr_setup" ) t )

    )

  )
)

;
;
