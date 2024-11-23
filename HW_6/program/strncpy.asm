.globl strncpy_loop

.text
strncpy_loop:
	loop:
		lb	t0	(a0)
		sb	t0	(a1)
		beqz	t0	end_loop
		addi	a0	a0	1
		addi 	a1	a1	1
		j	loop
		
	end_loop:
		jalr 	ra