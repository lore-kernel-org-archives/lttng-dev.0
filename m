From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RCU Reclamation
Date: Sat, 27 Feb 2016 13:50:52 +0000 (UTC)
Message-ID: <1694364146.10021.1456581052115.JavaMail.zimbra__46858.012621715$1456581110$gmane$org@efficios.com>
References: <CABTiFJbiuKp05X7QYpyVmh74ro6EJYWyOCOc2kfEHxpKCbedUA@mail.gmail.com>
 <1978150084.9928.1456579962251.JavaMail.zimbra@efficios.com>
 <CABTiFJb7B5tzp88-x4SjY9hN9RAFiBhEy2Sb=w5RLQZ-nGo-QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1652951748=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aZfGx-0004rU-8C
 for lttng-dev@lists.lttng.org; Sat, 27 Feb 2016 08:51:04 -0500
In-Reply-To: <CABTiFJb7B5tzp88-x4SjY9hN9RAFiBhEy2Sb=w5RLQZ-nGo-QA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: masoud hematpour <mashemat@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1652951748==
Content-Type: multipart/alternative;
	boundary="----=_Part_10020_1454793395.1456581052114"

------=_Part_10020_1454793395.1456581052114
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Feb 27, 2016, at 8:42 AM, masoud hematpour <mashemat@gmail.com> wrote: 

> Excuse me ,
> C.S1 = abbreviation of Critical Section 1 and the same for C.S2. I mean using
> rcu for two different Critical Sections.
> men_C.S1= I mean the memory that Critical Section1 was reading.

Please keep the list in CC. 

The answer is that synchronize_rcu() will only return 
after the second critical section has completed, 
because in your sequence below, the second critical 
section was running when synchronize_rcu() was 
invoked. 

Thanks, 

Mathieu 

> On Sat, Feb 27, 2016 at 2:32 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

>> ----- On Feb 27, 2016, at 8:24 AM, masoud hematpour < mashemat@gmail.com >
>> wrote:

>>> Hello to all,

>>> Can you please help me? I confused in the following situation:

>>> CPU0 CPU1
>>> ----------- -----------
>>> rcu_read_lock() .
>>> C.S1 .
>>> rcu_read_unlock() .
>>> .
>>> .
>>> rcu_read_lock()
>>> Update (C.S1)
>>> C.S2 Synchronise_rcu()
>>> free(men_C.S1)
>>> rcu_read_unlock()

>>> synchronize_rcu() wait till end of C.S2?

>> You might want to clarify what "C", "S1", "S2", and
>> "men_C" mean, as well as the meaning of the dot ".".

>> Without context, answering your question would be
>> more guesswork than anything reliable.

>> Thanks,

>> Mathieu

>>> Thank you very much

>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_10020_1454793395.1456581052114
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Feb 27, 2016, at 8:42 AM, masoud hematpour &lt;mashemat@gmail.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div c=
lass=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Exc=
use me ,&nbsp;</div><div class=3D"gmail_default" style=3D"font-family:arial=
,helvetica,sans-serif">C.S1 =3D abbreviation of Critical Section 1 and the =
same for C.S2. I mean using rcu for two different Critical Sections.</div><=
div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif=
">men_C.S1=3D I mean the memory that Critical Section1 was reading.</div></=
div></blockquote><div>Please keep the list in CC.<br></div><div><br data-mc=
e-bogus=3D"1"></div><div>The answer is that synchronize_rcu() will only ret=
urn<br data-mce-bogus=3D"1"></div><div>after the second critical section ha=
s completed,<br data-mce-bogus=3D"1"></div><div>because in your sequence be=
low, the second critical<br data-mce-bogus=3D"1"></div><div>section was run=
ning when synchronize_rcu() was<br data-mce-bogus=3D"1"></div><div>invoked.=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Tha=
nks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div=
>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px so=
lid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;=
font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-ser=
if;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"=
font-family:arial,helvetica,sans-serif"><br></div></div><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">On Sat, Feb 27, 2016 at 2:32 PM, Mat=
hieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:ar=
ial,helvetica,sans-serif;font-size:12pt;color:#000000"><span class=3D""><di=
v><span>----- On Feb 27, 2016, at 8:24 AM, masoud hematpour &lt;<a href=3D"=
mailto:mashemat@gmail.com" target=3D"_blank">mashemat@gmail.com</a>&gt; wro=
te:<br></span></div></span><div><span class=3D""><blockquote style=3D"borde=
r-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif">Hello to all,</div><div=
 class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><=
br></div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,=
sans-serif">Can you please help me? I confused in the following situation:<=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif">&nbsp; &nbsp; &nbsp;CPU0 &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; CPU1</div><div class=3D"gmail_default" style=3D"font-family:=
arial,helvetica,sans-serif">&nbsp; &nbsp;----------- &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;-----------</div><div class=3D"gmail_default" style=3D"font-family:a=
rial,helvetica,sans-serif">&nbsp; rcu_read_lock() &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .</div><div clas=
s=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;C.S1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; .</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,=
sans-serif">&nbsp; rcu_read_unlock() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; .</div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; .</div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; . &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;</div><div class=3D"gmail_default" style=3D"=
font-family:arial,helvetica,sans-serif">&nbsp;rcu_read_lock() &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
Update (C.S1)</div><div class=3D"gmail_default" style=3D"font-family:arial,=
helvetica,sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;C.S2 &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp;Synchronise_rcu()</div><div class=3D"gmail_def=
ault" style=3D"font-family:arial,helvetica,sans-serif">&nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;free(men_C.S1)</div><div class=3D"gmail_default" style=3D"font-f=
amily:arial,helvetica,sans-serif"><span style=3D"color:#ff0000">rcu_read_un=
lock() </span></div><div class=3D"gmail_default" style=3D"font-family:arial=
,helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif">&nbsp;synchronize_rcu() wait till end o=
f C.S2?</div></div></blockquote></span><div>You might want to clarify what =
"C", "S1", "S2", and<br></div><div>"men_C" mean, as well as the meaning of =
the dot ".".<br></div><br><div>Without context, answering your question wou=
ld be<br></div><div>more guesswork than anything reliable.<br></div><br><di=
v>Thanks,<br></div><br><div>Mathieu<br></div><br><blockquote style=3D"borde=
r-left:2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D=
"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Thank you =
very much</div></div><br>_______________________________________________<br=
>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" tar=
get=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.l=
ttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><span=
 style=3D"color: #888888;" data-mce-style=3D"color: #888888;" color=3D"#888=
888"><br></span></span></blockquote></div><span class=3D"HOEnZb"><span styl=
e=3D"color: #888888;" data-mce-style=3D"color: #888888;" color=3D"#888888">=
<br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D=
"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a><br =
data-mce-bogus=3D"1"></div></span></span></div></div></blockquote></div></d=
iv><br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">=
-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios=
.com</div></div></body></html>
------=_Part_10020_1454793395.1456581052114--


--===============1652951748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1652951748==--
