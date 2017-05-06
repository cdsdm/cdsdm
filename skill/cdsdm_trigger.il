; cdsdm_trigger.il
;

procedure( cdsdm_trigger( @optional dd )
  let( ( path )

    when( dd->type == 'ddLibType &&
	  isDir(path=strcat(ddGetObjReadPath(dd->lib) "/.git"))

      shell( sprintf( nil "%s -R u+w %s" cdsdm_git->chmod ddGetObjReadPath(dd->lib) ) )
      shell( sprintf( nil "%s -rf %s" cdsdm_git->rm path ) )

      cdsdm_cdslib(dd->name "delete")

    )

    t

  )
)

;
;
