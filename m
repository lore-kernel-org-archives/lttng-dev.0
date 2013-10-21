From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: =?utf-8?b?562U5aSNOiBsdHRuZyBsaXN0IC11IGNvcmVkdW1w?=
Date: Mon, 21 Oct 2013 09:20:46 +0000 (UTC)
Message-ID: <1005237918.46514.1382347246419.JavaMail.zimbra__38653.3593912192$1382347318$gmane$org@efficios.com>
References: <7f26c4b5-6de0-46b8-8752-7c40d01e9655@aliyun.com> <",
	20130913140919.GA20034"@Krystal,
	ac1f03bd-cb96-43b1-8567-98684ab82191@aliyun.com>
	<00f8295a-e65f-4d53-8722-3f7c42f4ddd8@aliyun.com> <",
	1307757412.43408.1382023623436.JavaMail.zimbra"@efficios.com>
	<f5e3b3cb-118a-48b8-8fd6-29d63ee36e85@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1426145142=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VYBfO-0001A7-SZ
	for lttng-dev@lists.lttng.org; Mon, 21 Oct 2013 05:20:55 -0400
In-Reply-To: <f5e3b3cb-118a-48b8-8fd6-29d63ee36e85@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>, David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1426145142==
Content-Type: multipart/alternative;
	boundary="----=_Part_46513_154026479.1382347246417"

------=_Part_46513_154026479.1382347246417
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zhenyu,=20

Added lttng-dev mailing list to CC.=20

----- Original Message -----

> From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Monday, October 21, 2013 9:41:39 AM
> Subject: =E7=AD=94=E5=A4=8D: lttng list -u coredump

> Hi,Mathieu
> I have known why lttng-sessiond coredumps. Suppose lfhash table to be emp=
ty :

> int ust_app_list_events(struct lttng_event **events)
> ...
> cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
> ...

> #define cds_lfht_for_each_entry(ht, iter, pos, member)\
> for (cds_lfht_first(ht, iter),\
> pos =3D caa_container_of(cds_lfht_iter_get_node(iter), \
> __typeof__(*(pos)), member);\
> &(pos)->member !=3D NULL;\

> ...

> If cds_lfht_iter_get_node(iter) returns NULL,then pos points to an unvali=
d
> value ,this is where core happens.

The NULL check will ensure that this "invalid" value is never actually dere=
ferenced:=20

whenever cds_lfht_first() populates the iterator "iter" with a NULL node, t=
he "pos" returned by caa_container_of() will be a very large pointer value =
which corresponds to a structure where the lfht node fields is the NULL poi=
nter. Therefore, the &(pos)->member !=3D NULL check will break out of the l=
oop immediately,=20

For the backtrace I see below, it appears that there might be mixup with re=
spect to struct ust_app hash table node usage somewhere. I don't see where =
for the moment. David, any idea ?=20

could be a mixup between:=20
struct lttng_ht_node_ulong pid_n;=20
struct lttng_ht_node_ulong sock_n;=20
struct lttng_ht_node_ulong notify_sock_n;=20
causing the start of loop not to succeed its NULL pointer check.=20

Please provide details about the lttng-tools, lttng-ust, lttng-modules, use=
rspace RCU versions you are using.=20

Thanks,=20

Mathieu=20

> thanks
> zhenyu.ren

> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyers@=
efficios.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2013=E5=B9=B410=E6=9C=8817=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 23:27
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>
> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: lttng list -u coredump

> Please ask this on lttng-dev@lists.lttng.org, or open a bug report report=
 on
> bugs.lttng.org, detailing versions used and detailing the error you
> encounter.

> Thanks,

> Mathieu

> ----- Original Message -----

> > From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
>=20
> > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>=20
> > Sent: Thursday, October 17, 2013 4:56:52 AM
>=20
> > Subject: lttng list -u coredump
>=20

> > Hi,Mathieu
>=20
> > regardless or not running as root,lttng list -u coredumps
>=20
> > #lttng list -u
>=20
> > Spawning a session daemon
>=20
> > FATAL: Module lttng_tracer not found.
>=20
> > Error: Unable to load module lttng-tracer
>=20
> > Error: Unable to remove module lttng-tracer
>=20
> > Warning: No kernel tracer available
>=20
> > Warning: No tracing group detected
>=20
> > Error: Session daemon died (exit status 0)
>=20
> > UST events:
>=20
> > -------------
>=20
> > None
>=20

> > *** glibc detected *** lttng: free(): invalid pointer: 0x000000000061ad=
00
> > ***
>=20
> > =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> > /lib64/libc.so.6[0x34b64722ef]
>=20
> > /lib64/libc.so.6(cfree+0x4b)[0x34b647273b]
>=20
> > lttng[0x404ef9]
>=20
> > lttng[0x40cf6a]
>=20
> > /lib64/libc.so.6(__libc_start_main+0xf4)[0x34b641d994]
>=20
> > lttng[0x403109]
>=20
> > =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> > 00400000-0041a000 r-xp 00000000 08:02 2494453 /usr/local/bin/lttng
>=20
> > 00619000-0061b000 rw-p 00019000 08:02 2494453 /usr/local/bin/lttng
>=20
> > 0061b000-0063d000 rw-p 00000000 00:00 0 [heap]
>=20
> > 34b6000000-34b601c000 r-xp 00000000 08:02 1884196 /lib64/ld-2.5.so
>=20
> > 34b621b000-34b621c000 r--p 0001b000 08:02 1884196 /lib64/ld-2.5.so
>=20
> > 34b621c000-34b621d000 rw-p 0001c000 08:02 1884196 /lib64/ld-2.5.so
>=20
> > 34b6400000-34b654d000 r-xp 00000000 08:02 1884473 /lib64/libc-2.5.so
>=20
> > 34b654d000-34b674d000 ---p 0014d000 08:02 1884473 /lib64/libc-2.5.so
>=20
> > 34b674d000-34b6751000 r--p 0014d000 08:02 1884473 /lib64/libc-2.5.so
>=20
> > 34b6751000-34b6752000 rw-p 00151000 08:02 1884473 /lib64/libc-2.5.so
>=20
> > 34b6752000-34b6757000 rw-p 00000000 00:00 0
>=20
> > 34b6800000-34b6802000 r-xp 00000000 08:02 1884474 /lib64/libdl-2.5.so
>=20
> > 34b6802000-34b6a02000 ---p 00002000 08:02 1884474 /lib64/libdl-2.5.so
>=20
> > 34b6a02000-34b6a03000 r--p 00002000 08:02 1884474 /lib64/libdl-2.5.so
>=20
> > 34b6a03000-34b6a04000 rw-p 00003000 08:02 1884474 /lib64/libdl-2.5.so
>=20
> > 34b6c00000-34b6c16000 r-xp 00000000 08:02 1884478 /lib64/libpthread-2.5=
.so
>=20
> > 34b6c16000-34b6e15000 ---p 00016000 08:02 1884478 /lib64/libpthread-2.5=
.so
>=20
> > 34b6e15000-34b6e16000 r--p 00015000 08:02 1884478 /lib64/libpthread-2.5=
.so
>=20
> > 34b6e16000-34b6e17000 rw-p 00016000 08:02 1884478 /lib64/libpthread-2.5=
.so
>=20
> > 34b6e17000-34b6e1b000 rw-p 00000000 00:00 0
>=20
> > 34b7400000-34b7407000 r-xp 00000000 08:02 1884480 /lib64/librt-2.5.so
>=20
> > 34b7407000-34b7607000 ---p 00007000 08:02 1884480 /lib64/librt-2.5.so
>=20
> > 34b7607000-34b7608000 r--p 00007000 08:02 1884480 /lib64/librt-2.5.so
>=20
> > 34b7608000-34b7609000 rw-p 00008000 08:02 1884480 /lib64/librt-2.5.so
>=20
> > 34b8400000-34b840d000 r-xp 00000000 08:02 1884371
> > /lib64/libgcc_s-4.1.2-20080825.so.1
>=20
> > 34b840d000-34b860d000 ---p 0000d000 08:02 1884371
> > /lib64/libgcc_s-4.1.2-20080825.so.1
>=20
> > 34b860d000-34b860e000 rw-p 0000d000 08:02 1884371
> > /lib64/libgcc_s-4.1.2-20080825.so.1
>=20
> > 34b9400000-34b9407000 r-xp 00000000 08:02 2493847
> > /usr/lib64/libpopt.so.0.0.0
>=20
> > 34b9407000-34b9607000 ---p 00007000 08:02 2493847
> > /usr/lib64/libpopt.so.0.0.0
>=20
> > 34b9607000-34b9608000 rw-p 00007000 08:02 2493847
> > /usr/lib64/libpopt.so.0.0.0
>=20
> > 37a5e00000-37a5e04000 r-xp 00000000 08:02 1884499 /lib64/libuuid.so.1.2
>=20
> > 37a5e04000-37a6003000 ---p 00004000 08:02 1884499 /lib64/libuuid.so.1.2
>=20
> > 37a6003000-37a6004000 rw-p 00003000 08:02 1884499 /lib64/libuuid.so.1.2
>=20
> > 7f596db29000-7f596db2d000 rw-p 00000000 00:00 0
>=20
> > 7f596db2d000-7f596db32000 r-xp 00000000 08:02 2296098
> > /usr/local/lib/liburcu.so.2.0.0
>=20
> > 7f596db32000-7f596dd31000 ---p 00005000 08:02 2296098
> > /usr/local/lib/liburcu.so.2.0.0
>=20
> > 7f596dd31000-7f596dd32000 rw-p 00004000 08:02 2296098
> > /usr/local/lib/liburcu.so.2.0.0
>=20
> > 7f596dd32000-7f596dd33000 rw-p 00000000 00:00 0
>=20
> > 7f596dd33000-7f596dd36000 r-xp 00000000 08:02 2296094
> > /usr/local/lib/liburcu-common.so.2.0.0
>=20
> > 7f596dd36000-7f596df35000 ---p 00003000 08:02 2296094
> > /usr/local/lib/liburcu-common.so.2.0.0
>=20
> > 7f596df35000-7f596df36000 rw-p 00002000 08:02 2296094
> > /usr/local/lib/liburcu-common.so.2.0.0
>=20
> > 7f596df49000-7f596df4a000 rw-p 00000000 00:00 0
>=20
> > 7f596df4a000-7f596df6d000 r-xp 00000000 08:02 2294055
> > /usr/local/lib/liblttng-ctl.so.0.0.0
>=20
> > 7f596df6d000-7f596e16c000 ---p 00023000 08:02 2294055
> > /usr/local/lib/liblttng-ctl.so.0.0.0
>=20
> > 7f596e16c000-7f596e16e000 rw-p 00022000 08:02 2294055
> > /usr/local/lib/liblttng-ctl.so.0.0.0
>=20
> > 7f596e16e000-7f596e170000 rw-p 00000000 00:00 0
>=20
> > 7f596e170000-7f596e171000 r-xp 00000000 08:02 1427686
> > /home/tops/lib/snoopy.so
>=20
> > 7f596e171000-7f596e371000 ---p 00001000 08:02 1427686
> > /home/tops/lib/snoopy.so
>=20
> > 7f596e371000-7f596e372000 rw-p 00001000 08:02 1427686
> > /home/tops/lib/snoopy.so
>=20
> > 7f596e372000-7f596e375000 rw-p 00000000 00:00 0
>=20
> > 7fffe92bf000-7fffe92d4000 rw-p 00000000 00:00 0 [stack]
>=20
> > 7fffe93ff000-7fffe9400000 r-xp 00000000 00:00 0 [vdso]
>=20
> > ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0 [vsyscall]
>=20
> > Aborted (core dumped)
>=20
> > $ls -l core.12535*
>=20
> > -rw------- 1 root root 471040 Oct 17 16:46 core.125350
>=20
> > -rw------- 1 root root 84475904 Oct 17 16:46 core.125351
>=20
> > #file core.12535*
>=20
> > core.125350: ELF 64-bit LSB core file AMD x86-64, version 1 (SYSV),
> > SVR4-style, from 'lttng'
>=20
> > core.125351: ELF 64-bit LSB core file AMD x86-64, version 1 (SYSV),
> > SVR4-style, from 'lttng-sessiond'
>=20
> > #gdb --core=3D./core.125351 /usr/local/bin/lttng-sessiond
>=20
> > warning: Can't read pathname for load map: Input/output error.
>=20
> > Reading symbols from /home/tops/lib/snoopy.so...done.
>=20
> > ...
>=20
> > Core was generated by `lttng-sessiond --sig-parent --quiet'.
>=20
> > Program terminated with signal 11, Segmentation fault.
>=20
> > [New process 125356]
>=20
> > [New process 125358]
>=20
> > [New process 125359]
>=20
> > [New process 125361]
>=20
> > [New process 125351]
>=20
> > [New process 125354]
>=20
> > [New process 125357]
>=20
> > [New process 125360]
>=20
> > [New process 125355]
>=20
> > #0 ust_app_list_events (events=3D0x40a62e10) at ust-app.c:3026
>=20
> > 3026 if (!app->compatible) {
>=20
> > (gdb) p ust_app_ht
>=20
> > $1 =3D (struct lttng_ht *) 0x65d030
>=20
> > (gdb) p ust_app_ht->ht
>=20
> > $2 =3D (struct cds_lfht *) 0x65d0a0
>=20
> > (gdb) p *(ust_app_ht->ht)
>=20
> > $7 =3D {max_nr_buckets =3D 9223372036854775808, mm =3D 0x7f297bd6ac20, =
flavor =3D
> > 0x7f297b9445e0, count =3D 0, resize_mutex =3D {__data =3D {__lock =3D 0=
, __count =3D
> > 0, __owner =3D 0,
>=20
> > __nusers =3D 0, __kind =3D 0, __spins =3D 0, __list =3D {__prev =3D 0x0=
, __next =3D
> > 0x0}}, __size =3D '\0' <repeats 39 times>, __align =3D 0}, resize_attr =
=3D 0x0,
>=20
> > in_progress_resize =3D 0, in_progress_destroy =3D 0, resize_target =3D =
4,
> > resize_initiated =3D 0, flags =3D 3, min_alloc_buckets_order =3D 0,
> > min_nr_alloc_buckets =3D 1,
>=20
> > split_count =3D 0x65d340, size =3D 4, bucket_at =3D 0x7f297bb5aa50 <buc=
ket_at>,
> > {tbl_order =3D {0x65d050, 0x65e350, 0x65e370, 0x0 <repeats 61 times>},
> > tbl_chunk =3D 0x65d130,
>=20
> > tbl_mmap =3D 0x65d050}}
>=20
> > (gdb) p app
>=20
> > $8 =3D (struct ust_app *) 0xffffffffffffff88
>=20
> > Since rcu hash table is unkown to me now,Could you please give me any
> > advices
> > on how to look at this issue?
>=20
> > thanks in advance
>=20
> > zhenyu.ren
>=20

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_46513_154026479.1382347246417
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Hi Zhenyu,<br></div><div><br></d=
iv><div>Added lttng-dev mailing list to CC.<br></div><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-=
mce-style=3D"border-left: 2px solid #1010FF; margin-left: 5px; padding-left=
: 5px; color: #000; font-weight: normal; font-style: normal; text-decoratio=
n: none; font-family: Helvetica,Arial,sans-serif; font-size: 12pt;"><b>From=
: </b>"zhenyu.ren" &lt;zhenyu.ren@aliyun.com&gt;<br><b>To: </b>"Mathieu Des=
noyers" &lt;mathieu.desnoyers@efficios.com&gt;<br><b>Sent: </b>Monday, Octo=
ber 21, 2013 9:41:39 AM<br><b>Subject: </b>=E7=AD=94=E5=A4=8D: lttng list -=
u coredump<br><div><br></div><div class=3D"__aliyun_email_body_block"><div =
style=3D"" data-mce-style=3D"">Hi,Mathieu</div><div style=3D"" data-mce-sty=
le=3D"">&nbsp; I have known why lttng-sessiond coredumps. Suppose lfhash ta=
ble to be empty :</div><div style=3D"" data-mce-style=3D""><br></div><div s=
tyle=3D"" data-mce-style=3D"">int ust_app_list_events(struct lttng_event **=
events)</div><div style=3D"" data-mce-style=3D"">...</div><div style=3D"" d=
ata-mce-style=3D"">cds_lfht_for_each_entry(ust_app_ht-&gt;ht, &amp;iter.ite=
r, app, pid_n.node) {</div><div style=3D"" data-mce-style=3D"">...</div><di=
v style=3D"" data-mce-style=3D""><br></div><div style=3D"" data-mce-style=
=3D""><br></div><div class=3D"__aliyun_signature_wrap"><div><div>#define cd=
s_lfht_for_each_entry(ht, iter, pos, member)\</div><div>for (cds_lfht_first=
(ht, iter),\</div><div>pos =3D caa_container_of(cds_lfht_iter_get_node(iter=
), \</div><div>__typeof__(*(pos)), member);\</div><div>&amp;(pos)-&gt;membe=
r !=3D NULL;\</div><div><br></div></div><div>...</div><div><br></div><div>I=
f&nbsp;&nbsp;cds_lfht_iter_get_node(iter) returns NULL,then pos points to a=
n unvalid value ,this is where core happens.</div></div></div></blockquote>=
<div><br></div><div>The NULL check will ensure that this "invalid" value is=
 never actually dereferenced:<br></div><div><br></div><div>whenever cds_lfh=
t_first() populates the iterator "iter" with a NULL node, the "pos" returne=
d by caa_container_of() will be a very large pointer value which correspond=
s to a structure where the lfht node fields is the NULL pointer. Therefore,=
 the &amp;(pos)-&gt;member !=3D NULL check will break out of the loop immed=
iately,<br></div><div><br></div><div>For the backtrace I see below, it appe=
ars that there might be mixup with respect to struct ust_app hash table nod=
e usage somewhere. I don't see where for the moment. David, any idea ?<br><=
/div><div><br></div><div>could be a mixup between:<br></div><div>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct lttng_ht_node_ulong pid_n;<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct lttng_ht_node_ulong sock_n;<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct lttng_ht_node_ulong noti=
fy_sock_n;<br></div><div>causing the start of loop not to succeed its NULL =
pointer check.<br></div><div><br></div><div>Please provide details about th=
e lttng-tools, lttng-ust, lttng-modules, userspace RCU versions you are usi=
ng.<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathi=
eu<br></div><div><br></div><div><br></div><div><br></div><div><br></div><bl=
ockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-lef=
t:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;=
font-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"b=
order-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; color: =
#000; font-weight: normal; font-style: normal; text-decoration: none; font-=
family: Helvetica,Arial,sans-serif; font-size: 12pt;"><div class=3D"__aliyu=
n_email_body_block"><div class=3D"__aliyun_signature_wrap"><div><br></div><=
div>thanks</div><div>zhenyu.ren</div><br><div><br></div></div><div class=3D=
"__aliyun_previous_quote">-------------------------------------------------=
-----------------<br>=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers =
&lt;mathieu.desnoyers@efficios.com&gt;<br>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=
=B4=EF=BC=9A2013=E5=B9=B410=E6=9C=8817=E6=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B=
) 23:27<br>=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren &lt;zhenyu.ren@al=
iyun.com&gt;<br>=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: lttng list -u cored=
ump<br><div><br></div><div style=3D"font-family: times new roman , new york=
 , times , serif;font-size: 12.0pt;color: #000000;" data-mce-style=3D"font-=
family: times new roman , new york , times , serif; font-size: 12.0pt; colo=
r: #000000;"><div>Please ask this on lttng-dev@lists.lttng.org, or open a b=
ug report report on bugs.lttng.org, detailing versions used and detailing t=
he error you encounter.<br></div><div><br></div><div>Thanks,<br></div><div>=
<br></div><div>Mathieu<br></div><div><br></div><hr id=3D"zwchr"><blockquote=
 style=3D"border-left: 2.0px solid #1010ff;margin-left: 5.0px;padding-left:=
 5.0px;color: #000000;font-weight: normal;font-style: normal;text-decoratio=
n: none;font-family: helvetica , arial , sans-serif;font-size: 12.0pt;" dat=
a-mce-style=3D"border-left: 2.0px solid #1010ff; margin-left: 5.0px; paddin=
g-left: 5.0px; color: #000000; font-weight: normal; font-style: normal; tex=
t-decoration: none; font-family: helvetica , arial , sans-serif; font-size:=
 12.0pt;"><b>From: </b>"zhenyu.ren" &lt;zhenyu.ren@aliyun.com&gt;<br><b>To:=
 </b>"Mathieu Desnoyers" &lt;mathieu.desnoyers@efficios.com&gt;<br><b>Sent:=
 </b>Thursday, October 17, 2013 4:56:52 AM<br><b>Subject: </b>lttng list -u=
 coredump<br><div><br></div><div class=3D"__aliyun_email_body_block"><div>H=
i,Mathieu</div><div>&nbsp;&nbsp; regardless or not running as root,lttng li=
st -u coredumps</div><div>#lttng list -u<br>Spawning a session daemon<br>FA=
TAL: Module lttng_tracer not found.<br>Error: Unable to load module lttng-t=
racer<br>Error: Unable to remove module lttng-tracer<br>Warning: No kernel =
tracer available<br>Warning: No tracing group detected<br>Error: Session da=
emon died (exit status 0)<br>UST events:<br>-------------<br>None<br><div><=
br></div>*** glibc detected *** lttng: free(): invalid pointer: 0x000000000=
061ad00 ***<br>=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>/lib64/libc.so.6[0x34b64722ef]<br>/lib64/libc.so.6(cfree+0x4b)[0x34b647=
273b]<br>lttng[0x404ef9]<br>lttng[0x40cf6a]<br>/lib64/libc.so.6(__libc_star=
t_main+0xf4)[0x34b641d994]<br>lttng[0x403109]<br>=3D=3D=3D=3D=3D=3D=3D Memo=
ry map: =3D=3D=3D=3D=3D=3D=3D=3D<br>00400000-0041a000 r-xp 00000000 08:02 2=
494453&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /usr/local/bin/lttng<br>00619000-0061b000 rw-p 00019000 =
08:02 2494453&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /usr/local/bin/lttng<br>0061b000-0063d000 rw-p 00=
000000 00:00 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [heap]<br>34=
b6000000-34b601c000 r-xp 00000000 08:02 1884196&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/ld-2.5.so<br>34b621b000-34b621c0=
00 r--p 0001b000 08:02 1884196&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /lib64/ld-2.5.so<br>34b621c000-34b621d000 rw-p 0001c000 =
08:02 1884196&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /lib64/ld-2.5.so<br>34b6400000-34b654d000 r-xp 00000000 08:02 1884473&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libc-2.5=
.so<br>34b654d000-34b674d000 ---p 0014d000 08:02 1884473&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libc-2.5.so<br>34b674d0=
00-34b6751000 r--p 0014d000 08:02 1884473&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libc-2.5.so<br>34b6751000-34b6752000 r=
w-p 00151000 08:02 1884473&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /lib64/libc-2.5.so<br>34b6752000-34b6757000 rw-p 00000000 00=
:00 0<br>34b6800000-34b6802000 r-xp 00000000 08:02 1884474&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libdl-2.5.so<br>34b68=
02000-34b6a02000 ---p 00002000 08:02 1884474&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libdl-2.5.so<br>34b6a02000-34b6a030=
00 r--p 00002000 08:02 1884474&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /lib64/libdl-2.5.so<br>34b6a03000-34b6a04000 rw-p 000030=
00 08:02 1884474&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /lib64/libdl-2.5.so<br>34b6c00000-34b6c16000 r-xp 00000000 08:02 18844=
78&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/li=
bpthread-2.5.so<br>34b6c16000-34b6e15000 ---p 00016000 08:02 1884478&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libpthread-=
2.5.so<br>34b6e15000-34b6e16000 r--p 00015000 08:02 1884478&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libpthread-2.5.so<br=
>34b6e16000-34b6e17000 rw-p 00016000 08:02 1884478&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libpthread-2.5.so<br>34b6e170=
00-34b6e1b000 rw-p 00000000 00:00 0<br>34b7400000-34b7407000 r-xp 00000000 =
08:02 1884480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /lib64/librt-2.5.so<br>34b7407000-34b7607000 ---p 00007000 08:02 1884480&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/librt=
-2.5.so<br>34b7607000-34b7608000 r--p 00007000 08:02 1884480&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/librt-2.5.so<br>34b=
7608000-34b7609000 rw-p 00008000 08:02 1884480&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/librt-2.5.so<br>34b8400000-34b840=
d000 r-xp 00000000 08:02 1884371&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /lib64/libgcc_s-4.1.2-20080825.so.1<br>34b840d000-34b8=
60d000 ---p 0000d000 08:02 1884371&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; /lib64/libgcc_s-4.1.2-20080825.so.1<br>34b860d000-34=
b860e000 rw-p 0000d000 08:02 1884371&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libgcc_s-4.1.2-20080825.so.1<br>34b9400000-=
34b9407000 r-xp 00000000 08:02 2493847&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; /usr/lib64/libpopt.so.0.0.0<br>34b9407000-34b960=
7000 ---p 00007000 08:02 2493847&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; /usr/lib64/libpopt.so.0.0.0<br>34b9607000-34b9608000 r=
w-p 00007000 08:02 2493847&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /usr/lib64/libpopt.so.0.0.0<br>37a5e00000-37a5e04000 r-xp 00=
000000 08:02 1884499&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /lib64/libuuid.so.1.2<br>37a5e04000-37a6003000 ---p 00004000 08:02=
 1884499&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /li=
b64/libuuid.so.1.2<br>37a6003000-37a6004000 rw-p 00003000 08:02 1884499&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lib64/libuuid.=
so.1.2<br>7f596db29000-7f596db2d000 rw-p 00000000 00:00 0<br>7f596db2d000-7=
f596db32000 r-xp 00000000 08:02 2296098&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /usr/local/lib/liburcu.so.2.0.0<br>7f596db32000-7f596dd31000 ---p 00005=
000 08:02 2296098&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/local/lib/lib=
urcu.so.2.0.0<br>7f596dd31000-7f596dd32000 rw-p 00004000 08:02 2296098&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/local/lib/liburcu.so.2.0.0<br>7f596=
dd32000-7f596dd33000 rw-p 00000000 00:00 0<br>7f596dd33000-7f596dd36000 r-x=
p 00000000 08:02 2296094&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/local/=
lib/liburcu-common.so.2.0.0<br>7f596dd36000-7f596df35000 ---p 00003000 08:0=
2 2296094&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/local/lib/liburcu-com=
mon.so.2.0.0<br>7f596df35000-7f596df36000 rw-p 00002000 08:02 2296094&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/local/lib/liburcu-common.so.2.0.0<br=
>7f596df49000-7f596df4a000 rw-p 00000000 00:00 0<br>7f596df4a000-7f596df6d0=
00 r-xp 00000000 08:02 2294055&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/=
local/lib/liblttng-ctl.so.0.0.0<br>7f596df6d000-7f596e16c000 ---p 00023000 =
08:02 2294055&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/local/lib/liblttn=
g-ctl.so.0.0.0<br>7f596e16c000-7f596e16e000 rw-p 00022000 08:02 2294055&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /usr/local/lib/liblttng-ctl.so.0.0.0<br=
>7f596e16e000-7f596e170000 rw-p 00000000 00:00 0<br>7f596e170000-7f596e1710=
00 r-xp 00000000 08:02 1427686&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /home=
/tops/lib/snoopy.so<br>7f596e171000-7f596e371000 ---p 00001000 08:02 142768=
6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /home/tops/lib/snoopy.so<br>7f596e=
371000-7f596e372000 rw-p 00001000 08:02 1427686&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /home/tops/lib/snoopy.so<br>7f596e372000-7f596e375000 rw-p 0000=
0000 00:00 0<br>7fffe92bf000-7fffe92d4000 rw-p 00000000 00:00 0&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [stack]<br>=
7fffe93ff000-7fffe9400000 r-xp 00000000 00:00 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [vdso]<br>ffffffffff600000-=
ffffffffff601000 r-xp 00000000 00:00 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [vsyscall=
]<br>Aborted (core dumped)</div><div>$ls -l core.12535*<br>-rw------- 1 roo=
t root&nbsp;&nbsp; 471040 Oct 17 16:46 core.125350<br>-rw------- 1 root roo=
t 84475904 Oct 17 16:46 core.125351</div><div>#file core.12535*<br>core.125=
350: ELF 64-bit LSB core file AMD x86-64, version 1 (SYSV), SVR4-style, fro=
m 'lttng'<br>core.125351: ELF 64-bit LSB core file AMD x86-64, version 1 (S=
YSV), SVR4-style, from 'lttng-sessiond'</div><div>#gdb --core=3D./core.1253=
51 /usr/local/bin/lttng-sessiond</div><div>warning: Can't read pathname for=
 load map: Input/output error.<br>Reading symbols from /home/tops/lib/snoop=
y.so...done.</div><div>...</div><div>Core was generated by `lttng-sessiond =
--sig-parent --quiet'.<br>Program terminated with signal 11, Segmentation f=
ault.<br>[New process 125356]<br>[New process 125358]<br>[New process 12535=
9]<br>[New process 125361]<br>[New process 125351]<br>[New process 125354]<=
br>[New process 125357]<br>[New process 125360]<br>[New process 125355]<br>=
#0&nbsp; ust_app_list_events (events=3D0x40a62e10) at ust-app.c:3026<br>302=
6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!app-&gt;compatible) {</div><d=
iv>(gdb) p ust_app_ht<br>$1 =3D (struct lttng_ht *) 0x65d030<br>(gdb) p ust=
_app_ht-&gt;ht<br>$2 =3D (struct cds_lfht *) 0x65d0a0</div><div>(gdb) p *(u=
st_app_ht-&gt;ht)<br>$7 =3D {max_nr_buckets =3D 9223372036854775808, mm =3D=
 0x7f297bd6ac20, flavor =3D 0x7f297b9445e0, count =3D 0, resize_mutex =3D {=
__data =3D {__lock =3D 0, __count =3D 0, __owner =3D 0,<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; __nusers =3D 0, __kind =3D 0, __spins =3D 0, __list =3D {__p=
rev =3D 0x0, __next =3D 0x0}}, __size =3D '\0' &lt;repeats 39 times&gt;, __=
align =3D 0}, resize_attr =3D 0x0,<br>&nbsp; in_progress_resize =3D 0, in_p=
rogress_destroy =3D 0, resize_target =3D 4, resize_initiated =3D 0, flags =
=3D 3, min_alloc_buckets_order =3D 0, min_nr_alloc_buckets =3D 1,<br>&nbsp;=
 split_count =3D 0x65d340, size =3D 4, bucket_at =3D 0x7f297bb5aa50 &lt;buc=
ket_at&gt;, {tbl_order =3D {0x65d050, 0x65e350, 0x65e370, 0x0 &lt;repeats 6=
1 times&gt;}, tbl_chunk =3D 0x65d130,<br>&nbsp;&nbsp;&nbsp; tbl_mmap =3D 0x=
65d050}}</div><div>(gdb) p app<br>$8 =3D (struct ust_app *) 0xfffffffffffff=
f88</div><div>&nbsp;&nbsp; Since rcu hash table is unkown to me now,Could y=
ou please give me any advices on how to look at this issue?</div><div>thank=
s in advance</div><div>zhenyu.ren</div></div></blockquote><div><br><div><br=
></div></div><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<br>Eff=
iciOS Inc.<br>http://www.efficios.com<br></div></div></div></div></blockquo=
te><div><br><div><br></div></div><div><br></div><div>-- <br></div><div><spa=
n name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effici=
os.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_46513_154026479.1382347246417--


--===============1426145142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1426145142==--
