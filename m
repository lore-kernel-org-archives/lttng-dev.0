From: Noam Cohen <noam@lifeonair.com>
Subject: problem running/installing lttng on ubuntu 16.04
Date: Wed, 17 Aug 2016 13:25:48 +0300
Message-ID: <CAKH_oXJ+20uS1d1S71JLbYkPO9+Cx=3v4-+Ss_jbj7rnUzp8_w__40598.8588849597$1471522005$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0166367220696041326=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1574AA02B1
 for <lttng-dev@lists.lttng.org>; Wed, 17 Aug 2016 10:26:14 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id o80so223061202wme.1
 for <lttng-dev@lists.lttng.org>; Wed, 17 Aug 2016 03:26:10 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0166367220696041326==
Content-Type: multipart/alternative; boundary=001a11412394c94f63053a41e4fa

--001a11412394c94f63053a41e4fa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello
I installed lttng on my ubuntu, and tried the "getting Started".


I ran the helloWorld, and then
$ lttng list --userspace
Error: Unable to list UST events: No session daemon is available
Error: Command error

Waited a minute and retried, and now the output was as expected.
$ lttng list --userspace
UST events:
-------------

PID: 17386 - Name: ./hello
      lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type:
tracepoint)
      < SNIP >
      hello_world:my_first_tracepoint (loglevel: TRACE_DEBUG_LINE (13))
(type: tracepoint)

**Is it normal behavior?*


Then,
$ lttng create
Session auto-20160817-132123 created.
Traces will be written in /home/noam/lttng-traces/auto-20160817-132123
noam@noam-nuc:~/tmp/lttng$ lttng enable-event --userspace
hello_world:my_first_tracepoint
Error: Event hello_world:my_first_tracepoint: UST create channel failed
(channel channel0, session auto-20160817-132123)

How do I solve it?
---------------------
system properties:

noam@noam-nuc:~$ ps -ef | grep lttng
noam     17410 17398  0 13:18 pts/3    00:00:00 lttng-sessiond -vvv
noam     17411 17410  0 13:18 pts/3    00:00:00 lttng-runas    -vvv
noam     17442 17410  0 13:21 pts/3    00:00:00 lttng-consumerd  -u
--consumerd-cmd-sock /home/noam/.lttng/ustconsumerd64/command
--consumerd-err-sock /home/noam/.lttng/ustconsumerd64/error --group tracing
noam     17444 17442  0 13:21 pts/3    00:00:00 lttng-runas      -u
--consumerd-cmd-sock /home/noam/.lttng/ustconsumerd64/command
--consumerd-err-sock /home/noam/.lttng/ustconsumerd64/error --group tracing
noam     17480 17467  0 13:22 pts/7    00:00:00 grep --color=3Dauto lttng
noam@noam-nuc:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 16.04.1 LTS
Release: 16.04
Codename: xenial


Installed lttng using:
sudo apt-get install lttng-tools lttng-modules-dkms liblttng-ust-dev


$ lttng --version
lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=A0 D=C3=A9tourne

--001a11412394c94f63053a41e4fa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello<div>I installed lttng on my ubuntu, and tried the &q=
uot;getting Started&quot;.</div><div><br></div><div><br></div><div>I ran th=
e helloWorld, and then=C2=A0</div><div><div>$ lttng list --userspace</div><=
div>Error: Unable to list UST events: No session daemon is available</div><=
div>Error: Command error</div></div><div><br></div><div>Waited a minute and=
 retried, and now the output was as expected.</div><div><div>$ lttng list -=
-userspace</div><div>UST events:</div><div>-------------</div><div><br></di=
v><div>PID: 17386 - Name: ./hello</div><div>=C2=A0 =C2=A0 =C2=A0 lttng_ust_=
tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type: tracepoint)</div><=
div>=C2=A0 =C2=A0 =C2=A0 &lt; SNIP &gt;</div><div>=C2=A0 =C2=A0 =C2=A0 hell=
o_world:my_first_tracepoint (loglevel: TRACE_DEBUG_LINE (13)) (type: tracep=
oint)</div></div><div><br></div><div><b>*Is it normal behavior?</b></div><d=
iv><br></div><div><br></div><div>Then,</div><div><div>$ lttng create</div><=
div>Session auto-20160817-132123 created.</div><div>Traces will be written =
in /home/noam/lttng-traces/auto-20160817-132123</div><div>noam@noam-nuc:~/t=
mp/lttng$ lttng enable-event --userspace hello_world:my_first_tracepoint</d=
iv><div>Error: Event hello_world:my_first_tracepoint: UST create channel fa=
iled (channel channel0, session auto-20160817-132123)</div></div><div><br><=
/div><div>How do I solve it?</div><div>---------------------</div><div>syst=
em properties:</div><div><br></div><div><div>noam@noam-nuc:~$ ps -ef | grep=
 lttng</div><div>noam =C2=A0 =C2=A0 17410 17398 =C2=A00 13:18 pts/3 =C2=A0 =
=C2=A000:00:00 lttng-sessiond -vvv</div><div>noam =C2=A0 =C2=A0 17411 17410=
 =C2=A00 13:18 pts/3 =C2=A0 =C2=A000:00:00 lttng-runas =C2=A0 =C2=A0-vvv</d=
iv><div>noam =C2=A0 =C2=A0 17442 17410 =C2=A00 13:21 pts/3 =C2=A0 =C2=A000:=
00:00 lttng-consumerd =C2=A0-u --consumerd-cmd-sock /home/noam/.lttng/ustco=
nsumerd64/command --consumerd-err-sock /home/noam/.lttng/ustconsumerd64/err=
or --group tracing</div><div>noam =C2=A0 =C2=A0 17444 17442 =C2=A00 13:21 p=
ts/3 =C2=A0 =C2=A000:00:00 lttng-runas =C2=A0 =C2=A0 =C2=A0-u --consumerd-c=
md-sock /home/noam/.lttng/ustconsumerd64/command --consumerd-err-sock /home=
/noam/.lttng/ustconsumerd64/error --group tracing</div><div>noam =C2=A0 =C2=
=A0 17480 17467 =C2=A00 13:22 pts/7 =C2=A0 =C2=A000:00:00 grep --color=3Dau=
to lttng</div><div>noam@noam-nuc:~$ lsb_release -a</div><div>No LSB modules=
 are available.</div><div>Distributor ID:<span class=3D"" style=3D"white-sp=
ace:pre">	</span>Ubuntu</div><div>Description:<span class=3D"" style=3D"whi=
te-space:pre">	</span>Ubuntu 16.04.1 LTS</div><div>Release:<span class=3D""=
 style=3D"white-space:pre">	</span>16.04</div><div>Codename:<span class=3D"=
" style=3D"white-space:pre">	</span>xenial</div></div><div><br></div><div><=
br></div><div>Installed lttng using:</div><div>sudo apt-get install lttng-t=
ools lttng-modules-dkms liblttng-ust-dev<br></div><div><br></div><div><br><=
/div><div><div>$ lttng --version</div><div>lttng (LTTng Trace Control) 2.7.=
1 - Herbe =C3=A0 D=C3=A9tourne</div></div><div><br></div><div><br></div></d=
iv>

--001a11412394c94f63053a41e4fa--

--===============0166367220696041326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0166367220696041326==--
