From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: memory usage depending on number and size of
 subbuffers
Date: Wed, 16 Apr 2014 17:32:39 +0000 (UTC)
Message-ID: <1715346731.2460.1397669559277.JavaMail.zimbra__8426.98210985891$1397669625$gmane$org@efficios.com>
References: <CAPkDDd40zkVK46vZ-x6SaDvBLvwufN219T+9d36neg95F0WH-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0382288735=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WaThW-0002RA-C0
 for lttng-dev@lists.lttng.org; Wed, 16 Apr 2014 13:32:52 -0400
In-Reply-To: <CAPkDDd40zkVK46vZ-x6SaDvBLvwufN219T+9d36neg95F0WH-g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?Q?S=C3=A9bastien_Barth=C3=A9l=C3=A9my?= <barthelemy@crans.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0382288735==
Content-Type: multipart/alternative;
	boundary="----=_Part_2459_1883734115.1397669559275"

------=_Part_2459_1883734115.1397669559275
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "S=C3=A9bastien Barth=C3=A9l=C3=A9my" <barthelemy@crans.org>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, April 16, 2014 12:22:42 PM
> Subject: [lttng-dev] memory usage depending on number and size of subbuff=
ers

> Hi all,

> LTTng uses more memory than I expected. On the simple experiment below on=
e
> can see that the "cached" memory increases by

> subbuf_size*num_cpu*(num_subbuf+1)

> That's not a big deal, but I did not expect the "+1".

> Does somebody know where it comes from?

It is the extra sub-buffer needed for reading a sub-buffer while the=20
other sub-buffers are written into. It's needed for snapshotting=20
data while tracing is active.=20

Thanks,=20

Mathieu=20

> -- Regards, Sebastien

> 12M =3D=3D 2M*2*(2+1)
> 24M =3D=3D 4M*2*(2+1)
> 20M =3D=3D 2M*2*(4+1)
> 40M =3D=3D 4M*2*(4+1)

> # grep processor /proc/cpuinfo
> processor : 0
> processor : 1

> # lttng create
> Session auto-20140416-180246 created.
> Traces will be written in /root/lttng-traces/auto-20140416-180246

> # free -m
> total used free shared buffers cached
> Mem: 1002 670 332 0 22 250
> -/+ buffers/cache: 397 605
> Swap: 0 0 0

> # lttng enable-channel channel0 --num-subbuf 2 --subbuf-size 2M -u
> UST channel channel0 enabled for session auto-20140416-180246

> # free -m
> total used free shared buffers cached
> Mem: 1002 682 320 0 22 262
> -/+ buffers/cache: 397 605
> Swap: 0 0 0

> # lttng destroy
> Session auto-20140416-180246 destroyed

> # lttng create
> Session auto-20140416-180317 created.
> Traces will be written in /root/lttng-traces/auto-20140416-180317

> # free -m
> total used free shared buffers cached
> Mem: 1002 670 332 0 22 250
> -/+ buffers/cache: 397 605
> Swap: 0 0 0

> # lttng enable-channel channel0 --num-subbuf 2 --subbuf-size 4M -u
> UST channel channel0 enabled for session auto-20140416-180317

> # free -m
> total used free shared buffers cached
> Mem: 1002 694 307 0 22 274
> -/+ buffers/cache: 397 605
> Swap: 0 0 0

> # lttng destroy
> Session auto-20140416-180317 destroyed

> # lttng create
> Session auto-20140416-180339 created.
> Traces will be written in /root/lttng-traces/auto-20140416-180339

> # free -m
> total used free shared buffers cached
> Mem: 1002 670 332 0 22 250
> -/+ buffers/cache: 397 605
> Swap: 0 0 0

> # lttng enable-channel channel0 --num-subbuf 4 --subbuf-size 2M -u
> UST channel channel0 enabled for session auto-20140416-180339

> # free -m
> total used free shared buffers cached
> Mem: 1002 690 311 0 22 270
> -/+ buffers/cache: 397 605
> Swap: 0 0 0

> # lttng destroy
> Session auto-20140416-180339 destroyed

> # lttng create
> Session auto-20140416-180406 created.
> Traces will be written in /root/lttng-traces/auto-20140416-180406

> # free -m
> total used free shared buffers cached
> Mem: 1002 670 332 0 22 250
> -/+ buffers/cache: 397 605
> Swap: 0 0 0

> # lttng enable-channel channel0 --num-subbuf 4 --subbuf-size 4M -u
> UST channel channel0 enabled for session auto-20140416-180406

> # free -m
> total used free shared buffers cached
> Mem: 1002 710 292 0 22 290
> -/+ buffers/cache: 397 605

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_2459_1883734115.1397669559275
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><div><br></div><hr id=
=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>Fr=
om: </b>"S=C3=A9bastien Barth=C3=A9l=C3=A9my" &lt;barthelemy@crans.org&gt;<=
br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Wednesday, April 16=
, 2014 12:22:42 PM<br><b>Subject: </b>[lttng-dev] memory usage depending on=
 number and size of subbuffers<br><div><br></div><div dir=3D"ltr"><div><div=
>Hi all, <br><div><br></div></div>LTTng uses more memory than I expected. O=
n the simple experiment below
one can see that the "cached" memory increases by<br><div><br></div>subbuf_=
size*num_cpu*(num_subbuf+1)<br><div><br></div></div><div>That's not a big d=
eal, but I did not expect the "+1".<br><div><br></div>Does somebody know wh=
ere it comes from?</div></div></blockquote><div><br></div><div>It is the ex=
tra sub-buffer needed for reading a sub-buffer while the<br></div><div>othe=
r sub-buffers are written into. It's needed for snapshotting<br></div><div>=
data while tracing is active.<br></div><div><br></div><div>Thanks,<br></div=
><div><br></div><div>Mathieu<br></div><div><br></div><blockquote style=3D"b=
order-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><br><div><br></d=
iv></div><div>-- Regards, Sebastien<br><div><br></div><br></div><div>12M =
=3D=3D 2M*2*(2+1)<br>24M =3D=3D 4M*2*(2+1)<br>20M =3D=3D 2M*2*(4+1)<br>40M =
=3D=3D 4M*2*(4+1)<br></div><div><br># grep processor /proc/cpuinfo<br>proce=
ssor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>processor&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; : 1<br><br># lttng create<br>Session auto-20140416-18024=
6 created.<br>Traces will be written in /root/lttng-traces/auto-20140416-18=
0246<br><div><br></div># free -m<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 used&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free&nbsp;&nbsp;&nbsp;&nbsp; shar=
ed&nbsp;&nbsp;&nbsp; buffers&nbsp;&nbsp;&nbsp;&nbsp; cached<br>
Mem:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1002&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 670&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 332&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 250<br>-/+ buffers/cache:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39=
7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 605<br>Swap:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0<br><div><br></div># lttng enable-channel channel0 --num-subbuf =
2 --subbuf-size 2M -u<br>
UST channel channel0 enabled for session auto-20140416-180246<br><div><br><=
/div># free -m<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; free&nbsp;&nbsp;&nbsp;&nbsp; shared&nbsp;&nbsp;&nbs=
p; buffers&nbsp;&nbsp;&nbsp;&nbsp; cached<br>Mem:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 1002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 682&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 320&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 262<br>
-/+ buffers/cache:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 397&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 605<br>Swap:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<=
br><div><br></div># lttng destroy<br>Session auto-20140416-180246 destroyed=
<br><div><br></div># lttng create<br>Session auto-20140416-180317 created.<=
br>Traces will be written in /root/lttng-traces/auto-20140416-180317<br><br=
># free -m<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; free&nbsp;&nbsp;&nbsp;&nbsp; shared&nbsp;&nbsp;&nbsp; b=
uffers&nbsp;&nbsp;&nbsp;&nbsp; cached<br>Mem:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 1002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 670=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 332&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 250<br>-/+ buffers/cache:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 397&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 605<br>Swap:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br><br># lttng enable-=
channel channel0 --num-subbuf 2 --subbuf-size 4M -u<br>UST channel channel0=
 enabled for session auto-20140416-180317<br><div><br></div># free -m<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tota=
l&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; free&nbsp;&nbsp;&nbsp;&nbsp; shared&nbsp;&nbsp;&nbsp; buffers&nbsp;&nbs=
p;&nbsp;&nbsp; cached<br>
Mem:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1002&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 694&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 307&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 274<br>-/+ buffers/cache:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39=
7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 605<br>Swap:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0<br><div><br></div># lttng destroy<br>Session auto-20140416-1803=
17 destroyed<br><br># lttng create<br>Session auto-20140416-180339 created.=
<br>Traces will be written in /root/lttng-traces/auto-20140416-180339<br><d=
iv><br></div># free -m<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free&nbsp;&nbsp;&nbsp;&nbsp; shared&nbsp;&n=
bsp;&nbsp; buffers&nbsp;&nbsp;&nbsp;&nbsp; cached<br>
Mem:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1002&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 670&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 332&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 250<br>-/+ buffers/cache:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39=
7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 605<br>Swap:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0<br><div><br></div># lttng enable-channel channel0 --num-subbuf =
4 --subbuf-size 2M -u<br>
UST channel channel0 enabled for session auto-20140416-180339<br><div><br><=
/div># free -m<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; free&nbsp;&nbsp;&nbsp;&nbsp; shared&nbsp;&nbsp;&nbs=
p; buffers&nbsp;&nbsp;&nbsp;&nbsp; cached<br>Mem:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 1002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 690&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 311&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 270<br>
-/+ buffers/cache:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 397&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 605<br>Swap:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<=
br><div><br></div># lttng destroy<br>Session auto-20140416-180339 destroyed=
<br><div><br></div># lttng create<br>Session auto-20140416-180406 created.<=
br>Traces will be written in /root/lttng-traces/auto-20140416-180406<br><br=
># free -m<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; total&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; free&nbsp;&nbsp;&nbsp;&nbsp; shared&nbsp;&nbsp;&nbsp; b=
uffers&nbsp;&nbsp;&nbsp;&nbsp; cached<br>Mem:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 1002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 670=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 332&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 250<br>-/+ buffers/cache:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 397&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 605<br>Swap:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br><br># lttng enable-=
channel channel0 --num-subbuf 4 --subbuf-size 4M -u<br>UST channel channel0=
 enabled for session auto-20140416-180406<br><div><br></div># free -m<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tota=
l&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; free&nbsp;&nbsp;&nbsp;&nbsp; shared&nbsp;&nbsp;&nbsp; buffers&nbsp;&nbs=
p;&nbsp;&nbsp; cached<br>
Mem:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1002&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 710&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 292&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 290<br>-/+ buffers/cache:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 39=
7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 605<br><div><br></div></div></d=
iv><br>_______________________________________________<br>lttng-dev mailing=
 list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div=
>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS In=
c.<br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body=
></html>
------=_Part_2459_1883734115.1397669559275--


--===============0382288735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0382288735==--
