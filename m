From: Anand Neeli <anand.neeli@gmail.com>
Subject: multiple tracing sessions using relayd
Date: Sun, 9 Nov 2014 00:01:15 +0530
Message-ID: <CAM5kDqxUdQtOEQb=wYO6tzB3z=Vboe66B=Ky0KW4ZkbS6OfySQ__41235.1211686202$1415471531$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1692549514=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XnAnA-0003yb-Uv
 for lttng-dev@lists.lttng.org; Sat, 08 Nov 2014 13:31:22 -0500
Received: by mail-wi0-f182.google.com with SMTP id d1so7157016wiv.15
 for <lttng-dev@lists.lttng.org>; Sat, 08 Nov 2014 10:31:15 -0800 (PST)
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

--===============1692549514==
Content-Type: multipart/alternative; boundary=047d7b86cb6878fd2c05075d22d9

--047d7b86cb6878fd2c05075d22d9
Content-Type: text/plain; charset=UTF-8

Hi,
i'm trying to create multiple tracing sessions which will relay to the same
relayd.
And i'm not able to create more than one session.
create channel of the second session hangs and doesn't give me the console
back.

Here are the steps i followed
$> lttng-relayd -d -g mygrp

 $> /usr/bin/lttng-sessiond --consumerd32-path
/usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/
--consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd
--consumerd64-libdir /usr/lib64/ -b --no-kernel -g mygrp
Warning: No tracing group detected

$> /usr/bin/lttng create mysession  --live 1000000 -U net://128.0.0.4
Session mysession created.
Traces will be written in net://128.0.0.4
Live timer set to 1000000 usec

 $> /usr/bin/lttng enable-channel mychannel --userspace --buffers-pid -s
mysession --tracefile-size 8388608 --tracefile-count 8Warning: No tracing
group detected
Warning: No tracing group detected
UST channel mychannel enabled for session mysession

 $> /usr/bin/lttng enable-event --channel mychannel --userspace --all
--exclude 'ust_libc:*' -s mysession
All UST events excluding ust_libc:* are enabled in channel mychannel

==> With this first session is created. Now i'm trying to create another
session.

 $>  /usr/bin/lttng create mysession2  --live 1000000 -U net://128.0.0.4
Session mysession2 created.
Traces will be written in net://128.0.0.4
Live timer set to 1000000 usec

 $>  /usr/bin/lttng enable-channel mychannel2 --userspace --buffers-pid -s
mysession2 --tracefile-size 8388608 --tracefile-count 8

==>>>> Console is stuck here and the command never returns.


I tried to create same without relayd and it works. Am i missing anything
here?

Although in the above example i'm enabling same/all events in session1 and
session2, but i think this should work and capture same events in both the
sessions.
Please let me know the correct way to enable this.

Thanks,
Anand Neeli

--047d7b86cb6878fd2c05075d22d9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>i&#39;m trying to create multiple tracing sessions=
 which will relay to the same relayd.</div><div>And i&#39;m not able to cre=
ate more than one session.</div><div>create channel of the second session h=
angs and doesn&#39;t give me the console back.</div><div><br></div><div>Her=
e are the steps i followed</div><div>$&gt; lttng-relayd -d -g mygrp</div><d=
iv><br></div><div><div>=C2=A0$&gt; /usr/bin/lttng-sessiond --consumerd32-pa=
th /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ --=
consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-lib=
dir /usr/lib64/ -b --no-kernel -g mygrp</div><div>Warning: No tracing group=
 detected</div><div><br></div><div>$&gt; /usr/bin/lttng create mysession =
=C2=A0--live 1000000 -U net://<a href=3D"http://128.0.0.4">128.0.0.4</a><br=
></div><div>Session mysession created.</div><div>Traces will be written in =
net://<a href=3D"http://128.0.0.4">128.0.0.4</a></div><div>Live timer set t=
o 1000000 usec</div><div><br></div><div>=C2=A0$&gt;=C2=A0/usr/bin/lttng ena=
ble-channel mychannel --userspace --buffers-pid -s mysession --tracefile-si=
ze 8388608 --tracefile-count 8Warning: No tracing group detected</div><div>=
Warning: No tracing group detected</div><div>UST channel mychannel enabled =
for session mysession</div><div><br></div><div>=C2=A0$&gt;=C2=A0/usr/bin/lt=
tng enable-event --channel mychannel --userspace --all --exclude &#39;ust_l=
ibc:*&#39; -s mysession<br></div><div>All UST events excluding ust_libc:* a=
re enabled in channel mychannel</div><div><br></div><div>=3D=3D&gt; With th=
is first session is created. Now i&#39;m trying to create another session.<=
/div><div><br></div><div>=C2=A0$&gt;=C2=A0=C2=A0/usr/bin/lttng create myses=
sion2 =C2=A0--live 1000000 -U net://<a href=3D"http://128.0.0.4">128.0.0.4<=
/a></div><div>Session mysession2 created.</div><div>Traces will be written =
in net://<a href=3D"http://128.0.0.4">128.0.0.4</a></div><div>Live timer se=
t to 1000000 usec</div><div><br></div><div>=C2=A0$&gt;=C2=A0=C2=A0/usr/bin/=
lttng enable-channel mychannel2 --userspace --buffers-pid -s mysession2 --t=
racefile-size 8388608 --tracefile-count 8<br></div></div><div><br></div><di=
v>=3D=3D&gt;&gt;&gt;&gt; Console is stuck here and the command never return=
s.</div><div><br></div><div><br></div><div>I tried to create same without r=
elayd and it works. Am i missing anything here?</div><div><br></div><div>Al=
though in the above example i&#39;m enabling same/all events in session1 an=
d session2, but i think this should work and capture same events in both th=
e sessions.</div><div>Please let me know the correct way to enable this.</d=
iv><div><br></div><div>Thanks,</div><div>Anand Neeli</div></div>

--047d7b86cb6878fd2c05075d22d9--


--===============1692549514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1692549514==--
