!path = expand_path('+/Users/' + getenv('username') + '/Dropbox/Development/IDLWorkspace85/Default') + path_sep(/SEARCH_PATH) + !path
!path = expand_path('+/Users/' + getenv('username') + '/Dropbox/Development//IDLWorkspace85/ResearchIDL') + path_sep(/SEARCH_PATH) + !path
!path = expand_path('+/Users/' + getenv('username') + '/Dropbox/Development//IDLWorkspace85/Coyote') + path_sep(/SEARCH_PATH) + !path
!path = expand_path('+/Users/' + getenv('username') + '/Dropbox/Development//IDLWorkspace85/Woods IDL Library') + path_sep(/SEARCH_PATH) + !path
!path = expand_path('+/Users/' + getenv('username') + '/Dropbox/Development//IDLWorkspace85/minxss_trunk') + path_sep(/SEARCH_PATH) + !path
setenv, 'username=jama6159'
setenv, 'EVE_DATA=/production/data'
setenv, 'minxss_data=/Users/jama6159/Dropbox/minxss_dropbox/data'
setenv, 'minxss_code=/Users/jama6159/Dropbox/Development/IDLWorkspace85/minxss_trunk'
setenv, 'TLE_dir=/Users/jama6159/Dropbox/minxss_dropbox/tle/'
setenv, 'isis_data=/Users/jama6159/Dropbox/isis_rundirs'
setenv, 'isis_data_jim_white=/Users/jama6159/Dropbox/nowhere'
message, /INFO, JPMsystime() + ' Loaded personal path'