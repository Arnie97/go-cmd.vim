function go_cmd#complete(lead, line, pos) abort
    let subcmd = a:line->strpart(0, a:pos - len(a:lead))->matchstr(
        \ '\v\u\w*[! ] *(mod|tool)? *\zs<\w[[:alnum:]-]*>\ze')

    if empty(subcmd)
        return s:subcmd_complete('build clean doc env fmt generate get install list mod run test tool version vet work ')
    elseif subcmd == 'mod'
        return s:subcmd_complete('download edit graph init tidy vendor verify why ')
    elseif subcmd == 'tool'
        return s:subcmd_complete(system('go tool'))
    elseif subcmd =~# 'get\|install'
        " directories only
        let paths = globpath(s:get_pkg_mod_path(), a:lead..'*', 0, 1)
        call filter(paths, {_, p -> isdirectory(p)})
        call map(paths, {_, p -> p[len(s:pkg_mod_path):]..'/'})
        return paths->join("\n")
    endif

    " add / to directories, and filter *.go files
    let paths = glob(a:lead..'*', 0, 1)
    call map(paths, {_, p -> p !~# '/$' && isdirectory(p)? p..'/': p})
    call filter(paths, {_, p -> p =~# '\v\.go$|/$'})
    return paths->join("\n")
endfunction

function s:subcmd_complete(cmds)
    return substitute(a:cmds, ' \|\n', ' \n', 'g')
endfunction

function s:get_pkg_mod_path()
    if !exists('s:pkg_mod_path')
        let s:pkg_mod_path = system('go env GOPATH')->trim("\n", 2)..'/pkg/mod/'
    endif
    return s:pkg_mod_path
endfunction
