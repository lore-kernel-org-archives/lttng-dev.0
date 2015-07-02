From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: application changes to support lttng
Date: Thu, 2 Jul 2015 17:02:34 +0000 (UTC)
Message-ID: <389822667.2829.1435856554624.JavaMail.zimbra__31817.031504079$1435856646$gmane$org@efficios.com>
References: <CACh_V54iounQNr+jxP85YjPuivjMTgowOCuTaox9fMRC9=ty0w@mail.gmail.com>
 <CACh_V578QYMi8CvhmvtR+QOY33maFNB6SB-eHBVOGOoJgUZ3HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1888246325=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZAhst-0004wT-RV
 for lttng-dev@lists.lttng.org; Thu, 02 Jul 2015 13:02:58 -0400
In-Reply-To: <CACh_V578QYMi8CvhmvtR+QOY33maFNB6SB-eHBVOGOoJgUZ3HA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jamie explorer <jamieexplorer@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1888246325==
Content-Type: multipart/alternative;
	boundary="----=_Part_2828_174645776.1435856554623"

------=_Part_2828_174645776.1435856554623
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jun 30, 2015, at 8:08 PM, jamie explorer <jamieexplorer@gmail.com> wrote: 

> Hi lttng-dev,
> sorry for asking basic questions.
> Can you guys point me to any documentation which has this info. lttng.org
> documentation doesnt have info about this.

> How does the app register to use lttng?

It awaits on a futex in a shared memory area, and then connects to the session 
daemon through a unix socket. 

> how do sessiond, app and lttng-ust interact? is there any socket from every app
> to sessiond?

Through unix sockets. Yes, there are two unix sockets between each instrumented 
application and each session daemon. One for commands (sent by session daemon, 
reply received from application), the other for notifications (send by app, reply received 
by session daemon). 

> How is the app modified when instrumented using lttng? are there any threads
> added?

Yes, 2 threads are added. One interacts with root sessiond (if there is one 
active), the other with per-user sessiond (if one is active). If no sessiond is 
active, those threads simply wait on futexes. 

> Are there any powerful tools for analysis on collected traces.

Trace Compass (Eclipse UI) 
lttng-analyses 
lttngtop 
and of course babeltrace for the event-by-event text output. 

Best regards, 

Mathieu 

> /Jam

> On Mon, Jun 29, 2015 at 10:03 AM, jamie explorer < jamieexplorer@gmail.com >
> wrote:

>> Hello,
>> I have just started using lttng and still looking at documentation.
>> Can you help me with some info.

>> How does the app register to use lttng?
>> how do sessiond, app and lttng-ust interact? is there any socket from every app
>> to sessiond?
>> How is the app modified when instrumented using lttng? are there any threads
>> added?
>> when lttng instrumentation is linked along with app
>> Are there any powerful tools for analysis on collected traces.

>> /Jam

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_2828_174645776.1435856554623
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><span id=3D"zwchr" data-marker=3D=
"__DIVIDER__">----- On Jun 30, 2015, at 8:08 PM, jamie explorer &lt;jamieex=
plorer@gmail.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED_TEXT__">=
<blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-=
left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"=
>Hi lttng-dev,<br><div>sorry for asking basic questions.</div><div>Can you =
guys point me to any documentation which has this info. <a href=3D"http://l=
ttng.org" target=3D"_blank">lttng.org</a> documentation doesnt have info ab=
out this.</div><br><div><div style=3D"font-size:12.8000001907349px">How doe=
s the app register to use lttng?</div></div></div></blockquote><div>It awai=
ts on a futex in a shared memory area, and then connects to the session<br>=
</div><div>daemon through a unix socket.<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt;"><div dir=3D"ltr"><div><div style=3D"font-size:12.8000001907=
349px">how do sessiond, app and lttng-ust interact? is there any socket fro=
m every app to sessiond?</div></div></div></blockquote><div>Through unix so=
ckets. Yes, there are two unix sockets between each instrumented<br></div><=
div>application and each session daemon. One for commands (sent by session =
daemon,<br></div><div>reply received from application), the other for notif=
ications (send by app, reply received<br data-mce-bogus=3D"1"></div><div>by=
 session daemon).<br data-mce-bogus=3D"1"></div><blockquote style=3D"border=
-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-we=
ight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ar=
ial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div style=3D"font-si=
ze:12.8000001907349px">How is the app modified when instrumented using lttn=
g? are there any threads added?&nbsp;</div></div></div></blockquote><div>Ye=
s, 2 threads are added. One interacts with root sessiond (if there is one<b=
r></div><div>active), the other with per-user sessiond (if one is active). =
If no sessiond is<br data-mce-bogus=3D"1"></div><div>active, those threads =
simply wait on futexes.<br data-mce-bogus=3D"1"></div><blockquote style=3D"=
border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div style=3D"f=
ont-size:12.8000001907349px"><span style=3D"font-size:12.8000001907349px">A=
re there any powerful tools for analysis on collected traces.</span></div><=
/div></div></blockquote><div>Trace Compass (Eclipse UI)<br></div><div>lttng=
-analyses<br data-mce-bogus=3D"1"></div><div>lttngtop<br data-mce-bogus=3D"=
1"></div><div>and of course babeltrace for the event-by-event text output.<=
br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Best=
 regards,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D=
"ltr"><div><div style=3D"font-size:12.8000001907349px"><br></div></div><div=
 style=3D"font-size:12.8000001907349px"><span style=3D"font-size:12.8000001=
907349px"><br></span></div><div style=3D"font-size:12.8000001907349px">/Jam=
</div><div style=3D"font-size:12.8000001907349px"><span style=3D"font-size:=
12.8000001907349px"><br></span></div></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Mon, Jun 29, 2015 at 10:03 AM, jamie explorer =
<span dir=3D"ltr">&lt;<a href=3D"mailto:jamieexplorer@gmail.com" target=3D"=
_blank">jamieexplorer@gmail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hello,<br><div>I have just started using ltt=
ng and still looking at documentation.</div><div>Can you help me with some =
info.</div><br><div>How does the app register to use lttng?</div><div>how d=
o sessiond, app and lttng-ust interact? is there any socket from every app =
to sessiond?</div><div>How is the app modified when instrumented using lttn=
g? are there any threads added?</div><div>when lttng instrumentation is lin=
ked along with app</div><div>Are there any powerful tools for analysis on c=
ollected traces.</div><br><div>/Jam&nbsp;</div></div></blockquote></div><br=
></div><br>_______________________________________________<br>lttng-dev mai=
ling list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SI=
G_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://ww=
w.efficios.com</div></div></body></html>
------=_Part_2828_174645776.1435856554623--


--===============1888246325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1888246325==--
