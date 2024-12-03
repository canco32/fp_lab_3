<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Функціональний і імперативний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><strong>Студент:</strong> <i>Сілін Ілля Денисович КВ-12</i><p>
<p align="right"><strong>Рік:</strong> <i>2024</i><p>

  ## Загальне завдання
  
Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного
списку. Не допускається використання: деструктивних операцій, циклів, функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Також реалізована функція не має
бути функціоналом (тобто приймати на вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і
деструктивних функцій (псевдофункцій). Не допускається використання функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Тим не менш, оригінальний список
цей варіант реалізації також не має змінювати, тому перед виконанням
деструктивних змін варто застосувати функцію copy-list (в разі необхідності).
Також реалізована функція не має бути функціоналом (тобто приймати на вхід
функції в якості аргументів).

Алгоритм, який необхідно реалізувати, задається варіантом (п. 3.1.1). Зміст і шаблон
звіту наведені в п. 3.2.

Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів (наприклад, як наведено у п. 2.3).

## Варіант 4

Алгоритм сортування вставкою №2 (з лінійним пошуком справа) за незменшенням.

## Лістинг функції рекурсивного підходу

```
(defun insert-into-sorted (elem sorted)
  (if (or (null sorted) (<= elem (car sorted)))
      (cons elem sorted)
      (cons (car sorted) (insert-into-sorted elem (cdr sorted)))))

(defun insertion-sort-functional (lst)
  (if (null lst)
      nil
      (insert-into-sorted (car lst) (insertion-sort-functional (cdr lst)))))
```

### Тестові набори
      
```
(defun check-sorting (name func input expected)
  (format t "~:[FAILED~;passed~] ~a~%~%"
          (equal (insertion-sort-functional func input) expected)
          name))

(defun test-sorting ()
  (check-sorting "test 1" #'insertion-sort-functional '(3 1 4 1 5 9) '(1 1 3 4 5 9))
  (check-sorting "test 2" #'insertion-sort-functional '(1 7 4 2 8 5 9) '(1 2 4 5 7 8 9))
  (check-sorting "test 3" #'insertion-sort-functional '(1 2 3) '(1 2 3)))
```
### Тестування
```
[1] CL-USER> (test-sorting)
passed test 1
passed test 2
passed test 3
NIL
```
## Лістинг функції імперативного підходу

```
(defun insertion-sort-imperative (lst)
  (let ((sorted (copy-list lst)))
    (do ((i 1 (1+ i)))  
        ((>= i (length sorted)))  
      (let ((key (nth i sorted)) 
            (j (1- i)))          
        (do ()
            ((or (< j 0) (<= (nth j sorted) key)))
          (setf (nth (1+ j) sorted) (nth j sorted)) 
          (decf j)) 
        (setf (nth (1+ j) sorted) key)))
    sorted))

```

### Тестові набори

```
(defun check-sorting (name func input expected)
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal (funcall func input) expected)
          name))

(defun test-sorting ()
  (check-sorting "test 1" #'insertion-sort-imperative '(3 1 4 1 5 9) '(1 1 3 4 5 9))
  (check-sorting "test 2" #'insertion-sort-imperative '(1 7 4 2 8 5 9) '(1 2 4 5 7 8 9))
  (check-sorting "test 3" #'insertion-sort-imperative '(1 2 3) '(1 2 3)))

```

### Тестування

```
[4] CL-USER> (test-sorting)
passed test 1
passed test 2
passed test 3
NIL
```
