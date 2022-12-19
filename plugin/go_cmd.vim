let s:save_cpo = &cpo
set cpo&vim

if has('patch-7.4.2044')
    command! -nargs=* -bang -bar -complete=custom,go_cmd#complete
        \ Go call asyncrun#run(<q-bang>, '', 'go '.<q-args>)
else
    command! -nargs=* -bang -bar -complete=file
        \ Go call asyncrun#run(<q-bang>, '', 'go '.<q-args>)
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vi: set ts=4 sw=4 et ff=unix :
