From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: tid
Date: Thu, 25 Feb 2016 17:43:10 +0000 (UTC)
Message-ID: <182356692.7833.1456422190619.JavaMail.zimbra__36216.768451459$1456422260$gmane$org@efficios.com>
References: <CABTiFJacAHs0_bq4cBeqDbvXqTUomU9qGgP=TYLneNjQXDV88Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1989236881=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aYzwc-00075x-HD
 for lttng-dev@lists.lttng.org; Thu, 25 Feb 2016 12:43:20 -0500
In-Reply-To: <CABTiFJacAHs0_bq4cBeqDbvXqTUomU9qGgP=TYLneNjQXDV88Q@mail.gmail.com>
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

--===============1989236881==
Content-Type: multipart/alternative;
	boundary="----=_Part_7832_1273072080.1456422190618"

------=_Part_7832_1273072080.1456422190618
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

It is the pthread ID as returned by pthread_self(). It is used internally, 
so it is not recommended to modify it manually. 

Thanks, 

Mathieu 

----- On Feb 25, 2016, at 11:57 AM, masoud hematpour <mashemat@gmail.com> wrote: 

> Hello,

> Excuse me, a stupid question, what does "tid" in rcu_reader do ?
> Can I modify it manually?

> Thank you

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_7832_1273072080.1456422190618
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>It is the pthread ID as returned by pthread=
_self(). It is used internally,<br></div><div>so it is not recommended to m=
odify it manually.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogu=
s=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div><sp=
an id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Feb 25, 2016, at 11:57=
 AM, masoud hematpour &lt;mashemat@gmail.com&gt; wrote:<br></span><div data=
-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #101=
0FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif">Hello,<br><br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">&nbsp;E=
xcuse me, a stupid question, what does&nbsp; "tid"&nbsp; in rcu_reader do ?=
<br>Can I modify it manually?<br><br><br></div><div class=3D"gmail_default"=
 style=3D"font-family:arial,helvetica,sans-serif">Thank you<br><br><br></di=
v></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POST_=
_">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effic=
ios.com</div></div></body></html>
------=_Part_7832_1273072080.1456422190618--


--===============1989236881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1989236881==--
