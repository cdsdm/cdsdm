; cdsLibMgr.il
;

let( (dm)
    dm = ddGetPathDMSys(simplifyFilename(getWorkingDir()))
    when(null(dm) || equal(dm "none")
      lmgrManageMenuItems(list("designCascade") nil)
    )
    lmgrDisplayMessage( "Loading cdsDM Version 1.0\n" )
)

lmgrCreateMenu( "cdsdmCascade" '(("label" "cdsDM") ("mapCallback" ("cdsdm_lmgr_cb")) ) )
lmgrAddMenuItems( "menuBar" "" '("cdsdmCascade") )

lmgrCreateMenuItem( "cdsdm_lmgr_sep1" "separator" nil )
lmgrCreateMenuItem( "cdsdm_lmgr_sep2" "separator" nil )
lmgrCreateMenuItem( "cdsdm_lmgr_sep3" "separator" nil )
lmgrCreateMenuItem( "cdsdm_lmgr_sep4" "separator" nil )
lmgrCreateMenuItem( "cdsdm_lmgr_sep5" "separator" nil )
lmgrCreateMenuItem( "cdsdm_lmgr_sep6" "separator" nil )
lmgrCreateMenuItem( "cdsdm_lmgr_sep7" "separator" nil )

lmgrCreateMenuItem( "cdsdm_lmgr_push" "simple"
    '(("label"	"Push")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_pull" "simple"
    '(("label"	"Pull")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_checkout" "simple"
    '(("label"	"Checkout")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_branch" "simple"
    '(("label"	"Checkout Specific Branch...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_checkin" "simple"
    '(("label"	"Checkin...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_cancel" "simple"
    '(("label"	"Cancel Checkout")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_diff" "simple"
    '(("label"	"Diff...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_revert" "simple"
    '(("label"	"Revert...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_recover" "simple"
    '(("label"	"Recover...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_tag" "simple"
    '(("label"	"Tag...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_gc" "simple"
    '(("label"	"Gc...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_archive" "simple"
    '(("label"	"Archive...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_clone" "simple"
    '(("label"	"Clone...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenu( "cdsdm_lmgr_setup" '(("label" "Setup")) )
lmgrCreateMenuItem( "cdsdm_lmgr_init" "simple"
    '(("label"	"Init...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_config" "simple"
    '(("label"	"Config...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_jira" "simple"
    '(("label"	"JIRA...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_trac" "simple"
    '(("label"	"Trac...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_redmine" "simple"
    '(("label"	"Redmine...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_jenkins" "simple"
    '(("label"	"Jenkins...")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrAddMenuItems( "cdsdm_lmgr_setup" "" '("cdsdm_lmgr_init" "cdsdm_lmgr_config") )
lmgrCreateMenuItem( "cdsdm_lmgr_gitk" "simple"
    '(("label"	"Gitk")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)
lmgrCreateMenuItem( "cdsdm_lmgr_xterm" "simple"
    '(("label"	"Xterm")
      ("callback" ("cdsdm_lmgr_proc"))
     )
)

lmgrAddMenuItems( "cdsdmCascade" ""  '(
		"cdsdm_lmgr_sep1" "cdsdm_lmgr_push" "cdsdm_lmgr_pull"
		"cdsdm_lmgr_sep2" "cdsdm_lmgr_checkout" "cdsdm_lmgr_branch" "cdsdm_lmgr_checkin"
		"cdsdm_lmgr_sep3" "cdsdm_lmgr_cancel"
		"cdsdm_lmgr_sep4" "cdsdm_lmgr_diff" "cdsdm_lmgr_revert" "cdsdm_lmgr_recover"
		"cdsdm_lmgr_sep5" "cdsdm_lmgr_tag" "cdsdm_lmgr_gc" "cdsdm_lmgr_archive"
		"cdsdm_lmgr_sep6" "cdsdm_lmgr_clone" "cdsdm_lmgr_setup"
		"cdsdm_lmgr_sep7" "cdsdm_lmgr_gitk" "cdsdm_lmgr_xterm"
) )
lmgrAddMenuItems( "cdsdmCascade" "L"  '(
		"cdsdm_lmgr_sep1" "cdsdm_lmgr_push" "cdsdm_lmgr_pull"
		"cdsdm_lmgr_sep2" "cdsdm_lmgr_checkout" "cdsdm_lmgr_checkin"
		"cdsdm_lmgr_sep3" "cdsdm_lmgr_cancel"
		"cdsdm_lmgr_sep7" "cdsdm_lmgr_gitk" "cdsdm_lmgr_xterm"
) )
lmgrAddMenuItems( "cdsdmCascade" "CV"  '(
		"cdsdm_lmgr_sep2" "cdsdm_lmgr_checkout" "cdsdm_lmgr_checkin"
		"cdsdm_lmgr_sep3" "cdsdm_lmgr_cancel"
		"cdsdm_lmgr_sep7" "cdsdm_lmgr_xterm"
) )

lmgrCreateMenu("popup" '(("mapCallback" ("cdsdm_lmgr_popup")) ))

;
;
