From: Anand Neeli <anand.neeli@gmail.com>
Subject: Creating session on 64-bit system using a 32-bit wrapper
Date: Tue, 31 Mar 2015 19:14:14 +0530
Message-ID: <CAM5kDqyvCmxmiSEOLi22dWqj7qNgqq=Hyr=-NO9bFttEbGBYjA__29655.775280162$1427809549$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0542619972=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YcwSq-0006zu-0w
 for lttng-dev@lists.lttng.org; Tue, 31 Mar 2015 09:44:26 -0400
Received: by wixo5 with SMTP id o5so14281261wix.1
 for <lttng-dev@lists.lttng.org>; Tue, 31 Mar 2015 06:44:14 -0700 (PDT)
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

--===============0542619972==
Content-Type: multipart/alternative; boundary=001a11c363ce566377051295cb1b

--001a11c363ce566377051295cb1b
Content-Type: text/plain; charset=UTF-8

Hi,
I have a wrapper app which is 32-bit which is similar to lttng binary, it
links to liblttng-ctl for creating lttng sessions (similar to lttng) . But
the session create is stuck with below logs.

To simulate this i have done following
1) On a 64-bit system replace /usr/bin/lttng with a 32-bit version of lttng
binary
2) Spawn lttng-sessiond (sessiond is 64-bit, we have not changed it)
3) Now create lttng session using the 32-bit lttng binary using command
"lttng -vvv --no-sessiond create mysession --live 2000000 -U
net://localhost"

After step 3, the console is stuck and doesn't return.

Can anyone please tell me why cant we use 32-bit lttng (or any other
wrapper) which can link to liblttng-ctl and launch sessions? is there any
limitation?

Thanks,
Anand Neeli










root@fpc0:/usr/bin# lttng  -vvv --no-sessiond create mysession --live
2000000 -U net://128.0.0.4
DEBUG1 - 13:16:49.240956 [840/840]: Session live timer interval set to
2000000 (in cmd_create() at commands/create.c:575)
DEBUG3 - 13:16:49.241199 [840/840]: URI string: net://128.0.0.4 (in
uri_parse() at uri.c:293)
DEBUG2 - 13:16:49.241228 [840/840]: IP address resolved to 128.0.0.4 (in
set_ip_address() at uri.c:134)
DEBUG3 - 13:16:49.241235 [840/840]: URI dtype: 1, proto: 1, host:
128.0.0.4, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:507)
DEBUG1 - 13:16:49.241380 [840/840]: LSM cmd type : 30 (in
send_session_msg() at lttng-ctl.c:133)
DEBUG1 - 13:16:49.241452 [830/833]: Wait for client response (in
thread_manage_clients() at main.c:4090)
DEBUG1 - 13:16:49.241498 [830/833]: Receiving data from client ... (in
thread_manage_clients() at main.c:4135)
DEBUG1 - 13:16:49.241753 [830/833]: Processing client command 30 (in
process_client_msg() at main.c:2813)
DEBUG1 - 13:16:49.241775 [830/833]: Waiting for 2 URIs from client ... (in
process_client_msg() at main.c:3740)

--001a11c363ce566377051295cb1b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>I have a wrapper app which is 32-bit which is simi=
lar to lttng binary, it links to liblttng-ctl for creating lttng sessions (=
similar to lttng) . But the session create is stuck with below logs.</div><=
div><br></div><div>To simulate this i have done following</div><div>1) On a=
 64-bit system replace /usr/bin/lttng with a 32-bit version of lttng binary=
</div><div>2) Spawn lttng-sessiond (sessiond is 64-bit, we have not changed=
 it)</div><div>3) Now create lttng session using the 32-bit lttng binary us=
ing command &quot;lttng -vvv=C2=A0--no-sessiond create mysession --live 200=
0000 -U net://localhost&quot;</div><div><br></div><div>After step 3, the co=
nsole is stuck and doesn&#39;t return.</div><div><br></div><div>Can anyone =
please tell me why cant we use 32-bit lttng (or any other wrapper) which ca=
n link to liblttng-ctl and launch sessions? is there any limitation?</div><=
div><br></div><div>Thanks,</div><div>Anand Neeli</div>







<div><br></div><div><br></div><div><br><div><br></div><div><br></div><div><=
br></div><div><br></div><div><br></div><div><br></div><div><br></div><div><=
div>root@fpc0:/usr/bin# lttng =C2=A0-vvv --no-sessiond create mysession --l=
ive 2000000 -U net://<a href=3D"http://128.0.0.4">128.0.0.4</a></div><div>D=
EBUG1 - 13:16:49.240956 [840/840]: Session live timer interval set to 20000=
00 (in cmd_create() at commands/create.c:575)</div><div>DEBUG3 - 13:16:49.2=
41199 [840/840]: URI string: net://<a href=3D"http://128.0.0.4">128.0.0.4</=
a> (in uri_parse() at uri.c:293)</div><div>DEBUG2 - 13:16:49.241228 [840/84=
0]: IP address resolved to 128.0.0.4 (in set_ip_address() at uri.c:134)</di=
v><div>DEBUG3 - 13:16:49.241235 [840/840]: URI dtype: 1, proto: 1, host: 12=
8.0.0.4, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:507)</div><div=
>DEBUG1 - 13:16:49.241380 [840/840]: LSM cmd type : 30 (in send_session_msg=
() at lttng-ctl.c:133)</div><div>DEBUG1 - 13:16:49.241452 [830/833]: Wait f=
or client response (in thread_manage_clients() at main.c:4090)</div><div>DE=
BUG1 - 13:16:49.241498 [830/833]: Receiving data from client ... (in thread=
_manage_clients() at main.c:4135)</div><div>DEBUG1 - 13:16:49.241753 [830/8=
33]: Processing client command 30 (in process_client_msg() at main.c:2813)<=
/div><div>DEBUG1 - 13:16:49.241775 [830/833]: Waiting for 2 URIs from clien=
t ... (in process_client_msg() at main.c:3740)</div><div><br></div></div></=
div></div>

--001a11c363ce566377051295cb1b--


--===============0542619972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0542619972==--
