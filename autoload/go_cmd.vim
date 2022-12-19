function go_cmd#complete(lead, line, pos) abort
    let subcmd = matchstr(strpart(a:line, 0, a:pos - len(a:lead)),
        \ '\v\u\w*[! ] *(mod|tool)? *\zs<\w[[:alnum:]-]*>\ze')

    if has_key(s:subcmds, subcmd)
        return s:subcmd_complete(s:subcmds[subcmd].' ')
    elseif subcmd == 'tool'
        return s:subcmd_complete(system('go tool'))
    elseif subcmd =~# 'get\|install'
        return s:go_mod_complete(a:lead)
    else
        return s:go_file_complete(a:lead)
    endif
endfunction

function s:subcmd_complete(cmds)
    return substitute(a:cmds, ' \|\n', ' \n', 'g')
endfunction

function s:go_mod_complete(lead) abort
    if !exists('s:pkg_mod_path')
        let s:pkg_mod_path = trim(system('go env GOPATH'), "\n", 2).'/pkg/mod/'
    endif

    let paths = globpath(s:pkg_mod_path, a:lead.'*', 0, 1)

    " show only directories
    call filter(paths, {_, p -> isdirectory(p) && p !~# '^cache\>'})

    " remove path prefix, and add / suffix for parent directories w/o @version
    call map(paths, {_, p -> p[len(s:pkg_mod_path):].(p !~ '@'? '/': '')})

    return join(paths, "\n")
endfunction

function s:go_file_complete(lead) abort
    let paths = glob(a:lead.'*', 0, 1)

    " add / suffix to directories
    call map(paths, {_, p -> p !~ '/$' && isdirectory(p)? p.'/': p})

    " filter *.go files; directories are always allowed
    call filter(paths, {_, p -> p =~# '\v\.go$|/$'})

    " https://pkg.go.dev/cmd/go#hdr-Package_lists_and_patterns
    call insert(paths, fnamemodify(a:lead, ':h') . '/...')

    return join(paths, "\n")
endfunction

let s:subcmds = {
    \ '': 'build clean doc env fmt generate get help install list mod run test tool version vet work',
    \ 'help': 'bug buildconstraint buildmode c cache environment filetype go.mod gopath gopath-get goproxy importpath modules module-get module-auth packages private testflag testfunc vcs',
    \ 'mod': 'download edit graph init tidy vendor verify why',
    \ 'work': 'edit init sync use',
\ }
let s:subcmds['help'] .= ' ' . s:subcmds['']
