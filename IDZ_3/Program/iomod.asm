.globl output
.include "macro-syscalls.m"

output:
	beq	s8	zero	no_output_console	# Если в s8 лежит 0, т.е. false то мы пропускаем вывод
	j	output_console				# Прыгаем в подпрограмму вывода в консоль
	
	output_console:
		# Вывод текста на консоль
		print_str("Output: ")
		li 	a7 	4
		ecall 
		
		ret
	
	no_output_console:
		ret
	

