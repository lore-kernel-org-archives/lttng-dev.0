From: Anand Neeli <anand.neeli@gmail.com>
Subject: Warning: HOME environment variable not set.
Date: Wed, 18 Mar 2015 02:48:24 +0530
Message-ID: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q__48745.1951405548$1426627174$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0689357734=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YXysg-0008Rx-Az
 for lttng-dev@lists.lttng.org; Tue, 17 Mar 2015 17:18:32 -0400
Received: by wibg7 with SMTP id g7so73913732wib.1
 for <lttng-dev@lists.lttng.org>; Tue, 17 Mar 2015 14:18:24 -0700 (PDT)
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

--===============0689357734==
Content-Type: multipart/alternative; boundary=001a1135e9a8cd815d05118281a8

--001a1135e9a8cd815d05118281a8
Content-Type: text/plain; charset=UTF-8

Hi All,

any idea when do we get this error?

app: libust[4745/4745]: Warning: HOME environment variable not set.
Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
lttng-ust-comm.c:385)
app: libust[4751/4751]: Warning: HOME environment variable not set.
Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
lttng-ust-comm.c:385)
app: libust[4760/4760]: Warning: HOME environment variable not set.
Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
lttng-ust-comm.c:385)
app: libust[4780/4780]: Warning: HOME environment variable not set.
Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
lttng-ust-comm.c:385)

i have set LTTNG_HOME=HOME=/home/root
using 2.6

Thanks,
Anand Neeli

--001a1135e9a8cd815d05118281a8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>any idea when do we get this er=
ror?</div><div><br></div><div><div>app: libust[4745/4745]: Warning: HOME en=
vironment variable not set. Disabling LTTng-UST per-user tracing. (in setup=
_local_apps() at lttng-ust-comm.c:385)</div><div>app: libust[4751/4751]: Wa=
rning: HOME environment variable not set. Disabling LTTng-UST per-user trac=
ing. (in setup_local_apps() at lttng-ust-comm.c:385)</div><div>app: libust[=
4760/4760]: Warning: HOME environment variable not set. Disabling LTTng-UST=
 per-user tracing. (in setup_local_apps() at lttng-ust-comm.c:385)</div><di=
v>app: libust[4780/4780]: Warning: HOME environment variable not set. Disab=
ling LTTng-UST per-user tracing. (in setup_local_apps() at lttng-ust-comm.c=
:385)</div></div><div><br></div><div>i have set LTTNG_HOME=3DHOME=3D/home/r=
oot</div><div>using 2.6</div><div><br></div><div>Thanks,</div><div>Anand Ne=
eli</div><div><br></div></div>

--001a1135e9a8cd815d05118281a8--


--===============0689357734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0689357734==--
