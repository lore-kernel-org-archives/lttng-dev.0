From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: faulty context for sched_stat_ tracepoints?
Date: Thu, 26 Nov 2015 15:21:53 +0000 (UTC)
Message-ID: <1809072616.157482.1448551313021.JavaMail.zimbra__29404.2785455988$1448551396$gmane$org@efficios.com>
References: <73b02dedea024337886a82474372bcde@FE-MBX1025.de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0920090727=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1a1yN5-00039b-Vq
 for lttng-dev@lists.lttng.org; Thu, 26 Nov 2015 10:22:12 -0500
In-Reply-To: <73b02dedea024337886a82474372bcde@FE-MBX1025.de.bosch.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Luetkebohle Ingo (CR/AEA2)" <Ingo.Luetkebohle@de.bosch.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0920090727==
Content-Type: multipart/alternative;
	boundary="----=_Part_157481_471214850.1448551313020"

------=_Part_157481_471214850.1448551313020
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

---- On Nov 26, 2015, at 7:34 AM, Luetkebohle Ingo (CR/AEA2) <Ingo.Luetkebo=
hle@de.bosch.com> wrote:=20

> Hi,

> I noticed that the =E2=80=9Cprocname=E2=80=9D and =E2=80=9Ctid=E2=80=9D *=
 context * variables can differ from
> the =E2=80=9Ccomm=E2=80=9D and =E2=80=9Ctid=E2=80=9D variables of the sch=
ed_stat_-tracepoints (e.g., for
> sched_stat_runtime).

> For example, see the following two outputs:

> [15:49:33.674072890] (+0.000029771) rng2070 sched_stat_sleep: { cpu_id =
=3D 4 }, {
> pid =3D 26974, procname =3D "amcl", tid =3D 26975 }, { comm =3D "lttng-se=
ssiond", tid =3D
> 798, delay =3D 194122524 }

> [15:49:33.722894563] (+0.000004851) rng2070 sched_stat_sleep: { cpu_id =
=3D 0 }, {
> pid =3D 0, procname =3D "swapper/0", tid =3D 0 }, { comm =3D "amcl", tid =
=3D 27078, delay
> =3D 10043658 }

> In both cases, procname differs from comm. I=E2=80=99ve looked at the ker=
nel source
> code, and the =E2=80=9Ccomm=E2=80=9D variable is taken from task_struct.f=
ilename. Barring
> renames, this would be the correct one, so I=E2=80=99m assuming that the =
context is
> sometimes incorrect.

> Now, for this particular case, I can take the correct variables from the
> tracepoint, but of course, this makes me worried that the context might a=
lso be
> wrong in other cases=E2=80=A6 Do you have any idea what could be going on=
 here?

> LTTng is Version 2.7.x+stable+bzr2948+pack17+201511192116~ubuntu14.04.1 a=
nd this
> is on a 3.19.0-33-generic kernel (btw, that=E2=80=99s not the default ker=
nel for Ubuntu
> 14.04, but the LTS vivid backport kernel).

Hi,=20

Looking at lttng-modules lttng-context-tid.c tid_record(), we see that it u=
ses task_pid_nr(current).=20
It therefore gets the tid of the currently scheduled task. This is similar =
for procname.=20

Now looking at the Linux kernel kernel/sched/fair.c: enqueue_sleeper(), whi=
ch calls=20
trace_sched_stat_sleep(), we see that it passes "tsk" as parameter to the t=
racepoint.=20
Already here, nothing seems to ensure that "tsk" is the currently scheduled=
 task. It's=20
rather a task that is being put to sleep. Looking at the callers of enqueue=
_sleeper(),=20
we can understand that the current task is first scheduled out before being=
 enqueued=20
as a sleeper. This is why, when we hit the sched_stat_sleep tracepoint, the=
 current=20
task is not "tsk", which explains the difference between the context inform=
ation=20
and the tracepoint payload information: they really target different tasks.=
=20

Does this help solve your concerns ?=20

Thanks,=20

Mathieu=20

> Mit freundlichen Gr=C3=BC=C3=9Fen / Best regards

> Ingo Luetkebohle

> Application Software (CR/AEA2)
> Tel. +49(711)811-12248 | Fax +49(711)811-0 | Ingo.Luetkebohle@de.bosch.co=
m

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_157481_471214850.1448551313020
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">---- On Nov 26, 2015, at 7:34 AM, Luetkebohle Ingo (CR/AEA2) &lt;Ingo.L=
uetkebohle@de.bosch.com&gt; wrote:<br></span></div><div data-marker=3D"__QU=
OTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><st=
yle><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:#0563C1;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:#954F72;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Arial",sans-serif;
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal"><span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-U=
S">Hi,</span></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p><p c=
lass=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&=
quot;,sans-serif" lang=3D"EN-US">I noticed that the =E2=80=9Cprocname=E2=80=
=9D and =E2=80=9Ctid=E2=80=9D *<b>context</b>* variables can differ from th=
e =E2=80=9Ccomm=E2=80=9D and =E2=80=9Ctid=E2=80=9D variables of the sched_s=
tat_-tracepoints (e.g., for sched_stat_runtime).</span></p><p class=3D"MsoN=
ormal"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif" lang=3D"EN-US">&nbsp;</span></p><p class=3D"MsoNormal"><span style=3D=
"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">=
For example, see the following two outputs:</span></p><p class=3D"MsoNormal=
"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"=
 lang=3D"EN-US">[15:49:33.674072890] (+0.000029771) rng2070 sched_stat_slee=
p: { cpu_id =3D 4 }, { pid =3D 26974, procname =3D "amcl", tid =3D 26975 },=
 { comm =3D "lttng-sessiond", tid =3D 798,
 delay =3D 194122524 }</span></p><p class=3D"MsoNormal"><span style=3D"font=
-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">[15:4=
9:33.722894563] (+0.000004851) rng2070 sched_stat_sleep: { cpu_id =3D 0 }, =
{ pid =3D 0, procname =3D "swapper/0", tid =3D 0 }, { comm =3D "amcl", tid =
=3D 27078, delay =3D
 10043658 }</span></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p=
><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif" lang=3D"EN-US">In both cases, procname differs from =
comm. &nbsp;I=E2=80=99ve looked at the kernel source code, and the =E2=80=
=9Ccomm=E2=80=9D variable is taken from task_struct.filename. Barring renam=
es, this
 would be the correct one, so I=E2=80=99m assuming that the context is some=
times incorrect.</span></p><p class=3D"MsoNormal"><span style=3D"font-size:=
10.0pt;font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</spa=
n></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif" lang=3D"EN-US">Now, for this particular case, I=
 can take the correct variables from the tracepoint, but of course, this ma=
kes me worried that the context might also be wrong in
 other cases=E2=80=A6 Do you have any idea what could be going on here?</sp=
an></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&=
quot;Arial&quot;,sans-serif" lang=3D"EN-US">&nbsp;</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans=
-serif" lang=3D"EN-US">LTTng is Version 2.7.x+stable+bzr2948+pack17+2015111=
92116~ubuntu14.04.1 and this is on a 3.19.0-33-generic kernel (btw, that=E2=
=80=99s not the default kernel for Ubuntu
 14.04, but the LTS vivid backport kernel).</span></p></div></blockquote><d=
iv>Hi,<br></div><div><br data-mce-bogus=3D"1"></div><div>Looking at lttng-m=
odules lttng-context-tid.c tid_record(), we see that it uses task_pid_nr(cu=
rrent).<br data-mce-bogus=3D"1"></div><div>It therefore gets the tid of the=
 currently scheduled task. This is similar for procname.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Now looking at the Li=
nux kernel kernel/sched/fair.c: enqueue_sleeper(), which calls<br data-mce-=
bogus=3D"1"></div><div>trace_sched_stat_sleep(), we see that it passes "tsk=
" as parameter to the tracepoint.<br data-mce-bogus=3D"1"></div><div>Alread=
y here, nothing seems to ensure that "tsk" is the currently scheduled task.=
 It's<br data-mce-bogus=3D"1"></div><div>rather a task that is being put to=
 sleep. Looking at the callers of enqueue_sleeper(),<br data-mce-bogus=3D"1=
"></div><div>we can understand that the current task is first scheduled out=
 before being enqueued<br data-mce-bogus=3D"1"></div><div>as a sleeper. Thi=
s is why, when we hit the sched_stat_sleep tracepoint, the current<br data-=
mce-bogus=3D"1"></div><div>task is not "tsk", which explains the difference=
 between the context information<br data-mce-bogus=3D"1"></div><div>and the=
 tracepoint payload information: they really target different tasks.<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Does this =
help solve your concerns ?<br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br d=
ata-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010F=
F;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt;"><div class=3D"WordSection1"><p class=3D"MsoNormal"><span style=3D=
"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif" lang=3D"EN-US">=
&nbsp;</span></p><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;fon=
t-family:&quot;Arial&quot;,sans-serif;color:black;mso-fareast-language:DE" =
lang=3D"EN-US">Mit freundlichen Gr=C3=BC=C3=9Fen / Best regards
<br>
<br>
<b>Ingo Luetkebohle<br>
</b><br>
Application Software (CR/AEA2) <br>
Tel. +49(711)811-12248 | Fax +49(711)811-0 | </span><span style=3D"font-siz=
e:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black;mso-fareast-l=
anguage:DE"><a href=3D"mailto:Ingo.Luetkebohle@de.bosch.com" target=3D"_bla=
nk"><span style=3D"color:blue" lang=3D"EN-US">Ingo.Luetkebohle@de.bosch.com=
</span></a></span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&q=
uot;,sans-serif;color:black;mso-fareast-language:DE">
</span><span style=3D"font-size:8.0pt;font-family:&quot;Arial&quot;,sans-se=
rif;color:black;mso-fareast-language:DE" lang=3D"EN-US"><br>
</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif;color:black;mso-fareast-language:DE" lang=3D"EN-US"><br>
<br>
</span></p></div><br>_______________________________________________<br>ltt=
ng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><di=
v data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>Effic=
iOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_157481_471214850.1448551313020--


--===============0920090727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0920090727==--
