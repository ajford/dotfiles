"Only run if autocmd is compiled in
if has("autocmd")

    autocmd FileType mkd set textwidth=80
    autocmd FileType mkd nnoremap <leader>1 I# A #o
    autocmd FileType mkd inoremap <leader>1 I# A #o
    autocmd FileType mkd nnoremap <leader>2 I## A ##o
    autocmd FileType mkd inoremap <leader>2 I## A ##o
    autocmd FileType mkd nnoremap <leader>3 I### A ###o
    autocmd FileType mkd inoremap <leader>3 I### A ###o
    autocmd FileType mkd nnoremap <leader>4 I#### A ####o
    autocmd FileType mkd inoremap <leader>4 I#### A ####o
    autocmd FileType mkd nnoremap <leader>5 I##### A #####o
    autocmd FileType mkd inoremap <leader>5 I##### A #####o
    autocmd FileType mkd nnoremap <leader>6 I###### A ######o
    autocmd FileType mkd inoremap <leader>6 I###### A ######o
    autocmd FileType mkd nnoremap <leader>- yypVr-o
    autocmd FileType mkd inoremap <leader>- yypVr-o
    autocmd FileType mkd nnoremap <leader>= yypVr=o
    autocmd FileType mkd inoremap <leader>= yypVr=o
    autocmd FileType mkd nnoremap <leader>h o20I-o<CR>
    autocmd FileType mkd inoremap <leader>h o20I-o<CR>
    autocmd FileType mkd nnoremap <leader>H 20I-
    autocmd FileType mkd inoremap <leader>H 20I-

    autocmd FileType mkd nnoremap <leader>8 I* 
    autocmd FileType mkd inoremap <leader>8 I* 
    autocmd FileType mkd nnoremap <leader>* I* 
    autocmd FileType mkd inoremap <leader>* I* 

    
end
