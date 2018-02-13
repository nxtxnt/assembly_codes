  mov eax, [val]

  get_numeration:
    shr eax, 1
    cmp eax, 0
    je incr

  incr:
    inc eax

