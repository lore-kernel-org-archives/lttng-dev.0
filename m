From: Anand Neeli <anand.neeli@gmail.com>
Subject: destroying one session stops tracing on all other
	sessions
Date: Mon, 2 Mar 2015 18:32:00 +0530
Message-ID: <CAM5kDqwwrEwwVMcaXhRnbmVcyQFSiwykAJv88tRLxfDVYJH-Rw__5323.76044798202$1425301395$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0057557167=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YSPz4-0006tx-4d
 for lttng-dev@lists.lttng.org; Mon, 02 Mar 2015 08:02:09 -0500
Received: by wghb13 with SMTP id b13so33258970wgh.0
 for <lttng-dev@lists.lttng.org>; Mon, 02 Mar 2015 05:02:00 -0800 (PST)
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

--===============0057557167==
Content-Type: multipart/alternative; boundary=047d7b6d9ac8e6536b05104dd25b

--047d7b6d9ac8e6536b05104dd25b
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm using 2.6.0 and see following issue:
On a multisession setup with relayd, Destroying  one session is showing
errors on the console and tracing of all the sessions is stopped.

steps to recreate are as follows
1) Create multiple sessions with relayd. (in below logs i have created 2
sessions)
2) Destroy one session and then tracing on all the sessions stops

(Have not check this with single session, could be happening with single
session also)

logs
---------
node-a # lttng list
Available tracing sessions:
  1) mys5 (tcp4://128.0.0.4:5342/ [data: 5343]) [active]
    Trace path: tcp4://128.0.0.4:5342/ [data: 5343]
    Live timer interval (usec): 2000000

  2) mysession (tcp4://128.0.0.4:5342/ [data: 5343]) [active]
    Trace path: tcp4://128.0.0.4:5342/ [data: 5343]
    Live timer interval (usec): 2000000

Use lttng list <session_name> for more details


node-a # lttng list mys5
Tracing session mys5: [active]
    Trace path: tcp4://128.0.0.4:5342/ [data: 5343]

=== Domain: UST global ===

Buffer type: per PID

Channels:
-------------
- myc5: [enabled]

    Attributes:
      overwrite mode: 0
      subbufers size: 4096
      number of subbufers: 4
      switch timer interval: 0
      read timer interval: 0
      trace file count: 2
      trace file size (bytes): 2000000
      output: mmap()

    Events:
      * (type: tracepoint) [enabled] [has exclusions]

node-a # lttng list mysession
Tracing session mysession: [active]
    Trace path: tcp4://128.0.0.4:5342/ [data: 5343]

=== Domain: UST global ===

Buffer type: per PID

Channels:
-------------
- mychannel: [enabled]

    Attributes:
      overwrite mode: 0
      subbufers size: 4096
      number of subbufers: 4
      switch timer interval: 0
      read timer interval: 0
      trace file count: 2
      trace file size (bytes): 2000000
      output: mmap()

    Events:
      * (type: tracepoint) [enabled] [has exclusions]


node-a # lttng destroy mys5    <<<<<<<<<<<<<<<<<<<< destroying session here
Error: Pushing metadata
Error: Handling metadata request
Error: Health error occurred in thread_manage_consumer
Error: Pushing metadata
Error: Handling metadata request
Error: Health error occurred in thread_manage_consumer
PERROR - 04:36:15.258880 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
PERROR - 04:36:15.259520 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.260076 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
Session mys5 destroyed
node-a # PERROR - 04:36:15.106369 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106410 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106437 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106474 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106490 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106500 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106509 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106519 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106528 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106537 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106546 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106555 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106564 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106573 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106581 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106590 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106599 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106608 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106616 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106625 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106636 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106645 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106654 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106663 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106672 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106681 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106690 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106699 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106708 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond
PERROR - 04:36:15.106717 [1651/1656]: sendmsg: Broken pipe (in
lttcomm_send_unix_sock() at unix.c:218)
Error: Asking metadata to sessiond

node-a # ps aux | grep lttng
root      1622  0.1  0.0 495020  1160 ?        Ssl  04:34   0:00
lttng-relayd -o /var/tmp/lttng-traces -d
root      1631  0.0  0.1 854020  6360 ?        Ssl  04:34   0:00
lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd
--consumerd32-libdir /usr/lib/ --consumerd64-path
/usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir /usr/lib64/
-b --no-kernel
root      1643  0.0  0.0 546356  3424 ?        Sl   04:34   0:00
lttng-consumerd  -u --consumerd-cmd-sock
/var/run/lttng/ustconsumerd64/command --consumerd-err-sock
/var/run/lttng/ustconsumerd64/error --group tracing
root      1651  0.0  0.0  64068  1852 ?        Sl   04:34   0:00
lttng-consumerd  -u --consumerd-cmd-sock
/var/run/lttng/ustconsumerd32/command --consumerd-err-sock
/var/run/lttng/ustconsumerd32/error --group tracing
root      2160  0.0  0.0   4448   704 pts/0    S+   04:36   0:00 grep lttng



Thanks,
Anand Neeli

--047d7b6d9ac8e6536b05104dd25b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I&#39;m using 2.6.0 and see following issue:=
=C2=A0</div><div>On a multisession setup with relayd, Destroying =C2=A0one =
session is showing errors on the console and tracing of all the sessions is=
 stopped.</div><div><br></div><div>steps to recreate are as follows</div><d=
iv>1) Create multiple sessions with relayd. (in below logs i have created 2=
 sessions)</div><div>2) Destroy one session and then tracing on all the ses=
sions stops<br><div><br></div><div>(Have not check this with single session=
, could be happening with single session also)</div><div><br></div><div>log=
s</div><div>---------</div><div><div>node-a # lttng list</div><div>Availabl=
e tracing sessions:</div><div>=C2=A0 1) mys5 (tcp4://<a href=3D"http://128.=
0.0.4:5342/">128.0.0.4:5342/</a> [data: 5343]) [active]</div><div>=C2=A0 =
=C2=A0 Trace path: tcp4://<a href=3D"http://128.0.0.4:5342/">128.0.0.4:5342=
/</a> [data: 5343]</div><div>=C2=A0 =C2=A0 Live timer interval (usec): 2000=
000</div><div><br></div><div>=C2=A0 2) mysession (tcp4://<a href=3D"http://=
128.0.0.4:5342/">128.0.0.4:5342/</a> [data: 5343]) [active]</div><div>=C2=
=A0 =C2=A0 Trace path: tcp4://<a href=3D"http://128.0.0.4:5342/">128.0.0.4:=
5342/</a> [data: 5343]</div><div>=C2=A0 =C2=A0 Live timer interval (usec): =
2000000</div><div><br></div><div>Use lttng list &lt;session_name&gt; for mo=
re details</div><div><br></div><div><br></div><div>node-a # lttng list mys5=
</div><div>Tracing session mys5: [active]</div><div>=C2=A0 =C2=A0 Trace pat=
h: tcp4://<a href=3D"http://128.0.0.4:5342/">128.0.0.4:5342/</a> [data: 534=
3]</div><div><br></div><div>=3D=3D=3D Domain: UST global =3D=3D=3D</div><di=
v><br></div><div>Buffer type: per PID</div><div><br></div><div>Channels:</d=
iv><div>-------------</div><div>- myc5: [enabled]</div><div><br></div><div>=
=C2=A0 =C2=A0 Attributes:</div><div>=C2=A0 =C2=A0 =C2=A0 overwrite mode: 0<=
/div><div>=C2=A0 =C2=A0 =C2=A0 subbufers size: 4096</div><div>=C2=A0 =C2=A0=
 =C2=A0 number of subbufers: 4</div><div>=C2=A0 =C2=A0 =C2=A0 switch timer =
interval: 0</div><div>=C2=A0 =C2=A0 =C2=A0 read timer interval: 0</div><div=
>=C2=A0 =C2=A0 =C2=A0 trace file count: 2</div><div>=C2=A0 =C2=A0 =C2=A0 tr=
ace file size (bytes): 2000000</div><div>=C2=A0 =C2=A0 =C2=A0 output: mmap(=
)</div><div><br></div><div>=C2=A0 =C2=A0 Events:</div><div>=C2=A0 =C2=A0 =
=C2=A0 * (type: tracepoint) [enabled] [has exclusions]</div><div><br></div>=
<div>node-a # lttng list mysession</div><div>Tracing session mysession: [ac=
tive]</div><div>=C2=A0 =C2=A0 Trace path: tcp4://<a href=3D"http://128.0.0.=
4:5342/">128.0.0.4:5342/</a> [data: 5343]</div><div><br></div><div>=3D=3D=
=3D Domain: UST global =3D=3D=3D</div><div><br></div><div>Buffer type: per =
PID</div><div><br></div><div>Channels:</div><div>-------------</div><div>- =
mychannel: [enabled]</div><div><br></div><div>=C2=A0 =C2=A0 Attributes:</di=
v><div>=C2=A0 =C2=A0 =C2=A0 overwrite mode: 0</div><div>=C2=A0 =C2=A0 =C2=
=A0 subbufers size: 4096</div><div>=C2=A0 =C2=A0 =C2=A0 number of subbufers=
: 4</div><div>=C2=A0 =C2=A0 =C2=A0 switch timer interval: 0</div><div>=C2=
=A0 =C2=A0 =C2=A0 read timer interval: 0</div><div>=C2=A0 =C2=A0 =C2=A0 tra=
ce file count: 2</div><div>=C2=A0 =C2=A0 =C2=A0 trace file size (bytes): 20=
00000</div><div>=C2=A0 =C2=A0 =C2=A0 output: mmap()</div><div><br></div><di=
v>=C2=A0 =C2=A0 Events:</div><div>=C2=A0 =C2=A0 =C2=A0 * (type: tracepoint)=
 [enabled] [has exclusions]</div><div><br></div><div><br></div><div>node-a =
# lttng destroy mys5 =C2=A0 =C2=A0&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&=
lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt; destroying session here</div><div>E=
rror: Pushing metadata</div><div>Error: Handling metadata request</div><div=
>Error: Health error occurred in thread_manage_consumer</div><div>Error: Pu=
shing metadata</div><div>Error: Handling metadata request</div><div>Error: =
Health error occurred in thread_manage_consumer</div><div>PERROR - 04:36:15=
.258880 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at u=
nix.c:218)</div><div>PERROR - 04:36:15.259520 [1651/1656]: sendmsg: Broken =
pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: Asking me=
tadata to sessiond</div><div>PERROR - 04:36:15.260076 [1651/1656]: sendmsg:=
 Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: A=
sking metadata to sessiond</div><div>Session mys5 destroyed</div><div>node-=
a # PERROR - 04:36:15.106369 [1651/1656]: sendmsg: Broken pipe (in lttcomm_=
send_unix_sock() at unix.c:218)</div><div>Error: Asking metadata to session=
d</div><div>PERROR - 04:36:15.106410 [1651/1656]: sendmsg: Broken pipe (in =
lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: Asking metadata to=
 sessiond</div><div>PERROR - 04:36:15.106437 [1651/1656]: sendmsg: Broken p=
ipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: Asking met=
adata to sessiond</div><div>PERROR - 04:36:15.106474 [1651/1656]: sendmsg: =
Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: As=
king metadata to sessiond</div><div>PERROR - 04:36:15.106490 [1651/1656]: s=
endmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>E=
rror: Asking metadata to sessiond</div><div>PERROR - 04:36:15.106500 [1651/=
1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</di=
v><div>Error: Asking metadata to sessiond</div><div>PERROR - 04:36:15.10650=
9 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:=
218)</div><div>Error: Asking metadata to sessiond</div><div>PERROR - 04:36:=
15.106519 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at=
 unix.c:218)</div><div>Error: Asking metadata to sessiond</div><div>PERROR =
- 04:36:15.106528 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_s=
ock() at unix.c:218)</div><div>Error: Asking metadata to sessiond</div><div=
>PERROR - 04:36:15.106537 [1651/1656]: sendmsg: Broken pipe (in lttcomm_sen=
d_unix_sock() at unix.c:218)</div><div>Error: Asking metadata to sessiond</=
div><div>PERROR - 04:36:15.106546 [1651/1656]: sendmsg: Broken pipe (in ltt=
comm_send_unix_sock() at unix.c:218)</div><div>Error: Asking metadata to se=
ssiond</div><div>PERROR - 04:36:15.106555 [1651/1656]: sendmsg: Broken pipe=
 (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: Asking metada=
ta to sessiond</div><div>PERROR - 04:36:15.106564 [1651/1656]: sendmsg: Bro=
ken pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: Askin=
g metadata to sessiond</div><div>PERROR - 04:36:15.106573 [1651/1656]: send=
msg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Erro=
r: Asking metadata to sessiond</div><div>PERROR - 04:36:15.106581 [1651/165=
6]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><=
div>Error: Asking metadata to sessiond</div><div>PERROR - 04:36:15.106590 [=
1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218=
)</div><div>Error: Asking metadata to sessiond</div><div>PERROR - 04:36:15.=
106599 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at un=
ix.c:218)</div><div>Error: Asking metadata to sessiond</div><div>PERROR - 0=
4:36:15.106608 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock=
() at unix.c:218)</div><div>Error: Asking metadata to sessiond</div><div>PE=
RROR - 04:36:15.106616 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_u=
nix_sock() at unix.c:218)</div><div>Error: Asking metadata to sessiond</div=
><div>PERROR - 04:36:15.106625 [1651/1656]: sendmsg: Broken pipe (in lttcom=
m_send_unix_sock() at unix.c:218)</div><div>Error: Asking metadata to sessi=
ond</div><div>PERROR - 04:36:15.106636 [1651/1656]: sendmsg: Broken pipe (i=
n lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: Asking metadata =
to sessiond</div><div>PERROR - 04:36:15.106645 [1651/1656]: sendmsg: Broken=
 pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: Asking m=
etadata to sessiond</div><div>PERROR - 04:36:15.106654 [1651/1656]: sendmsg=
: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div>Error: =
Asking metadata to sessiond</div><div>PERROR - 04:36:15.106663 [1651/1656]:=
 sendmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</div><div=
>Error: Asking metadata to sessiond</div><div>PERROR - 04:36:15.106672 [165=
1/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)</=
div><div>Error: Asking metadata to sessiond</div><div>PERROR - 04:36:15.106=
681 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.=
c:218)</div><div>Error: Asking metadata to sessiond</div><div>PERROR - 04:3=
6:15.106690 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() =
at unix.c:218)</div><div>Error: Asking metadata to sessiond</div><div>PERRO=
R - 04:36:15.106699 [1651/1656]: sendmsg: Broken pipe (in lttcomm_send_unix=
_sock() at unix.c:218)</div><div>Error: Asking metadata to sessiond</div><d=
iv>PERROR - 04:36:15.106708 [1651/1656]: sendmsg: Broken pipe (in lttcomm_s=
end_unix_sock() at unix.c:218)</div><div>Error: Asking metadata to sessiond=
</div><div>PERROR - 04:36:15.106717 [1651/1656]: sendmsg: Broken pipe (in l=
ttcomm_send_unix_sock() at unix.c:218)</div><div>Error: Asking metadata to =
sessiond</div><div><br></div><div>node-a # ps aux | grep lttng</div><div>ro=
ot =C2=A0 =C2=A0 =C2=A01622 =C2=A00.1 =C2=A00.0 495020 =C2=A01160 ? =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Ssl =C2=A004:34 =C2=A0 0:00 lttng-relayd -o /var/tmp/lt=
tng-traces -d</div><div>root =C2=A0 =C2=A0 =C2=A01631 =C2=A00.0 =C2=A00.1 8=
54020 =C2=A06360 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0Ssl =C2=A004:34 =C2=A0 0:00 l=
ttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd --c=
onsumerd32-libdir /usr/lib/ --consumerd64-path /usr/lib64/lttng/libexec/ltt=
ng-consumerd --consumerd64-libdir /usr/lib64/ -b --no-kernel</div><div>root=
 =C2=A0 =C2=A0 =C2=A01643 =C2=A00.0 =C2=A00.0 546356 =C2=A03424 ? =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Sl =C2=A0 04:34 =C2=A0 0:00 lttng-consumerd =C2=A0-u --=
consumerd-cmd-sock /var/run/lttng/ustconsumerd64/command --consumerd-err-so=
ck /var/run/lttng/ustconsumerd64/error --group tracing</div><div>root =C2=
=A0 =C2=A0 =C2=A01651 =C2=A00.0 =C2=A00.0 =C2=A064068 =C2=A01852 ? =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Sl =C2=A0 04:34 =C2=A0 0:00 lttng-consumerd =C2=A0-u --=
consumerd-cmd-sock /var/run/lttng/ustconsumerd32/command --consumerd-err-so=
ck /var/run/lttng/ustconsumerd32/error --group tracing</div><div>root =C2=
=A0 =C2=A0 =C2=A02160 =C2=A00.0 =C2=A00.0 =C2=A0 4448 =C2=A0 704 pts/0 =C2=
=A0 =C2=A0S+ =C2=A0 04:36 =C2=A0 0:00 grep lttng</div><div><br></div></div>=
<div><br></div><div><br></div><div>Thanks,</div><div>Anand Neeli</div><div>=
<br></div><div><br></div></div></div>

--047d7b6d9ac8e6536b05104dd25b--


--===============0057557167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0057557167==--
