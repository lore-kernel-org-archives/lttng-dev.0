From: Anand Neeli <anand.neeli@gmail.com>
Subject: lttng enable event failing with i386 deb package
Date: Fri, 13 Jun 2014 17:07:39 +0530
Message-ID: <CAM5kDqwu=BPJedJXp2y+uMmiBQy5QCSSmqG7PigKbN1pGdny6w__48935.1112083115$1402659517$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0823773866=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f181.google.com ([74.125.82.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1WvPnm-0001UH-Te
 for lttng-dev@lists.lttng.org; Fri, 13 Jun 2014 07:37:49 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so2584273wes.26
 for <lttng-dev@lists.lttng.org>; Fri, 13 Jun 2014 04:37:40 -0700 (PDT)
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

--===============0823773866==
Content-Type: multipart/alternative; boundary=001a11c2ab34da4e6304fbb61a1b

--001a11c2ab34da4e6304fbb61a1b
Content-Type: text/plain; charset=UTF-8

Hi All,

I have ubuntu i386 debian packages (ppa latest stable) at a location along
with the libraries, and i'm trying to launch lttng and seeing error when
i'm enabling events

PERROR [30126/30126]: Consumer execl(): No such file or directory (in
spawn_consumerd() at main.c:2294)
Error: Condition timed out. The consumer thread was never ready. Killing it
Error: Fatal error spawning consumer control thread
Error: Events: 32-bit UST consumer start failed (channel channel0, session
auto-20140613-165748)

Detailed steps i followed are as:
$> pwd
$> ....install/usr/bin
$> LD_LIBRARY_PATH=../lib/i386-linux-gnu/ ./lttng-relayd -d
$> LD_LIBRARY_PATH=../lib/i386-linux-gnu/ ./lttng --sessiond-path
<abs_path_to>lttng-sessiond --relayd-path <abs_path_to>lttng-relayd create
--live 200000 -U net://localhost
Spawning a session daemon
Session auto-20140613-165748 created.
Traces will be written in net://localhost
Live timer set to 200000 usec

$> export PATH=$PATH:<abs-path>/lib/i386-linux-gnu/lttng/libexec/
{i see that consumerd is in lib/<platform>/lttng/libexec/  so have set a
path to it}

$>  LD_LIBRARY_PATH=../lib/i386-linux-gnu/  ./lttng enable-event -a
--userspace

PERROR [30126/30126]: Consumer execl(): No such file or directory (in
spawn_consumerd() at main.c:2294)
Error: Condition timed out. The consumer thread was never ready. Killing it
Error: Fatal error spawning consumer control thread
Error: Events: 32-bit UST consumer start failed (channel channel0, session
auto-20140613-165748)

What does this mean? and how can i get around this?
can anyone please help.


Thanks,
Anand Neeli

--001a11c2ab34da4e6304fbb61a1b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>I have ubuntu i386 debian packa=
ges (ppa latest stable) at a location along with the libraries, and i&#39;m=
 trying to launch lttng and seeing error when i&#39;m enabling events</div>
<div><br></div><div><div>PERROR [30126/30126]: Consumer execl(): No such fi=
le or directory (in spawn_consumerd() at main.c:2294)</div><div>Error: Cond=
ition timed out. The consumer thread was never ready. Killing it</div><div>
Error: Fatal error spawning consumer control thread</div><div>Error: Events=
: 32-bit UST consumer start failed (channel channel0, session auto-20140613=
-165748)</div></div><div><br></div><div>Detailed steps i followed are as:</=
div>
<div>$&gt; pwd<br></div><div><div>$&gt; ....install/usr/bin</div><div>$&gt;=
=C2=A0LD_LIBRARY_PATH=3D../lib/i386-linux-gnu/ ./lttng-relayd -d</div><div>=
$&gt;=C2=A0LD_LIBRARY_PATH=3D../lib/i386-linux-gnu/ ./lttng --sessiond-path=
 &lt;abs_path_to&gt;lttng-sessiond --relayd-path=C2=A0&lt;abs_path_to&gt;lt=
tng-relayd create --live 200000 -U net://localhost</div>
<div><div>Spawning a session daemon</div><div>Session auto-20140613-165748 =
created.</div><div>Traces will be written in net://localhost</div><div>Live=
 timer set to 200000 usec</div></div><div><br></div><div>$&gt; export PATH=
=3D$PATH:&lt;abs-path&gt;/lib/i386-linux-gnu/lttng/libexec/<br>
</div><div>{i see that consumerd is in lib/&lt;platform&gt;/lttng/libexec/ =
=C2=A0so have set a path to it}</div><div><br></div><div>$&gt; =C2=A0LD_LIB=
RARY_PATH=3D../lib/i386-linux-gnu/ =C2=A0./lttng enable-event -a --userspac=
e</div><div><br>
</div><div>PERROR [30126/30126]: Consumer execl(): No such file or director=
y (in spawn_consumerd() at main.c:2294)</div><div>Error: Condition timed ou=
t. The consumer thread was never ready. Killing it</div><div>Error: Fatal e=
rror spawning consumer control thread</div>
<div>Error: Events: 32-bit UST consumer start failed (channel channel0, ses=
sion auto-20140613-165748)</div></div><div><br></div><div>What does this me=
an? and how can i get around this?</div><div>can anyone please help.</div>
<div><br></div><div><br></div><div>Thanks,</div><div>Anand Neeli</div><div>=
<br></div><div><br></div></div>

--001a11c2ab34da4e6304fbb61a1b--


--===============0823773866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0823773866==--
