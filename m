From: Anand Neeli <anand.neeli@gmail.com>
Subject: auto generation of .c and .h files for a userspace app
Date: Wed, 11 Dec 2013 11:02:57 +0530
Message-ID: <CAM5kDqwv-9ctjTaHsGyQVhPwmLooCv+U7eUNt=ggRnunqvdDBQ__33703.6464982249$1386740032$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0467733771=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <anand.neeli@gmail.com>) id 1VqcPw-0004JL-0z
	for lttng-dev@lists.lttng.org; Wed, 11 Dec 2013 00:33:07 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so8892986pdj.1
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 21:32:58 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0467733771==
Content-Type: multipart/alternative; boundary=e89a8ff1bfaaca406504ed3b8fbc

--e89a8ff1bfaaca406504ed3b8fbc
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

Is there a script/program which can be used to auto-generate the required
.c and .h files required for lttng-ust.
The script/program should parse all the .c files in a directory and
generate corresponding .c and .h files. And this should be run before the
build of app.

This would make app developers life easy and will be very useful for on the
fly changes.

Will be great if someone can all add more details related to this topic or
give me pointers if this is already discussed.

Thanks,
Anand Neeli

--e89a8ff1bfaaca406504ed3b8fbc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>Is there a script/program which=
 can be used to auto-generate the required .c and .h files required for ltt=
ng-ust.=A0</div><div>The script/program should parse all the .c files in a =
directory and generate corresponding .c and .h files. And this should be ru=
n before the build of app.</div>
<div><br></div><div>This would make app developers life easy and will be ve=
ry useful for on the fly changes.</div><div><br></div><div>Will be great if=
 someone can all add more details related to this topic or give me pointers=
 if this is already discussed.</div>
<div><br></div><div>Thanks,</div><div>Anand Neeli</div></div>

--e89a8ff1bfaaca406504ed3b8fbc--


--===============0467733771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0467733771==--
