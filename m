From: Yannick Lamarre <ylamarre@efficios.com>
Subject: Re: Fwd: LTTng user space data not flushed out
Date: Thu, 28 Mar 2019 12:44:06 -0400 (EDT)
Message-ID: <1896201813.13321.1553791446972.JavaMail.zimbra__19727.0889578917$1553791470$gmane$org@efficios.com>
References: <CAMDVSgkiL9+-Y1fwEiejr9UA1ernY5HqKqDKYqumQYxLfV3eJA@mail.gmail.com>
 <CA+jJMxtYVOnCi+uGi0UskHBZfbq9Dy6z=fnMN2AWgHP4o4sMEg@mail.gmail.com>
 <CAMDVSgkc_ohVFNZLALS=UQ9QS7zvbHxutd-8jAT0=CGHUb+LsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8748554478098343563=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44VW0s3FD4z17vv
 for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2019 12:44:13 -0400 (EDT)
In-Reply-To: <CAMDVSgkc_ohVFNZLALS=UQ9QS7zvbHxutd-8jAT0=CGHUb+LsA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: tujalasaikiran <tujalasaikiran@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8748554478098343563==
Content-Type: multipart/alternative;
	boundary="=_353cf6b5-2045-44b7-bb5d-4347e8a244e9"

--=_353cf6b5-2045-44b7-bb5d-4347e8a244e9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi TSK,=20
From [1]:=20


You must provide the following items for the bug to be reproducible:=20

    * Component(s) involved : [ https://bugs.lttng.org/projects/lttng-tools=
 | LTTng-tools ] , [ https://bugs.lttng.org/projects/lttng-ust | LTTng-UST =
] , [ https://bugs.lttng.org/projects/lttng-modules | LTTng-modules ] , [ h=
ttps://bugs.lttng.org/projects/urcu | liburcu ] , or [ https://bugs.lttng.o=
rg/projects/babeltrace | Babeltrace ] ? If the bug involves more than one c=
omponent, report it under the [ https://bugs.lttng.org/projects/lttng | Red=
mine LTTng umbrella project ] .=20
    * Component version : Full version of the software exhibiting the bug (=
 --version option) or Git commit hash for custom builds.=20
    * System information :=20
        * Architecture, number of CPUs.=20
        * Operating system version ( uname -a ) and distribution=20

Please explicitly report the version of each components: lttng-tools, lttng=
-ust, lttng-modules, liburcu, and babeltrace.=20
[1] https://lttng.org/community/#bug-reporting-guidelines=20


From: "tujalasaikiran" <tujalasaikiran@gmail.com>=20
To: "lttng-dev" <lttng-dev@lists.lttng.org>=20
Sent: Thursday, March 28, 2019 7:50:17 AM=20
Subject: [lttng-dev] Fwd: LTTng user space data not flushed out=20

---------- Forwarded message ----------=20
From: J=C3=A9r=C3=A9mie Galarneau < [ mailto:jeremie.galarneau@efficios.com=
 | jeremie.galarneau@efficios.com ] >=20
Date: Monday, March 25, 2019=20
Subject: LTTng user space data not flushed out=20
To: tujalasaikiran < [ mailto:tujalasaikiran@gmail.com | tujalasaikiran@gma=
il.com ] >=20


Hi Tujala,=20

Please use the public development mailing list=20
( [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ] ) to get=
 community support.=20
Private support is available through EfficiOS' support agreements.=20

Thanks,=20
J=C3=A9r=C3=A9mie=20

On Sat, 23 Mar 2019 at 13:13, tujalasaikiran < [ mailto:tujalasaikiran@gmai=
l.com | tujalasaikiran@gmail.com ] > wrote:=20
>=20
> Hi,=20
> I'm using LTTng live mode, the "live" parameter in the below command is t=
he time at which data is flushed. We get zero content size packets if we do=
n't have any data generated from the tracer. This is true for kernel space =
domain, that is getting content size zero packets. Whereas in the user spac=
e domain, I'm not getting zero content size packets this makes the "live vi=
ewer" (babeltrace) to not to show any trace data until the session stop.=20
> My application generates the kernel domain events frequently whereas user=
space domain events generate very rarely. Default flush time in "lttng crea=
te" command is 1 second, this is honored in kernel domain whereas in usersp=
ace domain not.=20
> Below commands, I'm using for LTTng configuration and using babel trace v=
iewer to view live trace.=20
>=20
> lttng create mysession --live=20
> lttng enable-event -k sched_swich=20
> lttng enable-event -u mytrace_point:tp_one=20
> lttng start=20
> babeltrace --input-format=3Dlttng-live net://localhost/host/mypc-name/mys=
ession=20
> <---- not getting any data from babeltrace until I stop the session------=
>=20
> lttng stop=20
> <--- I'm getting data from babeltrace once I stop the lttng session --->=
=20
> lttng destroy=20
> Thanks,=20
> TSK.=20
>=20
>=20


--=20
J=C3=A9r=C3=A9mie Galarneau=20
EfficiOS Inc.=20
[ http://www.efficios.com/ | http://www.efficios.com ]=20


_______________________________________________=20
lttng-dev mailing list=20
lttng-dev@lists.lttng.org=20
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=20

--=_353cf6b5-2045-44b7-bb5d-4347e8a244e9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi TSK,<br></div><div>From [1]:<br data-mce=
-bogus=3D"1"></div><div><p style=3D"margin: 0px;" data-mce-style=3D"margin:=
 0px;">You <strong>must</strong> provide the following items for the bug to=
 be reproducible:</p><ul><li><strong>Component(s) involved</strong>: <a hre=
f=3D"https://bugs.lttng.org/projects/lttng-tools" data-mce-href=3D"https://=
bugs.lttng.org/projects/lttng-tools">LTTng-tools</a>, <a href=3D"https://bu=
gs.lttng.org/projects/lttng-ust" data-mce-href=3D"https://bugs.lttng.org/pr=
ojects/lttng-ust">LTTng-UST</a>, <a href=3D"https://bugs.lttng.org/projects=
/lttng-modules" data-mce-href=3D"https://bugs.lttng.org/projects/lttng-modu=
les">LTTng-modules</a>, <a href=3D"https://bugs.lttng.org/projects/urcu" da=
ta-mce-href=3D"https://bugs.lttng.org/projects/urcu">liburcu</a>, or <a hre=
f=3D"https://bugs.lttng.org/projects/babeltrace" data-mce-href=3D"https://b=
ugs.lttng.org/projects/babeltrace">Babeltrace</a>? If the bug involves more=
 than one component, report it under the <a href=3D"https://bugs.lttng.org/=
projects/lttng" data-mce-href=3D"https://bugs.lttng.org/projects/lttng">Red=
mine LTTng umbrella project</a>.</li><li><strong>Component version</strong>=
: Full version of the software exhibiting the bug (<code>--version</code> o=
ption) or Git commit hash for custom builds.</li><li><strong>System informa=
tion</strong>:<ul><li>Architecture, number of CPUs.</li><li>Operating syste=
m version (<code>uname -a</code>) and distribution<br data-mce-bogus=3D"1">=
</li></ul></li></ul><div>Please explicitly report the version of each compo=
nents: lttng-tools, lttng-ust, lttng-modules, liburcu, and babeltrace.<br d=
ata-mce-bogus=3D"1"></div></div><div>[1] https://lttng.org/community/#bug-r=
eporting-guidelines<br data-mce-bogus=3D"1"></div><div><br></div><hr id=3D"=
zwchr" data-marker=3D"__DIVIDER__"><div data-marker=3D"__HEADERS__"><b>From=
: </b>"tujalasaikiran" &lt;tujalasaikiran@gmail.com&gt;<br><b>To: </b>"lttn=
g-dev" &lt;lttng-dev@lists.lttng.org&gt;<br><b>Sent: </b>Thursday, March 28=
, 2019 7:50:17 AM<br><b>Subject: </b>[lttng-dev] Fwd: LTTng user space data=
 not flushed out<br></div><div><br></div><div data-marker=3D"__QUOTED_TEXT_=
_">---------- Forwarded message ----------<br>From: <b>J=C3=A9r=C3=A9mie Ga=
larneau</b> &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D=
"_blank">jeremie.galarneau@efficios.com</a>&gt;<br>Date: Monday, March 25, =
2019<br>Subject: LTTng user space data not flushed out<br>To: tujalasaikira=
n &lt;<a href=3D"mailto:tujalasaikiran@gmail.com" target=3D"_blank">tujalas=
aikiran@gmail.com</a>&gt;<br><br><br>Hi Tujala,<br>
<br>
Please use the public development mailing list<br>
(<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@l=
ists.lttng.org</a>) to get community support.<br>
Private support is available through EfficiOS' support agreements.<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<br>
On Sat, 23 Mar 2019 at 13:13, tujalasaikiran &lt;<a href=3D"mailto:tujalasa=
ikiran@gmail.com" target=3D"_blank">tujalasaikiran@gmail.com</a>&gt; wrote:=
<br>
&gt;<br>
&gt; Hi,<br>
&gt; I'm using LTTng live mode, the "live" parameter in the below command i=
s the time at which data is flushed. We get zero content size packets if we=
 don't have any data generated from the tracer. This is true for kernel spa=
ce domain, that is getting content size zero packets. Whereas in the user s=
pace domain, I'm not getting zero content size packets this makes the "live=
 viewer"&nbsp; (babeltrace) to not to show any trace data until the session=
 stop.<br>
&gt; My application generates the kernel domain events frequently whereas u=
serspace domain events generate very rarely. Default flush time in "lttng c=
reate" command is 1 second, this is honored in kernel domain whereas in use=
rspace domain not.<br>
&gt; Below commands, I'm using for LTTng configuration and using babel trac=
e viewer to view live trace.<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lt=
tng create mysession --live<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lt=
tng enable-event -k sched_swich<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lt=
tng enable-event -u mytrace_point:tp_one<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lt=
tng start<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ba=
beltrace --input-format=3Dlttng-live net://localhost/host/mypc-name/mysessi=
on<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &lt;----=
 not getting any data from babeltrace until I stop the session------&gt;<br=
>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lt=
tng stop<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&l=
t;--- I'm getting data from babeltrace once I stop the lttng session&nbsp; =
---&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;lt=
tng destroy<br>
&gt; Thanks,<br>
&gt; TSK.<br>
&gt;<br>
&gt;<br>
<br>
<br>
-- <br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
<br>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></div></div></body></html>
--=_353cf6b5-2045-44b7-bb5d-4347e8a244e9--

--===============8748554478098343563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8748554478098343563==--
