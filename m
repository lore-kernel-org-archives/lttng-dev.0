From: Divya Vyas <dvyas@mvista.com>
Subject: babeltrace CTF -> Text -> CTF
Date: Tue, 11 Nov 2014 10:57:57 +0530
Message-ID: <CA+=dQ-9JigPHaP=_u8kBYQ4vWGGUowY7YsWwPjyZfVxaMjYuKA__7633.99220672927$1415683739$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0335332635=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dvyas@mvista.com>) id 1Xo407-0004ZE-R2
 for lttng-dev@lists.lttng.org; Tue, 11 Nov 2014 00:28:24 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so510909wiw.9
 for <lttng-dev@lists.lttng.org>; Mon, 10 Nov 2014 21:28:18 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0335332635==
Content-Type: multipart/alternative; boundary=047d7ba975e6efceef05078e8bdc

--047d7ba975e6efceef05078e8bdc
Content-Type: text/plain; charset=UTF-8

Hi ,

I am Converting the LTTng ouput ( I think this is in CTF format ) into a
text log using below command :

 babeltrace trace-20141016-071352-kernel/  > text_output


The text_output first line is

[12:44:05.438190693] (+?.?????????) kmem_cache_alloc: { cpu_id = 0 }, {
call_site = 0xFFFFFFFF811806FC, ptr = 0xFFFF8800157248C0, bytes_req = 304,
bytes_alloc = 320, gfp_flags = 32976 }

missing timestamp

Again I am trying to convert into CTF using babeltrace-log

cat text_output | babeltrace-log -t ctf_output


The output of LTTng output and ctf_ouput should be same in eclipse trace
viewer but I am not able to see ctf_output correctly .

I am not sure whether My steps are wrong?

--047d7ba975e6efceef05078e8bdc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi ,<br><br></div>I am Converting=
 the LTTng ouput ( I think this is in CTF format ) into a text log using be=
low command :<br><br>=C2=A0babeltrace trace-20141016-071352-kernel/=C2=A0 &=
gt; text_output<br><br><br></div>The text_output first line is <br><br>[12:=
44:05.438190693]
 (+?.?????????) kmem_cache_alloc: { cpu_id =3D 0 }, { call_site =3D=20
0xFFFFFFFF811806FC, ptr =3D 0xFFFF8800157248C0, bytes_req =3D 304,=20
bytes_alloc =3D 320, gfp_flags =3D 32976 }<br><br></div>missing timestamp <=
br><br></div>Again I am trying to convert into CTF using babeltrace-log <br=
><br>cat text_output | babeltrace-log -t ctf_output<br><br><br></div><div>T=
he
 output of LTTng output and ctf_ouput should be same in eclipse trace=C2=A0=
=20
viewer but I am not able to see ctf_output correctly . <br><br></div>I am n=
ot sure whether My steps are wrong? </div>

--047d7ba975e6efceef05078e8bdc--


--===============0335332635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0335332635==--
