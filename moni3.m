/*
 ===========================================
 *	SC/MP-III Sample Program
 ===========================================
 */

#asm
; プリアンブル
; ------------
	  cpu 8070
	  org 0

wk1  = 0xff80
cnt1 = 0xff81
cnt2 = 0xff82

#endasm
// スタート
	 nop;
	 sp=0x8000;
	 jmp(main);

getc()
{
     db(2);
}
putc()
{
     db(3);
}
exit()
{
     db(4);
}

// メイン
main()
{
	p2=#msg1;puts();	

	p2=0;mdump();
	exit();

	while(1) {	
		getc();
		e=a;
		if(a!=0) break;
	}
	a=e;putc();	


	exit();
}

//  アスキーダンプ１行
ascdump_16()
{
	push(p2);
	p2=ea;
	ascdump_8();
	pr_spc();
	ascdump_8();
	pop(p2);
}

//  アスキーダンプ8byte
ascdump_8()
{
	a=8;cnt2=a;
	do {
		a=*p2++;
		ascdump1();
	} while(--cnt2);
}

//  アスキーダンプ1byte
ascdump1()
{
	e=a;
	if(a<#0x20) {
		a=' ';e=a;
	}
	a=e;
	if(a>=#0x7f) {
		a=' ';e=a;
	}
	a=e;putc();
}


//  メモリーダンプ
mdump()
{
	a=16;cnt1=a;
	do {
		mdump_16();
	} while(--cnt1);
}

//  メモリーダンプ16byte
mdump_16()
{
	ea=p2;
	prhex4();
	pr_spc();

	mdump_8();
	pr_spc();
	mdump_8();

// ASCII DUMP
	ea=p2;ea-=#16;
	ascdump_16();

	pr_crlf();
}

//  メモリーダンプ8byte
mdump_8()
{
	a=8;cnt2=a;
	do {
		a=*p2++;
		prhex2();
		pr_spc();
	} while(--cnt2);
}

//  EAレジスタを16進4桁表示
prhex4()
{
	a<>e;
	prhex2();
	a<>e;
	prhex2();
}

//  Aレジスタを16進2桁表示
prhex2()
{
	push(ea);
	e=a;
	a>>=1;
	a>>=1;
	a>>=1;
	a>>=1;
	prhex1();

	a=e;
	prhex1();
	pop(ea);
}

//  Aレジスタ下位4bitのみを16進1桁表示
prhex1()
{
	push(ea);
	a&=#0x0f;
	e=a;
	if( a >= 10) {
		a=e;a+=#7;
	}else{
		a=e;
	}
	a += #0x30;
	putc();
	pop(ea);
}
//  空白文字を1つ出力
pr_spc()
{
	a=' ';putc();
}

//  改行コード出力
pr_crlf()
{
	a=0x0d;putc();
	a=0x0a;putc();
}

//  文字列出力( P2 )ヌル終端.
puts()
{
	do {
		a=*p2++;
		if(a==0) break;
		putc();
	}while(1);	
}

//  文字列サンプル
msg1: 
	db("abcdefg");
	db(0x0d);
	db(0x0a);
	db(0);


//
