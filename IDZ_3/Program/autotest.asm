.globl 	autotest
.include "macro-syscalls.m"

.eqv    NAME_SIZE 256		# Размер буфера для имени файла

.data
test_case_1_input:	.asciz	"TestData/test1.txt"
test_case_1_output:	.asciz	"TestData/test1_result.txt"

test_case_2_input:	.asciz	"TestData/test2.txt"
test_case_2_output:	.asciz	"TestData/test2_result.txt"

test_case_3_input:	.asciz	"TestData/test3.txt"
test_case_3_output:	.asciz	"TestData/test3_result.txt"

test_case_4_input:	.asciz	"TestData/test4.txt"
test_case_4_output:	.asciz	"TestData/test4_result.txt"

test_case_5_input:	.asciz	"TestData/test5.txt"
test_case_5_output:	.asciz	"TestData/test5_result.txt"

test_case_6_input:	.asciz	"TestData/test6.txt"
test_case_6_output:	.asciz	"TestData/test6_result.txt"

test_file_name_input:	.space	NAME_SIZE
test_file_name_output:	.space	NAME_SIZE

.text
autotest:
	test_1:
		strcpy(test_case_1_input, test_file_name_input)
		strcpy(test_case_1_output, test_file_name_output)
		jal	test_logic
		
	test_2:
		strcpy(test_case_2_input, test_file_name_input)
		strcpy(test_case_2_output, test_file_name_output)
		jal	test_logic
		
	test_3:
		strcpy(test_case_3_input, test_file_name_input)
		strcpy(test_case_3_output, test_file_name_output)
		jal	test_logic
		
	test_4:
		strcpy(test_case_4_input, test_file_name_input)
		strcpy(test_case_4_output, test_file_name_output)
		jal	test_logic
		
	test_5:
		strcpy(test_case_5_input, test_file_name_input)
		strcpy(test_case_5_output, test_file_name_output)
		jal	test_logic
		
	test_6:
		strcpy(test_case_6_input, test_file_name_input)
		strcpy(test_case_6_output, test_file_name_output)
		jal	test_logic
		
		
	exit()
			
test_logic:
	push(ra)
	
	print_str("\n")
	print_str("File path input: ")
	print_string(test_file_name_input)
	
	strcpy(test_file_name_input, file_name)
	jal	read_file
	
	jal	string_refactor
	
	print_new_line_if(s8)
	jal	output
	
	strcpy(test_file_name_output, file_name)
	jal	save_in_file
	
	print_str("\n")
	
	print_str("File name ouput: ")
	print_string(test_file_name_output)
	
	print_str("\n")
	
	pop(ra)
	jalr	ra