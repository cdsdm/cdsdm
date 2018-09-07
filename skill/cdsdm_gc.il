; cdsdm_gc.il
;

procedure( cdsdm_gc(lib @optional options)
  let( ( path branch master cid irp )

    path = ddGetObjReadPath(ddGetObj(lib))
    branch = cdsdm_check_branch(lib)
    master = cdsdm_git->master

    unless(options  options = "")

    shell( sprintf(nil "%s -C %s gc %s" cdsdm_git->git path options) )

  )
)

;
;
