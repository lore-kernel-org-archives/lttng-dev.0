From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Valgrind Memory Error in lttng-relayd
Date: Fri, 3 Jul 2015 15:56:47 -0400
Message-ID: <CA+jJMxv-9qprwTZBx-9NEH2StkzwHK61uj2LTmjJ+GY_BM7+Fg__3508.9052668356$1435953477$gmane$org@mail.gmail.com>
References: <CACd+_b7wB+RQNMBnFj6HZgHi4_a3-_giVfBJFBwkLeCbi8Hr9Q@mail.gmail.com>
 <CACd+_b70iWNJS50c2ZKiRcN1QEmkaHyDHFHpSH4rSmfHS=qw5g@mail.gmail.com>
 <CA+jJMxur4jj=kUAdeLDyobJgv6OqtYPkfkrhCZzjDmLjyUx43Q@mail.gmail.com>
 <CACd+_b4pfZyXdTKi56zOJy-ZHUxZ7MRDyDr6pESQZ_Khd45wsA@mail.gmail.com>
 <CA+jJMxu35zRhyiOp6erd1ExW94m-HkDBwdnVr6Qj4xWmcsu58w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1629864971=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZB74v-0004nn-Bx
 for lttng-dev@lists.lttng.org; Fri, 03 Jul 2015 15:56:58 -0400
Received: by pdbci14 with SMTP id ci14so67885753pdb.2
 for <lttng-dev@lists.lttng.org>; Fri, 03 Jul 2015 12:56:47 -0700 (PDT)
In-Reply-To: <CA+jJMxu35zRhyiOp6erd1ExW94m-HkDBwdnVr6Qj4xWmcsu58w@mail.gmail.com>
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

--===============1629864971==
Content-Type: multipart/alternative; boundary=047d7bd754bcc82c840519fdf482

--047d7bd754bcc82c840519fdf482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Can you share a bit more information about the session configurations in
your use case?
Are you creating and destroying new sessions, tracing in per-pid or uid
mode, enabling new channels, etc.

Also, is this in "live" mode or are you just streaming to the relay daemon?
(lttng create --set-url net://somewhere)

J=C3=A9r=C3=A9mie

On Fri, Jul 3, 2015 at 3:30 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

>
>
> On Fri, Jul 3, 2015 at 1:48 PM, Aravind HT <aravind.ht@gmail.com> wrote:
>
>> Hi,
>>
>> Thanks for replying.
>>
>> I have a daemon which i'm using for some CLI application, this forks
>> whenever invoked but never exec()'s and am using lttng for tracing this =
and
>> a few other apps.
>> I have a script that I run to stress test this daemon; this I think mean=
s
>> lttng is also being stressed.
>> As soon as I run this script, after a few streams are created, I
>> sometimes see a soft hang as mentioned in my previous thread
>> http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html
>> or
>> I see lttng-relayd coring.
>>
>> In short, an app that calls quite a bit of fork and exits which is being
>> traced with other normal apps that run forever should re-create the prob=
lem.
>>
>> To run valgrind, use the -DVALGRIND when building, your can grep the cod=
e
>> for what this does.
>> Kill the valgrind  proc with -TERM to produce the logs.
>>
>>
> Doh, of course! :-)
>
>
>> This is the command and the options that I use to run valgrind
>>
>> valgrind --tool=3Dmemcheck --leak-check=3Dfull -v --log-file=3D/tmp/test
>> --trace-children=3Dyes  /usr/bin/lttng-relayd -o /var/log/lttng-traces -=
d
>>
>>
>>
>> I have tried the fix detailed in the checkin
>> http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d5=
4ced9e4d0d03b865bb7fc6a905f80
>>
>> and it seems to work for me. This however only solves the relayd core,
>> but I still see the "soft hang" happening.
>>
>
>> Can some one please tell me how the above fix is missing from the source=
 ?
>>
>
> Somehow it appears this was reverted by this commit:
>
> https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c033=
1445346b15f
>
> I'm trying to reproduce the problem here.
>
> J=C3=A9r=C3=A9mie
>
>
>>
>> Regards,
>>
>> Aravind.
>>
>>
>>
>>
>> On Fri, Jul 3, 2015 at 8:36 PM, J=C3=A9r=C3=A9mie Galarneau <
>> jeremie.galarneau@efficios.com> wrote:
>>
>>> Hi,
>>>
>>> Thanks for the detailed report. Can you provide a sequence of steps tha=
t
>>> leads to this problem?
>>> Also, did you modify lttng-relayd at all to be able to run valgrind? I
>>> seem to remember valgrind not supporting clone().
>>>
>>> Thanks,
>>> J=C3=A9r=C3=A9mie
>>>
>>> On Thu, Jul 2, 2015 at 12:42 PM, Aravind HT <aravind.ht@gmail.com>
>>> wrote:
>>>
>>>> Possible Solution :
>>>>
>>>> The following changes seem to be missing from the actual code
>>>>
>>>>
>>>> http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1=
d54ced9e4d0d03b865bb7fc6a905f80
>>>>
>>>>
>>>> only the connection.h changes have been absorbed, while the main.c
>>>> changes left out.
>>>>
>>>> On Mon, Jun 29, 2015 at 11:51 PM, Aravind HT <aravind.ht@gmail.com>
>>>> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> I ran valgrind on lttng-relayd for a soft hang issue that I had
>>>>> reported earlier.
>>>>> http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html
>>>>>
>>>>> Below are the list of errors that I found.
>>>>>
>>>>> =3D=3D793=3D=3D Thread 4:
>>>>> =3D=3D793=3D=3D Invalid write of size 8
>>>>> =3D=3D793=3D=3D    at 0x406038: cds_list_add (list.h:53)
>>>>> =3D=3D793=3D=3D    by 0x409442: queue_stream (main.c:1175)
>>>>> =3D=3D793=3D=3D    by 0x409AB7: relay_add_stream (main.c:1274)
>>>>> =3D=3D793=3D=3D    by 0x40C47A: relay_process_control (main.c:2099)
>>>>> =3D=3D793=3D=3D    by 0x40DBB1: relay_thread_worker (main.c:2574)
>>>>> =3D=3D793=3D=3D    by 0x5BDAFE2: start_thread (pthread_create.c:312)
>>>>> =3D=3D793=3D=3D    by 0x5ED8AFC: clone (clone.S:111)
>>>>> =3D=3D793=3D=3D  Address 0x6e09040 is 64 bytes inside a block of size=
 312
>>>>> free'd
>>>>> =3D=3D793=3D=3D    at 0x4C2898C: free (in
>>>>> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>>>>> =3D=3D793=3D=3D    by 0x418EF8: rcu_destroy_stream (stream.c:33)
>>>>> =3D=3D793=3D=3D    by 0x5079C94: ??? (in /usr/lib64/liburcu.so.2.0.0)
>>>>> =3D=3D793=3D=3D    by 0x5BDAFE2: start_thread (pthread_create.c:312)
>>>>> =3D=3D793=3D=3D    by 0x5ED8AFC: clone (clone.S:111)
>>>>> =3D=3D793=3D=3D
>>>>>
>>>>> Are there any known bugs/fixes for these ?
>>>>>
>>>>>
>>>>> Regards,
>>>>> Aravind.
>>>>>
>>>>>
>>>>
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>
>>>
>>> --
>>> J=C3=A9r=C3=A9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bd754bcc82c840519fdf482
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Can you share a bit more information about the session con=
figurations in your use case?<div>Are you creating and destroying new sessi=
ons, tracing in per-pid or uid mode, enabling new channels, etc.</div><div>=
<br></div><div>Also, is this in &quot;live&quot; mode or are you just strea=
ming to the relay daemon? (lttng create --set-url net://somewhere)</div><di=
v><br></div><div>J=C3=A9r=C3=A9mie<br><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Fri, Jul 3, 2015 at 3:30 PM, J=C3=A9r=C3=A9mie Gala=
rneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.co=
m" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid=
;padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote"><span class=3D"">On Fri, Jul 3, 2015 at 1:48 PM, Ara=
vind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" targe=
t=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br></span><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-le=
ft:1ex"><div dir=3D"ltr">Hi,<div><br></div><span class=3D""><div>Thanks for=
 replying.</div><div><br></div><div>I have a daemon which i&#39;m using for=
 some CLI application, this forks whenever invoked but never exec()&#39;s a=
nd am using lttng for tracing this and a few other apps.</div><div>I have a=
 script that I run to stress test this daemon; this I think means lttng is =
also being stressed.</div><div>As soon as I run this script, after a few st=
reams are created, I sometimes see a soft hang as mentioned in my previous =
thread=C2=A0<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2015-May/=
024533.html" style=3D"font-size:12.8000001907349px" target=3D"_blank">http:=
//lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html</a></div><div>or=
=C2=A0</div><div>I see lttng-relayd coring.</div><div><br></div><div>In sho=
rt, an app that calls quite a bit of fork and exits which is being traced w=
ith other normal apps that run forever should re-create the problem.</div><=
div><br></div><div>To run valgrind, use the -DVALGRIND when building, your =
can grep the code for what this does.</div><div>Kill the valgrind =C2=A0pro=
c with -TERM to produce the logs.</div><div><br></div></span></div></blockq=
uote><div><br></div><div>Doh, of course! :-)</div><span class=3D""><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><div dir=3D"ltr"><div></div><div>This is the comm=
and and the options that I use to run valgrind</div><div><p class=3D"MsoNor=
mal"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;color:rgb=
(31,73,125)">valgrind --tool=3Dmemcheck --leak-check=3Dfull -v
--log-file=3D/tmp/test --trace-children=3Dyes=C2=A0 /usr/bin/lttng-relayd -=
o
/var/log/lttng-traces -d</span><span style=3D"color:black"></span></p><p cl=
ass=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sans-se=
rif;color:rgb(31,73,125)"><br></span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:11pt;font-family:Calibri,sans-serif;color:rgb(31,73,125)"><br=
></span></p><p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-famil=
y:Calibri,sans-serif;color:rgb(31,73,125)">I have tried the fix detailed in=
 the checkin=C2=A0</span><a href=3D"http://git.lttng.org/?p=3Dlttng-tools.g=
it;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80" style=3D"fo=
nt-family:Calibri,sans-serif;font-size:11pt" target=3D"_blank">http://git.l=
ttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b86=
5bb7fc6a905f80</a></p><p class=3D"MsoNormal"><span style=3D"font-size:11pt;=
font-family:Calibri,sans-serif;color:rgb(31,73,125)">and it seems to work f=
or me. This however only solves the relayd core, but I still see the &quot;=
soft hang&quot; happening.</span></p></div></div></blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1=
ex"><div dir=3D"ltr"><div><p class=3D"MsoNormal"><span style=3D"font-size:1=
1pt;font-family:Calibri,sans-serif;color:rgb(31,73,125)"><br></span></p><p =
class=3D"MsoNormal"><font color=3D"#1f497d" face=3D"Calibri, sans-serif"><s=
pan style=3D"font-size:14.6666669845581px">Can some one please tell me how =
the above fix is missing from the source ?</span></font></p></div></div></b=
lockquote><div><br></div></span><div><div>Somehow it appears this was rever=
ted by this commit:</div><div><a href=3D"https://github.com/lttng/lttng-too=
ls/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f" target=3D"_blank">https=
://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331445346=
b15f</a><br></div><div><br></div><div>I&#39;m trying to reproduce the probl=
em here.</div><span class=3D""><font color=3D"#888888"><div><br></div><div>=
J=C3=A9r=C3=A9mie</div></font></span></div><div><div class=3D"h5"><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><div dir=3D"ltr"><div><p class=3D"MsoNormal"><spa=
n style=3D"font-size:11pt;font-family:Calibri,sans-serif;color:rgb(31,73,12=
5)"><br></span></p><p class=3D"MsoNormal">Regards,<span style=3D"font-size:=
11pt;font-family:Calibri,sans-serif;color:rgb(31,73,125)"><br></span></p><p=
 class=3D"MsoNormal">Aravind.</p><p class=3D"MsoNormal"><br></p></div><div>=
<br></div></div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Fri, Jul 3, 2015 at 8:36 PM, J=C3=A9r=C3=A9mie Galarneau <span =
dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D=
"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-lef=
t:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>Thanks for the detailed repo=
rt. Can you provide a sequence of steps that leads to this problem?</div><d=
iv>Also, did you modify lttng-relayd at all to be able to run valgrind? I s=
eem to remember valgrind not supporting clone().</div><div><br></div><div>T=
hanks,</div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote"><div><div>On Thu, Jul 2, 2015 at 12:42 PM, Ara=
vind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" targe=
t=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br></div></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex"><div><div><div dir=3D"ltr">Possible Solution :<div><br></div><=
div>The following changes seem to be missing from the actual code</div><div=
><p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,s=
ans-serif;color:rgb(31,73,125)"><a href=3D"http://git.lttng.org/?p=3Dlttng-=
tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80" targ=
et=3D"_blank">http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3D=
cd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80</a></span></p><p class=3D"MsoNorma=
l"><br></p><p class=3D"MsoNormal">only the connection.h changes have been a=
bsorbed, while the main.c changes left out.</p></div></div><div><div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Jun 29, 2015 at=
 11:51 PM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gm=
ail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pad=
ding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I ran valgrind on lt=
tng-relayd for a soft hang issue that I had reported earlier.</div><div><a =
href=3D"http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html" ta=
rget=3D"_blank">http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.=
html</a><br></div><div><br></div><div>Below are the list of errors that I f=
ound.</div><div><br></div><div><div>=3D=3D793=3D=3D Thread 4:</div><div>=3D=
=3D793=3D=3D Invalid write of size 8</div><div>=3D=3D793=3D=3D =C2=A0 =C2=
=A0at 0x406038: cds_list_add (list.h:53)</div><div>=3D=3D793=3D=3D =C2=A0 =
=C2=A0by 0x409442: queue_stream (main.c:1175)</div><div>=3D=3D793=3D=3D =C2=
=A0 =C2=A0by 0x409AB7: relay_add_stream (main.c:1274)</div><div>=3D=3D793=
=3D=3D =C2=A0 =C2=A0by 0x40C47A: relay_process_control (main.c:2099)</div><=
div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x40DBB1: relay_thread_worker (main.c:2=
574)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5BDAFE2: start_thread (pth=
read_create.c:312)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5ED8AFC: clo=
ne (clone.S:111)</div><div>=3D=3D793=3D=3D =C2=A0Address 0x6e09040 is 64 by=
tes inside a block of size 312 free&#39;d</div><div>=3D=3D793=3D=3D =C2=A0 =
=C2=A0at 0x4C2898C: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-l=
inux.so)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x418EF8: rcu_destroy_st=
ream (stream.c:33)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5079C94: ???=
 (in /usr/lib64/liburcu.so.2.0.0)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by=
 0x5BDAFE2: start_thread (pthread_create.c:312)</div><div>=3D=3D793=3D=3D =
=C2=A0 =C2=A0by 0x5ED8AFC: clone (clone.S:111)</div><div>=3D=3D793=3D=3D</d=
iv></div><div><br></div><div>Are there any known bugs/fixes for these ?</di=
v><div><br></div><div><br></div><div>Regards,</div><div>Aravind.</div><div>=
<br></div></div>
</blockquote></div><br></div>
</div></div><br></div></div>_______________________________________________=
<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><span><font color=3D"#888888"><br><br clear=3D"all">=
<div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br>=
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></div>
</font></span></div>
</blockquote></div><br></div>
</div></div></blockquote></div></div></div><div><div class=3D"h5"><br><br c=
lear=3D"all"><div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>Effi=
ciOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://w=
ww.efficios.com</a></div>
</div></div></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div></div></div>

--047d7bd754bcc82c840519fdf482--


--===============1629864971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1629864971==--
