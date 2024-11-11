.include "macrolib.asm"
.globl 	tests

.data
	test_value:		.asciz "Test value: "
	new_double_line:	.asciz "\n\n"

.text
tests:
	# Тест при x = 0
	test_1: 
			li		t0,	0       # Загружаем x = 0 в регистр t0
			       
			print_string(test_value)	# Печатаем строку "Test result: "
			print_int(t0)			# Печатаем значение x (0)
			print_string(new_line)		# Печатаем новую строку
			
    			fcvt.d.w 	ft0, 	t0      # Преобразуем значение x (t0) в тип double и сохраняем в ft0          
   			jal      	check_minus	# Переходим к подпрограмме для обработки знака числа
   			
   	# Тест при x = 10
   	test_2:
			li		t0,	10       
			 
			print_string(new_double_line)       
			print_string(test_value)
			print_int(t0)
			print_string(new_line)
			
			
    			fcvt.d.w 	ft0, 	t0                
   			jal      	check_minus
   
   	# Тест при x = -10
   	test_3:
			li		t0,	-10     
			 
			print_string(new_double_line)                 
			print_string(test_value)
			print_int(t0)
			print_string(new_line)
			
    			fcvt.d.w 	ft0, 	t0                
   			jal      	check_minus
   
   	# Тест при x = 100
   	test_4:
			li		t0,	100        
			
			print_string(new_double_line)                
			print_string(test_value)
			print_int(t0)
			print_string(new_line)
			
    			fcvt.d.w 	ft0, 	t0                
   			jal      	check_minus
   			
   	# Тест при x = -100
   	test_5:
			li		t0,	-100        
			
			print_string(new_double_line)                    
			print_string(test_value)
			print_int(t0)
			print_string(new_line)
			
    			fcvt.d.w 	ft0, 	t0                
   			jal      	check_minus
   	
   	# Тест при x = 1000
   	test_6:
			li		t0,	1000        
			
			
			print_string(new_double_line)                
			print_string(test_value)
			print_int(t0)
			print_string(new_line)
			
    			fcvt.d.w 	ft0, 	t0                
   			jal      	check_minus
	
	# Тест при x = -1000
	test_7:
			li		t0,	-1000        
			  
			print_string(new_double_line)                   
			print_string(test_value)
			print_int(t0)
			print_string(new_line)
			
    			fcvt.d.w 	ft0, 	t0                
   			jal      	check_minus
   			
   	end_program()