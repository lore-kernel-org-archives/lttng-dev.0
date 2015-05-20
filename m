From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng function tracing nginx problem
Date: Wed, 20 May 2015 16:28:41 +0000 (UTC)
Message-ID: <638476085.4659.1432139321124.JavaMail.zimbra__49060.1818463348$1432139411$gmane$org@efficios.com>
References: <SNT146-W4B20B8ED37731C883223FB8C20@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2111375222=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Yv6rO-00007m-A2
 for lttng-dev@lists.lttng.org; Wed, 20 May 2015 12:28:54 -0400
In-Reply-To: <SNT146-W4B20B8ED37731C883223FB8C20@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: gang li <portlet@outlook.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2111375222==
Content-Type: multipart/alternative;
	boundary="----=_Part_4658_1261798030.1432139321123"

------=_Part_4658_1261798030.1432139321123
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> hi all,

> I compile the nginx-1.4.7 with FLAG -finstrument-functions , and start nginx
> like this:

> LD_PRELOAD=liblttng-ust-cyg-profile-fast.so ./nginx

> Then I use the command lttng list --userspace and got nothing like this:

> UST events:

> -------------

> None

> I don't understand why I can't get the func_exit/entry events from nginx.

Is the "ngix" executable a binary executable or a shell script ? 

Can you give us the output of "file ./ngix" ? 

You might want to try 

export LD_PRELOAD=liblttng-ust-cyg-profile-fast.so 
./ngix 

Thanks, 

Mathieu 

> By the way, I test function tracing with a single c source file and works
> well, output like this:

> UST events:

> -------------

> PID: 4687 - Name: ./tt

> lttng_ust_cyg_profile:func_exit (loglevel: TRACE_DEBUG_FUNCTION (12)) (type:
> tracepoint)

> lttng_ust_cyg_profile:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12)) (type:
> tracepoint)

> lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type: tracepoint)

> ust_baddr_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) (type:
> tracepoint)

> Wishing for help.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_4658_1261798030.1432139321123
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><hr id=3D"zwchr"><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 12pt;
font-family:Calibri
}
--></style><div dir=3D"ltr">hi all,<div><br></div><div>I compile the nginx-=
1.4.7 with FLAG&nbsp;<span style=3D"font-size: 12pt;">-finstrument-function=
s</span><span style=3D"font-size: 12pt;">&nbsp;, and start nginx like this:=
</span></div><div><span style=3D"font-size: 12pt;"><br></span></div><div><p=
 class=3D"p1"><span class=3D"s1">LD_PRELOAD=3Dliblttng-ust-cyg-profile-fast=
.so &nbsp;./nginx</span></p><p class=3D"p1"><span class=3D"s1"><br></span><=
/p><p class=3D"p1"><span class=3D"s1">Then I use the command&nbsp;</span><s=
pan style=3D"font-size: 12pt;">lttng list --userspace and got nothing like =
this:</span></p><p class=3D"p1"><br></p><p class=3D"p1"><span class=3D"s1">=
UST events:</span></p><p class=3D"p1"><span class=3D"s1">-------------</spa=
n></p><p class=3D"p1"><span class=3D"s1">None</span></p><p class=3D"p1"><sp=
an class=3D"s1"><br></span></p><p class=3D"p1"><span class=3D"s1"><br class=
=3D"Apple-interchange-newline">I don't understand why I can't get the func_=
exit/entry events from nginx.</span></p></div></div></blockquote><div><br><=
/div><div>Is the "ngix" executable a binary executable or a shell script ?<=
br></div><div><br></div><div>Can you give us the output of "file ./ngix" ?<=
br></div><div><br></div><div>You might want to try<br></div><div><br></div>=
<div>export LD_PRELOAD=3Dliblttng-ust-cyg-profile-fast.so<br></div><div>./n=
gix<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathi=
eu<br></div><div><br></div><div><br></div><blockquote style=3D"border-left:=
2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt;"><div dir=3D"ltr"><div><p class=3D"p1"><span style=
=3D"font-size: 12pt;"><br></span></p><p class=3D"p1"><span style=3D"font-si=
ze: 12pt;">By the way, I test function tracing with a single c source file =
and works well, output like this:</span></p><p class=3D"p1"><span class=3D"=
s1"><br></span></p><p class=3D"p1"><span class=3D"s1">UST events:</span></p=
><p class=3D"p1"><span class=3D"s1">-------------</span></p><p class=3D"p2"=
><br></p><p class=3D"p1"><span class=3D"s1">PID: 4687 - Name: ./tt</span></=
p><p class=3D"p1"><span class=3D"s1">&nbsp; &nbsp; &nbsp; lttng_ust_cyg_pro=
file:func_exit (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)</sp=
an></p><p class=3D"p1"><span class=3D"s1">&nbsp; &nbsp; &nbsp; lttng_ust_cy=
g_profile:func_entry (loglevel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoin=
t)</span></p><p class=3D"p1"><span class=3D"s1">&nbsp; &nbsp; &nbsp; lttng_=
ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type: tracepoint)</span></p>=
<p class=3D"p1"><span class=3D"s1">














</span></p><p class=3D"p1"><span class=3D"s1">&nbsp; &nbsp; &nbsp;&nbsp;ust=
_baddr_statedump:soinfo (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint=
)</span></p><p class=3D"p1"><span class=3D"s1"><br></span></p><p class=3D"p=
1"><span class=3D"s1"><br></span></p><p class=3D"p1">Wishing for help.</p><=
/div></div><br>_______________________________________________<br>lttng-dev=
 mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></=
div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>Eff=
iciOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div></di=
v></body></html>
------=_Part_4658_1261798030.1432139321123--


--===============2111375222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2111375222==--
