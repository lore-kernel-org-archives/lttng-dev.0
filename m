From: shirish gajera <gajerashirish@gmail.com>
Subject: Error while enabling multiple channel for same session
Date: Thu, 30 Apr 2015 09:23:08 -0700
Message-ID: <CAG77vrpmzfhZ419CV3zVt83e6B4cMoT-2xA8kvwH=aPaOLwSFQ__32788.9924905778$1430411075$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0216029429=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gajerashirish@gmail.com>) id 1YnrF3-0000Kn-Pk
 for lttng-dev@lists.lttng.org; Thu, 30 Apr 2015 12:23:16 -0400
Received: by wgen6 with SMTP id n6so68191366wge.3
 for <lttng-dev@lists.lttng.org>; Thu, 30 Apr 2015 09:23:08 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0216029429==
Content-Type: multipart/alternative; boundary=047d7b5d86a5d570000514f382de

--047d7b5d86a5d570000514f382de
Content-Type: text/plain; charset=UTF-8

Hi,

I want to enable multiple(50) channel for the same session, below is my
script doing the same.
Single channel with the same script  is working fine. But, when I tried to
enable multiple channel for the same session it's giving me error.

Here is what I found
1) I have 50 channel in my db files and it's failing at 13th channel create
command, below is the log
       ...12 channel creation successful
       Spawning a session daemon
       Warning: Could not get lock file /var/run/lttng/lttng-sessiond.lck,
another instance is running.
       Error: Session daemon died (exit status 1)
       Spawning a session daemon
       Warning: Could not get lock file /var/run/lttng/lttng-sessiond.lck,
another instance is running.
       Error: Session daemon died (exit status 1)
       1
       failed!

Let me know if question is not clear.

my lttng script
--------------------------------------------
lttng create -o /root/data/tracing --snapshot TEST
while IFS=, read EVENTNAME CHANNELNAME BUFFERSIZE
do
lttng enable-channel --userspace --tracefile-size ${BUFFERSIZE}K
--tracefile-count 1 --overwrite ${CHANNELNAME}
lttng enable-event -u ${EVENTNAME} --loglevel ERR -c ${CHANNELNAME}
lttng enable-event -u ${EVENTNAME} --loglevel CRIT -c ${CHANNELNAME}
done < demo_lttngdb
lttng start


my demo_lttngdb file
-------------------------------------------
channel1,channel1,65535
channel2*,channel2,4096
channel3*,channel3,4096
channel4*,channel4,4096
channel5*,channel5,4096
channel6*,channel6,4096
channel7*,channel7,4096
channel8*,channel8,4096
channel9*,channel9,8192
channel10*,channel10,4096
channel11*,channel11,4096
channel12*,channel12,4096
channel13*,channel13,4096
channel14*,channel14,4096
channel15*,channel15,4096
.............
.............
.............
channel48*,channel48,4096

--047d7b5d86a5d570000514f382de
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I want to enable multiple(50) chann=
el for the same session, below is my script doing the same.=C2=A0</div><div=
>Single channel with the same script =C2=A0is working fine. But, when I tri=
ed to enable multiple channel for the same session it&#39;s giving me error=
.</div><div><br></div><div>Here is what I found</div><div>1) I have 50 chan=
nel in my db files and it&#39;s failing at 13th channel create command, bel=
ow is the log</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0...12 channel creation s=
uccessful</div><div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Spawning a session daem=
on</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0Warning: Could not get lock file /v=
ar/run/lttng/lttng-sessiond.lck, another instance is running.</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0Error: Session daemon died (exit status 1)</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0Spawning a session daemon</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0Warning: Could not get lock file /var/run/lttng/lttng-sess=
iond.lck, another instance is running.</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0Error: Session daemon died (exit status 1)=C2=A0</div><div>=C2=A0 =C2=A0=
 =C2=A0 =C2=A01</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0failed!</div></div><di=
v><br></div><div>Let me know if question is not clear.</div><div><br></div>=
<div>my lttng script<br></div><div><div>-----------------------------------=
---------=C2=A0</div><div><div>lttng create -o /root/data/tracing --snapsho=
t TEST</div><div>while IFS=3D, read EVENTNAME CHANNELNAME BUFFERSIZE=C2=A0<=
/div><div>do</div><div><span style=3D"white-space:pre-wrap">	</span>lttng e=
nable-channel --userspace --tracefile-size ${BUFFERSIZE}K --tracefile-count=
 1 --overwrite ${CHANNELNAME}</div><div><span style=3D"white-space:pre-wrap=
">	</span>lttng enable-event -u ${EVENTNAME} --loglevel ERR -c ${CHANNELNAM=
E}</div><div><span style=3D"white-space:pre-wrap">	</span>lttng enable-even=
t -u ${EVENTNAME} --loglevel CRIT -c ${CHANNELNAME}</div><div>done &lt; dem=
o_lttngdb</div><div><span style=3D"white-space:pre-wrap">	</span>lttng star=
t</div></div><div><br></div><div><br></div><div>my demo_lttngdb file</div><=
div>-------------------------------------------</div><div><div>channel1,cha=
nnel1,65535</div><div>channel2*,channel2,4096</div><div>channel3*,channel3,=
4096</div><div>channel4*,channel4,4096</div><div>channel5*,channel5,4096</d=
iv><div>channel6*,channel6,4096</div><div>channel7*,channel7,4096</div><div=
>channel8*,channel8,4096</div><div>channel9*,channel9,8192</div><div>channe=
l10*,channel10,4096</div><div>channel11*,channel11,4096</div><div>channel12=
*,channel12,4096</div><div>channel13*,channel13,4096</div><div>channel14*,c=
hannel14,4096</div><div>channel15*,channel15,4096</div></div></div><div>...=
..........</div><div>.............<br></div><div>.............<br></div><di=
v>channel48*,channel48,4096<br></div></div>

--047d7b5d86a5d570000514f382de--


--===============0216029429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0216029429==--
