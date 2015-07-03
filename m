From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Valgrind Memory Error in lttng-relayd
Date: Fri, 3 Jul 2015 11:06:03 -0400
Message-ID: <CA+jJMxur4jj=kUAdeLDyobJgv6OqtYPkfkrhCZzjDmLjyUx43Q__26571.0670188584$1435936024$gmane$org@mail.gmail.com>
References: <CACd+_b7wB+RQNMBnFj6HZgHi4_a3-_giVfBJFBwkLeCbi8Hr9Q@mail.gmail.com>
 <CACd+_b70iWNJS50c2ZKiRcN1QEmkaHyDHFHpSH4rSmfHS=qw5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0583865240=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZB2XZ-0003N5-4l
 for lttng-dev@lists.lttng.org; Fri, 03 Jul 2015 11:06:10 -0400
Received: by pdjd13 with SMTP id d13so65249121pdj.0
 for <lttng-dev@lists.lttng.org>; Fri, 03 Jul 2015 08:06:03 -0700 (PDT)
In-Reply-To: <CACd+_b70iWNJS50c2ZKiRcN1QEmkaHyDHFHpSH4rSmfHS=qw5g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aravind HT <aravind.ht@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0583865240==
Content-Type: multipart/alternative; boundary=047d7bd754bc05a8ee0519f9e508

--047d7bd754bc05a8ee0519f9e508
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the detailed report. Can you provide a sequence of steps that
leads to this problem?
Also, did you modify lttng-relayd at all to be able to run valgrind? I seem
to remember valgrind not supporting clone().

Thanks,
J=C3=A9r=C3=A9mie

On Thu, Jul 2, 2015 at 12:42 PM, Aravind HT <aravind.ht@gmail.com> wrote:

> Possible Solution :
>
> The following changes seem to be missing from the actual code
>
>
> http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54=
ced9e4d0d03b865bb7fc6a905f80
>
>
> only the connection.h changes have been absorbed, while the main.c change=
s
> left out.
>
> On Mon, Jun 29, 2015 at 11:51 PM, Aravind HT <aravind.ht@gmail.com> wrote=
:
>
>> Hi,
>>
>> I ran valgrind on lttng-relayd for a soft hang issue that I had reported
>> earlier.
>> http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html
>>
>> Below are the list of errors that I found.
>>
>> =3D=3D793=3D=3D Thread 4:
>> =3D=3D793=3D=3D Invalid write of size 8
>> =3D=3D793=3D=3D    at 0x406038: cds_list_add (list.h:53)
>> =3D=3D793=3D=3D    by 0x409442: queue_stream (main.c:1175)
>> =3D=3D793=3D=3D    by 0x409AB7: relay_add_stream (main.c:1274)
>> =3D=3D793=3D=3D    by 0x40C47A: relay_process_control (main.c:2099)
>> =3D=3D793=3D=3D    by 0x40DBB1: relay_thread_worker (main.c:2574)
>> =3D=3D793=3D=3D    by 0x5BDAFE2: start_thread (pthread_create.c:312)
>> =3D=3D793=3D=3D    by 0x5ED8AFC: clone (clone.S:111)
>> =3D=3D793=3D=3D  Address 0x6e09040 is 64 bytes inside a block of size 31=
2 free'd
>> =3D=3D793=3D=3D    at 0x4C2898C: free (in
>> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>> =3D=3D793=3D=3D    by 0x418EF8: rcu_destroy_stream (stream.c:33)
>> =3D=3D793=3D=3D    by 0x5079C94: ??? (in /usr/lib64/liburcu.so.2.0.0)
>> =3D=3D793=3D=3D    by 0x5BDAFE2: start_thread (pthread_create.c:312)
>> =3D=3D793=3D=3D    by 0x5ED8AFC: clone (clone.S:111)
>> =3D=3D793=3D=3D
>>
>> Are there any known bugs/fixes for these ?
>>
>>
>> Regards,
>> Aravind.
>>
>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd754bc05a8ee0519f9e508
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Thanks for the detailed report. Can=
 you provide a sequence of steps that leads to this problem?</div><div>Also=
, did you modify lttng-relayd at all to be able to run valgrind? I seem to =
remember valgrind not supporting clone().</div><div><br></div><div>Thanks,<=
/div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Thu, Jul 2, 2015 at 12:42 PM, Aravind HT <span dir=
=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">arav=
ind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv dir=3D"ltr">Possible Solution :<div><br></div><div>The following changes=
 seem to be missing from the actual code</div><div><p class=3D"MsoNormal"><=
span style=3D"font-size:11pt;font-family:Calibri,sans-serif;color:rgb(31,73=
,125)"><a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;=
h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80" target=3D"_blank">http://git.=
lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b8=
65bb7fc6a905f80</a></span></p><p class=3D"MsoNormal"><br></p><p class=3D"Ms=
oNormal">only the connection.h changes have been absorbed, while the main.c=
 changes left out.</p></div></div><div class=3D"HOEnZb"><div class=3D"h5"><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Jun 29, 20=
15 at 11:51 PM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.=
ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I=
 ran valgrind on lttng-relayd for a soft hang issue that I had reported ear=
lier.</div><div><a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2015-=
May/024533.html" target=3D"_blank">http://lists.lttng.org/pipermail/lttng-d=
ev/2015-May/024533.html</a><br></div><div><br></div><div>Below are the list=
 of errors that I found.</div><div><br></div><div><div>=3D=3D793=3D=3D Thre=
ad 4:</div><div>=3D=3D793=3D=3D Invalid write of size 8</div><div>=3D=3D793=
=3D=3D =C2=A0 =C2=A0at 0x406038: cds_list_add (list.h:53)</div><div>=3D=3D7=
93=3D=3D =C2=A0 =C2=A0by 0x409442: queue_stream (main.c:1175)</div><div>=3D=
=3D793=3D=3D =C2=A0 =C2=A0by 0x409AB7: relay_add_stream (main.c:1274)</div>=
<div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x40C47A: relay_process_control (main.=
c:2099)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x40DBB1: relay_thread_wo=
rker (main.c:2574)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5BDAFE2: sta=
rt_thread (pthread_create.c:312)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by =
0x5ED8AFC: clone (clone.S:111)</div><div>=3D=3D793=3D=3D =C2=A0Address 0x6e=
09040 is 64 bytes inside a block of size 312 free&#39;d</div><div>=3D=3D793=
=3D=3D =C2=A0 =C2=A0at 0x4C2898C: free (in /usr/lib64/valgrind/vgpreload_me=
mcheck-amd64-linux.so)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x418EF8: =
rcu_destroy_stream (stream.c:33)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by =
0x5079C94: ??? (in /usr/lib64/liburcu.so.2.0.0)</div><div>=3D=3D793=3D=3D =
=C2=A0 =C2=A0by 0x5BDAFE2: start_thread (pthread_create.c:312)</div><div>=
=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5ED8AFC: clone (clone.S:111)</div><div>=
=3D=3D793=3D=3D</div></div><div><br></div><div>Are there any known bugs/fix=
es for these ?</div><div><br></div><div><br></div><div>Regards,</div><div>A=
ravind.</div><div><br></div></div>
</blockquote></div><br></div>
</div></div><br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--047d7bd754bc05a8ee0519f9e508--


--===============0583865240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0583865240==--
