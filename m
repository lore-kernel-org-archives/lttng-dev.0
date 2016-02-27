From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RCU Reclamation
Date: Sat, 27 Feb 2016 13:32:42 +0000 (UTC)
Message-ID: <1978150084.9928.1456579962251.JavaMail.zimbra__3908.92064101553$1456580024$gmane$org@efficios.com>
References: <CABTiFJbiuKp05X7QYpyVmh74ro6EJYWyOCOc2kfEHxpKCbedUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1035663531=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aZezK-0004jc-6S
 for lttng-dev@lists.lttng.org; Sat, 27 Feb 2016 08:32:51 -0500
In-Reply-To: <CABTiFJbiuKp05X7QYpyVmh74ro6EJYWyOCOc2kfEHxpKCbedUA@mail.gmail.com>
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

--===============1035663531==
Content-Type: multipart/alternative;
	boundary="----=_Part_9927_888483639.1456579962250"

------=_Part_9927_888483639.1456579962250
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Feb 27, 2016, at 8:24 AM, masoud hematpour <mashemat@gmail.com> wrote: 

> Hello to all,

> Can you please help me? I confused in the following situation:

> CPU0 CPU1
> ----------- -----------
> rcu_read_lock() .
> C.S1 .
> rcu_read_unlock() .
> .
> .
> rcu_read_lock()
> Update (C.S1)
> C.S2 Synchronise_rcu()
> free(men_C.S1)
> rcu_read_unlock()

> synchronize_rcu() wait till end of C.S2?

You might want to clarify what "C", "S1", "S2", and 
"men_C" mean, as well as the meaning of the dot ".". 

Without context, answering your question would be 
more guesswork than anything reliable. 

Thanks, 

Mathieu 

> Thank you very much

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_9927_888483639.1456579962250
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Feb 27, 2016, at 8:24 AM, masoud hematpour &lt;mashemat@gmail.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div c=
lass=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Hel=
lo to all,</div><div class=3D"gmail_default" style=3D"font-family:arial,hel=
vetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif">Can you please help me? I confused in the f=
ollowing situation:</div><div class=3D"gmail_default" style=3D"font-family:=
arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D=
"font-family:arial,helvetica,sans-serif">&nbsp; &nbsp; &nbsp;CPU0 &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CPU1</div><div class=3D"gmail_default" s=
tyle=3D"font-family:arial,helvetica,sans-serif">&nbsp; &nbsp;----------- &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;-----------</div><div class=3D"gmail_default" st=
yle=3D"font-family:arial,helvetica,sans-serif">&nbsp; rcu_read_lock() &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; .</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetic=
a,sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;C.S1 &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; .</div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif">&nbsp; rcu_read_unlock() &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .</div><div class=3D"gm=
ail_default" style=3D"font-family:arial,helvetica,sans-serif">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; .</div><div class=3D"gmail_default" style=3D"f=
ont-family:arial,helvetica,sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; . &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div><div class=3D"gmail_=
default" style=3D"font-family:arial,helvetica,sans-serif">&nbsp;rcu_read_lo=
ck() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div><div class=3D"gm=
ail_default" style=3D"font-family:arial,helvetica,sans-serif">&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;Update (C.S1)</div><div class=3D"gmail_default" style=3D"=
font-family:arial,helvetica,sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;C=
.S2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Synchronise_rcu()</div><div =
class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp;free(men_C.S1)</div><div class=3D"gmail_defaul=
t" style=3D"font-family:arial,helvetica,sans-serif"><span style=3D"color: #=
ff0000;" data-mce-style=3D"color: #ff0000;" color=3D"#ff0000">rcu_read_unlo=
ck() </span></div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:arial,helvetica,sans-serif">&nbsp;synchronize_rcu() wait till end of =
C.S2?</div></div></blockquote><div>You might want to clarify what "C", "S1"=
, "S2", and<br></div><div>"men_C" mean, as well as the meaning of the dot "=
.".<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>=
Without context, answering your question would be<br data-mce-bogus=3D"1"><=
/div><div>more guesswork than anything reliable.<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"borde=
r-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_defau=
lt" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Thank y=
ou very much</div></div><br>_______________________________________________=
<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></=
div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<b=
r>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_9927_888483639.1456579962250--


--===============1035663531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1035663531==--
