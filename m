From: somanath sahoo <bapi_mvit2004@yahoo.com>
Subject: lttng - ubuntu 11.10 - problem
Date: Fri, 15 Jun 2012 00:41:28 -0700 (PDT)
Message-ID: <1339746088.90723.YahooMailNeo__20658.4640699022$1339746122$gmane$org@web161201.mail.bf1.yahoo.com>
Reply-To: somanath sahoo <bapi_mvit2004@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1607596476=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm28.bullet.mail.bf1.yahoo.com ([98.139.212.187])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <bapi_mvit2004@yahoo.com>) id 1SfR9y-0006D7-3a
	for lttng-dev@lists.lttng.org; Fri, 15 Jun 2012 03:41:34 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1607596476==
Content-Type: multipart/alternative; boundary="1261493821-194523641-1339746088=:90723"

--1261493821-194523641-1339746088=:90723
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AAs i am new to lttng usage, I have followed the instructions from =
<https://launchpad.net/~lttng/+archive/ppa> in order to install the lttng t=
ool set in my ubuntu 11.10.=0AAfter successful installation, i followed the=
 getting started link on lttng.org <http://lttng.org/quickstart> in "root m=
ode".=0A=0A1. when i am executing the first command - =0A=0A=A0=A0=A0 # ltt=
ng list -k=0A=0A=A0=A0=A0 i am getting the following error=0A=A0=A0=A0 " Er=
ror: Unable to list kernel events"=0A=0A2. # lttng create mysession=0A=A0=
=A0=A0 Session mysession created.=0A=0A3. # lttng enable-event sched_switch=
,sched_process_fork -k=0A=A0=A0=A0 Error: Event sched_switch: Kernel tracer=
 not available (channel channel0, session mysession)=0A=A0=A0=A0 Error: Eve=
nt sched_process_fork: Kernel tracer not available (channel channel0, sessi=
on mysession)=0A=A0=A0=A0 Warning: Some command(s) went wrong=A0=0A=0A=0A4.=
 # lttng start=0A=A0=A0=A0 Tracing started for session mysession=0A=0A5. # =
lttng stop=0A=A0=A0=A0 Tracing stopped for session mysession=0A=0A6.=A0 # l=
ttng destroy=0A=A0=A0=A0 Session mysession destroyed at /root=0A=0A--------=
----=0A=0AI have checked that lttng-sessiond is running by below command =
=0A=0A=0A# ps -ef|grep lttn=0Aroot=A0=A0=A0=A0=A0=A0 535=A0=A0=A0=A0 1=A0 0=
 Jun14 ?=A0=A0=A0=A0=A0=A0=A0 00:00:00 lttng-sessiond=0Asomanath=A0 5359=A0=
=A0=A0=A0 1=A0 0 Jun14 pts/1=A0=A0=A0 00:00:00 lttng-sessiond --sig-parent =
--quiet=0Aroot=A0=A0=A0=A0 19514 19495=A0 0 12:44 pts/2=A0=A0=A0 00:00:00 g=
rep --color=3Dauto lttn=0A=0A--------------=0A=0ACould anyone please help m=
e to understand or clarify why kernel tracer is not available when above po=
int (3) / (1) is executed or whether i need to do anything more , please le=
t me know so that i can start using lttng in ubuntu 11.10 successfully.=0A=
=0A=0AI have googled about this problem, I got to know about this similar p=
roblem from one link - http://www.mail-archive.com/lttng-dev@lists.lttng.or=
g/msg00763.html=0AHowever i executed all this commands under root and expli=
cit lttng-seesiond start, But still the problem is persistant.=0A=0A=0A=0AA=
ny help will be appreciated.=0A=0A=0AThanks & Regards,=0ASomanath
--1261493821-194523641-1339746088=:90723
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div>Hi,</div><div><b=
r></div><div>As i am new to lttng usage, I have followed the instructions f=
rom &lt;https://launchpad.net/~lttng/+archive/ppa&gt; in order to install t=
he lttng tool set in my ubuntu 11.10.</div><div>After successful installati=
on, i followed the getting started link on lttng.org &lt;http://lttng.org/q=
uickstart&gt; in "root mode".</div><div><br></div><div>1. when i am executi=
ng the first command - <br></div><div><span class=3D"tab">&nbsp;&nbsp;&nbsp=
; </span># lttng list -k</div><div><br></div><div><span class=3D"tab">&nbsp=
;&nbsp;&nbsp; </span>i am getting the following error</div><div><span class=
=3D"tab">&nbsp;&nbsp;&nbsp; </span>" Error: Unable to list kernel events"</=
div><div><br></div><div>2. # lttng create mysession<br><span class=3D"tab">=
&nbsp;&nbsp;&nbsp; </span>Session mysession
 created.</div><div><br></div><div>3. # lttng enable-event sched_switch,sch=
ed_process_fork -k<br><span class=3D"tab">&nbsp;&nbsp;&nbsp; </span>Error: =
Event sched_switch: Kernel tracer not available (channel channel0, session =
mysession)<br><span class=3D"tab">&nbsp;&nbsp;&nbsp; </span>Error: Event sc=
hed_process_fork: Kernel tracer not available (channel channel0, session my=
session)<br><span class=3D"tab">&nbsp;&nbsp;&nbsp; </span>Warning: Some com=
mand(s) went wrong&nbsp;<br></div><div><br></div><div>4. # lttng start<br><=
span class=3D"tab">&nbsp;&nbsp;&nbsp; </span>Tracing started for session my=
session</div><div><br></div><div>5. # lttng stop<br><span class=3D"tab">&nb=
sp;&nbsp;&nbsp; </span>Tracing stopped for session mysession</div><div><br>=
</div><div>6.<span class=3D"tab">&nbsp; # lttng destroy<br></span><span cla=
ss=3D"tab">&nbsp;&nbsp;&nbsp; </span><span class=3D"tab">Session mysession =
destroyed at /root</span></div><div><br><span class=3D"tab"></span></div><d=
iv><span
 class=3D"tab">------------</span></div><div><br></div><div>I have checked =
that lttng-sessiond is running by below command <br></div><div><br></div><d=
iv># ps -ef|grep lttn<br>root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 535&nbsp;=
&nbsp;&nbsp;&nbsp; 1&nbsp; 0 Jun14 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 00:00:00 lttng-sessiond<br>somanath&nbsp; 5359&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp; 0 Jun14 pts/1&nbsp;&nbsp;&nbsp; 00:00:00 lttng-sessiond --sig-paren=
t --quiet<br>root&nbsp;&nbsp;&nbsp;&nbsp; 19514 19495&nbsp; 0 12:44 pts/2&n=
bsp;&nbsp;&nbsp; 00:00:00 grep --color=3Dauto lttn<br><span class=3D"tab"><=
/span></div><div>--------------</div><div><br></div><div>Could anyone pleas=
e help me to understand or clarify why kernel tracer is not available when =
above point (3) / (1) is executed or whether i need to do anything more , p=
lease let me know so that i can start using lttng in ubuntu 11.10 successfu=
lly.<br></div><div><br></div><div>I have googled about this problem, I got
 to know about this similar problem from one link - http://www.mail-archive=
.com/lttng-dev@lists.lttng.org/msg00763.html</div><div>However i executed a=
ll this commands under root and explicit lttng-seesiond start, But still th=
e problem is persistant.<br></div><div><br></div><div><br></div><div>Any he=
lp will be appreciated.</div><div><br></div><div><br></div><div>Thanks &amp=
; Regards,<br>Somanath<br> </div><div><br></div><div><br></div><div><br></d=
iv><div><br><span class=3D"tab"></span></div><div><span class=3D"tab"><br><=
/span></div></div></body></html>
--1261493821-194523641-1339746088=:90723--


--===============1607596476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1607596476==--
