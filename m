From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?b?562U5aSNOiDnrZTlpI06IOetlOWkjTogbHR0bmcg?=
	=?utf-8?q?list_-u_coredump?=
Date: Wed, 23 Oct 2013 13:38:07 +0800
Message-ID: <c5bf2711-a6c2-4253-b2f7-576bef49de8d__6764.3592403785$1382506749$gmane$org@aliyun.com>
References: <7f26c4b5-6de0-46b8-8752-7c40d01e9655@aliyun.com> <",
	20130913140919.GA20034"@Krystal,
	ac1f03bd-cb96-43b1-8567-98684ab82191@aliyun.com>
	<00f8295a-e65f-4d53-8722-3f7c42f4ddd8@aliyun.com> <",
	1307757412.43408.1382023623436.JavaMail.zimbra"@efficios.com>
	<f5e3b3cb-118a-48b8-8fd6-29d63ee36e85@aliyun.com> <",
	1005237918.46514.1382347246419.JavaMail.zimbra"@efficios.com>
	<436ff36d-c5ec-464f-9f32-32137898f61d@aliyun.com>,
	917978419.47122.1382417967569.JavaMail.zimbra@efficios.com
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0494059156=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-318.freemail.mail.aliyun.com ([110.75.46.18])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zhenyu.ren@aliyun.com>) id 1VYr96-0008AW-Ko
	for lttng-dev@lists.lttng.org; Wed, 23 Oct 2013 01:38:18 -0400
In-Reply-To: 917978419.47122.1382417967569.JavaMail.zimbra@efficios.com
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0494059156==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_9171_48149940_526760bf_25654"

------=ALIBOUNDARY_9171_48149940_526760bf_25654
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>Can you point out what in the C99 specification makes you believe that the po=
inter is actually dereferenced in the expression "&(pos)->member" ?>AFAIK, thi=
s only evaluates to the address of field "member" within "pos". The compiler s=
hould not dereference the pointer "pos" at all.=0AYes,you are right.=0A=0A> Pr=
obably that getting it with a lttng-sessiond compiled with "-g -O0" (no optimi=
sations, with debug symbols) would help us make more sense out of the free() e=
rror output.=C2=A0Everything is ok f lttng-sessiond compiled with "-O0",so it =
looks like a compiler issue.with -O2 disassemble ust_app_list_events()0x000000=
0000418821 <ust_app_list_events+49>:=C2=A0=C2=A0=C2=A0 callq=C2=A0 0x403f60 <r=
cu_read_lock_memb@plt>=0A0x0000000000418826 <ust_app_list_events+54>:=C2=A0=C2=
=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x2441ab(%rip),%rax=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 # 0x65c9d8 <ust_app_ht>=0A0x000000000041882d <ust_app_list_eve=
nts+61>:=C2=A0=C2=A0=C2=A0 lea=C2=A0=C2=A0=C2=A0 0x230(%rsp),%rsi=0A0x00000000=
00418835 <ust_app_list_events+69>:=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 (%r=
ax),%rdi=0A0x0000000000418838 <ust_app_list_events+72>:=C2=A0=C2=A0=C2=A0 call=
q=C2=A0 0x403ba0 <lttng_cds_lfht_first@plt>=0A0x000000000041883d <ust_app_list=
_events+77>:=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 $0xffffffffffffffc8,%rax=0A=
0x0000000000418844 <ust_app_list_events+84>:=C2=A0=C2=A0=C2=A0 add=C2=A0=C2=A0=
=C2=A0 %fs:0x0,%rax=0A0x000000000041884d <ust_app_list_events+93>:=C2=A0=C2=A0=
=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x230(%rsp),%rbp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 //app->pid_n.node=0A0x0000000000418855 <ust_app_list_events+10=
1>:=C2=A0=C2=A0 movq=C2=A0=C2=A0 $0x20,0x28(%rsp)=0A0x000000000041885e <ust_ap=
p_list_events+110>:=C2=A0=C2=A0 movq=C2=A0=C2=A0 $0x0,0x30(%rsp)=0A0x000000000=
0418867 <ust_app_list_events+119>:=C2=A0=C2=A0 movq=C2=A0=C2=A0 $0x0,0x18(%rsp=
)=0A0x0000000000418870 <ust_app_list_events+128>:=C2=A0=C2=A0 add=C2=A0=C2=A0=C2=
=A0 $0x18,%rax=0A0x0000000000418874 <ust_app_list_events+132>:=C2=A0=C2=A0 sub=
=C2=A0=C2=A0=C2=A0 $0x78,%rbp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //app=0A0x0000000000418878 <ust_app_list_eve=
nts+136>:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rax,0x38(%rsp)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //inside loop=0A0x000000000041887d <ust_app_=
list_events+141>:=C2=A0=C2=A0 nopl=C2=A0=C2=A0 (%rax)=0A0x0000000000418880 <us=
t_app_list_events+144>:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x38(%rsp),%rax=0A0x=
0000000000418885 <ust_app_list_events+149>:=C2=A0=C2=A0 lock addq $0x2,(%rax)=0A=
0x000000000041888a <ust_app_list_events+154>:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0=
 0x34(%rbp),%eax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //app->=
compatible=0A0x000000000041888d <ust_app_list_events+157>:=C2=A0=C2=A0 test=C2=
=A0=C2=A0 %eax,%eax=0A0x000000000041888f <ust_app_list_events+159>:=C2=A0=C2=A0=
 je=C2=A0=C2=A0=C2=A0=C2=A0 0x418a00 <ust_app_list_events+528>=0A0x00000000004=
18895 <ust_app_list_events+165>:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x0(%rbp),%=
edi=0A0x0000000000418898 <ust_app_list_events+168>:=C2=A0=C2=A0 callq=C2=A0 0x=
4036f0 <ustctl_tracepoint_list@plt>=0A0x000000000041889d <ust_app_list_events+=
173>:=C2=A0=C2=A0 test=C2=A0=C2=A0 %eax,%eax=0A=C2=A0 As you may see,nothing c=
an prevent cpu from walking inside loop even if app is an invalid pointer.It s=
eems the=C2=A0 compiler=EF=BC=88GCC 4.1.2 20080704=EF=BC=89 always think &(pos=
)->member!=3DNULL. with -O0 disassemble ust_app_list_events()0x000000000041c64=
9 <ust_app_list_events+180>:=C2=A0=C2=A0 callq=C2=A0 0x404018 <rcu_read_lock_m=
emb@plt>=0A0x000000000041c64e <ust_app_list_events+185>:=C2=A0=C2=A0 mov=C2=A0=
=C2=A0=C2=A0 0x243ee3(%rip),%rax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 0=
x660538 <ust_app_ht>=0A0x000000000041c655 <ust_app_list_events+192>:=C2=A0=C2=A0=
 mov=C2=A0=C2=A0=C2=A0 (%rax),%rdi=0A0x000000000041c658 <ust_app_list_events+1=
95>:=C2=A0=C2=A0 lea=C2=A0=C2=A0=C2=A0 -0x70(%rbp),%rsi=0A0x000000000041c65c <=
ust_app_list_events+199>:=C2=A0=C2=A0 callq=C2=A0 0x403c48 <lttng_cds_lfht_fir=
st@plt>=0A0x000000000041c661 <ust_app_list_events+204>:=C2=A0=C2=A0 lea=C2=A0=C2=
=A0=C2=A0 -0x70(%rbp),%rdi=0A0x000000000041c665 <ust_app_list_events+208>:=C2=A0=
=C2=A0 callq=C2=A0 0x41701e <cds_lfht_iter_get_node>=0A0x000000000041c66a <ust=
_app_list_events+213>:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rax,-0x30(%rbp)=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //app->pid_n.node=0A0x000000000041c=
66e <ust_app_list_events+217>:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 -0x30(%rbp),%=
rax=0A0x000000000041c672 <ust_app_list_events+221>:=C2=A0=C2=A0 sub=C2=A0=C2=A0=
=C2=A0 $0x78,%rax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 //app=0A0x000000000041c676 <ust_app_list_events+225>:=C2=
=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 %rax,-0x48(%rbp)=0A0x000000000041c67a <ust_app=
_list_events+229>:=C2=A0=C2=A0 jmpq=C2=A0=C2=A0 0x41c9db <ust_app_list_events+=
1094>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //&(app)->pid_n.node!=3DNULL=0A0x000000000=
041c67f <ust_app_list_events+234>:=C2=A0=C2=A0 callq=C2=A0 0x418582 <health_co=
de_update>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
/inside loop=0A0x000000000041c684 <ust_app_list_events+239>:=C2=A0=C2=A0 mov=C2=
=A0=C2=A0=C2=A0 -0x48(%rbp),%rax=0A0x000000000041c688 <ust_app_list_events+243=
>:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 0x34(%rax),%eax=0A0x000000000041c68b <ust=
_app_list_events+246>:=C2=A0=C2=A0 test=C2=A0=C2=A0 %eax,%eax=0A0x000000000041=
c68d <ust_app_list_events+248>:=C2=A0=C2=A0 je=C2=A0=C2=A0=C2=A0=C2=A0 0x41c9a=
f <ust_app_list_events+1050>=0A0x000000000041c693 <ust_app_list_events+254>:=C2=
=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 -0x48(%rbp),%rax=0A0x000000000041c697 <ust_app=
_list_events+258>:=C2=A0=C2=A0 mov=C2=A0=C2=A0=C2=A0 (%rax),%edi=0A...=0A0x000=
000000041c9db <ust_app_list_events+1094>:=C2=A0 mov=C2=A0=C2=A0=C2=A0 -0x48(%r=
bp),%rax=C2=A0=C2=A0 //app--(pos)=0A0x000000000041c9df <ust_app_list_events+10=
98>:=C2=A0 add=C2=A0=C2=A0=C2=A0 $0x78,%rax=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //app->pid_n.node --(po=
s->member)=0A0x000000000041c9e3 <ust_app_list_events+1102>:=C2=A0 test=C2=A0=C2=
=A0 %rax,%rax=0A0x000000000041c9e6 <ust_app_list_events+1105>:=C2=A0 jne=C2=A0=
=C2=A0=C2=A0 0x41c67f <ust_app_list_events+234>=0AIn this case,the compiler wi=
ll do checking at 0x000000000041c9e3 that is missed in the previous case.Thank=
szhenyu.ren
------=ALIBOUNDARY_9171_48149940_526760bf_25654
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"">&gt;Can you point out=
 what in the C99 specification makes you believe that the pointer is actually =
dereferenced in the expression "&amp;(pos)-&gt;member" ?<br data-mce-bogus=3D"=
1"></div><div style=3D"">&gt;AFAIK, this only evaluates to the address of fiel=
d "member" within "pos". The compiler should not dereference the pointer "pos"=
 at all.<br></div><div style=3D""><br data-mce-bogus=3D"1"></div><div style=3D=
"">Yes,you are right.<br data-mce-bogus=3D"1"></div><div class=3D"__aliyun_sig=
nature_wrap"><br><br></div><div class=3D"__aliyun_signature_wrap">&gt; Probabl=
y that getting it with a lttng-sessiond compiled with "-g -O0" (no optimisatio=
ns, with debug symbols) would help us make more sense out of the free() error =
output.<br data-mce-bogus=3D"1"></div><div class=3D"__aliyun_signature_wrap"><=
br data-mce-bogus=3D"1"></div><div class=3D"__aliyun_signature_wrap">&nbsp;Eve=
rything is ok f lttng-sessiond compiled with "-O0",so it looks like a compiler=
 issue.<br data-mce-bogus=3D"1"></div><div class=3D"__aliyun_signature_wrap"><=
br data-mce-bogus=3D"1"></div><div class=3D"__aliyun_signature_wrap">with -O2 =
disassemble ust_app_list_events()<br data-mce-bogus=3D"1"></div><div class=3D"=
__aliyun_signature_wrap">0x0000000000418821 &lt;ust_app_list_events+49&gt;:&nb=
sp;&nbsp;&nbsp; callq&nbsp; 0x403f60 &lt;rcu_read_lock_memb@plt&gt;<br>0x00000=
00000418826 &lt;ust_app_list_events+54&gt;:&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&=
nbsp; 0x2441ab(%rip),%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # 0x65c9d8=
 &lt;ust_app_ht&gt;<br>0x000000000041882d &lt;ust_app_list_events+61&gt;:&nbsp=
;&nbsp;&nbsp; lea&nbsp;&nbsp;&nbsp; 0x230(%rsp),%rsi<br>0x0000000000418835 &lt=
;ust_app_list_events+69&gt;:&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; (%rax),%r=
di<br>0x0000000000418838 &lt;ust_app_list_events+72&gt;:&nbsp;&nbsp;&nbsp; cal=
lq&nbsp; 0x403ba0 &lt;lttng_cds_lfht_first@plt&gt;<br>0x000000000041883d &lt;u=
st_app_list_events+77&gt;:&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; $0xffffffff=
ffffffc8,%rax<br>0x0000000000418844 &lt;ust_app_list_events+84&gt;:&nbsp;&nbsp=
;&nbsp; add&nbsp;&nbsp;&nbsp; %fs:0x0,%rax<br>0x000000000041884d &lt;ust_app_l=
ist_events+93&gt;:&nbsp;&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x230(%rsp),%rbp&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //app-&gt;pid_n.node<br>0x000000=
0000418855 &lt;ust_app_list_events+101&gt;:&nbsp;&nbsp; movq&nbsp;&nbsp; $0x20=
,0x28(%rsp)<br>0x000000000041885e &lt;ust_app_list_events+110&gt;:&nbsp;&nbsp;=
 movq&nbsp;&nbsp; $0x0,0x30(%rsp)<br>0x0000000000418867 &lt;ust_app_list_event=
s+119&gt;:&nbsp;&nbsp; movq&nbsp;&nbsp; $0x0,0x18(%rsp)<br>0x0000000000418870 =
&lt;ust_app_list_events+128&gt;:&nbsp;&nbsp; add&nbsp;&nbsp;&nbsp; $0x18,%rax<=
br>0x0000000000418874 &lt;ust_app_list_events+132&gt;:&nbsp;&nbsp; sub&nbsp;&n=
bsp;&nbsp; $0x78,%rbp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; //app<br>0x0000000000418878 &lt;ust_app_list_event=
s+136&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; %rax,0x38(%rsp)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //inside loop<br>0x000000000041887d &lt;u=
st_app_list_events+141&gt;:&nbsp;&nbsp; nopl&nbsp;&nbsp; (%rax)<br>0x000000000=
0418880 &lt;ust_app_list_events+144&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x3=
8(%rsp),%rax<br>0x0000000000418885 &lt;ust_app_list_events+149&gt;:&nbsp;&nbsp=
; lock addq $0x2,(%rax)<br>0x000000000041888a &lt;ust_app_list_events+154&gt;:=
&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x34(%rbp),%eax&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; //app-&gt;compatible<br>0x000000000041888d &lt;ust_=
app_list_events+157&gt;:&nbsp;&nbsp; test&nbsp;&nbsp; %eax,%eax<br>0x000000000=
041888f &lt;ust_app_list_events+159&gt;:&nbsp;&nbsp; je&nbsp;&nbsp;&nbsp;&nbsp=
; 0x418a00 &lt;ust_app_list_events+528&gt;<br>0x0000000000418895 &lt;ust_app_l=
ist_events+165&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x0(%rbp),%edi<br>0x0000=
000000418898 &lt;ust_app_list_events+168&gt;:&nbsp;&nbsp; callq&nbsp; 0x4036f0=
 &lt;ustctl_tracepoint_list@plt&gt;<br>0x000000000041889d &lt;ust_app_list_eve=
nts+173&gt;:&nbsp;&nbsp; test&nbsp;&nbsp; %eax,%eax<br></div><div class=3D"__a=
liyun_previous_quote"><br class=3D"__aliyun_previous_quote"></div><div class=3D=
"__aliyun_previous_quote">&nbsp; As you may see,nothing can prevent cpu from w=
alking inside loop even if app is an invalid pointer.It seems the&nbsp; compil=
er=EF=BC=88GCC 4.1.2 20080704=EF=BC=89 always think &amp;(pos)-&gt;member!=3DN=
ULL. <br data-mce-bogus=3D"1"></div><div class=3D"__aliyun_previous_quote"><br=
 data-mce-bogus=3D"1"></div><div class=3D"__aliyun_previous_quote">with -O0 di=
sassemble ust_app_list_events()</div><div class=3D"__aliyun_previous_quote">0x=
000000000041c649 &lt;ust_app_list_events+180&gt;:&nbsp;&nbsp; callq&nbsp; 0x40=
4018 &lt;rcu_read_lock_memb@plt&gt;<br>0x000000000041c64e &lt;ust_app_list_eve=
nts+185&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x243ee3(%rip),%rax&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # 0x660538 &lt;ust_app_ht&gt;<br>0x000000000041=
c655 &lt;ust_app_list_events+192&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; (%rax)=
,%rdi<br>0x000000000041c658 &lt;ust_app_list_events+195&gt;:&nbsp;&nbsp; lea&n=
bsp;&nbsp;&nbsp; -0x70(%rbp),%rsi<br>0x000000000041c65c &lt;ust_app_list_event=
s+199&gt;:&nbsp;&nbsp; callq&nbsp; 0x403c48 &lt;lttng_cds_lfht_first@plt&gt;<b=
r>0x000000000041c661 &lt;ust_app_list_events+204&gt;:&nbsp;&nbsp; lea&nbsp;&nb=
sp;&nbsp; -0x70(%rbp),%rdi<br>0x000000000041c665 &lt;ust_app_list_events+208&g=
t;:&nbsp;&nbsp; callq&nbsp; 0x41701e &lt;cds_lfht_iter_get_node&gt;<br>0x00000=
0000041c66a &lt;ust_app_list_events+213&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp;=
 %rax,-0x30(%rbp)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //app-&gt;pi=
d_n.node<br>0x000000000041c66e &lt;ust_app_list_events+217&gt;:&nbsp;&nbsp; mo=
v&nbsp;&nbsp;&nbsp; -0x30(%rbp),%rax<br>0x000000000041c672 &lt;ust_app_list_ev=
ents+221&gt;:&nbsp;&nbsp; sub&nbsp;&nbsp;&nbsp; $0x78,%rax&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //app<br>0x00=
0000000041c676 &lt;ust_app_list_events+225&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nb=
sp; %rax,-0x48(%rbp)<br>0x000000000041c67a &lt;ust_app_list_events+229&gt;:&nb=
sp;&nbsp; jmpq&nbsp;&nbsp; 0x41c9db &lt;ust_app_list_events+1094&gt;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; //&amp;(app)-&gt;pid_n.node!=3DNULL<br>0x000000000041c67f=
 &lt;ust_app_list_events+234&gt;:&nbsp;&nbsp; callq&nbsp; 0x418582 &lt;health_=
code_update&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; //inside loop<br>0x000000000041c684 &lt;ust_app_list_events+239&gt;:&nbsp;=
&nbsp; mov&nbsp;&nbsp;&nbsp; -0x48(%rbp),%rax<br>0x000000000041c688 &lt;ust_ap=
p_list_events+243&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp; 0x34(%rax),%eax<br>0x=
000000000041c68b &lt;ust_app_list_events+246&gt;:&nbsp;&nbsp; test&nbsp;&nbsp;=
 %eax,%eax<br>0x000000000041c68d &lt;ust_app_list_events+248&gt;:&nbsp;&nbsp; =
je&nbsp;&nbsp;&nbsp;&nbsp; 0x41c9af &lt;ust_app_list_events+1050&gt;<br>0x0000=
00000041c693 &lt;ust_app_list_events+254&gt;:&nbsp;&nbsp; mov&nbsp;&nbsp;&nbsp=
; -0x48(%rbp),%rax<br>0x000000000041c697 &lt;ust_app_list_events+258&gt;:&nbsp=
;&nbsp; mov&nbsp;&nbsp;&nbsp; (%rax),%edi<br>...<br>0x000000000041c9db &lt;ust=
_app_list_events+1094&gt;:&nbsp; mov&nbsp;&nbsp;&nbsp; -0x48(%rbp),%rax&nbsp;&=
nbsp; //app--(pos)<br>0x000000000041c9df &lt;ust_app_list_events+1098&gt;:&nbs=
p; add&nbsp;&nbsp;&nbsp; $0x78,%rax&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //app-&gt;pid_n.node --(pos-&g=
t;member)<br>0x000000000041c9e3 &lt;ust_app_list_events+1102&gt;:&nbsp; test&n=
bsp;&nbsp; %rax,%rax<br>0x000000000041c9e6 &lt;ust_app_list_events+1105&gt;:&n=
bsp; jne&nbsp;&nbsp;&nbsp; 0x41c67f &lt;ust_app_list_events+234&gt;<br></div><=
div class=3D"__aliyun_previous_quote"><br data-mce-bogus=3D"1"></div><div clas=
s=3D"__aliyun_previous_quote">In this case,the compiler will do checking at 0x=
000000000041c9e3 that is missed in the previous case.<br data-mce-bogus=3D"1">=
</div><div class=3D"__aliyun_previous_quote"><br data-mce-bogus=3D"1"></div><d=
iv class=3D"__aliyun_previous_quote">Thanks<br data-mce-bogus=3D"1"></div><div=
 class=3D"__aliyun_previous_quote">zhenyu.ren<br data-mce-bogus=3D"1"></div><d=
iv class=3D"__aliyun_previous_quote"><br data-mce-bogus=3D"1"></div><div class=
=3D"__aliyun_previous_quote"><br data-mce-bogus=3D"1"></div></div>
------=ALIBOUNDARY_9171_48149940_526760bf_25654--



--===============0494059156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0494059156==--
