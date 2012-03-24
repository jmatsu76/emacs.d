;;; Magit
;; 2012-03-23
(el-get 'sync '(magit))

  ;;; commit logをanythingで選択できるようにする
  (defvar anything-c-source-log-edit-comment
    '((name . "Log-edit Comment")
      (candidates . anything-c-log-edit-comment-candidates)
      (action . (("Insert" . (lambda (str) (insert str)))))
      (migemo)
      (multiline))
    "Source for browse and insert Log-edit comment.")

  (defun anything-c-log-edit-comment-candidates ()
    (let* ((candidates
            (shell-command-to-string "\\git \\log -500 | \\grep -E '^    .+'"))
           (logs (string-to-list (split-string candidates "\n    "))))
      (push (replace-regexp-in-string "^    " "" (pop logs)) logs)
      logs))

  (defun anything-show-log-edit-comment ()
    "`anything' for Log-edit comment."
    (interactive)
    (anything-other-buffer 'anything-c-source-log-edit-comment
                           "*anything log-edit comment*"))

  ;; Magitのcommit messageの編集時にanythingでgit logのコメントから選択
  (define-key magit-log-edit-mode-map (kbd "C-s") 'anything-show-log-edit-comment)