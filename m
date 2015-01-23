From: Anand Neeli <anand.neeli@gmail.com>
Subject: enable-channel switch timer not getting updated
Date: Fri, 23 Jan 2015 15:46:31 +0530
Message-ID: <CAM5kDqyYjQFnU3bO9j0rxSzLPgDD_kcWP9PmJzf+ZRWeqhYm3w__25736.9452542209$1422008230$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0401637678=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f178.google.com ([74.125.82.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YEbI4-0005zC-Uf
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 05:16:39 -0500
Received: by mail-we0-f178.google.com with SMTP id k48so6666343wev.9
 for <lttng-dev@lists.lttng.org>; Fri, 23 Jan 2015 02:16:31 -0800 (PST)
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

--===============0401637678==
Content-Type: multipart/alternative; boundary=f46d043c7dd21c9ef2050d4f1584

--f46d043c7dd21c9ef2050d4f1584
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm using 2.4.1 version.
and i dont see switch timer being updated in output of "lttng list
<session>"
i'm using default subbuf-size and default sub-buf count.

output :

$ # lttng list mys4
Tracing session mys4: [active]
    Trace path: net4://127.0.0.1:5342/ [data: 5343]

=== Domain: UST global ===
Buffer type: per PID
Channels:
-------------
- myc4: [enabled]

    Attributes:
      overwrite mode: 0
      subbufers size: 4096
      number of subbufers: 4
*      switch timer interval: 0   <<<<<<<< doesnt show switch-timer*
      read timer interval: 0
      output: mmap()

    Events:
      * (type: tracepoint) [enabled] [has exclusions]


i used following commands to create session

lttng  --no-sessiond create mys4 --live 200000 -U net://localhost

lttng enable-channel myc4 --userspace --buffers-pid -s mys4
--tracefile-size 8388608 --tracefile-count 8 *--switch-timer 1000*

lttng enable-event --channel myc4 --userspace --all --exclude 'ust_libc:*'
-s mys4

lttng start mys4


Please let me know if i missed anything.

Thanks,

Anand Neeli

--f46d043c7dd21c9ef2050d4f1584
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I&#39;m using 2.4.1 version.</div><div>and i d=
ont see switch timer being updated in output of &quot;lttng list &lt;sessio=
n&gt;&quot;</div><div>i&#39;m using default subbuf-size and default sub-buf=
 count.</div><div><br></div><div>output :</div><div><br></div><div>$ # lttn=
g list mys4<br></div><div><div>Tracing session mys4: [active]</div><div>=C2=
=A0 =C2=A0 Trace path: net4://<a href=3D"http://127.0.0.1:5342/">127.0.0.1:=
5342/</a> [data: 5343]</div><div><br></div><div>=3D=3D=3D Domain: UST globa=
l =3D=3D=3D</div><div>Buffer type: per PID</div><div>Channels:</div><div>--=
-----------</div><div>- myc4: [enabled]</div><div><br></div><div>=C2=A0 =C2=
=A0 Attributes:</div><div>=C2=A0 =C2=A0 =C2=A0 overwrite mode: 0</div><div>=
=C2=A0 =C2=A0 =C2=A0 subbufers size: 4096</div><div>=C2=A0 =C2=A0 =C2=A0 nu=
mber of subbufers: 4</div><div><b>=C2=A0 =C2=A0 =C2=A0 switch timer interva=
l: 0 =C2=A0 &lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt; doesnt show switch-timer</b></=
div><div>=C2=A0 =C2=A0 =C2=A0 read timer interval: 0</div><div>=C2=A0 =C2=
=A0 =C2=A0 output: mmap()</div><div><br></div><div>=C2=A0 =C2=A0 Events:</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 * (type: tracepoint) [enabled] [has exclusions=
]</div><div><br></div></div><div><br></div><div>i used following commands t=
o create session</div><div><p class=3D"">lttng=C2=A0 --no-sessiond create m=
ys4 --live 200000 -U net://localhost</p><p class=3D"">lttng enable-channel =
myc4 --userspace --buffers-pid -s mys4 --tracefile-size 8388608 --tracefile=
-count 8=C2=A0<span style=3D"font-family:&#39;Arial,Bold&#39;;font-size:11p=
t"><b>--switch-timer 1000</b></span></p>
<p class=3D"">lttng enable-event --channel myc4 --userspace --all <span cla=
ss=3D"">--exclude &#39;ust_libc:*&#39;</span> -s mys4<br></p>
<p class=3D"">lttng start mys4<br></p><p class=3D""><br></p><p class=3D"">P=
lease let me know if i missed anything.</p><p class=3D"">Thanks,</p><p clas=
s=3D"">Anand Neeli</p></div></div>

--f46d043c7dd21c9ef2050d4f1584--


--===============0401637678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0401637678==--
