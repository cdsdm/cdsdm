; cdsdm_gc.il
;

procedure( cdsdm_gc(lib @optional options)
  let( ( path )

    path = ddGetObjReadPath(ddGetObj(lib))

    unless(options  options = "")

    shell( sprintf(nil "%s -C %s gc %s" cdsdm_git->git path options) )

  )
)

;
;
