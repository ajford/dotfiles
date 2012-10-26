"Only run if autocmd is compiled in
if has("autocmd")

    autocmd FileType mkd set textwidth=80
    autocmd FileType mkd nnoremap <leader><leader>1 I# A #o
    autocmd FileType mkd inoremap <leader><leader>1 I# A #o
    autocmd FileType mkd nnoremap <leader><leader>2 I## A ##o
    autocmd FileType mkd inoremap <leader><leader>2 I## A ##o
    autocmd FileType mkd nnoremap <leader><leader>3 I### A ###o
    autocmd FileType mkd inoremap <leader><leader>3 I### A ###o
    autocmd FileType mkd nnoremap <leader><leader>4 I#### A ####o
    autocmd FileType mkd inoremap <leader><leader>4 I#### A ####o
    autocmd FileType mkd nnoremap <leader><leader>5 I##### A #####o
    autocmd FileType mkd inoremap <leader><leader>5 I##### A #####o
    autocmd FileType mkd nnoremap <leader><leader>6 I###### A ######o
    autocmd FileType mkd inoremap <leader><leader>6 I###### A ######o
    autocmd FileType mkd nnoremap <leader>- yypVr-o
    autocmd FileType mkd inoremap <leader>- yypVr-o
    autocmd FileType mkd nnoremap <leader>= yypVr=o
    autocmd FileType mkd inoremap <leader>= yypVr=o
    autocmd FileType mkd nnoremap <leader><leader>h o20I-o<CR>
    autocmd FileType mkd inoremap <leader><leader>h o20I-o<CR>
    autocmd FileType mkd nnoremap <leader><leader>H 20I-
    autocmd FileType mkd inoremap <leader><leader>H 20I-

    autocmd FileType mkd nnoremap <leader><leader>8 I* 
    autocmd FileType mkd inoremap <leader><leader>8 I* 
    autocmd FileType mkd nnoremap <leader><leader>* I* 
    autocmd FileType mkd inoremap <leader><leader>* I* 

   

    ""Utilizing Tabularize
    "if exists(":Tabularize")
      "autocmd FileType mkd nnoremap <Leader>a= :Tabularize /=<CR>
      "autocmd FileType mkd vmap <Leader>a= :Tabularize /=<CR> 
      "autocmd FileType mkd nnoremap <Leader>a= :Tabularize /:\zs<CR>
      "autocmd FileType mkd vmap <Leader>a= :Tabularize /:\zs<CR>
    "endif
    
    

end
