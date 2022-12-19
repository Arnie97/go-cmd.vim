command! -nargs=* -bang -bar -complete=custom,go_cmd#complete
    \ Go call asyncrun#run(<q-bang>, '', 'go '..<q-args>)
