From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Valgrind Memory Error in lttng-relayd
Date: Thu, 2 Jul 2015 22:12:13 +0530
Message-ID: <CACd+_b70iWNJS50c2ZKiRcN1QEmkaHyDHFHpSH4rSmfHS=qw5g__38472.8848039687$1435855822$gmane$org@mail.gmail.com>
References: <CACd+_b7wB+RQNMBnFj6HZgHi4_a3-_giVfBJFBwkLeCbi8Hr9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0521850073=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f48.google.com ([209.85.215.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1ZAhZ5-0004lj-JH
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 12:42:30 -0400
Received: by lagx9 with SMTP id x9so64969796lag.1
 for <lttng-dev@lists.lttng.org>; Thu, 02 Jul 2015 09:42:13 -0700 (PDT)
In-Reply-To: <CACd+_b7wB+RQNMBnFj6HZgHi4_a3-_giVfBJFBwkLeCbi8Hr9Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0521850073==
Content-Type: multipart/alternative; boundary=001a1132f6821baccd0519e71f8f

--001a1132f6821baccd0519e71f8f
Content-Type: text/plain; charset=UTF-8

Possible Solution :

The following changes seem to be missing from the actual code

http://git.lttng.org/?p=lttng-tools.git;a=commitdiff;h=cd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80


only the connection.h changes have been absorbed, while the main.c changes
left out.

On Mon, Jun 29, 2015 at 11:51 PM, Aravind HT <aravind.ht@gmail.com> wrote:

> Hi,
>
> I ran valgrind on lttng-relayd for a soft hang issue that I had reported
> earlier.
> http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html
>
> Below are the list of errors that I found.
>
> ==793== Thread 4:
> ==793== Invalid write of size 8
> ==793==    at 0x406038: cds_list_add (list.h:53)
> ==793==    by 0x409442: queue_stream (main.c:1175)
> ==793==    by 0x409AB7: relay_add_stream (main.c:1274)
> ==793==    by 0x40C47A: relay_process_control (main.c:2099)
> ==793==    by 0x40DBB1: relay_thread_worker (main.c:2574)
> ==793==    by 0x5BDAFE2: start_thread (pthread_create.c:312)
> ==793==    by 0x5ED8AFC: clone (clone.S:111)
> ==793==  Address 0x6e09040 is 64 bytes inside a block of size 312 free'd
> ==793==    at 0x4C2898C: free (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==793==    by 0x418EF8: rcu_destroy_stream (stream.c:33)
> ==793==    by 0x5079C94: ??? (in /usr/lib64/liburcu.so.2.0.0)
> ==793==    by 0x5BDAFE2: start_thread (pthread_create.c:312)
> ==793==    by 0x5ED8AFC: clone (clone.S:111)
> ==793==
>
> Are there any known bugs/fixes for these ?
>
>
> Regards,
> Aravind.
>
>

--001a1132f6821baccd0519e71f8f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Possible Solution :<div><br></div><div>The following chang=
es seem to be missing from the actual code</div><div><p class=3D"MsoNormal"=
><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;color:rgb(31,=
73,125)"><a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdif=
f;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80">http://git.lttng.org/?p=3Dl=
ttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80<=
/a></span></p><p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">only th=
e connection.h changes have been absorbed, while the main.c changes left ou=
t.</p></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Mon, Jun 29, 2015 at 11:51 PM, Aravind HT <span dir=3D"ltr">&lt;<a href=
=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<d=
iv><br></div><div>I ran valgrind on lttng-relayd for a soft hang issue that=
 I had reported earlier.</div><div><a href=3D"http://lists.lttng.org/piperm=
ail/lttng-dev/2015-May/024533.html" target=3D"_blank">http://lists.lttng.or=
g/pipermail/lttng-dev/2015-May/024533.html</a><br></div><div><br></div><div=
>Below are the list of errors that I found.</div><div><br></div><div><div>=
=3D=3D793=3D=3D Thread 4:</div><div>=3D=3D793=3D=3D Invalid write of size 8=
</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0at 0x406038: cds_list_add (list.h:5=
3)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x409442: queue_stream (main.c=
:1175)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x409AB7: relay_add_stream=
 (main.c:1274)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x40C47A: relay_pr=
ocess_control (main.c:2099)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x40D=
BB1: relay_thread_worker (main.c:2574)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=
=A0by 0x5BDAFE2: start_thread (pthread_create.c:312)</div><div>=3D=3D793=3D=
=3D =C2=A0 =C2=A0by 0x5ED8AFC: clone (clone.S:111)</div><div>=3D=3D793=3D=
=3D =C2=A0Address 0x6e09040 is 64 bytes inside a block of size 312 free&#39=
;d</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0at 0x4C2898C: free (in /usr/lib64=
/valgrind/vgpreload_memcheck-amd64-linux.so)</div><div>=3D=3D793=3D=3D =C2=
=A0 =C2=A0by 0x418EF8: rcu_destroy_stream (stream.c:33)</div><div>=3D=3D793=
=3D=3D =C2=A0 =C2=A0by 0x5079C94: ??? (in /usr/lib64/liburcu.so.2.0.0)</div=
><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5BDAFE2: start_thread (pthread_crea=
te.c:312)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5ED8AFC: clone (clone=
.S:111)</div><div>=3D=3D793=3D=3D</div></div><div><br></div><div>Are there =
any known bugs/fixes for these ?</div><div><br></div><div><br></div><div>Re=
gards,</div><div>Aravind.</div><div><br></div></div>
</blockquote></div><br></div>

--001a1132f6821baccd0519e71f8f--


--===============0521850073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0521850073==--
