; cdsdm_lmgr_popup.il
;

procedure( cdsdm_lmgr_popup( @optional lmgr lib cell view ver dum )

  when( member("cdsdmCascade" lmgrQueryNamedObjects())

    if( strlen(lib)>0  then
      cdsdm_lmgr_cb( lmgr lib cell view ver dum )
    else
      lmgrManageMenuItems( list( "cdsdm_lmgr_clone" "cdsdm_lmgr_init" "cdsdm_lmgr_config" ) t )
    )

  )

)

;
;
