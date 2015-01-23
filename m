From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: enable-channel switch timer not getting updated
Date: Fri, 23 Jan 2015 19:16:47 +0000 (UTC)
Message-ID: <167786765.40297.1422040607809.JavaMail.zimbra__40419.4088223905$1422040865$gmane$org@efficios.com>
References: <CAM5kDqyYjQFnU3bO9j0rxSzLPgDD_kcWP9PmJzf+ZRWeqhYm3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1241561068=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YEjir-0000dO-Kv
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 14:16:50 -0500
In-Reply-To: <CAM5kDqyYjQFnU3bO9j0rxSzLPgDD_kcWP9PmJzf+ZRWeqhYm3w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1241561068==
Content-Type: multipart/alternative;
	boundary="----=_Part_40296_566300667.1422040607809"

------=_Part_40296_566300667.1422040607809
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Anand Neeli" <anand.neeli@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, January 23, 2015 5:16:31 AM
> Subject: [lttng-dev] enable-channel switch timer not getting updated

> Hi All,
> I'm using 2.4.1 version.
> and i dont see switch timer being updated in output of "lttng list <session>"
> i'm using default subbuf-size and default sub-buf count.

> output :

> $ # lttng list mys4
> Tracing session mys4: [active]
> Trace path: net4:// 127.0.0.1:5342/ [data: 5343]

> === Domain: UST global ===
> Buffer type: per PID
> Channels:
> -------------
> - myc4: [enabled]

> Attributes:
> overwrite mode: 0
> subbufers size: 4096
> number of subbufers: 4
> switch timer interval: 0 <<<<<<<< doesnt show switch-timer
> read timer interval: 0
> output: mmap()

> Events:
> * (type: tracepoint) [enabled] [has exclusions]

> i used following commands to create session

> lttng --no-sessiond create mys4 --live 200000 -U net://localhost

> lttng enable-channel myc4 --userspace --buffers-pid -s mys4 --tracefile-size
> 8388608 --tracefile-count 8 --switch-timer 1000

> lttng enable-event --channel myc4 --userspace --all --exclude 'ust_libc:*' -s
> mys4

> lttng start mys4

> Please let me know if i missed anything.

Can you try on the latest stable-2.4 commit ? (or at least the last 2.4.x release) 

Thanks, 

Mathieu 

> Thanks,

> Anand Neeli

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_40296_566300667.1422040607809
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>Fr=
om: </b>"Anand Neeli" &lt;anand.neeli@gmail.com&gt;<br><b>To: </b>lttng-dev=
@lists.lttng.org<br><b>Sent: </b>Friday, January 23, 2015 5:16:31 AM<br><b>=
Subject: </b>[lttng-dev] enable-channel switch timer not getting updated<br=
><div><br></div><div dir=3D"ltr">Hi All,<div>I'm using 2.4.1 version.</div>=
<div>and i dont see switch timer being updated in output of "lttng list &lt=
;session&gt;"</div><div>i'm using default subbuf-size and default sub-buf c=
ount.</div><div><br></div><div>output :</div><div><br></div><div>$ # lttng =
list mys4<br></div><div><div>Tracing session mys4: [active]</div><div>&nbsp=
; &nbsp; Trace path: net4://<a href=3D"http://127.0.0.1:5342/" target=3D"_b=
lank">127.0.0.1:5342/</a> [data: 5343]</div><div><br></div><div>=3D=3D=3D D=
omain: UST global =3D=3D=3D</div><div>Buffer type: per PID</div><div>Channe=
ls:</div><div>-------------</div><div>- myc4: [enabled]</div><div><br></div=
><div>&nbsp; &nbsp; Attributes:</div><div>&nbsp; &nbsp; &nbsp; overwrite mo=
de: 0</div><div>&nbsp; &nbsp; &nbsp; subbufers size: 4096</div><div>&nbsp; =
&nbsp; &nbsp; number of subbufers: 4</div><div><b>&nbsp; &nbsp; &nbsp; swit=
ch timer interval: 0 &nbsp; &lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt; doesnt show sw=
itch-timer</b></div><div>&nbsp; &nbsp; &nbsp; read timer interval: 0</div><=
div>&nbsp; &nbsp; &nbsp; output: mmap()</div><div><br></div><div>&nbsp; &nb=
sp; Events:</div><div>&nbsp; &nbsp; &nbsp; * (type: tracepoint) [enabled] [=
has exclusions]</div><div><br></div></div><div><br></div><div>i used follow=
ing commands to create session</div><div><p class=3D"">lttng&nbsp; --no-ses=
siond create mys4 --live 200000 -U net://localhost</p><p class=3D"">lttng e=
nable-channel myc4 --userspace --buffers-pid -s mys4 --tracefile-size 83886=
08 --tracefile-count 8&nbsp;<span style=3D"font-family:'Arial,Bold';font-si=
ze:11pt"><b>--switch-timer 1000</b></span></p><p class=3D"">lttng enable-ev=
ent --channel myc4 --userspace --all <span class=3D"">--exclude 'ust_libc:*=
'</span> -s mys4<br></p><p class=3D"">lttng start mys4<br></p><p class=3D""=
><br></p><p class=3D"">Please let me know if i missed anything.</p></div></=
div></blockquote><div><br></div><div>Can you try on the latest stable-2.4 c=
ommit ? (or at least the last 2.4.x release)<br></div><div><br></div><div>T=
hanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><=
p class=3D"">Thanks,</p><p class=3D"">Anand Neeli</p></div></div><br>______=
_________________________________________<br>lttng-dev mailing list<br>lttn=
g-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev<br></blockquote><div><br><br></div><div><br></div><div>-- <br></div=
><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://=
www.efficios.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_40296_566300667.1422040607809--


--===============1241561068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1241561068==--
