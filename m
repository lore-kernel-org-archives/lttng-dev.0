From: paramesh p <params16jan@gmail.com>
Subject: Error in creating session in Embedded Android based
	development board
Date: Sat, 2 Jun 2018 18:01:36 -0700
Message-ID: <CAOG=51x=05q8b8T8TNVoxXuEsy5QOyK59gn6y67Rtmp-9qN+RA__47137.2619308115$1527987580$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1773838381674565680=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x242.google.com (mail-yb0-x242.google.com
 [IPv6:2607:f8b0:4002:c09::242])
 by lists.lttng.org (Postfix) with ESMTPS id 40z0Bn5nLMz18Hb
 for <lttng-dev@lists.lttng.org>; Sat,  2 Jun 2018 21:01:37 -0400 (EDT)
Received: by mail-yb0-x242.google.com with SMTP id p22-v6so9961267yba.13
 for <lttng-dev@lists.lttng.org>; Sat, 02 Jun 2018 18:01:37 -0700 (PDT)
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

--===============1773838381674565680==
Content-Type: multipart/alternative; boundary="000000000000e33370056db25be8"

--000000000000e33370056db25be8
Content-Type: text/plain; charset="UTF-8"

Hi,
    I am new to Tracing. I was trying to use Lttng in my Android based
Dragonboard Develop kit. I installed Lttng with Bitbake, by adding below
line in conf/local.conf
IMAGE_INSTALL_append = " lttng-tools lttng-modules lttng-ust"

After the succesful build and flashing, I can access the Lttng in my
platform. Below is the output of "lttng" command


*/ # lttng*
*LTTng Trace Control 2.6.0 - Gaia - v2.6.0*

*usage: lttng [OPTIONS] <COMMAND> [<ARGS>]*

*Options:*
*  -V, --version              Show version*
*  -h, --help                 Show this help*
*      --list-options         Simple listing of lttng options*
*      --list-commands        Simple listing of lttng commands*
*  -v, --verbose              Increase verbosity*
*  -q, --quiet                Quiet mode*
*  -m, --mi TYPE              Machine Interface mode.*
*                                 Type: xml*
*  -g, --group NAME           Unix tracing group name. (default: tracing)*
*  -n, --no-sessiond          Don't spawn a session daemon*
*      --sessiond-path PATH   Session daemon full path*
*      --relayd-path PATH     Relayd daemon full path*

*Commands:*
*    add-context       Add context to event and/or channel*
*    calibrate         Quantify LTTng overhead*
*    create            Create tracing session*
*    destroy           Tear down tracing session*
*    enable-channel    Enable tracing channel*
*    enable-event      Enable tracing event*
*    disable-channel   Disable tracing channel*
*    disable-event     Disable tracing event*
*    list              List possible tracing options*
*    set-session       Set current session name*
*    snapshot          Snapshot buffers of current session name*
*    start             Start tracing*
*    stop              Stop tracing*
*    version           Show version information*
*    view              Start trace viewer*
*    save              Save session configuration*
*    load              Load session configuration*

*Each command also has its own -h, --help option.*

*Please see the lttng(1) man page for full documentation.*
*See http://lttng.org <http://lttng.org> for updates, bug reports and news.*


When I try to create a session. I am getting below error.

*/ # lttng create test-session*
*Spawning a session daemon*
*modprobe: ERROR: could not insert 'lttng_tracer': Required key not
available*
*Error: Unable to load required module lttng-tracer*
*Warning: No kernel tracer available*
*Session test-session created.*
*Traces will be written in
/home/root/lttng-traces/test-session-19700101-000212*
*Error: Unable to create config file*
Error: Command error


Please help me.
Thanks in Advance.

Regards,
Paramesh

--000000000000e33370056db25be8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>=C2=A0 =C2=A0 I am new to Tracing. I was trying to=
 use Lttng in my Android based Dragonboard Develop kit. I installed Lttng w=
ith Bitbake, by adding below line in=C2=A0conf/local.conf</div><div>IMAGE_I=
NSTALL_append =3D &quot; lttng-tools lttng-modules lttng-ust&quot;<br></div=
><div><br></div><div>After the succesful build and flashing, I can access t=
he Lttng in my platform. Below is the output of &quot;lttng&quot; command</=
div><div><br></div><div><i>/ # lttng<br></i></div><div><div><i>LTTng Trace =
Control 2.6.0 - Gaia - v2.6.0</i></div><div><i><br></i></div><div><i>usage:=
 lttng [OPTIONS] &lt;COMMAND&gt; [&lt;ARGS&gt;]</i></div><div><i><br></i></=
div><div><i>Options:</i></div><div><i>=C2=A0 -V, --version=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Show version</i></div><div><i>=C2=A0 -h, --=
help=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Show this=
 help</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 --list-options=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Simple listing of lttng options</i></div><div><i>=C2=A0 =
=C2=A0 =C2=A0 --list-commands=C2=A0 =C2=A0 =C2=A0 =C2=A0 Simple listing of =
lttng commands</i></div><div><i>=C2=A0 -v, --verbose=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Increase verbosity</i></div><div><i>=C2=A0 -q, =
--quiet=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Quiet mode</=
i></div><div><i>=C2=A0 -m, --mi TYPE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Machine Interface mode.</i></div><div><i>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Type: xml</i></div><div><i>=C2=A0 -g, --group NAME=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Unix tracing group name. (default:=
 tracing)</i></div><div><i>=C2=A0 -n, --no-sessiond=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Don&#39;t spawn a session daemon</i></div><div><i>=C2=A0 =C2=A0 =
=C2=A0 --sessiond-path PATH=C2=A0 =C2=A0Session daemon full path</i></div><=
div><i>=C2=A0 =C2=A0 =C2=A0 --relayd-path PATH=C2=A0 =C2=A0 =C2=A0Relayd da=
emon full path</i></div><div><i><br></i></div><div><i>Commands:</i></div><d=
iv><i>=C2=A0 =C2=A0 add-context=C2=A0 =C2=A0 =C2=A0 =C2=A0Add context to ev=
ent and/or channel</i></div><div><i>=C2=A0 =C2=A0 calibrate=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Quantify LTTng overhead</i></div><div><i>=C2=A0 =C2=A0 =
create=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create tracing session</i><=
/div><div><i>=C2=A0 =C2=A0 destroy=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
Tear down tracing session</i></div><div><i>=C2=A0 =C2=A0 enable-channel=C2=
=A0 =C2=A0 Enable tracing channel</i></div><div><i>=C2=A0 =C2=A0 enable-eve=
nt=C2=A0 =C2=A0 =C2=A0 Enable tracing event</i></div><div><i>=C2=A0 =C2=A0 =
disable-channel=C2=A0 =C2=A0Disable tracing channel</i></div><div><i>=C2=A0=
 =C2=A0 disable-event=C2=A0 =C2=A0 =C2=A0Disable tracing event</i></div><di=
v><i>=C2=A0 =C2=A0 list=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Lis=
t possible tracing options</i></div><div><i>=C2=A0 =C2=A0 set-session=C2=A0=
 =C2=A0 =C2=A0 =C2=A0Set current session name</i></div><div><i>=C2=A0 =C2=
=A0 snapshot=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Snapshot buffers of current =
session name</i></div><div><i>=C2=A0 =C2=A0 start=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Start tracing</i></div><div><i>=C2=A0 =C2=A0 stop=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Stop tracing</i></div><div=
><i>=C2=A0 =C2=A0 version=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Show vers=
ion information</i></div><div><i>=C2=A0 =C2=A0 view=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Start trace viewer</i></div><div><i>=C2=A0 =C2=A0 =
save=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Save session configura=
tion</i></div><div><i>=C2=A0 =C2=A0 load=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Load session configuration</i></div><div><i><br></i></div><di=
v><i>Each command also has its own -h, --help option.</i></div><div><i><br>=
</i></div><div><i>Please see the lttng(1) man page for full documentation.<=
/i></div><div><i>See <a href=3D"http://lttng.org">http://lttng.org</a> for =
updates, bug reports and news.</i></div><div><br></div></div><div><br></div=
><div>When I try to create a session. I am getting below error.=C2=A0</div>=
<div><br></div><div><div><i>/ # lttng create test-session</i></div><div><i>=
Spawning a session daemon</i></div><div><i>modprobe: ERROR: could not inser=
t &#39;lttng_tracer&#39;: Required key not available</i></div><div><i>Error=
: Unable to load required module lttng-tracer</i></div><div><i>Warning: No =
kernel tracer available</i></div><div><i>Session test-session created.</i><=
/div><div><i>Traces will be written in /home/root/lttng-traces/test-session=
-19700101-000212</i></div><div><i>Error: Unable to create config file</i></=
div><div>Error: Command error</div></div><div><br></div><div><br></div><div=
>Please help me.</div><div>Thanks in Advance.</div><div><br></div><div>Rega=
rds,</div><div>Paramesh</div></div>

--000000000000e33370056db25be8--

--===============1773838381674565680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1773838381674565680==--
