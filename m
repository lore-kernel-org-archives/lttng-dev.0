From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Performance impact using the "filter" option
Date: Wed, 19 Mar 2014 16:48:44 -0400 (EDT)
Message-ID: <173115420.1939299.1395262124153.JavaMail.root__39070.5095175237$1395262175$gmane$org@polymtl.ca>
References: <CANRvXTMAYGjiQsRO+-4wsGQkaTVpBGtuuoUu=E-SVuMU5BXFLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0977421987=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michel.dagenais@polymtl.ca>) id 1WQNPs-0000Cv-K2
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 16:48:51 -0400
In-Reply-To: <CANRvXTMAYGjiQsRO+-4wsGQkaTVpBGtuuoUu=E-SVuMU5BXFLw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ilya Mirsky <ilya.mirsky@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0977421987==
Content-Type: multipart/alternative;
	boundary="----=_Part_1939298_563234428.1395262124152"

------=_Part_1939298_563234428.1395262124152
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

> That's what I thought, but benchmarking showed that there's
> practically no difference.
> The filter is a simple ID comparison of the form 'id % 1,000 == 0',
> so 999 out of 1K tracepoints are filtered out.
> Could you please point me to some references on this topic?
What is the running time and trace size with tracing disabled, with tracing enabled unconditionally, and with tracing under condition? If tracing takes negligible time, filtering will not change much. Note that I have not experimented with the current UST filter implementation but with a similar facility in GDB and an in-kernel prototype. 

This article is not directly related but discusses many of these issues 
http://benthamscience.com/open/tocsj/articles/V006/11TOCSJ.htm 

------=_Part_1939298_563234428.1395262124152
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: times new roman,new york,times,serif; font-size: =
12pt; color: #000000'><br><blockquote style=3D"border-left:2px solid #1010F=
F;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt;"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_q=
uote"><div>That's what I thought, but benchmarking showed that there's prac=
tically no difference.</div><div>The filter is a simple ID comparison of th=
e form 'id % 1,000 =3D=3D 0', so 999 out of 1K tracepoints are filtered out=
.</div>

<div id=3D"DWT157">Could you please point me to some references on this top=
ic?</div></div></div></div></blockquote>What is the running time and trace =
size with tracing disabled, with tracing enabled unconditionally, and with =
tracing under condition? If tracing takes negligible time, filtering will n=
ot change much. Note that I have not experimented with the current UST filt=
er implementation but with a similar facility in GDB and an in-kernel proto=
type.<br><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px=
;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div di=
r=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div></div>=
</div></div></div></blockquote>This article is not directly related but dis=
cusses many of these issues<br>http://benthamscience.com/open/tocsj/article=
s/V006/11TOCSJ.htm<br><blockquote style=3D"border-left:2px solid #1010FF;ma=
rgin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:1=
2pt;"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote=
"><div></div></div></div></div></blockquote></div></body></html>
------=_Part_1939298_563234428.1395262124152--


--===============0977421987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0977421987==--
