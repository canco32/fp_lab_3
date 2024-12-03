(defun insert-into-sorted (elem sorted)
  (if (or (null sorted) (<= elem (car sorted)))
      (cons elem sorted)
      (cons (car sorted) (insert-into-sorted elem (cdr sorted)))))

(defun insertion-sort-functional (lst)
  (if (null lst)
      nil
      (insert-into-sorted (car lst) (insertion-sort-functional (cdr lst)))))

(defun check-sorting (name func input expected)
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal (funcall func input) expected)
          name))

(defun test-sorting ()
  (check-sorting "test 1" #'insertion-sort-functional '(3 1 4 1 5 9) '(1 1 3 4 5 9))
  (check-sorting "test 2" #'insertion-sort-functional '(1 7 4 2 8 5 9) '(1 2 4 5 7 8 9))
  (check-sorting "test 3" #'insertion-sort-functional '(1 2 3) '(1 2 3)))

