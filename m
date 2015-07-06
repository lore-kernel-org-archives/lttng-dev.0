From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Valgrind Memory Error in lttng-relayd
Date: Mon, 6 Jul 2015 09:40:32 +0530
Message-ID: <CACd+_b5ZWrCM7_z0=S6MG+45mR0JqNpG+aWmfirRF_4p2ELJcw__4975.04794407195$1436155908$gmane$org@mail.gmail.com>
References: <CACd+_b7wB+RQNMBnFj6HZgHi4_a3-_giVfBJFBwkLeCbi8Hr9Q@mail.gmail.com>
 <CACd+_b70iWNJS50c2ZKiRcN1QEmkaHyDHFHpSH4rSmfHS=qw5g@mail.gmail.com>
 <CA+jJMxur4jj=kUAdeLDyobJgv6OqtYPkfkrhCZzjDmLjyUx43Q@mail.gmail.com>
 <CACd+_b4pfZyXdTKi56zOJy-ZHUxZ7MRDyDr6pESQZ_Khd45wsA@mail.gmail.com>
 <CA+jJMxu35zRhyiOp6erd1ExW94m-HkDBwdnVr6Qj4xWmcsu58w@mail.gmail.com>
 <CA+jJMxv-9qprwTZBx-9NEH2StkzwHK61uj2LTmjJ+GY_BM7+Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1642068301=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f45.google.com ([209.85.215.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1ZBxjq-0004Jw-Ey
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 00:10:42 -0400
Received: by lagh6 with SMTP id h6so139198160lag.2
 for <lttng-dev@lists.lttng.org>; Sun, 05 Jul 2015 21:10:32 -0700 (PDT)
In-Reply-To: <CA+jJMxv-9qprwTZBx-9NEH2StkzwHK61uj2LTmjJ+GY_BM7+Fg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1642068301==
Content-Type: multipart/alternative; boundary=001a11c3fd123b7ba7051a2d1695

--001a11c3fd123b7ba7051a2d1695
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is how I am creating the session and using


lttng-relayd -o /var/tmp/lttng-traces -d

lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd
--consumerd32-libdir /usr/lib/ --consumerd64-path
/usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir /usr/lib64/
-b --no-kernel



lttng  --no-sessiond create mysession --live 2000000 -U net://128.0.0.4

lttng enable-channel mychannel --userspace --buffers-pid -s mysession
--tracefile-size 2000000 --tracefile-count 2

lttng enable-event --channel mychannel --userspace --all --exclude
'ust_libc:*' -s mysession

lttng start mysession

lttng list


At present, I am not trying to enable new channels. The above is pretty
much what I do.




On Sat, Jul 4, 2015 at 1:26 AM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Can you share a bit more information about the session configurations in
> your use case?
> Are you creating and destroying new sessions, tracing in per-pid or uid
> mode, enabling new channels, etc.
>
> Also, is this in "live" mode or are you just streaming to the relay
> daemon? (lttng create --set-url net://somewhere)
>
> J=C3=A9r=C3=A9mie
>
>
> On Fri, Jul 3, 2015 at 3:30 PM, J=C3=A9r=C3=A9mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
>
>>
>>
>> On Fri, Jul 3, 2015 at 1:48 PM, Aravind HT <aravind.ht@gmail.com> wrote:
>>
>>> Hi,
>>>
>>> Thanks for replying.
>>>
>>> I have a daemon which i'm using for some CLI application, this forks
>>> whenever invoked but never exec()'s and am using lttng for tracing this=
 and
>>> a few other apps.
>>> I have a script that I run to stress test this daemon; this I think
>>> means lttng is also being stressed.
>>> As soon as I run this script, after a few streams are created, I
>>> sometimes see a soft hang as mentioned in my previous thread
>>> http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html
>>> or
>>> I see lttng-relayd coring.
>>>
>>> In short, an app that calls quite a bit of fork and exits which is bein=
g
>>> traced with other normal apps that run forever should re-create the pro=
blem.
>>>
>>> To run valgrind, use the -DVALGRIND when building, your can grep the
>>> code for what this does.
>>> Kill the valgrind  proc with -TERM to produce the logs.
>>>
>>>
>> Doh, of course! :-)
>>
>>
>>> This is the command and the options that I use to run valgrind
>>>
>>> valgrind --tool=3Dmemcheck --leak-check=3Dfull -v --log-file=3D/tmp/tes=
t
>>> --trace-children=3Dyes  /usr/bin/lttng-relayd -o /var/log/lttng-traces =
-d
>>>
>>>
>>>
>>> I have tried the fix detailed in the checkin
>>> http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d=
54ced9e4d0d03b865bb7fc6a905f80
>>>
>>> and it seems to work for me. This however only solves the relayd core,
>>> but I still see the "soft hang" happening.
>>>
>>
>>> Can some one please tell me how the above fix is missing from the sourc=
e
>>> ?
>>>
>>
>> Somehow it appears this was reverted by this commit:
>>
>> https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c03=
31445346b15f
>>
>> I'm trying to reproduce the problem here.
>>
>> J=C3=A9r=C3=A9mie
>>
>>
>>>
>>> Regards,
>>>
>>> Aravind.
>>>
>>>
>>>
>>>
>>> On Fri, Jul 3, 2015 at 8:36 PM, J=C3=A9r=C3=A9mie Galarneau <
>>> jeremie.galarneau@efficios.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> Thanks for the detailed report. Can you provide a sequence of steps
>>>> that leads to this problem?
>>>> Also, did you modify lttng-relayd at all to be able to run valgrind? I
>>>> seem to remember valgrind not supporting clone().
>>>>
>>>> Thanks,
>>>> J=C3=A9r=C3=A9mie
>>>>
>>>> On Thu, Jul 2, 2015 at 12:42 PM, Aravind HT <aravind.ht@gmail.com>
>>>> wrote:
>>>>
>>>>> Possible Solution :
>>>>>
>>>>> The following changes seem to be missing from the actual code
>>>>>
>>>>>
>>>>> http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef=
1d54ced9e4d0d03b865bb7fc6a905f80
>>>>>
>>>>>
>>>>> only the connection.h changes have been absorbed, while the main.c
>>>>> changes left out.
>>>>>
>>>>> On Mon, Jun 29, 2015 at 11:51 PM, Aravind HT <aravind.ht@gmail.com>
>>>>> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I ran valgrind on lttng-relayd for a soft hang issue that I had
>>>>>> reported earlier.
>>>>>> http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html
>>>>>>
>>>>>> Below are the list of errors that I found.
>>>>>>
>>>>>> =3D=3D793=3D=3D Thread 4:
>>>>>> =3D=3D793=3D=3D Invalid write of size 8
>>>>>> =3D=3D793=3D=3D    at 0x406038: cds_list_add (list.h:53)
>>>>>> =3D=3D793=3D=3D    by 0x409442: queue_stream (main.c:1175)
>>>>>> =3D=3D793=3D=3D    by 0x409AB7: relay_add_stream (main.c:1274)
>>>>>> =3D=3D793=3D=3D    by 0x40C47A: relay_process_control (main.c:2099)
>>>>>> =3D=3D793=3D=3D    by 0x40DBB1: relay_thread_worker (main.c:2574)
>>>>>> =3D=3D793=3D=3D    by 0x5BDAFE2: start_thread (pthread_create.c:312)
>>>>>> =3D=3D793=3D=3D    by 0x5ED8AFC: clone (clone.S:111)
>>>>>> =3D=3D793=3D=3D  Address 0x6e09040 is 64 bytes inside a block of siz=
e 312
>>>>>> free'd
>>>>>> =3D=3D793=3D=3D    at 0x4C2898C: free (in
>>>>>> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>>>>>> =3D=3D793=3D=3D    by 0x418EF8: rcu_destroy_stream (stream.c:33)
>>>>>> =3D=3D793=3D=3D    by 0x5079C94: ??? (in /usr/lib64/liburcu.so.2.0.0=
)
>>>>>> =3D=3D793=3D=3D    by 0x5BDAFE2: start_thread (pthread_create.c:312)
>>>>>> =3D=3D793=3D=3D    by 0x5ED8AFC: clone (clone.S:111)
>>>>>> =3D=3D793=3D=3D
>>>>>>
>>>>>> Are there any known bugs/fixes for these ?
>>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Aravind.
>>>>>>
>>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> J=C3=A9r=C3=A9mie Galarneau
>>>> EfficiOS Inc.
>>>> http://www.efficios.com
>>>>
>>>
>>>
>>
>>
>> --
>> J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c3fd123b7ba7051a2d1695
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is how I am creating the session and using=C2=A0<div>=
<p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-fami=
ly:Helvetica,sans-serif;color:black"><br></span></p><p style=3D"margin:0in =
0in 0.0001pt"><span style=3D"font-size:9pt;font-family:Helvetica,sans-serif=
;color:black">lttng-relayd -o
/var/tmp/lttng-traces -d</span></p>

<p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-fami=
ly:Helvetica,sans-serif;color:black">lttng-sessiond
--consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-lib=
dir
/usr/lib/ --consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd
--consumerd64-libdir /usr/lib64/ -b --no-kernel</span></p>

<p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-fami=
ly:Helvetica,sans-serif;color:black">=C2=A0</span></p>

<p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-fami=
ly:Helvetica,sans-serif;color:black">lttng=C2=A0 --no-sessiond
create mysession --live 2000000 -U net://<a href=3D"http://128.0.0.4">128.0=
.0.4</a></span></p>

<p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-fami=
ly:Helvetica,sans-serif;color:black">lttng enable-channel mychannel
--userspace --buffers-pid -s mysession --tracefile-size 2000000
--tracefile-count 2</span></p>

<p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-fami=
ly:Helvetica,sans-serif;color:black">lttng enable-event --channel
mychannel --userspace --all </span><span style=3D"font-size:10pt;font-famil=
y:Arial,sans-serif;color:rgb(35,35,35)">--exclude &#39;ust_libc:*&#39;</spa=
n><span style=3D"font-size:9pt;font-family:Helvetica,sans-serif;color:black=
"> -s
mysession</span></p>

<p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-fami=
ly:Helvetica,sans-serif;color:black">lttng start mysession</span></p>

<p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-fami=
ly:Helvetica,sans-serif;color:black">lttng list</span></p><p style=3D"margi=
n:0in 0in 0.0001pt"><span style=3D"font-size:9pt;font-family:Helvetica,sans=
-serif;color:black"><br></span></p><p style=3D"margin:0in 0in 0.0001pt"><fo=
nt color=3D"#000000" face=3D"Helvetica, sans-serif"><span style=3D"font-siz=
e:12px">At present, I am not trying to enable new channels. The above is pr=
etty much what I do.</span></font></p><p style=3D"margin:0in 0in 0.0001pt">=
<span style=3D"font-size:9pt;font-family:Helvetica,sans-serif;color:black">=
<br></span></p><p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-siz=
e:9pt;font-family:Helvetica,sans-serif;color:black"><br></span></p></div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Jul 4=
, 2015 at 1:26 AM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galar=
neau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div dir=3D"ltr">Can you share a bit more information about the session conf=
igurations in your use case?<div>Are you creating and destroying new sessio=
ns, tracing in per-pid or uid mode, enabling new channels, etc.</div><div><=
br></div><div>Also, is this in &quot;live&quot; mode or are you just stream=
ing to the relay daemon? (lttng create --set-url net://somewhere)</div><spa=
n class=3D"HOEnZb"><font color=3D"#888888"><div><br></div></font></span><di=
v><span class=3D"HOEnZb"><font color=3D"#888888">J=C3=A9r=C3=A9mie</font></=
span><div><div class=3D"h5"><br><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Fri, Jul 3, 2015 at 3:30 PM, J=C3=A9r=C3=A9mie Galarnea=
u <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" t=
arget=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pad=
ding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote"><span>On Fri, Jul 3, 2015 at 1:48 PM, Aravind HT <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">ar=
avind.ht@gmail.com</a>&gt;</span> wrote:<br></span><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div di=
r=3D"ltr">Hi,<div><br></div><span><div>Thanks for replying.</div><div><br><=
/div><div>I have a daemon which i&#39;m using for some CLI application, thi=
s forks whenever invoked but never exec()&#39;s and am using lttng for trac=
ing this and a few other apps.</div><div>I have a script that I run to stre=
ss test this daemon; this I think means lttng is also being stressed.</div>=
<div>As soon as I run this script, after a few streams are created, I somet=
imes see a soft hang as mentioned in my previous thread=C2=A0<a href=3D"htt=
p://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html" style=3D"font=
-size:12.8000001907349px" target=3D"_blank">http://lists.lttng.org/pipermai=
l/lttng-dev/2015-May/024533.html</a></div><div>or=C2=A0</div><div>I see ltt=
ng-relayd coring.</div><div><br></div><div>In short, an app that calls quit=
e a bit of fork and exits which is being traced with other normal apps that=
 run forever should re-create the problem.</div><div><br></div><div>To run =
valgrind, use the -DVALGRIND when building, your can grep the code for what=
 this does.</div><div>Kill the valgrind =C2=A0proc with -TERM to produce th=
e logs.</div><div><br></div></span></div></blockquote><div><br></div><div>D=
oh, of course! :-)</div><span><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div dir=3D=
"ltr"><div></div><div>This is the command and the options that I use to run=
 valgrind</div><div><p class=3D"MsoNormal"><span style=3D"font-size:11pt;fo=
nt-family:Calibri,sans-serif;color:rgb(31,73,125)">valgrind --tool=3Dmemche=
ck --leak-check=3Dfull -v
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
em here.</div><span><font color=3D"#888888"><div><br></div><div>J=C3=A9r=C3=
=A9mie</div></font></span></div><div><div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
><div dir=3D"ltr"><div><p class=3D"MsoNormal"><span style=3D"font-size:11pt=
;font-family:Calibri,sans-serif;color:rgb(31,73,125)"><br></span></p><p cla=
ss=3D"MsoNormal">Regards,<span style=3D"font-size:11pt;font-family:Calibri,=
sans-serif;color:rgb(31,73,125)"><br></span></p><p class=3D"MsoNormal">Arav=
ind.</p><p class=3D"MsoNormal"><br></p></div><div><br></div></div><div><div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Jul 3, 2=
015 at 8:36 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.galarn=
eau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:=
rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div dir=3D"ltr"=
>Hi,<div><br></div><div>Thanks for the detailed report. Can you provide a s=
equence of steps that leads to this problem?</div><div>Also, did you modify=
 lttng-relayd at all to be able to run valgrind? I seem to remember valgrin=
d not supporting clone().</div><div><br></div><div>Thanks,</div><div>J=C3=
=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote"><div><div>On Thu, Jul 2, 2015 at 12:42 PM, Aravind HT <span dir=3D"=
ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.=
ht@gmail.com</a>&gt;</span> wrote:<br></div></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-lef=
t-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div><di=
v><div dir=3D"ltr">Possible Solution :<div><br></div><div>The following cha=
nges seem to be missing from the actual code</div><div><p class=3D"MsoNorma=
l"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;color:rgb(3=
1,73,125)"><a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitd=
iff;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80" target=3D"_blank">http://=
git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d=
03b865bb7fc6a905f80</a></span></p><p class=3D"MsoNormal"><br></p><p class=
=3D"MsoNormal">only the connection.h changes have been absorbed, while the =
main.c changes left out.</p></div></div><div><div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">On Mon, Jun 29, 2015 at 11:51 PM, Aravind =
HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"=
_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div=
 dir=3D"ltr">Hi,<div><br></div><div>I ran valgrind on lttng-relayd for a so=
ft hang issue that I had reported earlier.</div><div><a href=3D"http://list=
s.lttng.org/pipermail/lttng-dev/2015-May/024533.html" target=3D"_blank">htt=
p://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html</a><br></div><=
div><br></div><div>Below are the list of errors that I found.</div><div><br=
></div><div><div>=3D=3D793=3D=3D Thread 4:</div><div>=3D=3D793=3D=3D Invali=
d write of size 8</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0at 0x406038: cds_l=
ist_add (list.h:53)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x409442: que=
ue_stream (main.c:1175)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x409AB7:=
 relay_add_stream (main.c:1274)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0=
x40C47A: relay_process_control (main.c:2099)</div><div>=3D=3D793=3D=3D =C2=
=A0 =C2=A0by 0x40DBB1: relay_thread_worker (main.c:2574)</div><div>=3D=3D79=
3=3D=3D =C2=A0 =C2=A0by 0x5BDAFE2: start_thread (pthread_create.c:312)</div=
><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5ED8AFC: clone (clone.S:111)</div><=
div>=3D=3D793=3D=3D =C2=A0Address 0x6e09040 is 64 bytes inside a block of s=
ize 312 free&#39;d</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0at 0x4C2898C: fre=
e (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)</div><div>=3D=
=3D793=3D=3D =C2=A0 =C2=A0by 0x418EF8: rcu_destroy_stream (stream.c:33)</di=
v><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5079C94: ??? (in /usr/lib64/liburc=
u.so.2.0.0)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5BDAFE2: start_thre=
ad (pthread_create.c:312)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5ED8A=
FC: clone (clone.S:111)</div><div>=3D=3D793=3D=3D</div></div><div><br></div=
><div>Are there any known bugs/fixes for these ?</div><div><br></div><div><=
br></div><div>Regards,</div><div>Aravind.</div><div><br></div></div>
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
</div></div></blockquote></div></div></div><div><div><br><br clear=3D"all">=
<div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br>=
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></div>
</div></div></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9=
r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com=
" target=3D"_blank">http://www.efficios.com</a></div>
</div></div></div></div></div>
</blockquote></div><br></div>

--001a11c3fd123b7ba7051a2d1695--


--===============1642068301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1642068301==--
