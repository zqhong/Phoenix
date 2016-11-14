
        ORG        0x7c00             ; 指令程序的装载地址

        ; 用于标准 FAT12 格式的软盘
        JMP        entry
        DB        0x90
        DB        "HELLOIPL"
        DW        512
        DB        1
        DW        1
        DB        2
        DW        224
        DW        2880
        DB        0xf0
        DW        9
        DW        18
        DW        2
        DD        0
        DD        2880
        DB        0,0,0x29
        DD        0xffffffff
        DB        "HELLO-OS   "
        DB        "FAT12   "
        RESB    18

; 程序核心
entry:
        MOV        AX,0                 ; 初始化寄存器
        MOV        SS,AX
        MOV        SP,0x7c00
        MOV        DS,AX
        MOV        ES,AX

        MOV        SI,msg
putloop:                                ; 给 SI 加 1
        MOV        AL,[SI]
        ADD        SI,1
        CMP        AL,0

        JE        fin
        MOV        AH,0x0e              ; 显示一个文字
        MOV        BX,15                ; 指定字符颜色
        INT        0x10                 ; 调用显卡 BIOS
        JMP        putloop
fin:
        HLT                             ; 让 CPU 停止，等待指令
        JMP        fin                  ; 无限循环

msg:
        DB        0x0a, 0x0a            ; 换行 2 次
        DB        "hello, world"
        DB        0x0a                  ; 换行
        DB        0

        RESB    0x7dfe-$

        DB        0x55, 0xaa
