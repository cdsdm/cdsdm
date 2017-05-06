; cdsdm_cdslib_backup.il
;

procedure( cdsdm_cdslib_backup()
  let( ( cdslib (cdslib_backup "") )

    cdslib = ddGetStartup("cds.lib")
    for( i 1 length(parseString(cdslib "/"))-1
      cdslib_backup = strcat( cdslib_backup "/" nthelem(i parseString(cdslib "/")) )
    )

    strcat(cdslib_backup "/" cdsdm_git->backup_name )

  )
)

;
;
