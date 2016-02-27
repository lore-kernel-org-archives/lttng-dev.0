From: masoud hematpour <mashemat@gmail.com>
Subject: Re: RCU Reclamation
Date: Sat, 27 Feb 2016 15:03:13 +0100
Message-ID: <CABTiFJaLFd2fWwGZbfpE-VvoT61Rj9L+CoGu2V8gyVZq9GOe+w__25668.4293425225$1456581889$gmane$org@mail.gmail.com>
References: <CABTiFJbiuKp05X7QYpyVmh74ro6EJYWyOCOc2kfEHxpKCbedUA@mail.gmail.com>
 <1978150084.9928.1456579962251.JavaMail.zimbra@efficios.com>
 <CABTiFJb7B5tzp88-x4SjY9hN9RAFiBhEy2Sb=w5RLQZ-nGo-QA@mail.gmail.com>
 <1694364146.10021.1456581052115.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0287433313=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mashemat@gmail.com>) id 1aZfTS-0004y3-QL
 for lttng-dev@lists.lttng.org; Sat, 27 Feb 2016 09:03:59 -0500
Received: by mail-yk0-f182.google.com with SMTP id z13so46554958ykd.0
 for <lttng-dev@lists.lttng.org>; Sat, 27 Feb 2016 06:03:58 -0800 (PST)
In-Reply-To: <1694364146.10021.1456581052115.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0287433313==
Content-Type: multipart/alternative; boundary=001a114738b8c3103d052cc0e235

--001a114738b8c3103d052cc0e235
Content-Type: text/plain; charset=UTF-8

Thank you very much for your info Mathieu.

On Sat, Feb 27, 2016 at 2:50 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Feb 27, 2016, at 8:42 AM, masoud hematpour <mashemat@gmail.com>
> wrote:
>
> Excuse me ,
> C.S1 = abbreviation of Critical Section 1 and the same for C.S2. I mean
> using rcu for two different Critical Sections.
> men_C.S1= I mean the memory that Critical Section1 was reading.
>
> Please keep the list in CC.
>
> The answer is that synchronize_rcu() will only return
> after the second critical section has completed,
> because in your sequence below, the second critical
> section was running when synchronize_rcu() was
> invoked.
>
> Thanks,
>
> Mathieu
>
>
>
>
> On Sat, Feb 27, 2016 at 2:32 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> ----- On Feb 27, 2016, at 8:24 AM, masoud hematpour <mashemat@gmail.com>
>> wrote:
>>
>> Hello to all,
>>
>> Can you please help me? I confused in the following situation:
>>
>>      CPU0                                   CPU1
>>    -----------                              -----------
>>   rcu_read_lock()                         .
>>          C.S1                                   .
>>   rcu_read_unlock()                     .
>>             .
>>             .
>>  rcu_read_lock()
>>                                                    Update (C.S1)
>>          C.S2                                  Synchronise_rcu()
>>                                                    free(men_C.S1)
>> rcu_read_unlock()
>>
>>  synchronize_rcu() wait till end of C.S2?
>>
>> You might want to clarify what "C", "S1", "S2", and
>> "men_C" mean, as well as the meaning of the dot ".".
>>
>> Without context, answering your question would be
>> more guesswork than anything reliable.
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>> Thank you very much
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a114738b8c3103d052cc0e235
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Thank you very much for your info Mathieu.</div></div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Feb 27, 20=
16 at 2:50 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:ma=
thieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=
=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><s=
pan class=3D""><div><span>----- On Feb 27, 2016, at 8:42 AM, masoud hematpo=
ur &lt;<a href=3D"mailto:mashemat@gmail.com" target=3D"_blank">mashemat@gma=
il.com</a>&gt; wrote:<br></span></div></span><div><span class=3D""><blockqu=
ote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div cla=
ss=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Excus=
e me ,=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif">C.S1 =3D abbreviation of Critical Section 1 and the sa=
me for C.S2. I mean using rcu for two different Critical Sections.</div><di=
v class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">=
men_C.S1=3D I mean the memory that Critical Section1 was reading.</div></di=
v></blockquote></span><div>Please keep the list in CC.<br></div><div><br></=
div><div>The answer is that synchronize_rcu() will only return<br></div><di=
v>after the second critical section has completed,<br></div><div>because in=
 your sequence below, the second critical<br></div><div>section was running=
 when synchronize_rcu() was<br></div><div>invoked.<br></div><div><br></div>=
<div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><div class=
=3D"h5"><div><br></div><div><br></div><blockquote style=3D"border-left:2px =
solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D=
"font-family:arial,helvetica,sans-serif"><br></div></div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Sat, Feb 27, 2016 at 2:32 PM, Ma=
thieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@e=
fficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:a=
rial,helvetica,sans-serif;font-size:12pt;color:#000000"><span><div><span>--=
--- On Feb 27, 2016, at 8:24 AM, masoud hematpour &lt;<a href=3D"mailto:mas=
hemat@gmail.com" target=3D"_blank">mashemat@gmail.com</a>&gt; wrote:<br></s=
pan></div></span><div><span><blockquote style=3D"border-left:2px solid #101=
0ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-fami=
ly:arial,helvetica,sans-serif">Hello to all,</div><div class=3D"gmail_defau=
lt" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Can you=
 please help me? I confused in the following situation:</div><div class=3D"=
gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div><=
div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif=
">=C2=A0 =C2=A0 =C2=A0CPU0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU1=
</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,san=
s-serif">=C2=A0 =C2=A0----------- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-----------<=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif">=C2=A0 rcu_read_lock() =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .</div><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0C.S1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .</div><div =
class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">=
=C2=A0 rcu_read_unlock() =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .</div><div class=3D"gmail_default" style=3D"font-fami=
ly:arial,helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .<=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 . =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0</div><div class=3D"gmail_default" style=3D"font-family=
:arial,helvetica,sans-serif">=C2=A0rcu_read_lock() =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0</div><div class=3D"gmail_default" style=3D"font-fa=
mily:arial,helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Update (C=
.S1)</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica=
,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C.S2 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Synchronise_rcu()</div><div class=3D"gmail_default"=
 style=3D"font-family:arial,helvetica,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free(men_C.S1)</div><div class=3D"gmail_default" style=3D"font-fa=
mily:arial,helvetica,sans-serif"><span style=3D"color:#ff0000">rcu_read_unl=
ock() </span></div><div class=3D"gmail_default" style=3D"font-family:arial,=
helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-=
family:arial,helvetica,sans-serif">=C2=A0synchronize_rcu() wait till end of=
 C.S2?</div></div></blockquote></span><div>You might want to clarify what &=
quot;C&quot;, &quot;S1&quot;, &quot;S2&quot;, and<br></div><div>&quot;men_C=
&quot; mean, as well as the meaning of the dot &quot;.&quot;.<br></div><br>=
<div>Without context, answering your question would be<br></div><div>more g=
uesswork than anything reliable.<br></div><br><div>Thanks,<br></div><br><di=
v>Mathieu<br></div><br><blockquote style=3D"border-left:2px solid #1010ff;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:ar=
ial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"f=
ont-family:arial,helvetica,sans-serif">Thank you very much</div></div><br>_=
______________________________________________<br>lttng-dev mailing list<br=
><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@l=
ists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><span><span style=3D"color:#888888" color=3D"#888888">=
<br></span></span></blockquote></div><span><span style=3D"color:#888888" co=
lor=3D"#888888"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS In=
c.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effi=
cios.com</a><br></div></span></span></div></div></blockquote></div></div><b=
r></blockquote></div></div></div><div><div class=3D"h5"><div><br></div><div=
>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://=
www.efficios.com" target=3D"_blank">http://www.efficios.com</a></div></div>=
</div></div></div></blockquote></div><br></div>

--001a114738b8c3103d052cc0e235--


--===============0287433313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0287433313==--
