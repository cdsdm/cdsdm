; cdsdm_permission.il
;

procedure( cdsdm_permission( path mode )

    when( isDir(path) && (mode == "+" || mode == "-")
    
      ;;; library
      shell( sprintf( nil "%s -f ugo%sw %s" cdsdm_git->chmod mode path ) )

      ;;; 0-9 A-Z a-z
      shell( sprintf( nil "%s -f -R ugo%sw %s/[0-z]* %s" cdsdm_git->chmod mode path cdsdm_git->bg ) )

      ;;: #
      when( setof(x getDirFiles(path) substring(x 1 1)=="#")
	shell( sprintf( nil "%s -f -R ugo%sw %s/#*" cdsdm_git->chmod mode path ) )
      )

      ;;; @
      when( setof(x getDirFiles(path) substring(x 1 1)=="@")
	shell( sprintf( nil "%s -f -R ugo%sw %s/@*" cdsdm_git->chmod mode path ) )
      )

      ;;; _
      when( setof(x getDirFiles(path) substring(x 1 1)=="_")
	shell( sprintf( nil "%s -f -R ugo%sw %s/_*"  cdsdm_git->chmod mode path ) )
      )

      ;;; dotfiles
      foreach( x cdsdm_git->dotfiles
	when( isFile( sprintf(nil "%s/%s" path x) )
	  shell( sprintf( nil  "%s -f ugo%sw %s/%s" cdsdm_git->chmod mode path x ) )
	)
      )

    )

)

;
;
