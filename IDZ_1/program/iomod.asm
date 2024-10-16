.include "macrolib.asm"
.globl get_and_save_n

.data
	print_get_n:				.asciz "Please enter the number of array elements from 1 to 10 (autotest - 0): "
	invalid_n_value:			.asciz "Invalid input, try again"
.text
	# Ввод n и сохранение его в памяти
	get_and_save_n:	
		print_string(print_get_n)				# Выводим содержимое a0 через макрос print_string						
		read_int(a0)						# Получаем от пользвателя n (int) через макрос (значение будет лежать в регистре a0)
		
		beq, zero, a0, tests					# Если пользователь ввел 0, то выполням авто-тестирование	
		
		# Регист a0 : введедееый инт пользователем
    		j	check_n_for_correctness				# "Прыгаем" в другую подпрограмму, чтобы проверить что пользователь ввел корректные данные (int от 1 до 10)

 	check_n_for_correctness:					# Проверям, корректность ввода пользователя
 		ble, 	a0, zero, incorrect_n_value_back_to_get_n	# Если введеное значение пользователя меньше или равно 1, то "прыгаем" в обработку (incorrect_n_value_back_to_get_n)
 		li 	t2, 10						# Загружаем в t1 10
		bgt	a0, t2, incorrect_n_value_back_to_get_n		# Если введеное значение пользователя больше 10, то  "прыгаем" в обработку (incorrect_n_value_back_to_get_n)
		
		mv	t3, a0						# Перемещаем int от пользователя в t3
		sw	t3, (t0)					# Загрузка n в память на хранение
		
 		ret							# Если данные прошли все проверки, то возвращаемся по адрессу
 		
 	incorrect_n_value_back_to_get_n:				
 		print_string(invalid_n_value)				# Выводим "Invalid input, try again"
 		print_string(new_line)					# Выводим переход строки
 		j	get_and_save_n					# "Прыгаем" в (get_and_save_n) для повторого запроса данных
