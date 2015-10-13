From: Anders Wallin <wallinux@gmail.com>
Subject: Issue when first lttng_sessiond is started as a user
 with GID tracing and 2nd session is started as root
Date: Tue, 13 Oct 2015 16:29:18 +0200
Message-ID: <CAF2baFdhhVz7FVjPge7zknEnQ+rb=J=Z-NTb9jsjeHWrvRTrXw__36657.1146333174$1444747147$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0761934596=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <wallinux@gmail.com>) id 1Zm0iE-0005uK-Lq
 for lttng-dev@lists.lttng.org; Tue, 13 Oct 2015 10:38:00 -0400
Received: by wicgb1 with SMTP id gb1so91957776wic.1
 for <lttng-dev@lists.lttng.org>; Tue, 13 Oct 2015 07:37:53 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0761934596==
Content-Type: multipart/alternative; boundary=001a11c34ade64055f0521fd45b2

--001a11c34ade64055f0521fd45b2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

when I start a session as user with gid=3Dtracing it is created fine, but
when I start a 2nd session as root the first session is gone!


+ ssh root@128.224.95.181 'killall -9 lttng-sessiond'

+ ssh root@128.224.95.181 'ps -ef | grep lttng'
root      5119  5115  0 14:21 ?        00:00:00 sh -c ps -ef | grep lttng
root      5121  5119  0 14:21 ?        00:00:00 /bin/busybox.nosuid
/bin/grep lttng

+ ssh root@128.224.95.181 'lttng --version'
lttng (LTTng Trace Control) 2.7.0 - Herbe =C3=A0 D=C3=A9tourne - v2.7.0

+ ssh trace1@128.224.95.181 'lttng create s_trace1'
Spawning a session daemon
Session s_trace1 created.

+ ssh trace1@128.224.95.181 'lttng list'
Available tracing sessions:
  1) s_trace1 (/home/trace1/lttng-traces/s_trace1-20151013-142106)
[inactive]
    Trace path: /home/trace1/lttng-traces/s_trace1-20151013-142106


Use lttng list <session_name> for more details

+ ssh root@128.224.95.181 'lttng create s_root'
Spawning a session daemon
Session s_root created.
Traces will be written in /root/lttng-traces/s_root-20151013-142108

+ ssh root@128.224.95.181 'lttng list'
Available tracing sessions:
  1) s_root (/root/lttng-traces/s_root-20151013-142108) [inactive]
    Trace path: /root/lttng-traces/s_root-20151013-142108


Use lttng list <session_name> for more details

<<<<< AND HERE IS THE ISSUE WHERE THE s_trace1 SESSION IS LOST>>>>
+ ssh trace1@128.224.95.181 'lttng list'
Currently no available tracing session


+ ssh root@128.224.95.181 'ps -ef | grep lttng'
trace1    5134     1  0 14:21 ?        00:00:00 lttng-sessiond --daemonize
trace1    5135  5134  0 14:21 ?        00:00:00 lttng-runas    --daemonize
root      5157     1 14 14:21 ?        00:00:00 lttng-sessiond --daemonize
root      5158  5157  0 14:21 ?        00:00:00 lttng-runas    --daemonize
root      5189  5185  0 14:21 ?        00:00:00 sh -c ps -ef | grep lttng
root      5191  5189  0 14:21 ?        00:00:00 /bin/busybox.nosuid
/bin/grep lttng


I've tried it on 2.5 as well with the same result.

Anders Wallin

--001a11c34ade64055f0521fd45b2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>when I start a session as user with=
 gid=3Dtracing it is created fine, but when I start a 2nd session as root t=
he first session is gone!</div><div><br></div><div><br></div><div><div>+ ss=
h <a href=3D"mailto:root@128.224.95.181">root@128.224.95.181</a> &#39;killa=
ll -9 lttng-sessiond&#39;</div><div><br></div><div>+ ssh <a href=3D"mailto:=
root@128.224.95.181">root@128.224.95.181</a> &#39;ps -ef | grep lttng&#39;<=
/div><div>root =C2=A0 =C2=A0 =C2=A05119 =C2=A05115 =C2=A00 14:21 ? =C2=A0 =
=C2=A0 =C2=A0 =C2=A000:00:00 sh -c ps -ef | grep lttng</div><div>root =C2=
=A0 =C2=A0 =C2=A05121 =C2=A05119 =C2=A00 14:21 ? =C2=A0 =C2=A0 =C2=A0 =C2=
=A000:00:00 /bin/busybox.nosuid /bin/grep lttng</div><div><br></div><div>+ =
ssh <a href=3D"mailto:root@128.224.95.181">root@128.224.95.181</a> &#39;ltt=
ng --version&#39;</div><div>lttng (LTTng Trace Control) 2.7.0 - Herbe =C3=
=A0 D=C3=A9tourne - v2.7.0</div><div><br></div><div>+ ssh <a href=3D"mailto=
:trace1@128.224.95.181">trace1@128.224.95.181</a> &#39;lttng create s_trace=
1&#39;</div><div>Spawning a session daemon</div><div>Session s_trace1 creat=
ed.</div><div><br></div><div>+ ssh <a href=3D"mailto:trace1@128.224.95.181"=
>trace1@128.224.95.181</a> &#39;lttng list&#39;</div><div>Available tracing=
 sessions:</div><div>=C2=A0 1) s_trace1 (/home/trace1/lttng-traces/s_trace1=
-20151013-142106) [inactive]</div><div>=C2=A0 =C2=A0 Trace path: /home/trac=
e1/lttng-traces/s_trace1-20151013-142106</div><div><br></div><div><br></div=
><div>Use lttng list &lt;session_name&gt; for more details</div><div><br></=
div><div>+ ssh <a href=3D"mailto:root@128.224.95.181">root@128.224.95.181</=
a> &#39;lttng create s_root&#39;</div><div>Spawning a session daemon</div><=
div>Session s_root created.</div><div>Traces will be written in /root/lttng=
-traces/s_root-20151013-142108</div><div><br></div><div>+ ssh <a href=3D"ma=
ilto:root@128.224.95.181">root@128.224.95.181</a> &#39;lttng list&#39;</div=
><div>Available tracing sessions:</div><div>=C2=A0 1) s_root (/root/lttng-t=
races/s_root-20151013-142108) [inactive]</div><div>=C2=A0 =C2=A0 Trace path=
: /root/lttng-traces/s_root-20151013-142108</div><div><br></div><div><br></=
div><div>Use lttng list &lt;session_name&gt; for more details</div><div><br=
></div><div>&lt;&lt;&lt;&lt;&lt; AND HERE IS THE ISSUE WHERE THE s_trace1 S=
ESSION IS LOST&gt;&gt;&gt;&gt;</div><div>+ ssh <a href=3D"mailto:trace1@128=
.224.95.181">trace1@128.224.95.181</a> &#39;lttng list&#39;</div><div>Curre=
ntly no available tracing session</div><div><br></div><div><br></div><div>+=
 ssh <a href=3D"mailto:root@128.224.95.181">root@128.224.95.181</a> &#39;ps=
 -ef | grep lttng&#39;</div><div>trace1 =C2=A0 =C2=A05134 =C2=A0 =C2=A0 1 =
=C2=A00 14:21 ? =C2=A0 =C2=A0 =C2=A0 =C2=A000:00:00 lttng-sessiond --daemon=
ize</div><div>trace1 =C2=A0 =C2=A05135 =C2=A05134 =C2=A00 14:21 ? =C2=A0 =
=C2=A0 =C2=A0 =C2=A000:00:00 lttng-runas =C2=A0 =C2=A0--daemonize</div><div=
>root =C2=A0 =C2=A0 =C2=A05157 =C2=A0 =C2=A0 1 14 14:21 ? =C2=A0 =C2=A0 =C2=
=A0 =C2=A000:00:00 lttng-sessiond --daemonize</div><div>root =C2=A0 =C2=A0 =
=C2=A05158 =C2=A05157 =C2=A00 14:21 ? =C2=A0 =C2=A0 =C2=A0 =C2=A000:00:00 l=
ttng-runas =C2=A0 =C2=A0--daemonize</div><div>root =C2=A0 =C2=A0 =C2=A05189=
 =C2=A05185 =C2=A00 14:21 ? =C2=A0 =C2=A0 =C2=A0 =C2=A000:00:00 sh -c ps -e=
f | grep lttng</div><div>root =C2=A0 =C2=A0 =C2=A05191 =C2=A05189 =C2=A00 1=
4:21 ? =C2=A0 =C2=A0 =C2=A0 =C2=A000:00:00 /bin/busybox.nosuid /bin/grep lt=
tng</div></div><div><br></div><div><br></div><div>I&#39;ve tried it on 2.5 =
as well with the same result.</div><div><br clear=3D"all"><div><div class=
=3D"gmail_signature">Anders Wallin</div></div>
</div></div>

--001a11c34ade64055f0521fd45b2--


--===============0761934596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0761934596==--
