From: Yang Wang <yangw.wang5@unb.ca>
Subject: bug?
Date: Wed, 23 Jan 2013 20:09:30 +0000
Message-ID: <8E0A14A4C9B95B459AE214584119C1EB3BC909B3__21184.7803243019$1358972290$gmane$org@Hal.ad.unb.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0718229024=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from tempo.its.unb.ca ([131.202.1.21])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yangw.wang5@unb.ca>) id 1Ty6eD-0004SL-Pr
	for lttng-dev@lists.lttng.org; Wed, 23 Jan 2013 15:10:13 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Kenneth Kent <ken@unb.ca>, "," <Grame_johson@ca.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============0718229024==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8E0A14A4C9B95B459AE214584119C1EB3BC909B3Haladunbca_"

--_000_8E0A14A4C9B95B459AE214584119C1EB3BC909B3Haladunbca_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am Yang Wang, I am currently using lttng to trace my JVM.

During my using lttng in tracing JVM, I found three problems,

 1) in lttng-ust-2.1.0/include/lttng/ust-tracepoint-event.h

     why using an assertion "assert(!ret);"  (Line676)?
     not allowing double registering and init?
     if double registering or initialization (provider), why not allowed ju=
st returning silently instead
      of aborting"? How about comments assert(!ret); =3D=3D>//assert(!ret);=
 what is the side-effects
      of doing this?

 2) The other problem is in ./userspace-rcu-0.7.5/urcu/list.h Line85

  I have to add a guard "if" statement as the assertion in my program fails=
 otherwise

  static inline void
  __cds_list_del (struct cds_list_head *prev, struct cds_list_head *next)
  {
   if (prev !=3D NULL && next !=3D NULL) {
      //assert(prev !=3D NULL && next !=3D NULL);
      next->prev =3D prev;
      prev->next =3D next;
  }

 3) Now my instrumented prog is ready to run. Here is my commands:
     lttng create
     lttng enable-event -u -a
     lttng start
     ./prog

    The (lttng) instrumented prog is stuck there without any outputs relate=
d to lttng tracing, how can I know what happen inside.
    In other words, does lttng have any mechanism to trace itself?

   Thanks

   Yang

--_000_8E0A14A4C9B95B459AE214584119C1EB3BC909B3Haladunbca_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;"><font size=3D"2"><span style=3D"font-size:10pt;">Hello,<br>
<br>
I am Yang Wang, I am currently using lttng to trace my JVM.<br>
<br>
During my using lttng in tracing JVM, I found three problems,<br>
<br>
&nbsp;1) in </span></font><font size=3D"2"><span style=3D"font-size:10pt;">=
lttng-ust-2.1.0/include/lttng/ust-tracepoint-event.h</span></font><br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; why using an assertion &quot;<font size=3D"2"><spa=
n style=3D"font-size:10pt;">assert(!ret);&quot;&nbsp; (Line676)?<br>
&nbsp;&nbsp;&nbsp;&nbsp; not allowing double registering and init?<br>
&nbsp;&nbsp;&nbsp;&nbsp; if double registering or initialization (provider)=
, why not allowed just returning silently instead&nbsp;&nbsp;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of aborting&quot;? How about </span></font><=
b><font size=3D"2"><span style=3D"font-size:10pt;">comments assert(!ret); =
=3D=3D&gt;//assert(!ret);</span></font></b> what is the side-effects<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of doing this?<br>
<font size=3D"2"><span style=3D"font-size:10pt;">&nbsp;<br>
&nbsp;2) The other problem is in .<b>/userspace-rcu-0.7.5/urcu/list.h Line8=
5</b><br>
<br>
&nbsp; I have to add a guard &quot;if&quot; statement as the assertion in m=
y program fails otherwise<br>
<br>
&nbsp; static inline void<br>
&nbsp; __cds_list_del (struct cds_list_head *prev, struct cds_list_head *ne=
xt)<br>
&nbsp; {<br>
&nbsp;<b>&nbsp; if (prev !=3D NULL &amp;&amp; next !=3D NULL) {</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //assert(prev !=3D NULL &amp;&amp; next !=3D=
 NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next-&gt;prev =3D prev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev-&gt;next =3D next;<br>
&nbsp; }<br>
<br>
&nbsp;3) Now my instrumented prog is ready to run. Here is my commands:<br>
&nbsp;&nbsp;&nbsp;&nbsp; lttng create<br>
&nbsp;&nbsp;&nbsp;&nbsp; lttng enable-event -u -a<br>
&nbsp;&nbsp;&nbsp;&nbsp; lttng start<br>
&nbsp;&nbsp;&nbsp;&nbsp; ./prog <br>
<br>
&nbsp;&nbsp;&nbsp; The (lttng) instrumented prog is stuck there without any=
 outputs related to lttng tracing, how can I know what happen inside.<br>
&nbsp;&nbsp;&nbsp; In other words, does lttng have any mechanism to trace i=
tself?<br>
<br>
&nbsp;&nbsp; Thanks<br>
<br>
&nbsp;&nbsp; Yang<br>
</span></font></div>
</body>
</html>

--_000_8E0A14A4C9B95B459AE214584119C1EB3BC909B3Haladunbca_--


--===============0718229024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0718229024==--
