From: "Ionut D." <ionut5001@gmail.com>
Subject: LTTNG on Android ICS
Date: Fri, 17 May 2013 08:32:01 +0300
Message-ID: <CAGNqz8L+Kat-C+3RLRknPHOiGXX8_1zYcKCm1j1s5tet3AsEqA__18710.8184014962$1368768766$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0149677705=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f196.google.com ([209.85.220.196])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ionut5001@gmail.com>) id 1UdDGx-0007jv-5W
	for lttng-dev@lists.lttng.org; Fri, 17 May 2013 01:32:07 -0400
Received: by mail-vc0-f196.google.com with SMTP id m17so206314vca.11
	for <lttng-dev@lists.lttng.org>; Thu, 16 May 2013 22:32:01 -0700 (PDT)
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

--===============0149677705==
Content-Type: multipart/alternative; boundary=20cf3071cde26f025b04dce34d88

--20cf3071cde26f025b04dce34d88
Content-Type: text/plain; charset=ISO-8859-1

Hello all,

Recently I started to integrate LTTNG in Android ICS by compiling each
package, each dependency, by using the Android build system. It is a lot of
work because I met different problems and to be sincere, I do not know if
at the end will work and I do not know how much I will need to modify the
sources in order to work.

My questions are about this integration. I mention that I read a lot of
discussions about this on Internet, on this mailing list, but the things
are still not very clear for me.

It is ok? what I am trying to do ? to integrate and build by using the
Android build system.
Could you give me some guidelines, indications about how I should proceed,
maybe a tutorial or maybe some android make files/patches that would help
me to see how the job must be done and if I am doing it right ?

Until now I managed to build lttng-modules, liburcu, libuuid from
util-linux and configure lttng-ust by using the android toolchain for arm.
I got a lot of errors but until now I managed to configure/make these
packages.

I mention that I am trying to build lttng 2.x on ICS 4.0.3.

Would be great if you will give me a tutorial about how to do it.

Ionut

--20cf3071cde26f025b04dce34d88
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello all,</div><div><br></div><div>Recently I starte=
d to integrate LTTNG in Android ICS by compiling each package, each depende=
ncy, by using the Android build system. It is a lot of work because I met d=
ifferent problems and to be sincere,  I do not know if at the end will work=
 and I do not know how much I will need to modify the sources in order to w=
ork.<br>
</div><br>My questions are about this integration. I mention that I read a =
lot of discussions about this on Internet, on this mailing list, but the th=
ings are still not very clear for me.<br><br>It is ok? what I am trying to =
do ? to integrate and build by using the Android build system.<br>
Could you give me some guidelines, indications about how I should proceed, =
maybe a tutorial or maybe some android make files/patches that would help m=
e to see how the job must be done and if I am doing it right ?<br><br>Until=
 now I managed to build lttng-modules, liburcu, libuuid from util-linux and=
 configure lttng-ust by using the android toolchain for arm. I got a lot of=
 errors but until now I managed to configure/make these packages.<br>
<br>I mention that I am trying to build lttng 2.x on ICS 4.0.3.<br><br><div=
>Would be great if you will give me a tutorial about how to do it.</div><di=
v><br></div><div>Ionut</div></div>

--20cf3071cde26f025b04dce34d88--


--===============0149677705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0149677705==--
