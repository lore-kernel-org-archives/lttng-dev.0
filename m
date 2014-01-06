From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [UST] SIGSEGV in lttng_ust_exit()
Date: Mon, 6 Jan 2014 20:44:13 +0000 (UTC)
Message-ID: <653943812.4048.1389041053865.JavaMail.zimbra__42342.3791108236$1389041132$gmane$org@efficios.com>
References: <OF99872887.58F6C4DA-ONC2257C4C.00466CBF-C2257C4C.00474033@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0832109951=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1W0H25-0003RN-Gw
	for lttng-dev@lists.lttng.org; Mon, 06 Jan 2014 15:44:27 -0500
In-Reply-To: <OF99872887.58F6C4DA-ONC2257C4C.00466CBF-C2257C4C.00474033@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0832109951==
Content-Type: multipart/alternative;
	boundary="----=_Part_4047_471777448.1389041053864"

------=_Part_4047_471777448.1389041053864
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

Can you try with updated lttng-ust (2.3.1 and stable-2.3 branch head) and update userspace RCU (0.8.1 and stable-0.8 head). 

Thanks, 

Mathieu 

----- Original Message -----

> From: "Amit Margalit" <AMITM@il.ibm.com>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Wednesday, December 25, 2013 7:58:05 AM
> Subject: [lttng-dev] [UST] SIGSEGV in lttng_ust_exit()

> Hi,

> Using 2.3.0, we have a daemon process that's being restarted. The process is
> being asked to terminate using a simple 'kill', i.e. SIGTERM.

> Here is most of the traceback - any help is appreciated.

> .424636] ===26292=== #2 crash_sig_handler (sig=11, info=0xb519f0,
> uc=<optimized out>) at common/crashandler/crashandler_client.c:139
> .424671] ===26292=== #3 <signal handler called>
> .424730] ===26292=== #4 0x00007f4c2cb57831 in pthread_cancel () from
> /lib64/libpthread.so.0
> .424788] ===26292=== #5 0x00007f4c2dec428e in lttng_ust_exit () at
> lttng-ust-comm.c:1296
> .424846] ===26292=== #6 0x00007f4c2e310469 in _dl_fini () from
> /lib64/ld-linux-x86-64.so.2
> .424904] ===26292=== #7 0x00007f4c2c4135e5 in __run_exit_handlers () from
> /lib64/libc.so.6
> .424954] ===26292=== #8 0x00007f4c2c413635 in exit () from /lib64/libc.so.6
> .425011] ===26292=== #9 0x00007f4c2c3fcbcd in __libc_start_main () from
> /lib64/libc.so.6
> .425072] ===26292=== #10 0x000000000041cd49 in _start () at
> ../sysdeps/x86_64/elf/start.S:113

> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03 -689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_4047_471777448.1389041053864
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Hi,</div><div><br></div><div>Can=
 you try with updated lttng-ust (2.3.1 and stable-2.3 branch head) and upda=
te userspace RCU (0.8.1 and stable-0.8 head).<br></div><div><br></div><div>=
Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><=
br></div><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010F=
F;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt;"><b>From: </b>"Amit Margalit" &lt;AMITM@il.ibm.com&gt;<br><b>To: <=
/b>"lttng-dev" &lt;lttng-dev@lists.lttng.org&gt;<br><b>Sent: </b>Wednesday,=
 December 25, 2013 7:58:05 AM<br><b>Subject: </b>[lttng-dev] [UST] SIGSEGV =
in lttng_ust_exit()<br><div><br></div><tt><span style=3D"font-size: small;"=
 data-mce-style=3D"font-size: small;" size=3D"2">Hi,</span></tt>
<br>
<br><tt><span style=3D"font-size: small;" data-mce-style=3D"font-size: smal=
l;" size=3D"2">Using 2.3.0, we have a daemon process that's being
restarted. The process is being asked to terminate using a simple 'kill',
i.e. SIGTERM.</span></tt>
<br>
<br><tt><span style=3D"font-size: small;" data-mce-style=3D"font-size: smal=
l;" size=3D"2">Here is most of the traceback - any help is appreciated.</sp=
an></tt>
<br>
<br><tt><span style=3D"font-size: small;" data-mce-style=3D"font-size: smal=
l;" size=3D"2">.424636] =3D=3D=3D26292=3D=3D=3D #2 crash_sig_handler (sig=
=3D11,
info=3D0xb519f0, uc=3D&lt;optimized out&gt;) at common/crashandler/crashand=
ler_client.c:139<br>
.424671] =3D=3D=3D26292=3D=3D=3D #3 &lt;signal handler called&gt;<br>
.424730] =3D=3D=3D26292=3D=3D=3D #4 0x00007f4c2cb57831 in pthread_cancel ()=
 from /lib64/libpthread.so.0<br>
.424788] =3D=3D=3D26292=3D=3D=3D #5 0x00007f4c2dec428e in lttng_ust_exit ()=
 at lttng-ust-comm.c:1296<br>
.424846] =3D=3D=3D26292=3D=3D=3D #6 0x00007f4c2e310469 in _dl_fini () from =
/lib64/ld-linux-x86-64.so.2<br>
.424904] =3D=3D=3D26292=3D=3D=3D #7 0x00007f4c2c4135e5 in __run_exit_handle=
rs () from
/lib64/libc.so.6<br>
.424954] =3D=3D=3D26292=3D=3D=3D #8 0x00007f4c2c413635 in exit () from /lib=
64/libc.so.6<br>
.425011] =3D=3D=3D26292=3D=3D=3D #9 0x00007f4c2c3fcbcd in __libc_start_main=
 () from
/lib64/libc.so.6<br>
.425072] =3D=3D=3D26292=3D=3D=3D #10 0x000000000041cd49 in _start () at ../=
sysdeps/x86_64/elf/start.S:113</span></tt>
<br>
<br>
<br><span style=3D"color: #000080; font-family: sans-serif; font-size: smal=
l;" data-mce-style=3D"color: #000080; font-family: sans-serif; font-size: s=
mall;" color=3D"#000080" face=3D"sans-serif" size=3D"2">Amit Margalit</span=
>
<br><span style=3D"color: #808000; font-family: sans-serif; font-size: smal=
l;" data-mce-style=3D"color: #808000; font-family: sans-serif; font-size: s=
mall;" color=3D"#808000" face=3D"sans-serif" size=3D"2">IBM XIV </span><spa=
n style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"fo=
nt-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">-
<i>Storage Reinvented</i></span>
<br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-sty=
le=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">XIV-NAS Development Team</span>
<br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-sty=
le=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">Tel. 03</span><span style=3D"font-family: Arial; font-size: small;" =
data-mce-style=3D"font-family: Arial; font-size: small;" face=3D"Arial" siz=
e=3D"2">-689-7774</span>
<br><span style=3D"font-family: Arial; font-size: small;" data-mce-style=3D=
"font-family: Arial; font-size: small;" face=3D"Arial" size=3D"2">Fax. 03-6=
89-7230</span><br>_______________________________________________<br>lttng-=
dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><br=
></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>=
EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div><=
/div></body></html>
------=_Part_4047_471777448.1389041053864--


--===============0832109951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0832109951==--
