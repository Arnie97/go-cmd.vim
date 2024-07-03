let s:save_cpo = &cpo
set cpo&vim

if has('patch-8.1.1510')
    command! -nargs=* -bang -bar -complete=custom,go_cmd#complete
        \ Go call asyncrun#run(<q-bang>, {},
            \ 'go '.join(map([<f-args>], {_, p -> expandcmd(p)})))
elseif has('patch-7.4.2044')
    command! -nargs=* -bang -bar -complete=custom,go_cmd#complete
        \ Go call asyncrun#run(<q-bang>, {},
            \ 'go '.join(map([<f-args>], {_, p -> expand(p)})))
else
    command! -nargs=* -bang -bar -complete=file
        \ Go call asyncrun#run(<q-bang>, {}, 'go '.<q-args>)
endif

if !exists('g:go_cmd_formatter_on_save')
    if executable('goimports')
        let g:go_cmd_formatter_on_save = '!goimports -w "%"'
    elseif executable('gofmt')
        let g:go_cmd_formatter_on_save = '!gofmt -w "%"'
    elseif executable('go')
        let g:go_cmd_formatter_on_save = '!go fmt "%"'
    else
        let g:go_cmd_formatter_on_save = ''
    endif
endif

if len(g:go_cmd_formatter_on_save)
    autocmd BufWritePost *.go silent execute g:go_cmd_formatter_on_save | edit
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vi: set ts=4 sw=4 et ff=unix :
