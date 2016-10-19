From: Evgeniy Ivanov <i@eivanov.com>
Subject: Deadlock in call_rcu_thread when destroy rculfhash node
	with nested rculfhash
Date: Wed, 19 Oct 2016 12:56:04 +0300
Message-ID: <CAO6Ho0ea+Mhdoea4b3EL-J4z2wifHPWohq1ps74LQBU+b0-OOQ__10995.0091959492$1476870997$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3398330330845768843=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
 [209.85.214.47])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9B9FCA0E89
 for <lttng-dev@lists.lttng.org>; Wed, 19 Oct 2016 09:58:08 +0000 (UTC)
Received: by mail-it0-f47.google.com with SMTP id 139so99458009itm.1
 for <lttng-dev@lists.lttng.org>; Wed, 19 Oct 2016 02:56:06 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3398330330845768843==
Content-Type: multipart/alternative; boundary=94eb2c03473e40a259053f34d1e9

--94eb2c03473e40a259053f34d1e9
Content-Type: text/plain; charset=UTF-8

Hi,

Each node of top level rculfhash has nested rculfhash. Some thread clears
the top level map and then uses rcu_barrier() to wait until everything is
destroyed (it is done to check leaks). Recently it started to dead lock
sometimes with following stacks:

Thread1:

__poll
cds_lfht_destroy    <---- nested map
...
free_Node(rcu_head*)  <----- node of top level map
call_rcu_thread

Thread2:

syscall
rcu_barrier_qsbr
destroy_all
main


Did call_rcu_thread dead lock with barrier thread? Or is it some kind of
internal deadlock because of nested maps?


-- 
Cheers,
Evgeniy

--94eb2c03473e40a259053f34d1e9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>Each node of top level rculfhash has nested rcu=
lfhash. Some thread clears the top level map and then uses rcu_barrier() to=
 wait until everything is destroyed (it is done to check leaks). Recently i=
t started to dead lock sometimes with following stacks:<br><br>Thread1:<br>=
<font face=3D"monospace, monospace"><br></font><div><font face=3D"monospace=
, monospace">__poll<br>cds_lfht_destroy =C2=A0 =C2=A0&lt;---- nested map<br=
>...<br>free_Node(rcu_head*) =C2=A0&lt;----- node of top level map<br>call_=
rcu_thread<br></font><br>Thread2:<div><br><font face=3D"monospace, monospac=
e">syscall <br>rcu_barrier_qsbr <br>destroy_all<br>main<br></font><br><br>D=
id=C2=A0call_rcu_thread dead lock with barrier thread? Or is it some kind o=
f internal deadlock because of nested maps?<br><br><br>-- <br>Cheers,<br>Ev=
geniy</div></div></div>

--94eb2c03473e40a259053f34d1e9--

--===============3398330330845768843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3398330330845768843==--
